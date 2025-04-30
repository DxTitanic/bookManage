
# 项目操作指南

## 环境配置
1. 安装依赖：
```bash
npm install
```

2. 启动开发服务器：
```bash
npm run serve
```

3. 构建生产版本：
```bash
npm run build
```

## Git操作规范
1. 提交前检查：
```bash
git status
git diff
```

2. 提交更改：
```bash
git add .
git commit -m "描述你的修改"
git push
```

## 常见问题
### 依赖安装失败
- 删除node_modules后重试：
```bash
rm -rf node_modules
npm install
```

### 开发服务器端口占用
- 修改vue.config.js中的devServer.port配置

---

> 最后更新：{更新时间}
