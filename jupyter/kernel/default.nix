{ stdenv
, jq
, env
, kernelSrc ? env
, prefix ? env.name
, note ? " (nix/${prefix})"
}:

stdenv.mkDerivation rec {
  name = "jupyter-kernel-${prefix}";
  nativeBuildInputs = [jq] ++ stdenv.lib.optional (builtins.isAttrs kernelSrc) kernelSrc;
  propagatedBuildInputs = stdenv.lib.optional (builtins.isAttrs env) env;
  inherit kernelSrc env prefix note;
  builder = ./builder.sh;
}