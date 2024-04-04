{ pkgs, ...}:
{
 refactoring-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "refactoring.nvim";
    version = "c9c1a0995b7d9a534f3b9a4df7fd55240127eeb4";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "refactoring.nvim";
      rev = "c9c1a0995b7d9a534f3b9a4df7fd55240127eeb4";
      hash = "sha256-QtqNMcGVzI2TJQdRhE7GWWS8YQMYk696OZYB0R5UUrk=";
    };
  };
}
