-- null_ls format
local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

null_ls.setup({
	debug = false,
	log_level = "warn",
	update_in_insert = false,
	sources = {
		null_ls.builtins.formatting.black.with({
			extra_args = {
				"--target-version",
				"py312",
			},
		}),
		null_ls.builtins.formatting.stylua,
	},
})
