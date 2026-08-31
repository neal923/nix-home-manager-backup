require("nvim-treesitter").setup {}

-- nvim-treesitter 重写版移除了 configs.setup，高亮与缩进改为按 buffer 启用。
-- 语法解析器由 Nix 的 nvim-treesitter.withAllGrammars 提供，无需 :TSInstall。
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang then
      return
    end

    local ok, added = pcall(vim.treesitter.language.add, lang)
    if not (ok and added) then
      return
    end

    vim.treesitter.start(args.buf, lang)

    -- 延后设置，避免被 runtime 自带的 ftplugin indent 脚本覆盖
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end)
  end,
})
