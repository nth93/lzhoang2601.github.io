DefinitionBlock("", "SSDT", 2, "ACDT", "SleepKey", 0)
{
    External(_SB.PCI9.FNOK, IntObj)
    External(_SB.PCI9.MODE, IntObj)
    External(_SB.LID0, DeviceObj) 
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.XQxx, MethodObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q13, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (\_SB.PCI9.MODE == 1) //PNP0C0E
                {
                    \_SB.PCI9.FNOK =1
                    \_SB.PCI0.LPCB.EC.XQxx()
                }
                Else //PNP0C0D
                {
                    If (\_SB.PCI9.FNOK!=1)
                    {
                        \_SB.PCI9.FNOK =1
                    }
                    Else
                    {
                        \_SB.PCI9.FNOK =0
                    }
                    Notify (\_SB.LID0, 0x80) 
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQxx()
            }
        }
    }
}
//EOF