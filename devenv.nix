{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.ruff
    pkgs.zlib
    pkgs.python312Packages.pandas
  ];

  languages.python = {
    enable = true;
    uv.enable = true;
  };
}
