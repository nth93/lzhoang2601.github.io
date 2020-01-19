# Bản vá đặc biệt của Dell

### Yêu cầu

-Kiểm tra xem ACPI có `Phương thức` và 'Phương thức' nào sau đây và tên trùng khớp với nhau không, nếu không hãy bỏ qua chương này.
   -`Device`: ECDV [PNP0C09]
   -`Device`: LID0 [PNP0C0D]
   -`Method`: OSID
   -Method`: BRT6
   -Method`: BTNV

### Bản vá đặc biệt

- *** SSDT-OCWork-dell ***
    Bản vá phím tắt độ sáng điều kiện yêu cầu *** SSDT-OCWork-dell *** để hoạt động chính xác.
    -Modify `ACSE` trong bản vá để đặt chế độ làm việc.
      -` \ _SB.ACSE` = 0 là chế độ win7. Ở chế độ này, đèn thở sẽ nhấp nháy trong khi ngủ máy.
      -` \ _SB.ACSE` = 1 là chế độ win8. Ở chế độ này, đèn thở tắt trong khi ngủ máy.

Bộ sưu tập bản vá -Fix cho phím chức năng Fn + Chèn
  
   - *** SSDT-PTSWAK *** Xem PTSWAK Bản vá toàn diện và bản mở rộng
   - *** SSDT-EXT4-WakeScreen *** Xem "PTSWAK Bản vá toàn diện và Bản vá mở rộng"
  
   - *** SSDT-LIDpatch *** Xem "Phương pháp điều chỉnh giấc ngủ PNP0C0E"
  
   - *** SSDT-FnInsert_BTNV-dell *** Xem "Phương pháp điều chỉnh giấc ngủ PNP0C0E"
