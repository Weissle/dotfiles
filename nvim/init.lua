-- your custom config
--require("custom")
require("settings")
require("mappings")
-- impatient slow down startup when we don't use auto-session
-- if vim.g.auto_session_enabled ~= false then
--     pcall(require, "impatient")
-- end
require("plugins")
--require("mappings")
