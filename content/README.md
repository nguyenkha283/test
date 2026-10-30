# content — Nguồn nội dung dùng chung

Nội dung gốc, viết một lần và tái sử dụng cho cả 3 kênh.

```
content/
├── scripts/            Kịch bản
│   ├── template/       File mẫu để viết kịch bản mới
│   ├── draft/          Bản nháp, đang viết / chờ duyệt
│   └── approved/       Đã duyệt — đầu vào cho các kênh
├── assets/             Tài sản dùng chung
│   ├── images/         Ảnh minh hoạ
│   ├── audio/          Nhạc nền, hiệu ứng âm thanh
│   ├── fonts/          Font chữ
│   └── brand/          Logo, màu sắc, intro/outro
└── calendar/           Lịch nội dung & lịch đăng từng kênh
```

## Quy tắc
- Kịch bản chỉ được coi là sẵn sàng sản xuất khi đã nằm trong `scripts/approved/`.
- Không sửa trực tiếp file trong `approved/`; sửa ở `draft/` rồi duyệt lại.
- File nặng trong `assets/` không commit — chỉ commit file nhẹ và file mô tả nguồn.
