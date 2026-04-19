vim.pack.add({
    { src = "https://github.com/shellRaining/hlchunk.nvim", name = "indent-hlchunk.nvim" }, -- 缩进美化插件
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    callback = function()
        require("hlchunk").setup({
            -- ===== 核心：缩进线设置 =====
            indent = {
                enable = true, -- 开启缩进线
                chars = { "│" }, -- 竖线符号，也可以用 "▏", "┃", "┆"
                style = {
                    { fg = "#3b4252" }, -- 第1层颜色
                    { fg = "#4c566a" }, -- 第2层颜色
                    { fg = "#434c5e" }, -- 第3层颜色
                    { fg = "#4c566a" }, -- 第4层，可循环
                },
                -- 排除特定文件类型
                exclude_filetypes = {
                    "help", "dashboard", "NvimTree", "Trouble", "lazy", "mason",
                    "markdown", "text", "neo-tree", "alpha", "oil"
                }
            },

            -- ===== 代码块高亮 =====
            chunk = {
                enable = true,               -- 开启代码块高亮
                notify = false,              -- 关闭通知提示
                use_treesitter = true,       -- 使用 Treesitter 更准确
                support_filetypes = { "*" }, -- 支持所有文件类型
                exclude_filetypes = {},      -- 排除文件类型（为空表示不排除）

                -- 代码块颜色（这里使用较深的背景色，不刺眼）
                style = {
                    { fg = "#FF6B6B", bg = "NONE" }, -- 红色边框
                },

                -- 高亮方式：边框、背景、下划线
                chars = {
                    horizontal_line = "─", -- 水平线
                    vertical_line = "│", -- 竖直线
                    left_top_corner = "╭", -- 左上角
                    left_bottom_corner = "╰", -- 左下角
                    right_arrow = ">", -- 右侧箭头
                },

                -- 不同层级使用不同颜色
                chunk_highlight_group = {
                    { fg = "#FF6B6B" }, -- 第1层：红
                    { fg = "#4ECDC4" }, -- 第2层：青
                    { fg = "#FFD166" }, -- 第3层：黄
                    { fg = "#06D6A0" }, -- 第4层：绿
                    { fg = "#118AB2" }, -- 第5层：蓝
                    { fg = "#EF476F" }, -- 第6层：粉
                },
            },

            -- ===== 行号高亮 =====
            line_num = {
                enable = true, -- 通常不需要，保持 false
            },

            -- ===== 空白字符高亮 =====
            blank = {
                enable = false, -- 关闭空白高亮（通常用其他插件）
            },

            -- ===== 性能优化 =====
            -- 如果你的项目文件很大（>1000行），开启这些优化
            performance = {
                fps = 60,             -- 刷新率
                max_scan_times = 200, -- 最大扫描次数
                debounce_time = 300,  -- 防抖时间（毫秒）
            },
        })
    end
})
