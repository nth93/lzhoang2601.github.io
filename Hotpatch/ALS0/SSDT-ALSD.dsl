// In config ACPI, ALSD._STA renamed ALSD.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:414C5344
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_ALS0", 0)
{
#endif
    External(ALSD, DeviceObj)
    External(ALSD.XSTA, MethodObj)
    Scope (ALSD)
    {
        Name (_CID, "smc-als")
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0B)
            }
            Else
            {
                Return (\ALSD.XSTA())
            }
        }
    } 
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
