-- null_ls format

local util = require("core.util")
local ok, null_ls = pcall(require, "null-ls")
if not ok then
	util.log_warn("nim-null-ls init failed.")
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
