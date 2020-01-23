# Phương pháp vá AOAC

## AOAC

-Các máy tính xách tay mới giới thiệu một công nghệ mới - `AOAC`, cụ thể là: * Luôn bật / Luôn kết nối *. `AOAC` được đề xuất bởi` Intel`, nhằm mục đích duy trì kết nối mạng và truyền dữ liệu của máy tính ở chế độ ngủ hoặc ngủ đông. Nói một cách đơn giản, việc giới thiệu AOAC làm cho máy tính xách tay, như điện thoại của chúng tôi, không bao giờ tắt và luôn trực tuyến.
-Để biết thêm thông tin về AOAC, vui lòng sử dụng Yahoo `AOAC`,` Lenovo AOAC`, `AOAC Network Card`, v.v.

## Sự cố với AOAC

### Mất ngủ

-Do mâu thuẫn giữa `AOAC` và` S3`, các máy sử dụng công nghệ` AOAC` không có chức năng ngủ 'S3`, chẳng hạn như` Lenovo PRO13`. Khi một chiếc máy như vậy đi vào giấc ngủ `S3`, nó sẽ ** ngủ không thành công **. ** Mất ngủ ** Các biểu hiện chính là: không thể thức dậy sau khi ngủ, thể hiện trạng thái đóng băng và chỉ có thể buộc phải tắt máy. ** Mất ngủ ** Bản chất là máy bị đình trệ trong khi ngủ, và chưa bao giờ thành công.
- ** Giải pháp **: ** Cấm `S3` ngủ **, xem phương pháp vá bên dưới. Để biết nội dung của `S3`, vui lòng tham khảo Thông số kỹ thuật ACPI.

### Vấn đề thời gian chờ

- ** S3` ngủ bị cấm ** Máy sẽ không còn ngủ nữa. Vấn đề đi kèm với giấc ngủ là thời gian chờ của máy bị giảm đáng kể ở chế độ chạy bằng pin. Ví dụ, trong trường hợp "ngủ menu", "ngủ tự động", "ngủ nắp", v.v., pin tiêu thụ một lượng điện năng lớn, khoảng 5% -10% mỗi giờ.
- ** Giải pháp **:
  Tắt nguồn màn hình độc lập
  - Tối đa hóa việc quản lý năng lượng của SSD
    -Chọn SSD chất lượng tốt hơn: SLC> MLC> TLC> QLC (không chắc chắn)
    Nâng cấp firmware SSD nếu có thể để cải thiện hiệu suất quản lý năng lượng
    -Sử dụng SSDT-DeepIdle để tăng khả năng SSD vào quản lý năng lượng nhàn rỗi, xem phương pháp vá bên dưới
    -Sử dụng NVMeFix.kext để bật APST cho SSD
    -Có thể sử dụng bo mạch chủ ASPM (thường trong các tùy chọn nâng cao của BIOS). Để tham khảo về cài đặt ASPM: <https://www.sohu.com/a/120850299_505795>

## Bản vá AOAC

-Các bản vá `S3`, xem chương này

  -Tên: `_S3` đến` XS3`

    `` `văn bản
    Tìm: 5F53335F
    Thay thế: 5853335F
    `` `

  -Patch: *** SSDT-S3-vô hiệu hóa ***

    `` `c
    Nếu (_OSI ("Darwin"))
    {
        / * Trống * /
    }
    Khác
    {
        Tên (_S3, Gói (0x04)
        {
            0x05,
            Không,
            Không,
            Không
        })
    }
    `` `

-`DeepIdle` patch, xem chương này

  -Tên: Không

  -Patch: *** SSDT-DeepIdle ***

    `` `c
    // IORegistryExplorer
    // Dịch vụ IOS: / AppleACPIPl platformExpert / IOPMrootDomain:
    // IOPMDeepIdleSupported = true
    // IOPMSystemS ngủType = 7
    // PMStatusCode =?
    Phạm vi (_SB)
    {
        Phương thức (LPS0, 0, NotSerialized)
        {
            Nếu (_OSI ("Darwin"))
            {
                Trả lại (Một)
            }
        }
    }
    Phạm vi (_GPE)
    {
        Phương thức (LXEN, 0, Không xác định)
        {
            Nếu (_OSI ("Darwin"))
            {
                Trả lại (Một)
            }
        }
    }
    `` `

  -Để biết chi tiết, xem: <https://pikeralpha.wordpress.com/2017/01/12/debugging-sadd-issues/>

-Wake lên màn hình sáng, xem chương này

  Sử dụng *** SSDT-S3-vô hiệu hóa *** sẽ khiến bạn khó thức dậy. Để giải quyết vấn đề này, các phương pháp sau được sử dụng:

  -Xác định một nút làm nút đánh thức. Lấy Xiaoxin PRO13 làm ví dụ, chỉ định `Fn + Q` (Vị trí:` _Q50`)
  -Sử dụng phương pháp đánh thức `PNP0C0D`, xem" Phương pháp điều chỉnh giấc ngủ PNP0C0E "
  
    Tài liệu đính kèm: `PNP0C0D` điều kiện thức dậy:
    -`_LID` trả lại` Một`. `_LID` là trạng thái hiện tại của thiết bị` PNP0C0D`.
    -Xuất hiện `Thông báo (***. LID0, 0x80)`. `LID0` là tên thiết bị` PNP0C0D`.
  -Ví dụ: *** SSDT-FnQ-WakeScreen ***

