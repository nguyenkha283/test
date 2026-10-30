# dev — Môi trường WordPress local (Docker)

Stack: **MariaDB 11 + WordPress 6.9 (PHP 8.3, Apache) + wp-cli**, chạy bằng Docker Compose.

## File trong folder

| File | Vai trò |
|------|---------|
| `docker-compose.yml` | Định nghĩa 3 service: `db`, `wordpress`, `wpcli` |
| `.env.example` | Mẫu biến môi trường — copy thành `.env` |
| `.env` | Giá trị thật (mật khẩu). **Không commit**, đã bị gitignore |
| `install.sh` | Cài WordPress + tạo nội dung mẫu, chạy lại nhiều lần được |

## Khởi động

Container của session này không chạy systemd nên **Docker daemon phải bật tay trước**:

```bash
sudo dockerd > /tmp/dockerd.log 2>&1 &
```

```bash
cp website/dev/.env.example website/dev/.env
```

```bash
cd website/dev && docker compose up -d && ./install.sh
```

Site chạy ở `http://localhost:8080`, quản trị ở `http://localhost:8080/wp-admin`.
Tài khoản và mật khẩu lấy trong `.env` (`WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`).

## Lệnh hay dùng

```bash
docker compose ps
```

```bash
docker compose logs -f wordpress
```

```bash
docker compose run --rm wpcli wp plugin list
```

```bash
docker compose down
```

Xoá sạch cả database để cài lại từ đầu:

```bash
docker compose down -v
```

## Nội dung mẫu `install.sh` tạo ra

- Tiêu đề site: *Kỹ Năng Sống Cho Trẻ*, timezone `Asia/Ho_Chi_Minh`, permalink `/%postname%/`
- 5 chuyên mục theo nhóm kỹ năng: an toàn cá nhân, tự lập, giao tiếp, cảm xúc, tư duy
- 2 trang: *Về dự án*, *Liên hệ*
- 3 bài viết mẫu, mỗi bài gắn một chuyên mục
- Xoá bài/trang mặc định của WordPress và plugin `hello`, `akismet`

## Lưu ý của môi trường cloud này

- **Docker Hub bị rate-limit (429)** khi pull ẩn danh. Đã cấu hình daemon dùng mirror
  `https://mirror.gcr.io` trong `/etc/docker/daemon.json`, nhờ đó pull bằng tên image
  chuẩn vẫn chạy. Cấu hình này **mất khi session kết thúc**, cần đặt lại:

```bash
echo '{"registry-mirrors":["https://mirror.gcr.io"]}' | sudo tee /etc/docker/daemon.json
```

- **Gói ngôn ngữ tiếng Việt chưa cài được**: `wp language core install vi` tải từ
  `wordpress.org`, host này bị network policy chặn. Site đang chạy tiếng Anh.
  Mở `wordpress.org` trong Allowed domains của environment là xong.
- **Cổng 8080 chỉ truy cập được từ bên trong container** (dùng `curl`), không mở ra
  máy cá nhân của bạn.
- Mọi thứ cài trong session đều mất khi container bị thu hồi. Nên đưa các lệnh khởi động
  vào setup script của environment.
