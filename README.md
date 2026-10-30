# Kỹ Năng Sống Cho Trẻ — Dự án nội dung đa kênh

Repo quản lý toàn bộ nội dung và quy trình sản xuất cho dự án chia sẻ, training
kiến thức kỹ năng sống cho trẻ em trên 3 kênh: **website (WordPress)**,
**YouTube**, **Facebook**.

> Hiện tại repo chỉ mới dựng **cây thư mục + tài liệu khung**.
> Chi tiết kỹ thuật (stack dựng video, cách deploy, API đăng tải) sẽ bàn và bổ sung sau.

## Cấu trúc

```
.
├── docs/        Tài liệu chung: mục tiêu, đối tượng, quy trình tổng thể
├── content/     Nguồn nội dung dùng chung cho mọi kênh (kịch bản, assets, lịch đăng)
├── website/     Kênh website WordPress (dev local bằng Docker, deploy lên Hostinger qua SSH)
├── youtube/     Kênh YouTube: quy trình tự động sản xuất video từ kịch bản
├── facebook/    Kênh Facebook: quy trình tự động sản xuất video từ kịch bản
└── tools/       Script/tiện ích dùng chung cho nhiều kênh
```

## Luồng làm việc dự kiến

```
content/scripts/draft  →  duyệt  →  content/scripts/approved
                                        │
                   ┌────────────────────┼────────────────────┐
                   ▼                    ▼                    ▼
              website/              youtube/             facebook/
         (bài viết WordPress)   (video + metadata)   (video + metadata)
```

## Quy ước

- Mỗi kênh là một folder độc lập, tự chứa quy trình riêng của kênh đó.
- Kịch bản gốc chỉ viết **một lần** trong `content/scripts/`, các kênh tái sử dụng.
- File nặng (video render, ảnh gốc, audio gốc) **không commit** — xem `.gitignore`.
- Mọi secret (SSH key, API token, mật khẩu) **không commit**; chỉ commit file `*.example`.

## Trạng thái

| Phần | Trạng thái |
|------|-----------|
| Cây thư mục | ✅ Đã dựng |
| Tài liệu quy trình | 🔄 Khung, cần bổ sung |
| Website — dev local (Docker) | ✅ Đã chạy, có nội dung mẫu |
| Website — deploy Hostinger | ⏳ Chưa triển khai (cổng 22 bị chặn, xem `website/README.md`) |
| Pipeline video YouTube | ⏳ Chưa triển khai |
| Pipeline video Facebook | ⏳ Chưa triển khai |
