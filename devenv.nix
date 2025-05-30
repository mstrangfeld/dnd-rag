{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.ruff
    pkgs.zlib
    pkgs.python312Packages.pandas
    pkgs.cairo
  ];

  languages.python = {
    enable = true;
    uv.enable = true;
  };

  dotenv.enable = true;
}
