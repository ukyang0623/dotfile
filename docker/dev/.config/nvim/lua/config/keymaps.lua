local keymap = vim.keymap.set
vim.g.mapleader = " " -- 设置 leader 键为空格
vim.g.maplocalleader = " "

-- 基本操作
keymap("i", "jk", "<Esc>", { noremap = true, desc = "back to normal mode" })
keymap({ "n", "v" }, "ds", "V", { noremap = true, desc = "change to visual mode with line" })
keymap({ "n", "v" }, "H", "^", { noremap = true, desc = "move to the home of the line" })
keymap({ "n", "v" }, "L", "$", { noremap = true, desc = "move to the end of the line" })
keymap({ "n" }, "<C-d>", "10jzt",
    { noremap = true, desc = "scroll [d]own 10 lines and move the current line to the top of the window" })
keymap({ "n" }, "<C-u>", "10kzt",
    { noremap = true, desc = "scroll [u]p 10 lines and move the current line to the top of the window" })
keymap({ "n", "v" }, "<C-a>", "ggVG", { noremap = true, desc = "select all region" })
keymap({ "n", "v", "i" }, "<C-z>", "<ESC>u", { noremap = true, desc = "undo" })
keymap("n", "U", "<C-r>", { noremap = true, desc = "[R]edo" })
keymap("n", "<leader>nh", "<Cmd>nohlsearch<CR>", { noremap = true, desc = "clean search highlight" })
keymap("n", "<leader>rs", "<Cmd>restart<CR>", { noremap = true, desc = "restart nvim" })
keymap("n", "<A-Left>", "<C-o>", { noremap = true, desc = "back" })
keymap("n", "<A-Right>", "<C-i>", { noremap = true, desc = "forward" })
keymap("n", "q", "ddO", { noremap = true, desc = "reword form the home of the line" })
keymap("n", "<leader>q", vim.diagnostic.open_float, { noremap = true, desc = "Open diagnostic [Q]uickfix message" })
keymap("n", "<leader>ql", vim.diagnostic.setloclist, { noremap = true, desc = "Open diagnostic [Q]uickfix [L]ist" })
keymap("n", "<leader>pi", ":IrisvimPlugins<CR>", { noremap = true, desc = "Show [P]lugins [I]nfo" })
keymap("n", "<leader>da", ":Dashboard<CR>", { noremap = true, desc = "Show [Da]shboard" })
keymap("n", "s", "<Plug>(leap)", { noremap = true, desc = "jump to everywhere" })
keymap("n", "S", "<Plug>(leap-from-window)", { noremap = true, desc = "jump to every window" })
keymap({ "n", "i", "v" }, "<C-s>", "<ESC><Cmd>w<CR>", { noremap = true, desc = "save file" })
keymap("n", "<leader>ll", "30zl", { noremap = true, desc = "go right" })
keymap("n", "<leader>hh", "30zh", { noremap = true, desc = "go left" })
-- buffer操作
keymap("n", "bc", "<Cmd>bdelete %<CR>", { noremap = true, desc = "close this buffer" })
keymap("n", "bp", "<Cmd>BufferLinePickClose<CR>", { noremap = true, desc = "close pick buffer" })
keymap("n", "bo", "<Cmd>BufferLineCloseOthers<CR>",
    { noremap = true, desc = "close other buffers" })
