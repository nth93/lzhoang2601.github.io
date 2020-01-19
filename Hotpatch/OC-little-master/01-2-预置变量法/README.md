

-Phương pháp được gọi là ** đặt trước ** là gán trước một số biến ACPI (loại `Name` và` FieldUnitObj`) để đạt được mục đích khởi tạo. [Mặc dù các biến này được gán các giá trị tại thời điểm định nghĩa, chúng không bị thay đổi cho đến khi phương thức Phương thức gọi chúng. 】
-Sửa đổi các biến này trong `Phạm vi (\)` thông qua các tệp vá của bên thứ ba có thể đạt được hiệu ứng vá mong đợi.

## Rủi ro

-Các biến `được sửa đổi có thể tồn tại ở nhiều nơi. Sau khi sửa đổi, nó có thể ảnh hưởng đến các phần khác trong khi đạt được hiệu quả mong đợi của chúng tôi.
-Corrected `biến` có thể đến từ thông tin phần cứng, chỉ đọc chứ không đọc. Trong trường hợp này, ** đổi tên nhị phân ** và ** bản vá SSDT ** là cần thiết để hoàn thành. Cần lưu ý rằng khi OC khởi động các hệ thống khác, có thể không thể khôi phục tên `biến`. Xem ** Ví dụ 4 **.

### Ví dụ 1

Một thiết bị _STA Bản gốc:

`` `Swift
    Phương thức (_STA, 0, Không được phân loại)
    {
        ECTP (Không)
        Nếu ((SDS1 == 0x07))
        {
            Trả lại (0x0F)
        }
        Trả lại (Không)
    }
`` `

Vì một số lý do, chúng tôi cần phải vô hiệu hóa thiết bị này, để đạt được mục đích `_STA` nên trả về` Zero`. Có thể thấy từ văn bản gốc miễn là `SDS1` không bằng` 0x07`. Phương thức biến đặt trước ** được sử dụng như sau:

`` `Swift
    Phạm vi (\)
    {
        Bên ngoài (SDS1, FieldUnitObj)
        Nếu (_OSI ("Darwin"))
        {
            SDS1 = 0
        }
    }
`` `

### Ví dụ 2

Bản vá chính thức *** SSDT-AWAC *** được sử dụng để buộc RTC và vô hiệu hóa AWAC cùng một lúc cho một số máy trên 300 series.

Lưu ý: *** SSDT-RTC0 *** cũng có thể được sử dụng để bật RTC, xem "Thiết bị giả".

Bản gốc:

`` `
Thiết bị (RTC)
{
    ...
    Phương thức (_STA, 0, Không được phân loại)
    {
            Nếu ((STAS == Một))
            {
                    Trả lại (0x0F)
            }
            Khác
            {
                    Trả lại (Không)
            }
    }
    ...
}
Thiết bị (AWAC)
{
    ...
    Phương thức (_STA, 0, Không được phân loại)
    {
            Nếu ((STAS == Zero))
            {
                    Trả lại (0x0F)
            }
            Khác
            {
                    Trả lại (Không)
            }
    }
    ...
}
`` `

Như có thể thấy từ văn bản gốc, miễn là STAS = 1, bạn có thể bật RTC và tắt AWAC cùng một lúc. Phương thức biến đặt trước ** được sử dụng như sau:

-Bảng vá hiệu quả *** SSDT-AWAC ***

  `` `
      Bên ngoài (STAS, IntObj)
      Phạm vi (_SB)
      {
          Phương thức (_INI, 0, NotSerialized) // _INI: Khởi tạo
          {
              Nếu (_OSI ("Darwin"))
              {
                  STAS = Một
              }
          }
      }
  `` `

  Lưu ý: Bản vá chính thức giới thiệu đường dẫn `_SB._INI`. Khi sử dụng, hãy đảm bảo rằng DSDT và các bản vá khác không tồn tại trong` _SB._INI`.

Bản vá được cải tiến *** SSDT-RTC_Y-AWAC_N ***

  `` `
      Bên ngoài (STAS, IntObj)
      Phạm vi (\)
      {
          Nếu (_OSI ("Darwin"))
          {
              STAS = Một
          }
      }
  `` `

### Ví dụ 3

 Khi I2C được vá, GPIO có thể cần phải được bật. Xem *** SSDT-OCGPI0-GPEN *** trong Bản vá OCI2C-GPIO.

Một số văn bản:

`` `
    Phương thức (_STA, 0, Không được phân loại)
    {
        Nếu ((GPEN == Zero))
        {
            Trả lại (Không)
        }
        Trả lại (0x0F)
    }
`` `

Như có thể thấy từ văn bản gốc, miễn là GPEN không bằng 0, GPIO có thể được bật. Phương thức biến đặt trước ** được sử dụng như sau:

`` `
    Bên ngoài (GPEN, FieldUnitObj)
    Phạm vi (\)
    {
        Nếu (_OSI ("Darwin"))
        {
            GPEN = 1
        }
    }
`` `

### Ví dụ 4

Khi `biến` chỉ đọc, giải pháp như sau:

-Tên tên `gốc`
-Xác định một biến có cùng tên trong tệp vá

Chẳng hạn như: một văn bản:

`` `
  OperationRegion (PNVA, SystemMemory, PNVB, PNVL)
  Trường (PNVA, AnyAcc, Khóa, Bảo quản)
  {
...
IM01, 8,
...
  }
  ...
Nếu ((IM01 == 0x02))
{
...
}
`` `

Tình huống thực tế `IM01` không bằng 0x02, nội dung của {...} không thể được thực thi. Để sửa lỗi, ** đổi tên nhị phân ** và ** bản vá SSDT ** được sử dụng:

** Đổi tên **: `IM01` đổi tên` XM01`

`` `
Tìm: 49 4D 30 31 08
Thay thế: 58 4D 30 31 08
`` `

** Bản vá **:

`` `
Tên (IM01, 0x02)
Nếu (_OSI ("Darwin"))
{
}
Khác
{
        IM01 = XM01 // Đường dẫn giống như biến ACPI ban đầu
}
`` `

** Rủi ro **: `XM01` có thể không được khôi phục khi OC khởi động các hệ thống khác.
