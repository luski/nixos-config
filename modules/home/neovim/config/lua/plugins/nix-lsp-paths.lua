local function real_exepath(command)
  local executable = vim.fn.exepath(command)
  return executable ~= "" and vim.uv.fs_realpath(executable) or nil
end

local function vue_plugin_path()
  local executable = real_exepath("vue-language-server")
  local package_root = executable and executable:match("^(.*)/bin/[^/]+$")
  return package_root and (package_root .. "/lib/language-tools/packages/language-server") or nil
end

local function astro_plugin_path()
  local executable = real_exepath("astro-ls")
  local package_root = executable and executable:match("^(.*)/lib/node_modules/astro%-language%-server/")
  return package_root
    and (package_root .. "/lib/node_modules/astro-language-server/packages/language-tools/ts-plugin")
    or nil
end

return {
  {
    "LazyVim/LazyVim",
    init = function()
      local mason_get_pkg_path = LazyVim.get_pkg_path
      local nix_paths = {
        ["vue-language-server"] = vue_plugin_path,
        ["astro-language-server"] = astro_plugin_path,
      }

      LazyVim.get_pkg_path = function(package, path, opts)
        local resolve = nix_paths[package]
        local nix_path = resolve and resolve()

        if nix_path and vim.uv.fs_stat(nix_path) then
          return nix_path
        end

        return mason_get_pkg_path(package, path, opts)
      end
    end,
  },
}
