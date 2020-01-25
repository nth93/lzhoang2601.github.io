# PNP0C0E Phương pháp điều chỉnh giấc ngủ

## `PNP0C0E` và` PNP0C0D` chế độ ngủ

Đặc điểm kỹ thuật -ACPI

  `PNP0C0E` - Thiết bị nút ngủ

  `PNP0C0D` - Thiết bị nắp

  Để biết chi tiết về `PNP0C0E` và` PNP0C0D`, vui lòng tham khảo thông số kỹ thuật ACPI.

-`PNP0C0E` điều kiện ngủ

  -Xuất hiện `Thông báo (***. SLPB, 0x80)`. `SLPB` là tên thiết bị` PNP0C0E`.
  
-`PNP0C0D` điều kiện ngủ

  -`_LID` trả về` Zero`. `_LID` là trạng thái hiện tại của thiết bị` PNP0C0D`.
  -Xuất hiện `Thông báo (***. LID0, 0x80)`. `LID0` là tên thiết bị` PNP0C0D`.

## Mô tả sự cố

Một số máy cung cấp các nút ngủ (nút mặt trăng nhỏ), chẳng hạn như: Fn + F4 cho một số ThinkPad, Fn + Chèn cho Dell, v.v. Khi nhấn nút này, hệ thống sẽ thực thi chế độ ngủ `PNP0C0E`. Tuy nhiên, ACPI đã chuyển không chính xác các tham số tắt hệ thống thay vì tham số ngủ, khiến hệ thống gặp sự cố. Ngay cả khi bạn có thể ngủ, bạn có thể thức dậy bình thường và trạng thái làm việc của hệ thống cũng bị phá hủy.

Một trong những phương pháp sau có thể khắc phục vấn đề này:

-Xác nhận các tham số được truyền bởi ACPI và sửa nó.
-Chuyển đổi `PNP0C0E` ngủ thành` PNP0C0D` ngủ.

## Giải pháp

#### Liên kết 3 Bản vá

- *** SSDT-PTSWAK ***: Xác định các biến `FNOK` và` MODE` để nắm bắt các thay đổi của` FNOK`. Xem "Bản vá mở rộng và bản vá mở rộng PTSWAK".

  -`FNOK` chỉ trạng thái chính
    -`FNOK` = 1: Nhấn nút ngủ
    -`FNOK` = 0: Sau khi nhấn nút ngủ một lần nữa hoặc máy bị đánh thức
  -`MODE` Đặt chế độ ngủ
    -`MODE` = 1: `PNP0C0E` ngủ
    -`MODE` = 0: `PNP0C0D` ngủ

  Lưu ý: Đặt `MODE` theo nhu cầu của bạn, nhưng bạn không thể thay đổi` FNOK`.

- *** SSDT-LIDpatch ***: Ghi lại các thay đổi `FNOK`

  -Nếu `FNOK` = 1, trạng thái hiện tại của thiết bị nắp trả về` Zero`
  -Nếu `FNOK` = 0, trạng thái hiện tại của thiết bị nắp trở về giá trị ban đầu

  Lưu ý: Tên và đường dẫn thiết bị `PNP0C0D` phải phù hợp với ACPI.

- *** Bản vá nút ngủ ***: Sau khi nhấn nút, tạo `FNOK` =` 1` và thực hiện thao tác tương ứng theo các chế độ ngủ khác nhau

  Lưu ý: Tên và đường dẫn của thiết bị `PNP0C0D` phải giống với ACPI.

#### Mô tả về hai chế độ ngủ

-`MODE` = 1 chế độ: Khi nhấn nút ngủ, *** vá nút ngủ *** làm cho` FNOK = 1`. *** SSDT-PTSWAK *** bị bắt `FNOK` as` 1`, buộc` Arg0 = 3` (nếu không thì` Arg0 = 5`). Tiếp tục `FNOK = 0` sau khi thức dậy. Một quá trình ngủ và thức hoàn toàn `PNP0C0E` kết thúc.
Chế độ -`MODE` = 0: Khi nhấn nút ngủ, ngoài việc hoàn thành quy trình trên, *** SSDT-LIDpatch *** cũng bắt` FNOK = 1`, để `_LID` trở về` Zero` và thực thi `PNP0C0D` Ngủ. Tiếp tục `FNOK = 0` sau khi thức dậy. Một quá trình ngủ và thức hoàn toàn `PNP0C0D` kết thúc.

Dưới đây là nội dung chính của *** SSDT-LIDpatch ***:

`` `
    Phương thức (_LID, 0, Chưa xác định)
    {
        if (\ _ SB.PCI9.FNOK == 1)
        {
            Trả về (0) // Trở về số 0, đáp ứng một trong các điều kiện ngủ PNP0C0D
        }
        Khác
        {
            Trả về (\ _SB.LID0.XLID ()) // Quay trở lại giá trị ban đầu
        }
    }
`` `

Sau đây là nội dung chính của *** Bản vá nút ngủ ***:

