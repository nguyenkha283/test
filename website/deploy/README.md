# deploy — Đưa website lên Hostinger

> ⏳ Chỗ dành sẵn. Script deploy sẽ viết sau khi chốt phương án.

Dự kiến chứa:
- Script đẩy code lên server qua SSH/rsync.
- File cấu hình đường dẫn, host, user (dạng `*.example`).
- Ghi chú các bước thủ công còn lại (backup, xoá cache, kiểm tra sau deploy).

## Checklist trước mỗi lần deploy (nháp)
- [ ] Backup file + database trên Hostinger.
- [ ] Kiểm tra thay đổi trên môi trường thử.
- [ ] Deploy.
- [ ] Xoá cache, kiểm tra website chạy bình thường.
