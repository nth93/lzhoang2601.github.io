#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    
    Scope (_SB.PCI0.LPCB.EC0)
    {
        //path:_SB.PCI0.LPCB.EC0._Q0E
        Method (_Q0E, 0, NotSerialized)//up
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
        }
    
        //path:_SB.PCI0.LPCB.EC0._Q0F
        Method (_Q0F, 0, NotSerialized)//down
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
        }
    }
    
// For _Q66 of DELL Laptop 
// In config ACPI, SMEE to XMEE
// Find:     53 4D 45 45 01
// Replace:  58 4D 45 45 01 
/*  
    External(GENS, MethodObj)
    Method (SMEE, 1, NotSerialized)
    {
        Local0 = Arg0
        Local0 = GENS (0x11, Zero, Zero)
        If ((Local0 & 0x04))
        {
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify (\_SB.PCI0.LPCB.PS2K, 0x10)
        }

        If ((Local0 & 0x02))
        {
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify (\_SB.PCI0.LPCB.PS2K, 0x20)
        }
    }
*/

// For _Q13 HP AD112TU
// In config ACPI, _Q13 renamed XQ13
// Find:     5F 51 31 33
// Replace:  58 51 31 33
/*
    External(HKNO, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q13, 0, NotSerialized) //path:_SB.PCI0.LPCB.EC0._Q13
        {
            Name (_T_0, Zero)
            While (One)
            {
                Store (HKNO, _T_0)
                If (LEqual (_T_0, 0x07))
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
                }
                ElseIf (LEqual (_T_0, 0x08))
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
                }
                Else{}
                Break
            }
        }
    }
*/
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
