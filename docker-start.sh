#!/bin/bash

# Docker 启动 Strapi 的简化脚本
# 作者：AI Assistant

set -e  # 遇到错误时立即退出

# 颜色输出函数
print_info() {
    echo -e "\033[34m[信息]\033[0m $1"
}

print_success() {
    echo -e "\033[32m[成功]\033[0m $1"
}

print_error() {
    echo -e "\033[31m[错误]\033[0m $1"
}

print_warning() {
    echo -e "\033[33m[警告]\033[0m $1"
}

# 检查 Docker 是否安装
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker 未安装，请先安装 Docker"
        print_info "访问 https://docs.docker.com/get-docker/ 获取安装指南"
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose 未安装，请先安装 Docker Compose"
        exit 1
    fi
    
    print_success "Docker 环境检查通过"
}

# 检查必要文件
check_files() {
    if [ ! -f "docker-compose.yml" ]; then
        print_error "未找到 docker-compose.yml 文件"
        exit 1
    fi
    
    if [ ! -f "Dockerfile" ]; then
        print_error "未找到 Dockerfile 文件"
        exit 1
    fi
    
    print_success "必要文件检查通过"
}

# 启动 Docker 容器
start_strapi() {
    print_info "开始构建和启动 Strapi 容器..."
    
    # 停止可能存在的容器
    docker-compose down 2>/dev/null || true
    
    # 构建并启动容器
    docker-compose up --build -d
    
    print_success "Strapi 容器启动成功！"
    print_info "管理面板地址: http://localhost:1337/admin"
    print_info "API 地址: http://localhost:1337/api"
    echo
    print_info "查看日志: docker-compose logs -f"
    print_info "停止服务: docker-compose down"
}

# 显示状态
show_status() {
    print_info "容器状态："
    docker-compose ps
}

# 主函数
main() {
    print_info "=== Docker Strapi 启动脚本 ==="
    echo
    
    check_docker
    check_files
    start_strapi
    show_status
}

# 运行主函数
main "$@"
