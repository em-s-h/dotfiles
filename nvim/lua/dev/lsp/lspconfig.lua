-- luacheck: ignore 212
-- luacheck: ignore 113

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    print("lspconfig is not installed!")
    return
end

local cmp_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_lsp_status then
    print("cmp-nvim-lsp is not installed!")
    return
end

local keymap = vim.keymap

-- Enable keybindings when a LSP server is available.
local on_attach = function(client, bufnr)
    -- Keybind options.
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- keybindings.
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- Show diagnostics for cursor.
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- Show diagnostics for line.

    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)       -- Go to implementation.
    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)          -- Go to declaration.

    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- Jump to previous diagnostic in buffer.
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- Jump to next diagnostic in buffer.

    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)            -- See available code actions.
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)                 -- See outline on right hand side.

    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)                -- See definition and make edits in window.
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)                     -- Show definition, references.

    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                 -- Smart rename.
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- Show documentation for what is under cursor.
end

-- Used to enable autocompletion.
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter).
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Html server
lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Js, Ts server.
lspconfig.tsserver.setup({
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
    },
})

-- Css server.
lspconfig.cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Rust server.
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- C# server.
lspconfig.omnisharp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- -- GDscript server.
-- lspconfig.gdscript.setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- C/C++ server.
lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Python server.
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Lua runtime path.
local lua_rtp = vim.split(package.path, ";")

-- Lua server.
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim).
                version = "LuaJIT",
                path = lua_rtp,
            },

            -- Make language server aware of runtime files.
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },

            -- Do not send telemetry data containing a randomized but unique identifier.
            telemetry = {
                enable = false,
            },
        },
    },

    capabilities = capabilities,
    on_attach = on_attach,
})
