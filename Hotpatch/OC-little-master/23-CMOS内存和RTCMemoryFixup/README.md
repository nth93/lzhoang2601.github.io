# ** CMOS ** Bộ nhớ và RTCMemoryFixup

## Mô tả

-Khi ** AppleRTC ** và ** BIOS ** xung đột, bạn có thể thử sử dụng ** RTCMemoryFixup ** để mô phỏng bộ nhớ ** CMOS ** để tránh xung đột.
- ** RTCMemoryFixup ** Tải xuống: <https://github.com/acidanthera/RTCMemoryFixup>

## ** CMOS ** Bộ nhớ

- ** CMOS ** Bộ nhớ lưu trữ dữ liệu quan trọng như ngày, giờ, thông tin cấu hình phần cứng, thông tin cài đặt phụ trợ, cài đặt khởi động, thông tin ngủ đông, v.v. ** CMOS ** Bộ nhớ chỉ có thể được đọc, không được ghi.
-Một số định nghĩa không gian bộ nhớ ** ** **:
  -Date, thời gian: `00-0D`
  Khoảng thời gian lưu trữ thông tin -Hibernation: `80-AB`
  -Quản lý năng lượng: `B0-B4`
  -Khác
-Attachment cung cấp định nghĩa chi tiết về bộ nhớ ** CMOS ** `00-3F`.

## Analog ** CMOS ** Phương thức bộ nhớ

-Install ** RTCMemoryFixup ** vào `OC \ Kexts` và thêm danh sách trình điều khiển.

-Bộ nhận dạng khởi động ** `boot-args` ** Đã thêm` rtcfx_exclude = ...`

   Định dạng: `rtcfx_exclude = offset1, offset2, start_offset-end_offset ...`

   Ví dụ: `rtcfx_exclude = 40-AF`,` rtcfx_exclude = 2A, 2D, 80-AB`, v.v.

## Lưu ý

-Analog ** Bộ nhớ ** ** sẽ xóa các chức năng được xác định ban đầu, vui lòng sử dụng cẩn thận **. Ví dụ: `rtcfx_exclude = 00-0D` sẽ khiến ngày và giờ của máy không còn được cập nhật trong khi ngủ. Một ví dụ khác, `rtcfx_exclude = B0-B4` sẽ khiến máy không tự động ngủ.

## Phụ lục: ** CMOS ** Bộ nhớ `00-3F` Định nghĩa

Địa chỉ | Mô tả |
| ----- | ------------------------------------------- ------------------------------------ |
| `0` | giây |
| `1` | Báo động thứ hai |
| `2` | điểm |
| `2` | điểm |
| `3` | Báo động phụ |
| `4` | Giờ |
| `5` | Báo thức thời gian |
| `6` | Tuần |
| `7` | Ngày |
| `8` | Tháng |
| `9` | Năm |
| `A` | Đăng ký trạng thái A |
| `B` | Đăng ký trạng thái B |
| `C` | Đăng ký trạng thái C |
| `D` | Đăng ký trạng thái D |
| `E` | Byte Status chẩn đoán (0 OK) |
| `F` | Dừng trạng thái byte (0 có nguồn điện chính |
| `10` | Loại ổ đĩa mềm (Bit 7-4: Ổ A, Bit 3-0: B Ổ 1-360KB; 2-1.2MB; 6-1.44MB; 7-720KB) |
| `11` | Dành riêng |
| `12` | Loại ổ cứng (Bits 7-4: Drive C, Bits 3-0: Drive D) |
| `13` | Dành riêng |
| 14` | byte thiết bị (số lượng ổ đĩa mềm, loại hiển thị, bộ đồng xử lý)
| `15` | Bộ nhớ cơ bản Thấp Byte |
| `16` | Bộ nhớ cơ bản Byte cao |
| `17` | Bộ nhớ mở rộng Thấp Byte |
| `18` | Bộ nhớ mở rộng Byte cao |
| `19` | Byte loại đĩa cứng (dưới 15 là 0) |
| `1A 2D 2D` | Dành riêng |
| `2E Đập 2F` | Kiểm tra CMOS (10-2D Tổng của mỗi byte) |
| `30` | Bộ nhớ mở rộng Thấp Byte |
| `31` | Bộ nhớ mở rộng Byte cao |
| `32` | byte thế kỷ (19H: thế kỷ 19) |
| `33` | Dấu hiệu thông tin |
`34 con3F` | Dành riêng (34-0: không có mật khẩu; vị trí mật khẩu 35-3F) |
