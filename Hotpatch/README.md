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
    
## Fan (Hiển thị tốc độ quạt và nhiệt độ)
    1. Cho ACPIPoller.kext vào CKO
    2. Nếu bạn không dùng FakeSMC.kext, vui lòng dùng nó. Mở FakeSMC.kext/Info.plist/IOKitPersonalities/FakeSMC/Configuration/keys/FNum/1/, bạn thay 00 thành 01
    3. Với Dell laptop, bạn save SSDT-Fans-Dell.dsl vào Clover/ACPI/patched
    Với Thinkpad laptop, bạn save 1 trong 2 SSDT-Fans-TP.dsl hoặc SSDT-TEMPToFans-TP.dsl, không được dùng 2 SSDT này cũng lúc.

## IMEI
    Save SSDT-IMEI.dsl vào Clover/APCI/patched với các máy dùng CPU Sandy Brigde, Ivy Brigde

## LPC
    Save SSDT-LPC.dsl vào Clover/APCI/patched với các máy dùng CPU Skylake trở về trước

## NullEthernet (Tạo 1 Lan ảo)
    1. Thêm NullEthernet.kext và NullEthernetInjector.kext vào CKO
    2. Save SSDT-LPC.dsl vào Clover/APCI/patched dưới dạng .aml
              
## PLUG
    Nếu bạn dùng Clover Bootloader thì không cần quan tâm, để kích hoạt chỉ cần tich PluginType trong config.plist/ACPI/Generate Options
    Còn nếu dùng OpenCore Bootloader, các bạn làm như sau
    1. Mở DSDT của máy bạn, tìm "Processor" nếu không có thì chuyển sang tìm "SCK0", dựa vào dòng đầu tiên ta sẽ được Scope _PR.CPU0 hoặc _PR.PR00, SCK0.C000, SCK0.CPU0, _SB.CPU0, _SB.PR00
    2. Nếu được Scope _PR.CPU0, bạn chỉ việc save SSDT-PLUG.dsl vào Clover/ACPI/patched
    Còn nếu bạn nhận được Scope khác thì mở SSDT-PLUG.dsl, thay thế "_PR.CPU0" bằng Scope bạn nhận được rồi save SSDT-PLUG.dsl vào Clover/ACPI/patched
        
## PNLF (Chỉnh độ sáng màn hình laptop)
    Để rõ hơn bạn có thể xem [bài viết](https://hackintosh.vn/su-dung-clover-de-thuc-hien-patch-nong-apci) hoặc [video]()

## PTSWAK
    1. Save file PTSWAK.dsl vào Clover/ACPI/patched dưới dạng .aml
    2. Tìm "_PTS" và "_WAK" trong DSDT của máy bạn, nếu
        Method (_PTS, 1, NotSerialized) tức Method (_PTS, 1, N)
        Method (_PTS, 1, Serialized) tức Method (_PTS, 1, S)
        Method (_WAK, 1, NotSerialized) tức Method (_WAK, 1, N)
        Method (_WAK, 1, Serialized) tức Method (_WAK, 1, S)
    3. Dựa vào Method đã xác định trên, tìm kiếm các patch "(PTSWAK)..." phù hợp thêm vào config.plist/ACPI/Patches của bạn
    
## PTSWAK-Bản vá mở rộng
    Nếu bạn gặp khó khăn trong việc đánh thức laptop sau sleep, bạn làm như sau:
    1. Tìm "_SB.LID0" và "_SB.PCI0.LPCB.LID0" trong DSDT của bạn. 
    2. Nếu "_SB.LID0" có thì save SSDT-%EXT3-Wake_SB.LID0.dsl vào Clover/APCI/patched hoặc tương tự
    Còn nếu máy tính không shutdown được:
    1. Tìm "Processor" rồi đến "SCK0" để có được kết quả
    2. Nếu DATA của CPU là 1810 thì thay 0x000 thành 0x1830 trong SSDT-%EXT1.dsl rồi save vào Clover/ACPI/patched còn nếu DATA của CPU là 410 thì làm tương tự nhưng thay 0x000 thành 0x430...
    3. Save SSDT vừa chỉnh vào Clover/ACPI/patched

## SATA
    1. Thêm SATA-100-series-unsupported.kext vào CKO nếu có pci 8086:a103 và 8086:9d03
       Thêm SATA-200-series-unsupported.kext vào CKO nếu có pci 8086:a282
       Thêm SATA-RAID-unsupported.kext vào CKO nếu có pci 8086:282A, 8086:2822
    2. Thêm 2 patches "(SATA)..." ở config_master.plist/KernelAndKextPatches/KextsToPatch vào config.plist/KernelAndKextPatches/KextsToPatch của bạn
    Nếu không có pci được nhắc trên mà không nhận ổ cứng SATA thì hãy thêm AHCIinjectport.kext hoặc Sata-unsupported.kext
    
## SBUS    
    1. Tìm "0x001F0003" nếu dùng CPU Broadwell trở về trước, "0x001F0004" nếu dùng CPU Skylake hoặc mới hơn trong DSDT của máy bạn
    2. Nếu đã có Device (SBUS) rồi thì thôi, còn không thì save SSDT-SBUS.dsl vào Clover/APCI/patched

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
    3. Mở SSDT-Sleep_PRW.dsl, nếu trong Method (_PRW,..) là 0x0D thì thay 0x6D thành 0x0D rồi save vào Clover/ACPI/patched
    
## XOSI
    1. Save file SSDT-X0SI.dsl vào Clover/ACPI/patched 
    2. Mở config.plist, thêm các patch có đầu là "(XOSI)..." vào config.plist/ACPI/Patches của bạn        
