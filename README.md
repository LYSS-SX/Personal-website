# Personal Website

3D / AI / 短片设计作品集。站点为纯静态 HTML，可直接部署至腾讯云 EdgeOne Pages。

## EdgeOne Pages 部署

1. 在 EdgeOne Pages 创建项目并导入本仓库。
2. 生产分支选择 `main`。
3. 框架预设选择静态 HTML（或不选择框架）。
4. 根目录保持仓库根目录 `./`。
5. 构建命令留空。
6. 输出目录填写 `.`。
7. 点击部署。

仓库根目录的 `edgeone.json` 已声明输出目录，并为素材配置长期缓存。

## 文件结构

```text
.
├── index.html
├── edgeone.json
└── assets/
```

以后修改 `index.html` 或 `assets/` 并推送到 `main`，EdgeOne Pages 开启自动部署后会自动发布新版。
