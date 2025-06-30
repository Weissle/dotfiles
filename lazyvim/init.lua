-- REAL_KEY_DEL = vim.keymap.del
-- vim.keymap.del = function(m, l, o)
--   if l == "<c-k>" then
--     print(debug.traceback(), l)
--     print("del ", l, " mode", m)
--   end
--   REAL_KEY_DEL(m, l, o)
-- end

-- REAL_KEY_SET = vim.keymap.set
-- vim.keymap.set = function(m, l, r, o)
--   if l == "<c-k>" then
--     print(debug.traceback(), l)
--     print("mode ", m, "set ", l, " ", r)
--   end
--   REAL_KEY_SET(m, l, r, o)
-- end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
