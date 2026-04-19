vim.pack.add({
    { src = "https://github.com/akinsho/toggleterm.nvim", name = "terminal-toggleterm.nvim" }, -- 终端
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<C-\>]],
            persist_mode = true, -- 记住终端状态
            persist_size = true, -- 记住终端尺寸
        })
    end
})
