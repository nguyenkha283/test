#!/usr/bin/env bash
# Cài đặt WordPress mẫu cho môi trường dev.
# Dùng: cd website/dev && ./install.sh
set -euo pipefail
cd "$(dirname "$0")"

[ -f .env ] || { echo "Thiếu file .env — copy từ .env.example trước."; exit 1; }
set -a; . ./.env; set +a

wp() { docker compose run --rm -T wpcli wp "$@"; }

echo "==> Chờ WordPress sẵn sàng"
for i in $(seq 1 20); do
  curl -sf -o /dev/null --noproxy localhost "http://localhost:${WP_PORT:-8080}/wp-admin/install.php" && break
  sleep 3
done

if wp core is-installed 2>/dev/null; then
  echo "==> WordPress đã cài sẵn, bỏ qua bước core install"
else
  echo "==> Cài WordPress"
  wp core install \
    --url="${WP_URL}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email
fi

echo "==> Cấu hình cơ bản"
wp option update blogdescription "Chia sẻ và training kỹ năng sống cho trẻ"
wp option update timezone_string "Asia/Ho_Chi_Minh"
wp option update start_of_week 1
wp option update date_format "d/m/Y"
wp rewrite structure '/%postname%/' --hard
wp option update default_comment_status closed

echo "==> Tiếng Việt (cần truy cập wordpress.org — bỏ qua nếu bị chặn)"
if wp language core install vi 2>/dev/null; then
  wp site switch-language vi
  echo "    đã chuyển sang tiếng Việt"
else
  echo "    bỏ qua: không tải được gói ngôn ngữ"
fi

echo "==> Dọn nội dung mặc định"
wp post delete $(wp post list --post_type=post,page --format=ids) --force 2>/dev/null || true
wp plugin delete hello akismet 2>/dev/null || true

echo "==> Tạo chuyên mục theo nhóm kỹ năng"
for c in "An toàn cá nhân:an-toan-ca-nhan" "Kỹ năng tự lập:ky-nang-tu-lap" \
         "Giao tiếp và ứng xử:giao-tiep-ung-xu" "Quản lý cảm xúc:quan-ly-cam-xuc" \
         "Tư duy và giải quyết vấn đề:tu-duy-giai-quyet-van-de"; do
  name="${c%%:*}"; slug="${c##*:}"
  wp term create category "$name" --slug="$slug" --porcelain >/dev/null 2>&1 || true
done

echo "==> Tạo trang và bài viết mẫu"
wp post create --post_type=page --post_title="Về dự án" --post_name="ve-du-an" --post_status=publish \
  --post_content="<p>Dự án chia sẻ và training kiến thức kỹ năng sống cho trẻ em qua website, YouTube và Facebook.</p>" >/dev/null
wp post create --post_type=page --post_title="Liên hệ" --post_name="lien-he" --post_status=publish \
  --post_content="<p>Thông tin liên hệ sẽ cập nhật sau.</p>" >/dev/null

wp post create --post_title="An toàn khi ở nhà một mình" --post_name="an-toan-khi-o-nha-mot-minh" \
  --post_status=publish --post_category="an-toan-ca-nhan" \
  --post_content="<p>Bài mẫu. Nội dung thật sẽ lấy từ kịch bản trong content/scripts/approved/.</p>" >/dev/null
wp post create --post_title="Dạy trẻ tự dọn đồ chơi" --post_name="day-tre-tu-don-do-choi" \
  --post_status=publish --post_category="ky-nang-tu-lap" \
  --post_content="<p>Bài mẫu. Nội dung thật sẽ lấy từ kịch bản trong content/scripts/approved/.</p>" >/dev/null
wp post create --post_title="Giúp trẻ gọi tên cảm xúc" --post_name="giup-tre-goi-ten-cam-xuc" \
  --post_status=publish --post_category="quan-ly-cam-xuc" \
  --post_content="<p>Bài mẫu. Nội dung thật sẽ lấy từ kịch bản trong content/scripts/approved/.</p>" >/dev/null

echo "==> Đặt trang chủ hiển thị bài viết, menu chính"
wp menu create "Menu chính" 2>/dev/null || true
wp menu location assign "menu-chinh" primary 2>/dev/null || true

echo
echo "==> Xong. Thông tin truy cập:"
echo "    Site:      ${WP_URL}"
echo "    Quản trị:  ${WP_URL}/wp-admin"
echo "    User:      ${WP_ADMIN_USER}"
echo "    Mật khẩu:  xem WP_ADMIN_PASSWORD trong website/dev/.env"
