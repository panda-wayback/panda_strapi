# Makefile for Panda Strapi Project with PM2
# 使用 PM2 管理 Strapi 应用

APP_NAME=panda-strapi

.PHONY: help start stop restart logs status

# 显示帮助
help:
	@echo "================================"
	@echo "Panda Strapi PM2 管理"
	@echo "================================"
	@echo ""
	@echo "make start    - 启动应用（含备份服务）"
	@echo "make stop     - 停止应用（含备份服务）"
	@echo "make restart  - 重启应用"
	@echo "make logs     - 查看日志"
	@echo "make status   - 查看状态"
	@echo ""
	@echo "💡 启动后会自动每10分钟备份数据库"
	@echo "📁 备份文件保存在 backups/ 目录"
	@echo ""
	@echo "或直接使用脚本："
	@echo "./scripts/start.sh"
	@echo "./scripts/stop.sh"
	@echo ""
	@echo "================================"

# 启动应用和备份服务
start:
	@./scripts/start.sh

# 停止应用和备份服务
stop:
	@./scripts/stop.sh

# 重启应用
restart:
	@echo "🔄 重启应用..."
	@pm2 restart $(APP_NAME)

# 查看日志
logs:
	@pm2 logs $(APP_NAME)

# 查看状态
status:
	@pm2 status $(APP_NAME)
