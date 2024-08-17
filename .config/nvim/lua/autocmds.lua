local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on copy
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = "300",
        })
    end,
})

-- Don"t auto comment new lines
autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o",
})

autocmd("Filetype", {
    pattern = { "xml", "html", "xhtml", "css", "scss", "yaml", "lua" },
    command = "setlocal shiftwidth=4 tabstop=4",
})

autocmd("Filetype", {
    pattern = { "javascript", "typescript" },
    command = "setlocal shiftwidth=4 tabstop=4 colorcolumn=100",
})

autocmd("Filetype", {
    pattern = { "python", "rust", "c", "cpp" },
    command = "set colorcolumn=100",
})

autocmd("Filetype", {
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

