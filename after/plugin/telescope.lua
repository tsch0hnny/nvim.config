-- Load Telescope and set up extensions
require('telescope').setup({
    defaults = {
        -- Your default config here
    },
    extensions = {
        emoji = {
            action = function(emoji)
                -- What to do with the selected emoji
                vim.api.nvim_put({emoji.value}, 'c', false, true)
            end,
        },
        tailiscope = {
            default = "all"
        },
        cmdline = {
            
        }
    },
})

-- Load Telescope extensions
require('telescope').load_extension('emoji')
require('telescope').load_extension('tailiscope')
require('telescope').load_extension('cmdline')

-- Built-in pickers
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fsh', builtin.search_history, {})
vim.keymap.set('n', '<leader>sug', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>km', builtin.keymaps, {})
vim.keymap.set('n', '<leader>gcom', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gst', builtin.git_status, {})

-- Key mapping for emoji picker
vim.keymap.set('n', '<leader>fe', function() require('telescope').extensions.emoji.emoji() end, {})

-- Key mapping for tailiscope
vim.keymap.set('n', '<leader>tailwind', function() require('telescope').extensions.tailiscope.tailiscope() end, {})

-- Key mapping for telescope-cmdline
vim.keymap.set('n', ':', function() require('telescope').extensions.cmdline.cmdline() end, {})
