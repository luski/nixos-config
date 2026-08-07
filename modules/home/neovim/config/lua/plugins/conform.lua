return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome", "prettierd", stop_after_first = true },
      typescript = { "biome", "prettierd", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", stop_after_first = true },
      typescriptreact = { "biome", "prettierd", stop_after_first = true },
      json = { "biome", "prettierd", stop_after_first = true },
      css = { "prettierd" },
      astro = { "prettierd" },
      scss = { "prettierd" },
      html = { "prettierd" },
      markdown = { "prettierd" },
      vue = { "prettierd" },
    },
  },
}
