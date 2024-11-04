{
  programs.nixvim = {
    enable = true;
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
