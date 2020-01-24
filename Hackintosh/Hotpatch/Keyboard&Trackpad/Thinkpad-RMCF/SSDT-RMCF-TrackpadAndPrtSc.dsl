
DefinitionBlock("", "SSDT", 2, "hack", "RM-Merge", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    Scope (_SB.PCI0.LPCB.PS2K)
    {
        Name (RMCF,Package() 
        {
            "Mouse", Package()//Enable Trackpad
            {
                "ActLikeTrackpad", ">y",
            },
            
            "Keyboard", Package()//Disable PrtSc
            {
                "Custom PS2 Map", Package()
                {
                    Package(){},
                    "e037=0",
                },
            },
        })
    }
}
//EOF