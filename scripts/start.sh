#!/bin/bash
# 启动 Strapi 应用和备份服务

set -e

APP_NAME="panda-strapi"
BACKUP_NAME="panda-strapi-backup"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 启动应用..."

# 检查应用是否已在运行
if pm2 describe $APP_NAME > /dev/null 2>&1; then
    echo "⚠️  应用已在运行"
    pm2 status
    exit 0
fi

# 检查依赖
if [ ! -d "node_modules" ]; then
    echo "📦 安装依赖..."
    npm install
fi

# 检查构建
if [ ! -d "dist" ]; then
    echo "🔨 构建项目..."
    npm run build
fi

# 启动主应用
echo "▶️  启动主应用..."
pm2 start npm --name $APP_NAME -- run start

# 启动备份服务
echo "📦 启动备份服务（每10分钟备份一次）..."
pm2 start "$SCRIPT_DIR/backup-daemon.sh" --name $BACKUP_NAME --interpreter bash

# 保存 PM2 配置
pm2 save

echo ""
echo "✅ 启动完成！"
pm2 status

