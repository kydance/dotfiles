-- Auto pair

local util = require("core.util")
local is_ok, cfg = pcall(require, "nvim-autopairs")
if not is_ok then
	util.log_warn("nvim-autopairs init failed.")
	return
end

cfg.setup({
	check_ts = true, -- check if treesitter is installed
	map_bs = true,
	disable_filetype = { "TelescopePrompt" },
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
