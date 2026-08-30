import argparse
import re, sys
from pathlib import Path

# Number of spiral samples. Loop is [unroll]'d, so the compiler folds the
# per-sample constants (spiralR/spiralTheta) itself -- no need to
# precompute them in Python.
SAMPLE_COUNT = 8

GOLDEN_ANGLE = "2.39996323"
COMP = r"[xyzw]"

CENTER_TAP_RE = re.compile(
    r"[ \t]*r(?P<ctrres>\d+)\.(?P<ctrresc>" + COMP + r") = t(?P<tex>\d+)\.SampleCmpLevelZero\(s(?P<samp>\d+)_s, "
    r"r(?P<ctr>\d+)\.(?P<uv>" + COMP + r"{2}), r(?P=ctr)\.(?P<depth>" + COMP + r")\)\.x;\r?\n"
)

LOOP_RE = re.compile(
    r"""
    while\ \(true\)\ \{\r?\n
    \s*r(?P<scratch>\d+)\.(?P<sa>""" + COMP + r""")\ =\ \(int\)r(?P<counter>\d+)\.(?P<ca>""" + COMP + r""");\r?\n
    \s*r(?P<cmpreg>\d+)\.(?P<cmpc>""" + COMP + r""")\ =\ cmp\(r(?P=scratch)\.(?P=sa)\ >=\ r(?P<cnt>\d+)\.(?P<cntc>""" + COMP + r""")\);\r?\n
    \s*if\ \(r(?P=cmpreg)\.(?P=cmpc)\ !=\ 0\)\ break;\r?\n
    \s*r(?P=scratch)\.(?P=sa)\ =\ r(?P=scratch)\.(?P=sa)\ \*\ r(?P<step>\d+)\.(?P<stepc>""" + COMP + r""")(?:\ \+\ 30)?;\r?\n
    \s*r(?P=scratch)\.(?P=sa)\ =\ 0\.0174532924\ \*\ r(?P=scratch)\.(?P=sa);\r?\n
    \s*sincos\(r(?P=scratch)\.(?P=sa)(?:\ \+\ frac\(52\.9829189\ \*\ frac\(dot\(v0\.xy,\ float2\(0\.06711056,\ 0\.00583715\)\)\)\)\ \*\ 2\ \*\ 3\.14159265359)?,\ r(?P<sinr>\d+)\.(?P<sinc>""" + COMP + r"""),\ r(?P<cosr>\d+)\.(?P<cosc>""" + COMP + r""")\);\r?\n
    \s*r(?P<off>\d+)\.(?P<offx>""" + COMP + r""")\ =\ (?:r(?P=cosr)\.(?P=cosc)\ \*\ (?P<radx>r\d+\.""" + COMP + r"""|cb0\[\d+\]\.""" + COMP + r""")|(?P<radx2>r\d+\.""" + COMP + r"""|cb0\[\d+\]\.""" + COMP + r""")\ \*\ r(?P=cosr)\.(?P=cosc));\r?\n
    \s*r(?P=off)\.(?P<offy>""" + COMP + r""")\ =\ (?:r(?P=sinr)\.(?P=sinc)\ \*\ (?P<rady>r\d+\.""" + COMP + r"""|cb0\[\d+\]\.""" + COMP + r""")|(?P<rady2>r\d+\.""" + COMP + r"""|cb0\[\d+\]\.""" + COMP + r""")\ \*\ r(?P=sinr)\.(?P=sinc));\r?\n
    \s*r(?P<comb>\d+)\.(?P<combc>""" + COMP + r"""{3})\ =\ r(?P=off)\.xyz\ \+\ r(?P<ctr>\d+)\.xyz;\r?\n
    \s*r(?P<samp2reg>\d+)\.(?P<samp2c>""" + COMP + r""")\ =\ t(?P<tex>\d+)\.SampleCmpLevelZero\(s(?P<samp>\d+)_s,\ r(?P=comb)\.(?P<combuv>""" + COMP + r"""{2}),\ r(?P=comb)\.(?P<combdepth>""" + COMP + r""")\)\.x;\r?\n
    \s*r(?P<acc>\d+)\.(?P<accc>""" + COMP + r""")\ =\ (?:r(?P=samp2reg)\.(?P=samp2c)\ \+\ r(?P=acc)\.(?P=accc)|r(?P=acc)\.(?P=accc)\ \+\ r(?P=samp2reg)\.(?P=samp2c));\r?\n
    \s*r(?P=counter)\.(?P=ca)\ =\ \(int\)r(?P=counter)\.(?P=ca)\ \+\ 1;\r?\n
    \s*\}\r?\n
    """,
    re.VERBOSE,
)

DECL_RE = re.compile(r"(^[ \t]*float4[ \t]+r0(?:,r\d+)*;\r?\n)", re.MULTILINE)


