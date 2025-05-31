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
    pkgs.just
    pkgs.jupyter
  ];

  languages.python = {
    enable = true;
    uv.enable = true;
  };

  dotenv.enable = true;
}
