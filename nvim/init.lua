require("nvim-tree").setup {}
require("options")
require("keymaps")
require("lsp")
require("treesitter")
require("theme")

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
