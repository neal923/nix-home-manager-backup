-- Neovim 0.11+ 原生 LSP 配置

local lsp = vim.lsp

-- ===== Nix =====
lsp.config["nil_ls"] = {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", "default.nix", ".git" },
}

-- ===== TypeScript / JavaScript =====
lsp.config["ts_ls"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
}

-- ===== Rust =====
lsp.config["rust_analyzer"] = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
}

-- ===== Java =====
lsp.config["jdtls"] = {
  cmd = { "jdtls" },
  filetypes = { "java" },
  root_markers = { "gradlew", "pom.xml", ".git" },
}

-- 启用所有已配置的 server
for name, _ in pairs(lsp.config) do
  lsp.enable(name)
end

-- ===== Keymaps =====
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

