
local config = require("fzf-lua.config")
local actions = require("trouble.sources.fzf").actions
config.defaults.actions.files["ctrl-t"] = actions.open

require("trouble").setup(config)
