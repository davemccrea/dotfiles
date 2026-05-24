return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Git: " .. desc })
            end
            map("]h", function() gs.nav_hunk("next") end, "Next [H]unk")
            map("[h", function() gs.nav_hunk("prev") end, "Prev [H]unk")
            map("<leader>gs", gs.stage_hunk, "[G]it [S]tage hunk")
            map("<leader>gr", gs.reset_hunk, "[G]it [R]eset hunk")
            map("<leader>gp", gs.preview_hunk, "[G]it [P]review hunk")
            map("<leader>gb", function() gs.blame_line({ full = true }) end, "[G]it [B]lame line")
        end,
    },
}
