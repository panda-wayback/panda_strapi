#!/bin/bash
# 配置 PM2 开机自启

echo "⚙️  配置 PM2 开机自启..."

# 检查 PM2 是否安装
if ! command -v pm2 &> /dev/null; then
    echo "❌ PM2 未安装，请先运行 make start"
    exit 1
fi

# 确保保存当前进程列表
pm2 save

# 获取 startup 命令
STARTUP_OUTPUT=$(pm2 startup 2>&1)

# 检查是否已配置
if echo "$STARTUP_OUTPUT" | grep -q "already setup\|already configured"; then
    echo "✅ 开机自启已配置"
    exit 0
fi

# 提取需要执行的命令
STARTUP_CMD=$(echo "$STARTUP_OUTPUT" | grep -E "sudo.*env.*PATH" | tail -n 1)

if [ -z "$STARTUP_CMD" ]; then
    echo "❌ 无法获取启动命令"
    echo "$STARTUP_OUTPUT"
    exit 1
fi

echo ""
echo "📋 请执行以下命令以完成开机自启配置："
echo ""
echo "$STARTUP_CMD"
echo ""
echo "💡 提示：这通常需要 sudo 权限"
echo ""
echo "执行后，重启电脑时应用将自动启动。"

