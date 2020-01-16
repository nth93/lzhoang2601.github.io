# LiZ Hoang

## ALS0 (Cảm biến ánh sáng)

## Battery (Các patch pin sẵn cho laptop)
    Xác định SSDT patch pin cho laptop của mình rồi save vào Clover/ACPI/patched dưới dạng .aml

## BrightKey (Hotkey tăng giảm độ sáng màn hình)
    Cách làm các bạn xem ở bài viết hoặc video sau
  
## EC
    1. Tìm "PNP0C09" trong DSDT của máy bạn，nếu tên bộ điều khiển EC là EC hay H_EC, ECDV thì đổi tên thành EC0 qua config.plist/ACPI/DSDT/Patches。
    2. Thêm SSDT-EC vào Clover/ACPI/patched để tạo EC ảo điều khiển nguồn USB

## ECDT
    1. Mở ECDT.aml trong Clover/ACPI/origin。
    2. Kiểm tra phần Namepatch, chuyển LPC thành LPCB, EC hay H_EC,ECDV thành ECO。
    3. Xoá hết phần Raw Table Data... đi 
    4. Save file ECDT.aml vừa chỉnh vào Clover/ACPI/patched
    5. Thêm ECDT vào config.plist/ACPI/Drop Table

## IMEI
    Save SSDT-IMEI.dsl vào Clover/APCI/patched dưới dạng .aml với các máy dùng CPU Sandy Brigde, Ivy Brigde

## LPC
    Save SSDT-LPC.dsl vào Clover/APCI/patched dưới dạng .aml với các máy dùng CPU Skylake trở về trước

## NullEthernet (Tạo 1 Lan ảo)
    1. Thêm NullEthernet.kext và NullEthernetInjector.kext vào CKO
    2. Save SSDT-LPC.dsl vào Clover/APCI/patched dưới dạng .aml
              
## PLUG
    Nếu bạn dùng Clover Bootloader thì không cần quan tâm, để kích hoạt chỉ cần tich PluginType trong config.plist/ACPI/Generate Options
    Còn nếu dùng OpenCore Bootloader, các bạn làm như sau
    1. Mở DSDT của máy bạn, tìm "Processor" nếu không có thì chuyển sang tìm "SCK0"
    2. Mở SSDT-Plug.dsl, nhấn Option+Command+F, 
        
## PNLF (Chỉnh độ sáng màn hình laptop)
    Để rõ hơn bạn có thể xem [bài viết](https://hackintosh.vn/su-dung-clover-de-thuc-hien-patch-nong-apci) hoặc [video]()

## PTSWAK
    1. Save file PTSWAK.dsl vào Clover/ACPI/patched dưới dạng .aml
    2. Mở DSDT của máy bạn, tìm "_PTS" và "_WAK"
    3. Mở config.plist, thêm các patch sau

## SATA
    Thêm SATA-100-series-unsupported.kext vào CKO nếu có pci 8086:a103 và 8086:9d03
    Thêm SATA-200-series-unsupported.kext vào CKO nếu có pci 8086:a282
    Thêm SATA-RAID-unsupported.kext vào CKO nếu có pci 8086:282A, 8086:2822
    Nếu không có pci được nhắc trên mà không nhận ổ cứng SATA thì hãy thêm AHCIinjectport.kext hoặc Sata-unsupported.kext
    
## SBUS    
    1. Tìm "0x001F0003" nếu dùng CPU Broadwell trở về trước, "0x001F0004" nếu dùng CPU Skylake hoặc mới hơn trong DSDT của máy bạn
    2. Nếu đã có Device (SBUS) rồi thì thôi, còn không thì save SSDT-SBUS.dsl vào Clover/APCI/patched dưới dạng .aml

## SleepKey

## USB

## Wake
    1. Mở DSDT của máy bạn, tìm kiếm lần lượt các địa chỉ sau: 
        * EHC1 (_ADR, 0x001D0000)
        * EHC2 (_ADR, 0x001A0000)
        * XHC, XHCI, XHC1 (_ADR, 0x00140000)
        * XDCI (_ADR, 0x00140001)
        * Sound: 
            Với CPU Broadwell trở về trước: HDEF hoặc AZAL (_ADR, 0x001B0000)
            Còn từ Skylake trở đi: HDAS (_ADR, 0x001F0003)
        * Ethernet
           Với CPU Broadwell trở về trước: GLAN hoặc IGBE hoặc khác (_ADR, 0x00190000)
           Còn từ Skylake trở đi: GLAN hoặc IGBE hoặc khác (_ADR, 0x001F0006)
        * CNVW (_ADR, 0x00140003)
        Kiểm tra tiếp xem thiết bị có '_PRW' hay không, nếu có thì tìm tiếp '0x0D' hoặc '0x6D' trong Method (_PRW,..) rồi lưu lại
    2. Dựa vào các thiết bị có '_PRW' để thêm patch vào config.plist/ACPI/Patches, các patch bạn có thể tìm ở config_master.plist với từ khoá (Wake)
    3. Mở SSDT-Sleep_PRW.dsl, nếu trong Method (_PRW,..) là 0x0D thì thay 0x6D thành 0x0D rồi save vào Clover/ACPI/patched với dạng .aml
    
## XOSI
    1. Save file SSDT-X0SI.dsl vào Clover/ACPI/patched dưới dạng .aml 
    2. Mở config.plist, thêm các patch sau
        
