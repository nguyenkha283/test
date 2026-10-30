# youtube — Kênh YouTube

Quy trình **tự động sản xuất video từ kịch bản đã có sẵn**
(`content/scripts/approved/`) cho định dạng video ngang, thời lượng dài.

> ⏳ Chưa triển khai. Cấu trúc dưới đây là chỗ dành sẵn;
> công nghệ dựng video và cách đăng tải sẽ chốt khi bàn chi tiết kỹ thuật.

```
youtube/
├── pipeline/   Quy trình tự động: kịch bản → giọng đọc → dựng video → xuất file
├── scripts/    Kịch bản đã chuyển thể riêng cho YouTube (nếu cần sửa so với bản gốc)
├── assets/     Tài sản riêng của kênh: intro, outro, thumbnail template
├── metadata/   Tiêu đề, mô tả, tag, playlist, brief thumbnail cho từng video
├── output/     Video render ra (không commit)
└── docs/       Hướng dẫn vận hành kênh
```

## Luồng dự kiến

```
content/scripts/approved/*.md
        │
        ▼
   pipeline/  ──► giọng đọc (TTS) ──► ghép hình + phụ đề ──► output/*.mp4
        │                                                        │
        └──────────────► metadata/*.* ◄─────────────────────── đăng tải
```

## Cần chốt sau
- [ ] Công nghệ dựng video (ví dụ: Python + ffmpeg + TTS, Remotion, hoặc công cụ automation).
- [ ] Nguồn giọng đọc tiếng Việt.
- [ ] Nguồn hình ảnh/clip minh hoạ.
- [ ] Định dạng chuẩn: độ phân giải, tỉ lệ, thời lượng, có phụ đề hay không.
- [ ] Đăng tải: tự động qua YouTube Data API hay đăng tay.

## Quy ước kênh (nháp)
- Tỉ lệ: 16:9
- Thời lượng: (điền)
- Luôn có intro/outro thống nhất từ `assets/`.
