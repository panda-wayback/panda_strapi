# Panda Strapi 脚本说明

## 🚀 快速开始

只需要一个命令就能启动所有服务：

```bash
make start
```

## 📋 自动化流程

启动脚本会自动执行以下步骤：

### 1. 环境准备
- ✅ 检查并安装 nvm（如果未安装）
- ✅ 加载 nvm 环境
- ✅ 检查并安装 Node.js 20（如果未安装）
- ✅ 切换到 Node.js 20
- ✅ 检查并安装 PM2（如果未安装）

### 2. 项目构建
- ✅ 检查并安装项目依赖（如果需要）
- ✅ 检查并构建项目（如果需要）

### 3. 服务启动
- ✅ 启动 Strapi 主应用
- ✅ 启动数据库备份服务（每10分钟自动备份）

## 📁 文件说明

```
scripts/
├── setup-nvm.sh       # nvm 和 Node.js 环境配置脚本
├── start.sh           # 启动脚本（调用所有必要的脚本）
├── stop.sh            # 停止脚本
├── backup.sh          # 单次备份脚本
└── backup-daemon.sh   # 备份守护进程
```

## 🎯 可用命令

```bash
make start    # 启动应用和备份服务
make stop     # 停止所有服务
make restart  # 重启应用
make logs     # 查看日志
make status   # 查看状态
```

## 💾 备份功能

- **频率**：每 10 分钟自动备份一次
- **位置**：`backups/` 目录
- **命名**：`data_YYYYMMDD_HHMMSS.db`
- **保留**：最近 24 小时的备份（144 个文件）

## 📌 环境要求

脚本会自动安装所有依赖，首次运行时无需手动安装：
- ✅ nvm（自动安装）
- ✅ Node.js 20（自动安装）
- ✅ PM2（自动安装）

## 🔧 配置

如需修改 Node.js 版本，编辑 `scripts/setup-nvm.sh`：

```bash
NODE_VERSION="20"  # 修改为其他版本号
```

## 🛠️ 单独使用环境配置脚本

如需单独配置 Node.js 环境（不启动应用）：

```bash
source scripts/setup-nvm.sh
```

## ⚠️ 注意事项

1. 首次运行可能需要较长时间（安装 nvm 和 Node.js）
2. 需要网络连接来下载依赖
3. 确保有足够的磁盘空间用于备份

## 💡 提示

- 备份文件自动清理，只保留最近 24 小时
- PM2 会在系统重启后自动恢复应用
- 可以使用 `pm2 monit` 实时监控资源使用

