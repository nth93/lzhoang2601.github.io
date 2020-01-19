# Bản vá thiết lập lại CMOS

## Mô tả

- ** "Lỗi tự kiểm tra khi bật nguồn" xuất hiện khi một số máy bị tắt hoặc khởi động lại, nguyên nhân là do CMOS được đặt lại.
-Khi sử dụng Cỏ ba lá, đánh dấu `ACPI \ FixRTC` có thể giải quyết các vấn đề trên.
-Khi sử dụng OpenCore, các giải pháp sau đây được cung cấp chính thức, xem *** Sample.plist ***:
  -Install ** RTCMemoryFixup.kext **
  -`Kernel \ Patch` patch: ** __ ZN11BCM5701Enet14getAd ModuleInfoEv **
- Chương này cung cấp phương pháp vá SSDT để giải quyết các vấn đề trên. Bản vá SSDT này thực chất là một RTC giả, xem Phương pháp Biến đặt sẵn và Thiết bị giả.

## Giải pháp

-Được xóa số ** ngắt ** của ** RTC `PNP0B00` ** part` _CRS`.

  `` `Swift
  Thiết bị (RTC)
  {
      Tên (_HID, EisaId ("PNP0B00"))
      Tên (_CRS, ResourceTemplate ()
      {
          IO (Giải mã 16,
              0x0070,
              0x0070,
              0x01,
              0x08, / * hoặc 0x02, được xác định bằng thực nghiệm * /
              )
          IRQNoFlags () / * xóa dòng này * /
              {8} / * xóa dòng này * /
      })
  }
  `` `

## Bản vá: SSDT-RTC0-NoFlags

-Các bộ phận gốc có thể thay đổi: ** RTC **
  -Nếu ** RTC ** không tồn tại `_STA`, hãy vô hiệu hóa ** RTC ** bằng cách sử dụng:
  
    `` `Swift
    Bên ngoài (_SB.PCI0.LPCB.RTC, DeviceObj)
    Phạm vi (_SB.PCI0.LPCB.RTC)
    {
        Phương thức (_STA, 0, Không được phân loại)
        {
            Nếu (_OSI ("Darwin"))
            {
                Trả lại (Không)
            }
            Khác
            {
                Trả lại (0x0F)
            }
        }
    }
    `` `
  
  -Nếu _RTC tồn tại trong ** RTC **, hãy tắt ** RTC ** bằng phương thức biến đặt trước. Biến trong ví dụ là `STAS`. Khi sử dụng nó, hãy chú ý đến tác động của` STAS` trên các thiết bị và thành phần khác.
  
    `` `Swift
    Bên ngoài (STAS, FieldUnitObj)
    Phạm vi (\)
    {
        Nếu (_OSI ("Darwin"))
        {
            STAS = 2
        }
    }
    `` `

-Cách giả ** RTC0 **, xem mẫu.

## Lưu ý

-Tên thiết bị và đường dẫn trong bản vá phải giống với ACPI ban đầu.

-Nếu máy bị vô hiệu hóa RTC vì một số lý do, nó cần phải được làm giả để hoạt động đúng. Trong trường hợp này, ** "Lỗi tự kiểm tra bật nguồn" xuất hiện, xóa số ngắt của bản vá giả:

  `` `Swift
    IRQNoFlags () / * xóa dòng này * /
        {8} / * xóa dòng này * /
  `` `
