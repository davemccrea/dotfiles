return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "folke/lazydev.nvim", ft = "lua", opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } } },
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
                map("<leader>e", vim.diagnostic.open_float, "Show [E]rror")
                map("<leader>ws", builtin.lsp_workspace_symbols, "[W]orkspace [S]ymbols")

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
}
