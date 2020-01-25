# Phương pháp vá AOAC

## AOAC

-Các máy tính xách tay mới giới thiệu một công nghệ mới - `AOAC`, cụ thể là: * Luôn bật / Luôn kết nối *. `AOAC` được đề xuất bởi` Intel`, nhằm mục đích duy trì kết nối mạng và truyền dữ liệu của máy tính ở chế độ ngủ hoặc ngủ đông. Nói một cách đơn giản, việc giới thiệu AOAC làm cho máy tính xách tay, như điện thoại của chúng tôi, không bao giờ tắt và luôn trực tuyến.
-Đối với nội dung của `AOAC`, xin vui lòng Baidu` AOAC`,` Lenovo AOAC`, `AOAC Network Card`, v.v.

## Vấn đề AOAC

### Mất ngủ

-Do mâu thuẫn giữa `AOAC` và` S3`, các máy sử dụng công nghệ` AOAC` không có chức năng ngủ 'S3`, chẳng hạn như` Lenovo PRO13`. Khi một chiếc máy như vậy đi vào giấc ngủ `S3`, nó sẽ ** ngủ không thành công **. ** Mất ngủ ** Các biểu hiện chính là: nó không thể được đánh thức sau khi ngủ, nó ở trạng thái chết và chỉ có thể buộc phải tắt máy. ** Mất ngủ ** Bản chất là máy bị đình trệ trong khi ngủ, và chưa bao giờ thành công.
-Đối với nội dung của `S3` ngủ, vui lòng tham khảo Thông số kỹ thuật ACPI.

### Vấn đề thời gian chờ

- ** Cấm `S3` ngủ ** có thể giải quyết vấn đề ** mất ngủ **, nhưng máy sẽ không còn ngủ nữa. Vấn đề đi kèm với giấc ngủ là thời gian chờ của máy bị giảm đáng kể ở chế độ chạy bằng pin. Ví dụ: trong trường hợp "ngủ thực đơn", "ngủ tự động", "ngủ nắp", v.v., pin tiêu thụ một lượng điện năng lớn, khoảng 5% -10% mỗi giờ.

## Giải pháp AOAC

- ** Không `S3` ngủ **
-Thời gian chờ mở rộng
  Tắt nguồn màn hình độc lập
  - Tối đa hóa việc quản lý năng lượng của SSD
    -Chọn SSD chất lượng tốt hơn: SLC> MLC> TLC> QLC (không chắc chắn)
    Nâng cấp firmware SSD nếu có thể để cải thiện hiệu suất quản lý năng lượng
    -Sử dụng SSDT-DeepIdle để tăng khả năng SSD vào quản lý năng lượng nhàn rỗi
    -Sử dụng NVMeFix.kext để bật APST cho SSD
    -Có thể sử dụng bo mạch chủ ASPM (Tùy chọn BIOS nâng cao). Tham khảo: <https://www.sohu.com/a/120850299_505795>

## AOAC ngủ, thức dậy

-`AOAC` ngủ -` AOAC` ngủ đặt hệ thống và phần cứng vào trạng thái nhàn rỗi, ngủ không truyền thống.
-`AOAC` đánh thức-`AOAC` thức dậy khó khăn hơn, thông thường bạn cần phím nguồn + PNP0C0D để thức dậy, xem` bản vá đánh thức màn hình sáng 'bên dưới.

## Bản vá AOAC

- *** Tắt SSDT-S3 *** - ** Tắt `S3` Ngủ ** Bản vá

- *** SSDT-DeepIdle *** - Bản vá `DeepIdle`

  Để biết chi tiết, xem: <https://pikeralpha.wordpress.com/2017/01/12/debugging-s ngủ -issues />

Kết hợp -`Bright màn hình Wake Patch`

  - *** SSDT-LIDpatch-AOAC *** Văn bản `Bản vá chung màn hình sáng`, vui lòng đảm bảo rằng đường dẫn PNP0C0D` giống như đường dẫn` ACPI` khi sử dụng
  
  - *** SSDT-FnQ-AOACWake *** Cách trẻXinxin PRO13 `Bản vá đánh thức bàn phím`, bàn phím:` Fn + Q`
  
  - *** SSDT-FnInsert-AOACWake *** Cách dùngdell5480 `Bản vá đánh thức khóa`, khóa:` Fn + Chèn`
  
      Tài liệu đính kèm: `PNP0C0D` điều kiện thức dậy:
  
    -`_LID` trả lại` Một`. `_LID` là trạng thái hiện tại của thiết bị` PNP0C0D`.
    -Xuất hiện `Thông báo (***. LID0, 0x80)`. `LID0` là tên thiết bị` PNP0C0D`.
    -Xem "Phương pháp điều chỉnh giấc ngủ PNP0C0E"
  
- Cấm các bản vá hiển thị độc lập - xem AOAC Cấm hiển thị độc lập

  ** Lưu ý **: Việc đổi tên theo yêu cầu của bản vá trên nằm trong phần nhận xét tệp bản vá tương ứng.


## Lưu ý

-Phương pháp này là một giải pháp tạm thời. Với ứng dụng rộng rãi của công nghệ AOAC, có thể có những giải pháp tốt hơn trong tương lai.
-`AOAC` Ngủ và thức giấc không liên quan gì đến 'S3` Ngủ và thức. Các bản vá sau đây là không bắt buộc:
  -PTSWAK Bản vá toàn diện và bản mở rộng
  - "Phương pháp điều chỉnh giấc ngủ PNP0C0E"
  - "Bản vá 0D6D" (có thể không cần thiết)
-Vì lý do tương tự, AOAC không thể hiển thị trạng thái làm việc chính xác trong khi ngủ, chẳng hạn như không có đèn thở.
-Không có máy móc AOAC` cũng có thể thử phương pháp này.