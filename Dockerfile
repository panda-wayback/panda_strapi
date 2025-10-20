# 使用 Node.js 18 Alpine 作为基础镜像
FROM node:18

# 安装必要的系统依赖
# libvips-dev 用于图片处理兼容性
# RUN apt update && apt install -y build-essential python3 vips-dev git


# 设置工作目录
WORKDIR /opt/


# 复制 package.json 和 yarn.lock
COPY strapi/package.json strapi/yarn.lock ./

# 安装全局依赖
# RUN yarn global add node-gyp
# # 设置 yarn 网络超时并安装依赖
# RUN MINUTES=100 && \
#     TIMEOUT_MS=$((MINUTES * 60 * 1000)) && \
#     yarn config set network-timeout $TIMEOUT_MS -g

# 设置 yarn 镜像源
# taobao 
# RUN yarn config set registry https://registry.npm.taobao.org -g
# RUN yarn config set registry https://registry.npmjs.org -g



RUN yarn install --verbose

# 设置环境变量
ENV PATH /opt/node_modules/.bin:$PATH

# 设置应用工作目录
WORKDIR /opt/app

# 复制项目文件
COPY strapi .

# 设置 yarn 缓存目录权限
USER root
RUN mkdir -p /home/node/.cache/yarn && chown -R node:node /home/node/.cache /opt/app

# 切换到 node 用户
USER node

# 构建应用
RUN ["yarn", "build"]

# 暴露端口
EXPOSE 1337

# 启动命令
# CMD ["yarn", "start"] 
CMD ["yarn", "start"] 