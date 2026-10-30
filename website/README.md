# website — Kênh WordPress

Website chạy WordPress, hosting trên **Hostinger**, deploy qua **SSH**.

```
website/
├── dev/        Môi trường dev local bằng Docker (MariaDB + WordPress + wp-cli)  ✅ đã chạy
├── src/        Code tự viết cho WordPress (child theme, plugin riêng, snippet)
├── deploy/     Script & cấu hình deploy lên Hostinger qua SSH                   ⏳
├── config/     Cấu hình môi trường (chỉ file *.example được commit)
└── docs/       Hướng dẫn vận hành website
```

## Môi trường dev

Xem `dev/README.md`. Tóm tắt:

```bash
sudo dockerd > /tmp/dockerd.log 2>&1 &
```

```bash
cd website/dev && docker compose up -d && ./install.sh
```

→ `http://localhost:8080` (chỉ truy cập được từ trong container).

## Cần chốt sau
- [ ] Repo quản lý tới đâu: chỉ child theme/plugin, hay toàn bộ `wp-content`?
- [ ] Cách deploy: `rsync` qua SSH, `git pull` trên server, hay GitHub Actions?
      *Lưu ý: container cloud này bị chặn cổng 22 ra ngoài, nên deploy trực tiếp từ đây
      không chạy — xem phần Deploy bên dưới.*
- [ ] Cách đồng bộ database & thư mục uploads giữa local và Hostinger.
- [ ] Thông tin kết nối Hostinger: host, port SSH, user, đường dẫn public_html.

## Deploy lên Hostinger

Cổng 22 ra ngoài bị network policy của environment chặn, nên **không SSH/rsync trực tiếp
từ container này**. Ba hướng:

1. **GitHub Actions** (khuyến nghị) — job chạy trên runner của GitHub, không bị policy này.
   SSH key nạp vào GitHub Secrets.
2. Mở quyền mạng cho environment (Network access / Allowed domains) rồi deploy từ đây.
3. Deploy từ máy cá nhân.

## Lưu ý bảo mật
SSH key, mật khẩu, `wp-config.php`, `.env` **không bao giờ commit**.
Chỉ commit file mẫu dạng `*.example`.
