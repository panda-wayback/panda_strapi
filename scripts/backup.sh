#!/bin/bash
# 数据库备份脚本 - 每10分钟执行一次

# 备份配置
DB_PATH=".tmp/data.db"
BACKUP_DIR="backups"
MAX_BACKUPS=144  # 保留最近24小时的备份 (24 * 6)

# 创建备份目录
mkdir -p $BACKUP_DIR

# 生成备份文件名（带时间戳）
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/data_$TIMESTAMP.db"

# 执行备份
if [ -f "$DB_PATH" ]; then
    cp "$DB_PATH" "$BACKUP_FILE"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ✅ 备份成功: $BACKUP_FILE"
    
    # 清理旧备份，只保留最近的备份
    cd $BACKUP_DIR
    ls -t data_*.db | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm
    cd ..
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ⚠️  数据库文件不存在: $DB_PATH"
fi

