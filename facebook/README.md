# facebook — Kênh Facebook

Quy trình **tự động sản xuất video từ kịch bản đã có sẵn**
(`content/scripts/approved/`) cho định dạng ngắn, dọc (Reels) và bài đăng kèm video.

> ⏳ Chưa triển khai. Cấu trúc dưới đây là chỗ dành sẵn;
> công nghệ dựng video và cách đăng tải sẽ chốt khi bàn chi tiết kỹ thuật.

```
facebook/
├── pipeline/   Quy trình tự động: kịch bản → giọng đọc → dựng video → xuất file
├── scripts/    Kịch bản đã rút gọn riêng cho Facebook
├── assets/     Tài sản riêng của kênh: khung dọc, sticker, cover
├── metadata/   Caption, hashtag, link, lịch đăng cho từng video
├── output/     Video render ra (không commit)
└── docs/       Hướng dẫn vận hành kênh
```

## Luồng dự kiến

```
content/scripts/approved/*.md
        │
        ▼
   pipeline/  ──► giọng đọc (TTS) ──► dựng bản dọc + phụ đề ──► output/*.mp4
        │                                                           │
        └──────────────► metadata/*.* ◄────────────────────────── đăng tải
```

## Cần chốt sau
- [ ] Dùng chung pipeline với YouTube (chỉ khác cấu hình tỉ lệ/thời lượng) hay pipeline riêng.
- [ ] Định dạng chuẩn: 9:16 hay 1:1, thời lượng tối đa.
- [ ] Đăng tải: tự động qua Facebook Graph API hay đăng tay.
- [ ] Đăng lên Page, Group hay cả hai.

## Quy ước kênh (nháp)
- Tỉ lệ: 9:16 (Reels)
- Thời lượng: dưới 90 giây
- Luôn có phụ đề cháy sẵn (người xem thường tắt tiếng).
