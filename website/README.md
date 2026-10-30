# website — Kênh WordPress

Website chạy WordPress, hosting trên **Hostinger**, deploy qua **SSH**.

> ⏳ Chưa triển khai. Cấu trúc dưới đây là chỗ dành sẵn;
> cách deploy và phạm vi code quản lý trong repo sẽ chốt khi bàn chi tiết kỹ thuật.

```
website/
├── src/        Code tự viết cho WordPress (child theme, plugin riêng, snippet)
├── deploy/     Script & cấu hình deploy lên Hostinger qua SSH
├── config/     Cấu hình môi trường (chỉ file *.example được commit)
└── docs/       Hướng dẫn vận hành website
```

## Cần chốt sau
- [ ] Repo quản lý tới đâu: chỉ child theme/plugin, hay toàn bộ `wp-content`?
- [ ] Cách deploy: `rsync` qua SSH, `git pull` trên server, hay CI/CD?
- [ ] Môi trường local để dev (có dùng Docker không?)
- [ ] Cách đồng bộ database & thư mục uploads.
- [ ] Thông tin kết nối Hostinger: host, port SSH, user, đường dẫn public_html.

## Lưu ý bảo mật
SSH key, mật khẩu, `wp-config.php` **không bao giờ commit**.
Chỉ commit file mẫu dạng `*.example`.
