# Makefile for Panda Strapi Project with PM2
# 使用 PM2 管理 Strapi 应用的 Makefile

# 项目名称
APP_NAME=panda-strapi

# Node 环境
NODE_ENV?=production

# PM2 配置
PM2_INSTANCES?=1

.PHONY: help install build start stop restart reload delete logs status monit flush

# 默认目标 - 显示帮助信息
help:
	@echo "==================================="
	@echo "Panda Strapi PM2 管理命令"
	@echo "==================================="
	@echo "make install      - 安装项目依赖"
	@echo "make build        - 构建 Strapi 项目"
	@echo "make start        - 使用 PM2 启动应用"
	@echo "make stop         - 停止 PM2 应用"
	@echo "make restart      - 重启 PM2 应用"
	@echo "make reload       - 零停机重载应用"
	@echo "make delete       - 从 PM2 中删除应用"
	@echo "make logs         - 查看应用日志"
	@echo "make logs-error   - 查看错误日志"
	@echo "make status       - 查看应用状态"
	@echo "make monit        - 监控应用资源使用"
	@echo "make flush        - 清空日志"
	@echo "make dev          - 开发模式启动(不使用 PM2)"
	@echo "make seed         - 执行数据填充"
	@echo "==================================="

# 安装依赖
install:
	@echo "📦 安装项目依赖..."
	npm install

# 构建项目
build:
	@echo "🔨 构建 Strapi 项目..."
	npm run build

# 使用 PM2 启动应用
start:
	@echo "🚀 使用 PM2 启动应用..."
	@if pm2 describe $(APP_NAME) > /dev/null 2>&1; then \
		echo "⚠️  应用已存在，使用 'make restart' 来重启"; \
	else \
		NODE_ENV=$(NODE_ENV) pm2 start npm --name $(APP_NAME) \
			--instances $(PM2_INSTANCES) \
			-- run start; \
		echo "✅ 应用启动成功"; \
	fi

# 启动应用并保存 PM2 配置
start-save:
	@echo "🚀 使用 PM2 启动应用并保存配置..."
	NODE_ENV=$(NODE_ENV) pm2 start npm --name $(APP_NAME) \
		--instances $(PM2_INSTANCES) \
		-- run start
	pm2 save
	@echo "✅ 应用启动成功并已保存配置"

# 停止应用
stop:
	@echo "⏸️  停止应用..."
	pm2 stop $(APP_NAME)
	@echo "✅ 应用已停止"

# 重启应用
restart:
	@echo "🔄 重启应用..."
	pm2 restart $(APP_NAME)
	@echo "✅ 应用已重启"

# 零停机重载
reload:
	@echo "🔄 零停机重载应用..."
	pm2 reload $(APP_NAME)
	@echo "✅ 应用已重载"

# 从 PM2 中删除应用
delete:
	@echo "🗑️  从 PM2 中删除应用..."
	pm2 delete $(APP_NAME)
	@echo "✅ 应用已删除"

# 查看日志
logs:
	@echo "📋 查看应用日志..."
	pm2 logs $(APP_NAME)

# 查看错误日志
logs-error:
	@echo "📋 查看错误日志..."
	pm2 logs $(APP_NAME) --err

# 查看应用状态
status:
	@echo "📊 查看应用状态..."
	pm2 status $(APP_NAME)

# 监控应用
monit:
	@echo "📈 监控应用资源使用..."
	pm2 monit

# 清空日志
flush:
	@echo "🧹 清空日志..."
	pm2 flush $(APP_NAME)
	@echo "✅ 日志已清空"

# 开发模式(不使用 PM2)
dev:
	@echo "🔧 开发模式启动..."
	npm run develop

# 数据填充
seed:
	@echo "🌱 执行数据填充..."
	npm run seed:example

# 完整部署流程：安装 -> 构建 -> 启动
deploy: install build start-save
	@echo "🎉 部署完成！"

# 更新并重启：拉取代码 -> 安装依赖 -> 构建 -> 重载
update:
	@echo "🔄 更新应用..."
	git pull
	npm install
	npm run build
	pm2 reload $(APP_NAME)
	@echo "✅ 更新完成！"

# 启动 PM2 守护进程在系统启动时自动运行
startup:
	@echo "⚙️  配置 PM2 开机自启..."
	pm2 startup
	pm2 save
	@echo "✅ PM2 开机自启配置完成"

# 查看 PM2 保存的应用列表
list:
	@echo "📋 PM2 应用列表..."
	pm2 list

