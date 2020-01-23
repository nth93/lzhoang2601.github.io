Bản vá # 0D / 6D

## Tổng quan

-`_PRW` định nghĩa một phương thức đánh thức thành phần. `Return` của nó là một gói có từ 2 byte trở lên. Để biết chi tiết về `_PRW`, xem đặc tả ACPI.
-Có một số bộ phận, vì `_PRW` và macOS của chúng bị xung đột, máy ngay lập tức được đánh thức ngay sau khi ngủ thành công. Để giải quyết vấn đề, các bản vá phải được áp dụng cho các thành phần này. Byte đầu tiên của các gói `_PRW` này là` 0D` hoặc` 6D`. Do đó, loại bản vá này được gọi là bản vá '0D / 6D', còn được gọi là 'bản vá đánh thức thứ hai', còn được gọi là bản vá 'đánh thức dậy'. Để thuận tiện cho việc mô tả, các phần sau đây được gọi chung là các bản vá `0D / 6D`.
- byte thứ hai của gói `_PRW` chủ yếu là` 03` hoặc` 04`. Sửa đổi byte này thành` 0` hoàn thành bản vá` 0D / 6D`.
-Các máy khác nhau có thể định nghĩa `_PRW` khác nhau, và nội dung và hình thức của các gói dữ liệu của chúng cũng có thể đa dạng. Bản vá `0D / 6D 'thực tế phải được xác định theo từng trường hợp cụ thể. Xem mô tả sau.
-Chúng tôi hy vọng rằng các phiên bản tương lai của OpenCore sẽ giải quyết vấn đề `0D / 6D`.

### Các thành phần có thể yêu cầu `0D / 6D Patch`

Thiết bị -USB
  -`ADR` địa chỉ: `0x001D0000`, tên một phần:` EHC1`.
  -`ADR` địa chỉ: `0x001A0000`, tên một phần:` EHC2`.
  -`ADR` địa chỉ: `0x00140000`, tên một phần:` XHC`, `XHCI`,` XHC1`, v.v.
  -`ADR` địa chỉ: `0x00140001`, tên một phần:` XDCI`.
  -`ADR` địa chỉ: `0x00140003`, tên một phần:` CNVW`.

-Khác

  -Trước thế hệ thứ 6, địa chỉ `ADR`:` 0x00190000`, tên bộ phận: `GLAN`,` IGBE`, v.v.
  Thế hệ thứ 6 trở lên, địa chỉ `ADR`:` 0x001F0006`, tên một phần: `GLAN`,` IGBE`, v.v.

Thẻ -Sound

  -Trước thế hệ thứ 6, địa chỉ `ADR`:` 0x001B0000`, tên bộ phận: `HDEF`,` AZAL`, v.v.
  Thế hệ thứ 6 trở lên, địa chỉ `ADR`:` 0x001F0003`, tên một phần: `HDAS`,` AZAL`, v.v.

  ** Lưu ý 1 **: Phương pháp xác nhận các phần trên bằng cách tra cứu tên không đáng tin cậy. Một phương pháp đáng tin cậy là tìm kiếm `địa chỉ ADR`,` _PRW`.

  ** Lưu ý 2 **: Các máy mới được phát hành có thể có các bộ phận mới yêu cầu các bản vá `0D / 6D`.

## `_PRW` sự đa dạng và các phương thức vá tương ứng

-'Tên loại`

  `` `Swift
    Tên (_PRW, Gói (0x02)
    {
        0x0D, / * có thể là 0x6D * /
        0x03, / * có thể là 0x04 * /
        ...
    })
  `` `

  Loại `0D / 6D patch` này phù hợp để sửa đổi` 0x03` (hoặc` 0x04`) thành` 0x00` bằng cách sử dụng phương thức đổi tên nhị phân. Gói cung cấp:

  -Name-0D đã đổi tên thành .plist
    -`Name0D-03` đến` 00`
    -`Name0D-04` đến` 00`
  -Name-6D đã đổi tên thành .plist
    -`Name6D-03` đến` 00`
    -`Name6D-04` đến` 00`

-Một trong các loại Phương thức`: `GPRW (UPRW)`

  `` `Swift
    Phương thức (_PRW, 0, Không được phân loại)
    {
      Trả về (GPRW (0x6D, 0x04)) / * hoặc Trả lại (UPRW (0x6D, 0x04)) * /
    }
  `` `

  Điều này chủ yếu là trường hợp với các máy mới hơn. Chỉ cần làm theo phương pháp thông thường (đổi tên-vá). Gói cung cấp:

  - *** SSDT-GPRW *** (dữ liệu được đổi tên nhị phân trong tệp vá)
  - *** SSDT-UPRW *** (dữ liệu được đổi tên nhị phân trong tệp vá)

-`Method type` hai: `Phạm vi`

  `` `Swift
    Phạm vi (_SB.PCI0.XHC)
    {
        Phương thức (_PRW, 0, Không được phân loại)
        {
            ...
            Nếu ((Local0 == 0x03))
            {
                Trả lại (Gói (0x02)
                {
                    0x6D,
                    0x03
                })
            }
            Nếu ((Local0 == Một))
            {
                Trả lại (Gói (0x02)
                {
                    0x6D,
                    Một
                })
            }
            Trả lại (Gói (0x02)
            {
                0x6D,
                Không
            })
        }
    }
  `` `

  Tình trạng này không phổ biến. Trong trường hợp ví dụ, sử dụng đổi tên nhị phân *** Name6D-03 thành 00 ***. Hãy thử các hình thức nội dung khác cho mình.

-`Name type`, `Kiểu phương thức` Phương thức hỗn hợp

  Đối với hầu hết các máy TP, các phần liên quan đến bản vá `0D / 6D 'có cả` Tên` và` Phương thức`. Sử dụng các loại miếng vá tương ứng. ** Cần lưu ý rằng ** Các bản vá đổi tên nhị phân không bị lạm dụng. Một số thành phần `_PRW` không yêu cầu bản vá 0D / 6D` cũng có thể là` 0D` hoặc` 6D`. Để ngăn chặn các lỗi như vậy, tệp `System DSDT` nên được trích xuất để xác minh và xác minh.

### Ghi chú

-Phương pháp được mô tả trong bài viết này hoạt động cho Hotpatch.
-Trong trường hợp đổi tên nhị phân được sử dụng, tệp `System DSDT` nên được trích xuất để xác minh.
