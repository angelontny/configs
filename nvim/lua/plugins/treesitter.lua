return {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "13be7a022997446bf96892bf1ac95784681a02e1", -- v0.9.3 for Neovim 0.9 compatibility
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = {
        enable = true,
        disable = function(lang, buf)
          -- Neovim 0.9 query engine does not support newer tree-sitter-lua grammar queries
          if lang == "lua" and vim.fn.has("nvim-0.10") == 0 then
            return true
          end
          return false
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
