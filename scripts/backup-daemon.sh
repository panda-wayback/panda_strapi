#!/bin/bash
# 备份守护进程 - 每10分钟执行一次备份

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 备份守护进程启动..."
echo "📦 每10分钟备份一次数据库"

# 立即执行一次备份
bash "$SCRIPT_DIR/backup.sh"

# 每10分钟执行一次
while true; do
    sleep 600  # 600秒 = 10分钟
    bash "$SCRIPT_DIR/backup.sh"
done

