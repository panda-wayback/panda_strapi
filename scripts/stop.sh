#!/bin/bash
# 停止 Strapi 应用和备份服务

APP_NAME="panda-strapi"
BACKUP_NAME="panda-strapi-backup"

echo "⏸️  停止所有服务..."

# 停止主应用
if pm2 describe $APP_NAME > /dev/null 2>&1; then
    pm2 delete $APP_NAME
    echo "✅ 主应用已停止"
else
    echo "⚠️  主应用未在运行"
fi

# 停止备份服务
if pm2 describe $BACKUP_NAME > /dev/null 2>&1; then
    pm2 delete $BACKUP_NAME
    echo "✅ 备份服务已停止"
else
    echo "⚠️  备份服务未在运行"
fi

echo ""
echo "✅ 所有服务已停止"