def build_loop_replacement(m: re.Match) -> str:
    g = m.group
    sinr, sinc = g("sinr"), g("sinc")
    cosr, cosc = g("cosr"), g("cosc")
    off, offx, offy = g("off"), g("offx"), g("offy")
    radx_expr = g("radx") or g("radx2")
    rady_expr = g("rady") or g("rady2")
    comb = g("comb")
    ctr = g("ctr")
    samp2reg, samp2c = g("samp2reg"), g("samp2c")
    tex, samp = g("tex"), g("samp")
    acc, accc = g("acc"), g("accc")
    combuv, combdepth = g("combuv"), g("combdepth")

    return f"""{{
    r{acc}.{accc} = 0;
    ignAngle = frac(dot(v0.xy, float2(0.06711056, 0.00583715)));
    ignAngle = frac(52.9829189 * ignAngle) * 2 * 3.14159265359;
    sincos(ignAngle, ign_sin, ign_cos);
    [unroll]
    for (int j = 0; j < {SAMPLE_COUNT}; j++) {{
      spiralR = sqrt((j + 0.5) / {SAMPLE_COUNT});
      spiralTheta = j * {GOLDEN_ANGLE};
      sincos(spiralTheta, r{sinr}.{sinc}, r{cosr}.{cosc});
      r{off}.{offx} = r{cosr}.{cosc} * spiralR;
      r{off}.{offy} = r{sinr}.{sinc} * spiralR;
      rotX = ign_cos * r{off}.{offx} - ign_sin * r{off}.{offy};
      rotY = ign_sin * r{off}.{offx} + ign_cos * r{off}.{offy};
      r{comb}.{combuv[0]} = {radx_expr} * rotX + r{ctr}.x;
      r{comb}.{combuv[1]} = {rady_expr} * rotY + r{ctr}.y;
      r{comb}.{combdepth} = r{ctr}.z;
      r{samp2reg}.{samp2c} = t{tex}.SampleCmpLevelZero(s{samp}_s, r{comb}.{combuv}, r{comb}.{combdepth}).x;
      r{acc}.{accc} = r{samp2reg}.{samp2c} + r{acc}.{accc};
    }}
  }}
"""


def convert(text: str) -> tuple[str, list]:
    notes = []
    idx = text.find("while (true) {")
    if idx == -1:
        return text, ["no while loop found"]
    preamble, rest = text[:idx], text[idx:]

    # 1) find and remove the pre-loop center tap
    ctm = CENTER_TAP_RE.search(preamble)
    if not ctm:
        return text, ["no pre-loop center tap found (matches known exclusion e.g. 91035eee)"]
    ctrres, ctrresc = ctm.group("ctrres"), ctm.group("ctrresc")
    preamble = preamble[:ctm.start()] + preamble[ctm.end():]

    # 2) find the line that seeds the accumulator from that center tap result,
    #    and replace its RHS with 0 instead
    acc_re = re.compile(r"r(\d+)\.(" + COMP + r") = r" + re.escape(ctrres) + r"\." + re.escape(ctrresc) + r";\r?\n")
    am = acc_re.search(preamble)
    if not am:
        return text, [f"center tap removed but couldn't find its accumulator-seed line (r?.? = r{ctrres}.{ctrresc};)"]
    acc, accc = am.group(1), am.group(2)
    preamble = preamble[:am.start()] + f"  r{acc}.{accc} = 0;\r\n" + preamble[am.end():]

    # 3) rewrite the loop body
    new_rest, n = LOOP_RE.subn(build_loop_replacement, rest)
    if n == 0:
        return text, ["center tap removed but loop body pattern didn't match"]

    new_text = preamble + new_rest

    decl_new, decl_n = DECL_RE.subn(
        r"\1  float ignAngle, ign_sin, ign_cos, spiralR, spiralTheta, rotX, rotY;\r\n",
        new_text, count=1,
    )
    if decl_n == 0:
        return text, ["converted but couldn't find float4 r0,... declaration line"]

    return decl_new, notes


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("folder", help="folder containing .hlsl files to convert")
    ap.add_argument("--out", default=None, help="output folder (default: <folder>/converted2)")
    ap.add_argument("--inplace", action="store_true", help="overwrite files in place")
    args = ap.parse_args()

    folder = Path(args.folder)
    if not folder.is_dir():
        print(f"Error: '{folder}' is not a folder", file=sys.stderr)
        sys.exit(1)

    out = folder if args.inplace else Path(args.out or (folder / "converted2"))
    if not args.inplace:
        out.mkdir(parents=True, exist_ok=True)

    ok, skipped = 0, 0
    for f in sorted(folder.glob("*.hlsl")):
        text = f.read_text(encoding="utf-8", errors="ignore")
        new_text, notes = convert(text)
        if notes:
            print(f"[SKIP] {f.name}: {notes[0]}")
            skipped += 1
            continue
        target = f if args.inplace else out / f.name
        target.write_text(new_text, encoding="utf-8")
        print(f"[OK]   {f.name}")
        ok += 1

    print(f"\nDone: {ok} converted, {skipped} skipped.")


if __name__ == "__main__":
    main()