-- window操作
keymap("n", "sv", "<Cmd>vs<CR><C-w>l", { noremap = true, desc = "vsplit" })
keymap("n", "sp", "<Cmd>sp<CR><C-w>j", { noremap = true, desc = "split" })
keymap({ "n", "i", "v" }, "<C-q>", "<Cmd>qa<CR>", { noremap = true, desc = "close neovim" })
keymap("n", "sc", "<C-w>c", { noremap = true, desc = "close window (not the last window)" })
keymap("n", "so", "<C-w>o", { noremap = true, desc = "close other windows" })
keymap({ "n", "v" }, "<A-h>", "<C-w>h", { noremap = true, desc = "Move focus to the left window" })
keymap({ "n", "v" }, "<A-j>", "<C-w>j", { noremap = true, desc = "Move focus to the lower window" })
keymap({ "n", "v" }, "<A-k>", "<C-w>k", { noremap = true, desc = "Move focus to the upper window" })
keymap({ "n", "v" }, "<A-l>", "<C-w>l", { noremap = true, desc = "Move focus to the right window" })
keymap("n", "<C-h>", "<C-w>H", { desc = "Move window to the left" })
keymap("n", "<C-l>", "<C-w>L", { desc = "Move window to the right" })
keymap("n", "<C-j>", "<C-w>J", { desc = "Move window to the lower" })
keymap("n", "<C-k>", "<C-w>K", { desc = "Move window to the upper" })
keymap("n", "<C-Up>", "<Cmd>resize +2<CR>", { noremap = true, desc = "Increase window height" })
keymap("n", "<C-Down>", "<Cmd>resize -2<CR>", { noremap = true, desc = "Decrease window height" })
keymap("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { noremap = true, desc = "Decrease window width" })
keymap("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { noremap = true, desc = "Increase window width" })
-- 退出终端模式（回到 Normal 模式）
keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, desc = "" })
-- 在终端窗口间跳转（保持 Terminal 模式）
keymap('t', '<A-h>', '<C-\\><C-n><C-w>h', { noremap = true, desc = "" })
keymap('t', '<A-j>', '<C-\\><C-n><C-w>j', { noremap = true, desc = "" })
keymap('t', '<A-k>', '<C-\\><C-n><C-w>k', { noremap = true, desc = "" })
keymap('t', '<A-l>', '<C-\\><C-n><C-w>l', { noremap = true, desc = "" })
-- tab操作
keymap("n", "tn", "<Cmd>tabnew<CR>", { noremap = true, desc = "create new tab" })
keymap("n", "tc", "<Cmd>tabc<CR>", { noremap = true, desc = "close this tab" })
keymap("n", "to", "<Cmd>tabo<CR>", { noremap = true, desc = "close other tab" })
keymap("n", "tr", "<Cmd>RenameTabPage<CR>", { noremap = true, desc = "rename the tab" })
keymap("n", "tp", "<Cmd>Tabby pick_window<CR>", { noremap = true, desc = "pick tab" })
keymap("n", "tj", "<Cmd>Tabby jump_to_tab<CR>", { noremap = true, desc = "jump to tab" })
-- git操作
keymap("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, desc = "open Lazy[G]it" })
-- session操作
-- keymap("n", "<leader>sw", "<cmd>AutoSession save<CR>", { noremap = true, desc = "save session" })
-- keymap("n", "<leader>ss", "<cmd>AutoSession search<CR>", { noremap = true, desc = "search session" })
-- keymap("n", "<leader>sd", "<cmd>AutoSession deletePicker<CR>", { noremap = true, desc = "delete session" })
-- keymap("n", "<leader>sr", "<cmd>AutoSession restore<CR>", { noremap = true, desc = "restore session" })
-- 格式化
keymap("n", "<C-A-l>",
    function()
        vim.lsp.buf.format()
    end,
    { desc = "format" }
)
-- 快速跳转诊断
-- shift+f2
keymap("n", "<S-F2>",
    function()
        vim.diagnostic.jump({ wrap = true, count = 1 })
    end,
    { noremap = true, desc = "prev diagnostic" }
)
keymap("n", "<F2>",
    function()
        vim.diagnostic.jump({ wrap = true, count = 1 })
    end,
    { noremap = true, desc = "next diagnostic" }
)

-- 系统剪贴板
-- keymap({ "n", "v" }, "<leader>c", '"+y', { noremap = true, desc = "copy to system clipboard" })
-- keymap({ "n", "v" }, "<leader>x", '"+d', { noremap = true, desc = "cut to system clipboard" })
-- keymap({ "n", "v" }, "<leader>p", '"+p', { noremap = true, desc = "paste to system clipboard" })
-- 撤销
-- 行移动
-- keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, desc = "Move line down" })
-- keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, desc = "Move line up" })
-- keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selection down" })
-- keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selection up" })
-- 文件/插件快捷键
keymap("n", "<leader>e", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>",
    { noremap = true, desc = "open file explorer" })
keymap("n", "<leader>f", "<Cmd>Pick files<CR>", { noremap = true, desc = "open file picker" })
keymap("n", "<leader>h", "<Cmd>Pick help<CR>", { noremap = true, desc = "open help picker" })
keymap("n", "<leader>b", "<Cmd>Pick buffers<CR>", { noremap = true, desc = "open buffer picker" })
-- LSP 快捷键
keymap("n", "gd", vim.lsp.buf.definition, { noremap = true, desc = "[G]o to [d]efinition" })
keymap("n", "gD", vim.lsp.buf.declaration, { noremap = true, desc = "Go to declaration" })
keymap("n", "gi", vim.lsp.buf.implementation, { noremap = true, desc = "Go to implementation" })
keymap("n", "gr", vim.lsp.buf.references, { noremap = true, desc = "Find references" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, desc = "LSP code action" })
-- 全局查找/搜索快捷键
keymap("n", "<leader>sa", function()
    -- 1. 弹窗让用户输入路径（如：components/user, src/utils）
    local path = vim.fn.input("Search directory (e.g. src/): ", "", "dir")
    if path == "" then
        path = "."
    end

    -- 2. 打开 Spectre 并设置路径
    --vim.fn.getcwd()
    require("spectre").toggle({
        cwd = path,
        -- search_paths = { path },
    })
end, { noremap = true, desc = "Toggle Spectre" })
keymap("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
    { noremap = true, desc = "[s]earch current [w]ord" })
-- 终端快捷键
keymap("n", "<leader>t1", "<Cmd>1ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 1" })
keymap("n", "<leader>t2", "<Cmd>2ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 2" })
keymap("n", "<leader>t3", "<Cmd>3ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 3" })
keymap("n", "<leader>t4", "<Cmd>4ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 4" })
keymap("n", "<leader>t5", "<Cmd>5ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 5" })
keymap("n", "<leader>t6", "<Cmd>6ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 6" })
keymap("n", "<leader>t7", "<Cmd>7ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 7" })
keymap("n", "<leader>t8", "<Cmd>8ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 8" })
keymap("n", "<leader>t9", "<Cmd>9ToggleTerm direction=horizontal<CR>", { noremap = true, desc = "Toggle terminal 9" })
keymap("n", "<leader>tt", "<Cmd>10ToggleTerm direction=float<CR>", { noremap = true, desc = "Toggle terminal 10" })
