---
name: piclist-upload
description: >
  Upload images to configured image hosting services via PicList HTTP server.
  Use when you need to: (1) Upload local image files to get public URLs, (2) Upload
  clipboard images, (3) Upload multiple images in batch, (4) Get shareable image links
  for use in documents, messages, or web content. Requires PicList to be running with
  HTTP server enabled (default port 36677).
---

# PicList Upload

Upload images to your configured image hosting service via PicList's built-in HTTP server.

## Prerequisites

- PicList must be installed and running
- HTTP server must be enabled in PicList settings (default: http://127.0.0.1:36677)
- At least one image hosting service must be configured in PicList (e.g., SM.MS, Qiniu, AWS S3)

## Quick Start

```bash
# Check if PicList server is running
curl -s http://127.0.0.1:36677/heartbeat

# Upload a single image
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/absolute/path/to/image.jpg"]}' \
  http://127.0.0.1:36677/upload | jq -r '.result[]'
```

## Upload Methods

### 1. Upload from File Path (Recommended)

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

### 2. Upload from Clipboard

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{}' \
  http://127.0.0.1:36677/upload
```

### 3. Upload via Multipart Form (v2.6.3+)

```bash
curl -s -X POST \
  -F "image=@/path/to/image.jpg" \
  http://127.0.0.1:36677/upload
```

### 4. Batch Upload

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image1.jpg", "/path/to/image2.png"]}' \
  http://127.0.0.1:36677/upload
```

## Advanced Options

### Specify Image Hosting Service

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?picbed=smms&configName=Default"
```

Parameters:
- `picbed`: Service type (smms, qiniu, aws-s3, etc.)
- `configName`: Configuration name (default: "Default")

### With Authentication

If PicList server has authentication enabled:

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"list": ["/path/to/image.jpg"]}' \
  "http://127.0.0.1:36677/upload?key=your-secret-key"
```

## Helper Script

Use the provided upload script for easier uploads:

```bash
scripts/upload.sh /path/to/image.jpg
scripts/upload.sh /path/to/image1.jpg /path/to/image2.png
```

## Workflow

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

## Error Handling

Common errors:
- **Connection refused**: PicList not running or HTTP server disabled
- **No image hosting configured**: Configure a service in PicList settings
- **File not found**: Use absolute paths and verify file exists
- **Upload failed**: Check PicList logs for details

## Tips

- Always use absolute file paths for reliability
- Check file size limits for your hosting service
- Use batch upload for multiple images to save time
- Multipart upload is preferred for large files (v2.6.3+)
- The helper script handles path resolution and error checking

## Configuration

PicList configuration is stored in `~/.config/piclist/data.json`:
- Current service: `picBed.current`
- Available services: `picBed.uploader`
- Server settings: `settings.server`
