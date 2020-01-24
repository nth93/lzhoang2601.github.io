//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "EXT1", 0)
{
#endif
    External(_SB.PCI0.LPCB.EXPE, FieldUnitObj)
    Method (EXT1, 1, NotSerialized)
    {   
        If (CondRefOf(\_SB.PCI0.LPCB.EXPE))
        {
            \_SB.PCI0.LPCB.EXPE=0
        }

        If (5 == Arg0)
        {
            OperationRegion(PMRS, SystemIO, 0x000, 1)
            Field(PMRS, ByteAcc, NoLock, Preserve)
            {
                    , 4,
                SLPE, 1,
            }
            
            If (CondRefOf(\_SB.PCI0.LPCB.EXPE))
            {
                \_SB.PCI0.LPCB.EXPE=1
            }
            SLPE =0
            Sleep(16)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
