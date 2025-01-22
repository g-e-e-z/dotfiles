local options = {
    guicursor="",
    relativenumber = true,
    hlsearch = false,
    hidden = true,
    errorbells = false,
    tabstop=4,
    softtabstop=4,
    shiftwidth=4,
    expandtab = true,
    smartindent = true,
    nu = true,
    wrap = false,
    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
    incsearch = true,
    termguicolors = true,
    scrolloff=8,
    signcolumn="yes",
    cmdheight=1,
    updatetime=50,
    colorcolumn="80",
    cursorline = true,
    splitright=true,
    formatoptions="co",
    conceallevel = 2,
}

for name, value in pairs(options) do
  vim.opt[name] = value
end
