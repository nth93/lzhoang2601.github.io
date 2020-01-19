# Tổng quan

### ACPI Đổi tên và Patch

Hãy thử sử dụng càng ít hoặc ít lần đổi tên và vá lỗi càng tốt. Ví dụ: `HDAS đổi tên HDEF`,` EC0 đổi tên EC`, `SSDT-OC-XOSI`, v.v. Đặc biệt đối với `MethodObj` được gạch chân (như _STA, _OSI, v.v.) đổi tên ** sử dụng một cách thận trọng **. Nói chung:
  -Không cần bản vá hệ điều hành. Đối với các thành phần bị hệ thống hạn chế và không thể hoạt động bình thường, hãy tùy chỉnh bản vá theo tình huống cụ thể của ACPI. ** Sử dụng thận trọng ** Bản vá hệ điều hành với các yêu cầu đặc biệt cho hệ điều hành.
  
  -Một số máy không cần đổi tên và vá bằng các phím tắt độ sáng. Sử dụng "ánh xạ bàn phím PS2 @ OC-xlivans" để đạt được hiệu quả tương tự.
  -Có mặt, hầu hết các máy đều cần "0D6D Patch" để giải quyết vấn đề thức dậy sau vài giây.
  -Đối với phần pin, nếu dữ liệu phải được phân chia, việc đổi tên và vá pin là rất cần thiết.
  -Nhiều máy Thinkpad cần "PTSWAK Bản vá toàn diện và Bản vá mở rộng" để giải quyết vấn đề đèn thở không hồi phục sau khi thức dậy.
  -Đối với các máy có nút ngủ [Mặt trăng nhỏ], vui lòng tham khảo "Phương pháp khắc phục giấc ngủ PNP0C0E" cho sự cố hệ thống sau khi nhấn nút này
- Giải quyết một số vấn đề yêu cầu bật hoặc tắt một số thiết bị. Để bật hoặc tắt thiết bị:
  -ACPI Binary Rename - Phương pháp này rất hiệu quả đối với các hệ thống đơn lẻ. Đối với nhiều hệ thống, cần đánh giá tác động của việc đổi tên đối với các hệ thống khác. ** Sử dụng thận trọng **.
  - "Phương pháp biến đặt sẵn" -may ảnh hưởng đến các thành phần khác hoặc các hệ thống khác. ** Sử dụng thận trọng **.
  -Thiết bị giả - Phương pháp này rất đáng tin cậy. ** Khuyến nghị **.

### Bản vá quan trọng

- *** SSDT-RTC0 *** - nằm trong Thiết bị giả

  Một số máy gặp sự cố trong khi khởi động do RTC bị vô hiệu hóa [PNP0B00]. Sử dụng *** SSDT-RTC0 *** để giải quyết vấn đề này.

- *** SSDT-EC *** - Nằm trong "EC giả"

  Đối với hệ thống ** 10.15 + ** [notebook], nếu tên bộ điều khiển EC không phải là `EC`, hãy thêm *** SSDT-EC ***, nếu không hệ thống sẽ gặp sự cố trong giai đoạn khởi động.
