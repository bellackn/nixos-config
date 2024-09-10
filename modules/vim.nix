{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    opts =
      {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };
    plugins = {
      lightline.enable = true;
    };
  };
}
