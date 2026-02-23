-- [[ style and colorscheme ]] --

local M = {}

function M.apply()
    vim.pack.add({
        { src = "https://github.com/vague2k/vague.nvim" },
    })

    vim.cmd.colorscheme("vague")

    vim.api.nvim_set_hl(0, "Search", {
        fg = "#000000",
        bg = "#ffcc00",
    })

    vim.api.nvim_set_hl(0, "IncSearch", {
        fg = "#000000",
        bg = "#ff8800",
    })

    -- currently manually specifying markdown coloring for vague colorscheme

    local c = {
        bg = "#141415",
        darktext = "#1c1c24",
        fg = "#cdcdcd",
        floatBorder = "#878787",
        line = "#252530",
        italic = "#b4d4cf",
        func = "#c48282",
        property = "#c3c3d5",
        constant = "#aeaed1",
        parameter = "#bb9dbd",
        bold = "#d8647e",
        title = "#f3be7c",
        title2 = "#7e98e8",
        operator = "#90a0b5",
        keyword = "#6e94b2",
        type = "#9bb4bc",
        search = "#405065",
        plus = "#7fa563",
        delta = "#f3be7c",
    }

    vim.api.nvim_set_hl(0, "Title", { fg = c.title, bold = true })
    vim.api.nvim_set_hl(0, "markdownH1", { fg = c.title2, bold = true })
    vim.api.nvim_set_hl(0, "markdownH2", { fg = c.title, bold = true })
    vim.api.nvim_set_hl(0, "markdownH3", { fg = c.title2, bold = true })
    vim.api.nvim_set_hl(0, "markdownH4", { fg = c.title })

    vim.api.nvim_set_hl(0, "markdownBold", { fg = c.darktext, bg = c.bold, bold = true })
    vim.api.nvim_set_hl(0, "markdownItalic", { fg = c.darktext, bg = c.italic, italic = true })

    vim.api.nvim_set_hl(0, "markdownCode", { fg = c.title, bg = c.line })
    vim.api.nvim_set_hl(0, "markdownCodeBlock", { fg = c.title, bg = c.line })

    vim.api.nvim_set_hl(0, "markdownLinkText", { fg = c.title2, underline = true })
    vim.api.nvim_set_hl(0, "markdownUrl", { fg = c.operator })
end

return M
