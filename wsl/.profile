if ! pgrep -x dockerd > /dev/null 2>&1; then
    echo "Starting Docker daemon..."
    # 使用 nohup 和 & 在后台启动，并忽略输出
    nohup dockerd > /dev/null 2>&1 &
    # 等待 2 秒确保启动完成
    # sleep 2
fi
