{
  pkgs,
  ...
}:

{
  packages = [
    pkgs.ruff
  ];

  languages.python = {
    enable = true;
    uv.enable = true;
  };
}
