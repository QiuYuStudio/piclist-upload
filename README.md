# PicList Upload Skill

[English](#english) | [中文](#中文)

## English

An OpenClaw skill for uploading images to image hosting services via PicList's HTTP server.

### Features

- 📤 Upload images from file paths
- 📋 Upload images from clipboard
- 📦 Batch upload multiple images
- 🔧 Easy-to-use helper script
- 🌐 Support for multiple image hosting services (SM.MS, Qiniu, AWS S3, etc.)

### Prerequisites

- [PicList](https://piclist.cn/) installed and running
- HTTP server enabled in PicList settings (default port: 36677)
- At least one image hosting service configured in PicList

### Installation

Install via ClawHub:
```bash
clawhub install piclist-upload
```

Or manually:
```bash
git clone https://github.com/QiuYuStudio/piclist-upload.git ~/.openclaw/skills/piclist-upload
```

### Quick Start

```bash
# Check if PicList server is running
curl -s http://127.0.0.1:36677/heartbeat

# Upload a single image
~/.openclaw/skills/piclist-upload/scripts/upload.sh /path/to/image.jpg

# Upload multiple images
~/.openclaw/skills/piclist-upload/scripts/upload.sh image1.jpg image2.png
```

### Usage

#### Method 1: Using Helper Script (Recommended)

```bash
scripts/upload.sh /path/to/image.jpg
```

#### Method 2: Direct API Call

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/absolute/path/to/image.jpg"]}' \
  http://127.0.0.1:36677/upload | jq -r '.result[]'
```

#### Method 3: Upload from Clipboard

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://127.0.0.1:36677/upload
```

### Advanced Options

#### Specify Image Hosting Service

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?picbed=smms&configName=Default"
```

#### With Authentication

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?key=your-secret-key"
```

### Supported Image Formats

- PNG
- JPEG
- GIF
- WebP

### License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 中文

一个用于通过 PicList HTTP 服务器上传图片到图床的 OpenClaw 技能。

### 功能特性

- 📤 从文件路径上传图片
- 📋 从剪贴板上传图片
- 📦 批量上传多张图片
- 🔧 易用的辅助脚本
- 🌐 支持多种图床服务（SM.MS、七牛云、AWS S3 等）

### 前置要求

- 已安装并运行 [PicList](https://piclist.cn/)
- 在 PicList 设置中启用 HTTP 服务器（默认端口：36677）
- 至少配置一个图床服务

### 安装

通过 ClawHub 安装：
```bash
clawhub install piclist-upload
```

或手动安装：
```bash
git clone https://github.com/QiuYuStudio/piclist-upload.git ~/.openclaw/skills/piclist-upload
```

### 快速开始

```bash
# 检查 PicList 服务器是否运行
curl -s http://127.0.0.1:36677/heartbeat

# 上传单张图片
~/.openclaw/skills/piclist-upload/scripts/upload.sh /path/to/image.jpg

# 上传多张图片
~/.openclaw/skills/piclist-upload/scripts/upload.sh image1.jpg image2.png
```

### 使用方法

#### 方法 1：使用辅助脚本（推荐）

```bash
scripts/upload.sh /path/to/image.jpg
```

#### 方法 2：直接调用 API

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/absolute/path/to/image.jpg"]}' \
  http://127.0.0.1:36677/upload | jq -r '.result[]'
```

#### 方法 3：从剪贴板上传

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://127.0.0.1:36677/upload
```

### 高级选项

#### 指定图床服务

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?picbed=smms&configName=Default"
```

#### 使用认证

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?key=your-secret-key"
```

### 支持的图片格式

- PNG
- JPEG
- GIF
- WebP

### 许可证

MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

### 相关链接

- [PicList 官网](https://piclist.cn/)
- [PicList GitHub](https://github.com/Kuingsmile/PicList)
- [OpenClaw](https://openclaw.ai/)
