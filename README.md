# Personal Website

3D / AIGC 产品视觉作品集。站点为纯静态 HTML，可直接部署到腾讯云 EdgeOne Pages。

当前仓库同时保存 V11 与 V13 页面，两套页面共用一份作品数据和素材库：

- V11：`/`（仓库入口 `index.html`）
- V13：`/v13.html`
- 共享数据：`portfolio-data.js`
- 共享素材：`assets-v8/`

## EdgeOne Pages 部署

1. 打开 [EdgeOne Pages](https://console.cloud.tencent.com/edgeone/pages)，创建项目并导入本仓库。
2. 生产分支选择 `main`。
3. 框架预设选择静态 HTML（或不选框架）。
4. 根目录保持 `./`。
5. 构建命令留空。
6. 输出目录填写 `.`。
7. 点击部署。

推送到 `main` 后，若已开启自动部署，EdgeOne 会发布新版。

## 线上文件

```text
.
├── index.html           # V11 默认首页
├── v13.html             # V13 独立页面
├── portfolio-data.js    # 作品 / 工作流 / 对比数据
├── assets-v8/           # 首屏视频、案例图、作品图
├── edgeone.json
└── README.md
```

本地可视化编辑器只在本机使用，不会随站点发布。更新共享数据或素材后，V11 与 V13 会同时读取新内容，无需维护两套素材副本。