`` `
    Nếu (\ _SB.PCI9.MODE == 1) // PNP0C0E ngủ
    {
        \ _SB.PCI9.FNOK = 1 // Nhấn nút ngủ
        \ _SB.PCI0.LPCB.EC.XQ13 () // Vị trí nút ngủ ban đầu, ví dụ là máy TP
    }
    Khác // PNP0C0D ngủ
    {
        Nếu (\ _SB.PCI9.FNOK! = 1)
        {
                \ _SB.PCI9.FNOK = 1 // Nhấn nút ngủ
        }
        Khác
        {
                \ _SB.PCI9.FNOK = 0 // Nhấn lại nút ngủ
        }
        Thông báo (\ _SB.LID, 0x80) // Thực hiện giấc ngủ PNP0C0D
    }
`` `



### Ví dụ về đổi tên và kết hợp bản vá: (Dell Latitude 5480 và ThinkPad X1C5th)

- ** Dell Latitude 5480 **

  PTSWAK đã đổi tên: `_PTS` thành` ZPTS`,` _WAK` thành` ZWAK`.

  Đổi tên trạng thái bìa: `_LID` thành` XLID`

  Đổi tên khóa: `BTNV` thành` XTNV` (Dell-Fn + Chèn)

  Kết hợp bản vá:

  - *** SSDT-PTSWAK ***: Bản vá toàn diện. Đặt `MODE` theo nhu cầu của bạn.
  - *** SSDT-LIDpatch ***: bản vá trạng thái nắp.
  - *** SSDT-FnInsert_BTNV-dell ***: Bản vá nút ngủ.

- ** ThinkPad X1C5th **

  PTSWAK đã đổi tên: `_PTS` thành` ZPTS`,` _WAK` thành` ZWAK`.

  Đổi tên trạng thái bìa: `_LID` thành` XLID`

  Đổi tên khóa: `_Q13 thành XQ13` (TP-Fn + F4)
  
  Kết hợp bản vá:
  
  - *** SSDT-PTSWAK ***: Bản vá toàn diện. Đặt `MODE` theo nhu cầu của bạn.
  - *** SSDT-LIDpatch ***: bản vá trạng thái nắp. Sửa đổi `LID0` trong bản vá thành` LID`.
  - *** SSDT-FnF4_Q13-X1C5th ***: Bản vá nút ngủ.
  
  ** Lưu ý 1 **: Nút ngủ của X1C5th là Fn + 4 và nút ngủ của một số TP là Fn + F4.
  
  ** Lưu ý 2 **: Tên bộ điều khiển `LPC` của máy LP có thể là` LPC` hoặc` LPCB`.

### Sửa chữa máy khác `PNP0C0E` ngủ

-Sử dụng bản vá: *** SSDT-PTSWAK ***; Đổi tên: `_PTS` thành` ZPTS`,` _WAK` thành` ZWAK`. Xem "Bản vá mở rộng và bản vá mở rộng PTSWAK".

  Sửa đổi `MODE` theo nhu cầu của bạn.

-Sử dụng bản vá: *** SSDT-LIDpatch ***; Đổi tên: `_LID` thành` XLID`.

  Lưu ý: Tên và đường dẫn thiết bị `PNP0C0D` phải phù hợp với ACPI.

-Tìm vị trí của nút ngủ, tạo *** miếng vá nút ngủ ***

  - Nói chung, nút ngủ là `_Qxx` dưới` EC`. Cái này` _Qxx` chứa lệnh 'Notify (***. SLPB, 0x80) `. Nếu bạn không thể tìm thấy nó, DSDT thực hiện tìm kiếm toàn văn `Thông báo (***. SLPB, 0x80)` để tìm vị trí của nó và dần dần tìm vị trí ban đầu lên trên.
  -Refer vào ví dụ để thực hiện một bản vá nút ngủ và đổi tên cần thiết.

  Lưu ý 1: SLPB là tên thiết bị `PNP0C0E`. Nếu bạn không có thiết bị `PNP0C0E`, hãy thêm bản vá: SSDT-SLPB (nằm trong" Thêm phần bị thiếu ").

  Lưu ý 2: Tên và đường dẫn thiết bị `PNP0C0D` phải phù hợp với ACPI.

### `PNP0C0E` Đặc điểm giấc ngủ

-Quá trình ngủ nhanh hơn một chút.
-Quá trình ngủ không thể chấm dứt.

### `PNP0C0D` Đặc điểm giấc ngủ

- Ngủ ngon, nhấn nút ngủ lần nữa để ngừng ngủ ngay lập tức.

-Khi màn hình ngoài được kết nối, sau khi nhấn nút ngủ, màn hình làm việc ở bên ngoài (màn hình bên trong tắt), khi nhấn nút ngủ một lần nữa, màn hình bên trong và màn hình ngoài vẫn bình thường.

  

## Lưu ý

-`PNP0C0E` và` PNP0C0D` tên và đường dẫn thiết bị phải giống với ACPI.
