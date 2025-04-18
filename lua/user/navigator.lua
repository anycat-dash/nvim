local status_ok, nav = pcall(require, "navigator")
if not status_ok then
  return
end

nav.setup({
  lsp = {
    format_on_save = false,
    servers = { "terraformls" },
    disable_lsp = {'jdtls'}
  }
})
