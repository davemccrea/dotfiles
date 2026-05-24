vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 999
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.termguicolors = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>q", "<cmd>bw<CR>", { desc = "[Q]uit buffer" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite buffer" })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "tpope/vim-sleuth" },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            require("which-key").setup()
            require("which-key").add({
                { "<leader>c", group = "[C]ode" },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>r", group = "[R]ename" },
                { "<leader>s", group = "[S]earch" },
                { "<leader>t", group = "[T]oggle" },
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function()
                return vim.fn.executable("make") == 1
            end },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        config = function()
            require("telescope").setup({
                extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } },
            })
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
            vim.keymap.set("n", "<leader>sf", function()
                builtin.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
            end, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
            vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent" })
            vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
            end, { desc = "[/] Fuzzy current buffer" })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
            auto_install = true,
            highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
            indent = { enable = true, disable = { "ruby" } },
        },
        config = function(_, opts)
            require("nvim-treesitter.install").prefer_git = true
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "folke/neodev.nvim", opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end
                    local builtin = require("telescope.builtin")
                    map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
                    map("gr", builtin.lsp_references, "[G]oto [R]eferences")
                    map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
                    map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
                    map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover")
                    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        local hl = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { buffer = event.buf, group = hl, callback = vim.lsp.buf.document_highlight })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { buffer = event.buf, group = hl, callback = vim.lsp.buf.clear_references })
                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                            callback = function(e) vim.lsp.buf.clear_references(); vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = e.buf }) end,
                        })
                    end
                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        map("<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            local capabilities = vim.tbl_deep_extend("force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities())

            local servers = {
                tailwindcss = {
                    filetypes = { "html", "elixir", "heex" },
                    init_options = { userLanguages = { elixir = "html-eex", heex = "html-eex" } },
                },
                lua_ls = {
                    settings = { Lua = { completion = { callSnippet = "Replace" } } },
                },
            }

            require("mason").setup()
            require("mason-tool-installer").setup({ ensure_installed = vim.list_extend(vim.tbl_keys(servers), { "stylua" }) })
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },

    {
        "stevearc/conform.nvim",
        lazy = false,
        keys = {
            { "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end, mode = "", desc = "[F]ormat buffer" },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                return { timeout_ms = 500, lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype] }
            end,
            formatters_by_ft = { lua = { "stylua" } },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip", build = (vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0) and nil or "make install_jsregexp" },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})
            cmp.setup({
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<C-l>"] = cmp.mapping(function() if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end end, { "i", "s" }),
                    ["<C-h>"] = cmp.mapping(function() if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end end, { "i", "s" }),
                }),
                sources = { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "path" } },
            })
        end,
    },

    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            require("mini.surround").setup()
            local statusline = require("mini.statusline")
            statusline.setup({ use_icons = vim.g.have_nerd_font })
            statusline.section_location = function() return "%2l:%-2v" end
        end,
    },

    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({ columns = { "icon" }, view_options = { show_hidden = true } })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            vim.keymap.set("n", "<space>-", require("oil").toggle_float)
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },

    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
    },

    {
        "https://git.sr.ht/~marcc/BufferBrowser",
        config = function()
            require("buffer_browser").setup()
            vim.keymap.set("n", "<M-k>", require("buffer_browser").next, { desc = "Next buffer" })
            vim.keymap.set("n", "<M-j>", require("buffer_browser").prev, { desc = "Previous buffer" })
        end,
    },
})
