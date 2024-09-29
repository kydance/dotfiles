--

-- Mason
local mason_ok, cfg_mason = pcall(require, "mason")
if not mason_ok then
	return
end
cfg_mason.setup()

-- null_ls
local null_ls_ok, cfg_null_ls = pcall(require, "null-ls")
if not null_ls_ok then
	return
end

local sources = {
	cfg_null_ls.builtins.formatting.black.with({
        extra_args = {
            "--target-version", "py312"
        }
    }),
	cfg_null_ls.builtins.formatting.stylua,
}

cfg_null_ls.setup({
	debug = false,
	log_level = "warn",
	update_in_insert = false,
	sources = sources,
})

-- mason_null_ls
local mason_null_ls_ok, cfg_mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
	return
end

cfg_mason_null_ls.setup({
	-- A list of sources to install if they're not already installed.
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = {
		"black",
		"stylua",
        "jq",
	},
	automatic_installation = false,
	-- Sources found installed in mason will automatically be setup for null-ls.
	automatic_setup = true,
	handlers = {},
})
