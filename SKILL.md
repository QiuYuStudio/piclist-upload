---
name: piclist-upload
description: >
  Upload images to configured image hosting services via PicList HTTP server.
  Use when you need to: (1) Upload local image files to get public URLs, (2) Upload
  clipboard images, (3) Upload multiple images in batch, (4) Get shareable image links
  for use in documents, messages, or web content. Requires PicList to be running with
  HTTP server enabled (default port 36677). 通过 PicList HTTP 服务器上传图片到图床服务。
  支持本地文件、剪贴板、批量上传，获取可分享的图片链接。
---

# PicList Upload | PicList 图片上传

[English](#english) | [中文](#中文)

---

## English

Upload images to your configured image hosting service via PicList's built-in HTTP server.

### Prerequisites

- PicList must be installed and running
- HTTP server must be enabled in PicList settings (default: http://127.0.0.1:36677)
- At least one image hosting service must be configured in PicList (e.g., SM.MS, Qiniu, AWS S3)

### Quick Start

```bash
# Check if PicList server is running
curl -s http://127.0.0.1:36677/heartbeat

# Upload a single image
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/absolute/path/to/image.jpg"]}' \
  http://127.0.0.1:36677/upload | jq -r '.result[]'
```

### Upload Methods

#### 1. Upload from File Path (Recommended)

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  http://127.0.0.1:36677/upload
```

Response:
```json
{
  "success": true,
  "result": ["https://example.com/uploaded-image.jpg"]
}
```

#### 2. Upload from Clipboard

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://127.0.0.1:36677/upload
```

#### 3. Upload via Multipart Form (v2.6.3+)

```bash
curl -s -X POST \
  -F "image=@/path/to/image.jpg" \
  http://127.0.0.1:36677/upload
```

#### 4. Batch Upload

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image1.jpg", "/path/to/image2.png"]}' \
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

Parameters:
- `picbed`: Service type (smms, qiniu, aws-s3, etc.)
- `configName`: Configuration name (default: "Default")

#### With Authentication

If PicList server has authentication enabled:

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?key=your-secret-key"
```

### Helper Script

Use the provided upload script for easier uploads:

```bash
scripts/upload.sh /path/to/image.jpg
scripts/upload.sh /path/to/image1.jpg /path/to/image2.png
```

### Workflow

1. **Verify PicList is running**:
   ```bash
   curl -s http://127.0.0.1:36677/heartbeat
   ```
   Expected: `{"success":true,"result":"alive"}`

2. **Prepare image**:
   - Use absolute file paths
   - Supported formats: PNG, JPEG, GIF, WebP
   - Check size limits (varies by hosting service)

3. **Upload**:
   ```bash
   curl -s -X POST \
     -H "Content-Type: application/json" \
     -d '{"list": ["/absolute/path/to/image.jpg"]}' \
     http://127.0.0.1:36677/upload | jq -r '.result[]'
   ```

4. **Use the URL**: The returned URL is a public CDN link ready to use

### Error Handling

Common errors:
- **Connection refused**: PicList not running or HTTP server disabled
- **No image hosting configured**: Configure a service in PicList settings
- **File not found**: Use absolute paths and verify file exists
- **Upload failed**: Check PicList logs for details

### Tips

- Always use absolute file paths for reliability
- Check file size limits for your hosting service
- Use batch upload for multiple images to save time
- Multipart upload is preferred for large files (v2.6.3+)
- The helper script handles path resolution and error checking

### Configuration

PicList configuration is stored in `~/.config/piclist/data.json`:
- Current service: `picBed.current`
- Available services: `picBed.uploader`
- Server settings: `settings.server`

---

## 中文

通过 PicList 内置的 HTTP 服务器将图片上传到已配置的图床服务。

### 前置要求

- 必须安装并运行 PicList
- 必须在 PicList 设置中启用 HTTP 服务器（默认：http://127.0.0.1:36677）
- 必须在 PicList 中配置至少一个图床服务（如 SM.MS、七牛云、AWS S3）

### 快速开始

```bash
# 检查 PicList 服务器是否运行
curl -s http://127.0.0.1:36677/heartbeat

# 上传单张图片
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/绝对路径/到/图片.jpg"]}' \
  http://127.0.0.1:36677/upload | jq -r '.result[]'
```

### 上传方法

#### 1. 从文件路径上传（推荐）

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  http://127.0.0.1:36677/upload
```

响应：
```json
{
  "success": true,
  "result": ["https://example.com/uploaded-image.jpg"]
}
```

#### 2. 从剪贴板上传

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://127.0.0.1:36677/upload
```

#### 3. 通过 Multipart 表单上传（v2.6.3+）

```bash
curl -s -X POST \
  -F "image=@/path/to/image.jpg" \
  http://127.0.0.1:36677/upload
```

#### 4. 批量上传

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image1.jpg", "/path/to/image2.png"]}' \
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

参数：
- `picbed`: 服务类型（smms、qiniu、aws-s3 等）
- `configName`: 配置名称（默认："Default"）

#### 使用认证

如果 PicList 服务器启用了认证：

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?key=your-secret-key"
```

### 辅助脚本

使用提供的上传脚本更方便：

```bash
scripts/upload.sh /path/to/image.jpg
scripts/upload.sh /path/to/image1.jpg /path/to/image2.png
```

### 工作流程

1. **验证 PicList 正在运行**：
   ```bash
   curl -s http://127.0.0.1:36677/heartbeat
   ```
   预期响应：`{"success":true,"result":"alive"}`

2. **准备图片**：
   - 使用绝对文件路径
   - 支持的格式：PNG、JPEG、GIF、WebP
   - 检查大小限制（因图床服务而异）

3. **上传**：
   ```bash
   curl -s -X POST \
     -H "Content-Type: application/json" \
     -d '{"list": ["/绝对路径/到/图片.jpg"]}' \
     http://127.0.0.1:36677/upload | jq -r '.result[]'
   ```

4. **使用 URL**：返回的 URL 是可直接使用的公共 CDN 链接

### 错误处理

常见错误：
- **连接被拒绝**：PicList 未运行或 HTTP 服务器未启用
- **未配置图床**：在 PicList 设置中配置图床服务
- **文件未找到**：使用绝对路径并验证文件存在
- **上传失败**：检查 PicList 日志获取详细信息

### 提示

- 始终使用绝对文件路径以确保可靠性
- 检查图床服务的文件大小限制
- 使用批量上传可节省时间
- 对于大文件，推荐使用 multipart 上传（v2.6.3+）
- 辅助脚本会处理路径解析和错误检查

### 配置

PicList 配置存储在 `~/.config/piclist/data.json`：
- 当前服务：`picBed.current`
- 可用服务：`picBed.uploader`
- 服务器设置：`settings.server`
