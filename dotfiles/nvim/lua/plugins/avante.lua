local function path_has_folder(path, folder)
  for part in vim.fs.normalize(path):gmatch("[^/]+") do
    if part == folder then
      return true
    end
  end

  return false
end

local function avante_provider()
  local buf_path = vim.api.nvim_buf_get_name(0)
  local path = buf_path ~= "" and buf_path or vim.uv.cwd() or ""

  if path_has_folder(path, "sf-gui") or path_has_folder(path, "sf-gui-clone") then
    return "claude"
  end

  return "codex"
end

local current_provider = avante_provider()

vim.api.nvim_create_user_command("AvanteClearSelectedCode", function()
  local sidebar = require("avante").get()

  if sidebar.code then
    sidebar.code.selection = nil
  end

  if sidebar.containers and sidebar.containers.selected_code then
    sidebar.containers.selected_code:unmount()
    sidebar.containers.selected_code = nil
  end
end, {})

return {
  "yetone/avante.nvim",
  disabled = true,
  enabled = false,
  init = function()
    vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
      group = vim.api.nvim_create_augroup("AvanteProjectProvider", { clear = true }),
      callback = function()
        local provider = avante_provider()
        if provider == current_provider then
          return
        end

        local ok, providers = pcall(require, "avante.providers")
        if ok then
          current_provider = provider
          providers.refresh(provider)
        end
      end,
    })
  end,
  opts = {
    provider = current_provider,
    acp_providers = {
      cursor = {
        command = os.getenv("HOME") .. "/.local/bin/agent",
        args = { "acp" },
        auth_method = "cursor_login",
        env = {
          HOME = os.getenv("HOME"),
          PATH = os.getenv("PATH"),
        },
      },
      codex = {
        command = "codex-acp",
        args = {},
        env = {
          NODE_NO_WARNINGS = "1",
          OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
        },
      },
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("avante.api").ask()
      end,
      mode = "x",
      desc = "Avante ask about selection",
    },
    {
      "<leader>ae",
      function()
        require("avante.api").edit()
      end,
      mode = "x",
      desc = "Avante edit selection",
    },
  },
}
