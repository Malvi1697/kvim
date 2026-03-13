return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "json", "bash", "markdown", "vim", "vue", "go", "gomod", "gosum", "gotmpl" },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "around function" },
          ["if"] = { query = "@function.inner", desc = "inside function" },
          ["ac"] = { query = "@class.outer", desc = "around class" },
          ["ic"] = { query = "@class.inner", desc = "inside class" },
          ["aa"] = { query = "@parameter.outer", desc = "around argument" },
          ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = { query = "@function.outer", desc = "Next function" },
          ["]]"] = { query = "@class.outer", desc = "Next class" },
        },
        goto_prev_start = {
          ["[m"] = { query = "@function.outer", desc = "Prev function" },
          ["[["] = { query = "@class.outer", desc = "Prev class" },
        },
      },
    },
  },
}
