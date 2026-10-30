# Quy ước kỹ thuật

> Khung tài liệu — chốt lại khi bàn chi tiết kỹ thuật.

## Đặt tên file kịch bản
```
<so-thu-tu>-<chu-de-khong-dau>.md
ví dụ: 001-an-toan-khi-o-nha-mot-minh.md
```

## Quản lý secret
- Không commit secret. Mỗi folder có file `*.example` làm mẫu.
- Secret thật đặt trong `.env` (đã bị `.gitignore` loại trừ).

## Nhánh Git
- `main`: nội dung đã duyệt.
- Nhánh phụ theo từng việc.

## File nặng
- Video render, ảnh/audio gốc không commit. Lưu ở nơi khác và ghi đường dẫn tham chiếu.
