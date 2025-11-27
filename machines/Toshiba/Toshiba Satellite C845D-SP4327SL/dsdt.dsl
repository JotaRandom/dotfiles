/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20170303 (64-bit version)
 * Copyright (c) 2000 - 2017 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of dsdt.dat, Thu Aug 31 01:06:29 2017
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x00011A61 (72289)
 *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 *     Checksum         0xE5
 *     OEM ID           "TOSQCI"
 *     OEM Table ID     "TOSQCI00"
 *     OEM Revision     0xF0000000 (4026531840)
 *     Compiler ID      "ACPI"
 *     Compiler Version 0x00040000 (262144)
 */
DefinitionBlock ("", "DSDT", 1, "TOSQCI", "TOSQCI00", 0xF0000000)
{
    External (_PR_.C000._PPC, IntObj)
    External (_PR_.C001._PPC, UnknownObj)
    External (_PR_.C002._PPC, UnknownObj)
    External (_PR_.C003._PPC, UnknownObj)
    External (ALIB, IntObj)

    OperationRegion (DBG0, SystemIO, 0x80, One)
    Field (DBG0, ByteAcc, NoLock, Preserve)
    {
        IO80,   8
    }

    OperationRegion (DBG1, SystemIO, 0x80, 0x02)
    Field (DBG1, WordAcc, NoLock, Preserve)
    {
        P80H,   16
    }

    OperationRegion (ACMS, SystemIO, 0x72, 0x02)
    Field (ACMS, ByteAcc, NoLock, Preserve)
    {
        INDX,   8, 
        DATA,   8
    }

    OperationRegion (PSMI, SystemIO, 0xB0, 0x02)
    Field (PSMI, ByteAcc, NoLock, Preserve)
    {
        APMC,   8, 
        APMD,   8
    }

    OperationRegion (PMRG, SystemIO, 0x0CD6, 0x02)
    Field (PMRG, ByteAcc, NoLock, Preserve)
    {
        PMRI,   8, 
        PMRD,   8
    }

    IndexField (PMRI, PMRD, ByteAcc, NoLock, Preserve)
    {
        Offset (0x24), 
        MMSO,   32, 
        Offset (0x50), 
        HPAD,   32, 
        Offset (0x60), 
        P1EB,   16, 
        Offset (0xC8), 
            ,   2, 
        SPRE,   1, 
        TPDE,   1, 
        Offset (0xF0), 
            ,   3, 
        RSTU,   1
    }

    OperationRegion (GSMM, SystemMemory, MMSO, 0x1000)
    Field (GSMM, AnyAcc, NoLock, Preserve)
    {
        Offset (0x132), 
            ,   7, 
        GP51,   1, 
        Offset (0x136), 
            ,   7, 
        GP55,   1, 
        Offset (0x13A), 
            ,   7, 
        GP59,   1, 
        Offset (0x13F), 
            ,   7, 
        GP64,   1, 
        Offset (0x160), 
            ,   7, 
        GE01,   1, 
        Offset (0x16A), 
            ,   7, 
        GE11,   1, 
            ,   7, 
        GE12,   1, 
        Offset (0x16E), 
            ,   7, 
        BATS,   1, 
        Offset (0x1FF), 
            ,   1, 
        G01S,   1, 
        Offset (0x203), 
            ,   1, 
        G01E,   1, 
        Offset (0x207), 
            ,   1, 
        TR01,   1, 
        Offset (0x20B), 
            ,   1, 
        TL01,   1, 
        Offset (0x20D), 
            ,   7, 
        ACIR,   1, 
        Offset (0x287), 
            ,   1, 
        CLPS,   1, 
        Offset (0x298), 
            ,   7, 
        G15A,   1, 
        Offset (0x2AF), 
            ,   2, 
        SLPS,   2, 
        Offset (0x376), 
        EPNM,   1, 
        DPPF,   1, 
        Offset (0x3BA), 
            ,   6, 
        PWDE,   1, 
        Offset (0x3BD), 
            ,   5, 
        ALLS,   1, 
        Offset (0x3DE), 
        BLNK,   2, 
        Offset (0x3EF), 
        PHYD,   1, 
        Offset (0xE80), 
            ,   2, 
        ECES,   1
    }

    OperationRegion (P1E0, SystemIO, P1EB, 0x04)
    Field (P1E0, ByteAcc, NoLock, Preserve)
    {
            ,   14, 
        PEWS,   1, 
        WSTA,   1, 
            ,   14, 
        PEWD,   1
    }

    OperationRegion (IOCC, SystemIO, 0x0400, 0x80)
    Field (IOCC, ByteAcc, NoLock, Preserve)
    {
        Offset (0x01), 
            ,   2, 
        RTCS,   1
    }

    Name (PRWP, Package (0x02)
    {
        Zero, 
        Zero
    })
    Method (GPRW, 2, NotSerialized)
    {
        PRWP [Zero] = Arg0
        PRWP [One] = Arg1
        If ((DAS3 == Zero))
        {
            If ((Arg1 <= 0x03))
            {
                PRWP [One] = Zero
            }
        }

        Return (PRWP) /* \PRWP */
    }

    Method (SPTS, 1, NotSerialized)
    {
        If ((Arg0 == 0x03))
        {
            RSTU = Zero
        }

        CLPS = One
        SLPS = One
        PEWS = PEWS /* \PEWS */
    }

    Method (SWAK, 1, NotSerialized)
    {
        If ((Arg0 == 0x03))
        {
            RSTU = One
        }

        PEWS = PEWS /* \PEWS */
        PWDE = One
        PEWD = Zero
    }

    Method (CHKH, 0, NotSerialized)
    {
    }

    OperationRegion (ABIO, SystemIO, 0x0CD8, 0x08)
    Field (ABIO, DWordAcc, NoLock, Preserve)
    {
        INAB,   32, 
        DAAB,   32
    }

    Method (RDAB, 1, NotSerialized)
    {
        INAB = Arg0
        Return (DAAB) /* \DAAB */
    }

    Method (WTAB, 2, NotSerialized)
    {
        INAB = Arg0
        DAAB = Arg1
    }

    Method (RWAB, 3, NotSerialized)
    {
        Local0 = (RDAB (Arg0) & Arg1)
        Local1 = (Local0 | Arg2)
        WTAB (Arg0, Local1)
    }

    Method (CABR, 3, NotSerialized)
    {
        Local0 = (Arg0 << 0x05)
        Local1 = (Local0 + Arg1)
        Local2 = (Local1 << 0x18)
        Local3 = (Local2 + Arg2)
        Return (Local3)
    }

    OperationRegion (PEBA, SystemMemory, 0xF8000000, 0x02000000)
    Field (PEBA, AnyAcc, NoLock, Preserve)
    {
        Offset (0xA807A), 
        PMS0,   1, 
        Offset (0xA8088), 
        TLS0,   4, 
        Offset (0xA907A), 
        PMS1,   1, 
        Offset (0xA9088), 
        TLS1,   4, 
        Offset (0xAA07A), 
        PMS2,   1, 
        Offset (0xAA088), 
        TLS2,   4, 
        Offset (0xAB07A), 
        PMS3,   1, 
        Offset (0xAB088), 
        TLS3,   4
    }

    OperationRegion (GNVS, SystemMemory, 0xDFBBEE98, 0x00000013)
    Field (GNVS, AnyAcc, NoLock, Preserve)
    {
        DAS3,   8, 
        TNBH,   8, 
        TCP0,   8, 
        TCP1,   8, 
        ATNB,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PWMN,   8, 
        LPTY,   8, 
        M92D,   8, 
        WKPM,   8, 
        ALST,   8, 
        AFUC,   8, 
        EXUS,   8, 
        AIRC,   8, 
        WLSH,   8, 
        TSSS,   8, 
        ODZC,   8
    }

    OperationRegion (OGNS, SystemMemory, 0xDFBBCC18, 0x0000027C)
    Field (OGNS, AnyAcc, Lock, Preserve)
    {
        OG00,   8, 
        OG01,   8, 
        OG02,   8, 
        OG03,   8, 
        OG04,   8, 
        OG05,   8, 
        OG06,   8, 
        OG07,   8, 
        OG08,   8, 
        OG09,   8, 
        OG10,   8, 
        OG11,   8, 
        OG12,   8, 
        OG13,   8, 
        OG14,   8, 
        OG15,   8, 
        OG16,   8, 
        OG17,   8, 
        OG18,   8, 
        OG19,   8, 
        OG20,   8, 
        OG21,   8, 
        BLK0,   32, 
        BLK1,   32, 
        BLK2,   32, 
        BLK3,   32, 
        BLK4,   32, 
        BLK5,   32, 
        BTEN,   1, 
        WLAN,   1, 
        WN3G,   1, 
        ENSR,   2, 
        CCDE,   1, 
        DACB,   1, 
        TPDV,   1, 
        WOLI,   1, 
        CIRE,   1, 
        FGPE,   1, 
        HDME,   1, 
        CPUD,   1, 
        PCIL,   1, 
        FBBS,   1, 
        SWKS,   1, 
        OWNS,   4096, 
        DVDI,   160, 
        OWN0,   8, 
        OWN1,   8, 
        HEUE,   8, 
        BEUE,   8, 
        VEVT,   16, 
        FEVT,   16, 
        NEVT,   16, 
        OPR0,   8, 
        OPR1,   8, 
        OPR2,   8, 
        KBIN,   8, 
        SLPB,   32, 
        PE00,   1, 
        PE01,   1, 
        PE02,   1, 
        PE03,   5, 
        FKSF,   8, 
        FKCS,   8, 
        FKSD,   8, 
        ALMF,   1, 
        YALM,   6, 
        MALM,   4, 
        DALM,   5, 
        ALMS,   8, 
        ALMM,   8, 
        ALMH,   8, 
        ALMD,   8, 
        ALMO,   8, 
        ALMY,   8, 
        OAST,   16, 
        OADK,   32, 
        BP00,   8, 
        BP01,   8, 
        BP02,   8, 
        BP03,   8, 
        BP04,   8, 
        BP05,   8, 
        BP06,   8, 
        BP07,   8, 
        BPFG,   8, 
        BOMO,   8, 
        SEBO,   8, 
        UPIS,   8, 
        PL00,   8, 
        PL01,   8, 
        PL02,   8, 
        PL03,   8, 
        PL04,   8, 
        PL05,   8, 
        PL06,   8, 
        PL07,   8
    }

    OperationRegion (NVST, SystemMemory, 0xDFBBDE8E, 0x0000012B)
    Field (NVST, AnyAcc, Lock, Preserve)
    {
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        BRTL,   8, 
        TLST,   8, 
        IGDS,   8, 
        LCDA,   16, 
        CSTE,   16, 
        NSTE,   16, 
        CADL,   16, 
        PADL,   16, 
        LIDS,   8, 
        PWRS,   8, 
        BVAL,   32, 
        ADDL,   16, 
        BCMD,   8, 
        SBFN,   8, 
        DID,    32, 
        INFO,   2048, 
        TOML,   8, 
        TOMH,   8, 
        CEBP,   8, 
        C0LS,   8, 
        C1LS,   8, 
        C0HS,   8, 
        C1HS,   8, 
        ROMS,   32, 
        MUXF,   8, 
        PDDN,   8
    }

    Method (SCMP, 2, NotSerialized)
    {
        Name (STG1, Buffer (0x50){})
        Name (STG2, Buffer (0x50){})
        STG1 = Arg0
        STG2 = Arg1
        If ((SizeOf (Arg0) != SizeOf (Arg1)))
        {
            Return (Zero)
        }

        Local0 = Zero
        While ((Local0 < SizeOf (Arg0)))
        {
            If ((DerefOf (STG1 [Local0]) != DerefOf (STG2 [Local0]
                )))
            {
                Return (Zero)
            }

            Local0++
        }

        Return (One)
    }

    Name (WNOS, Zero)
    Name (MYOS, Zero)
    Name (HTTS, Zero)
    Name (OSTB, Ones)
    Name (TPOS, Zero)
    Name (LINX, Zero)
    Name (OSSP, Zero)
    Method (CKOS, 0, NotSerialized)
    {
        If ((WNOS == Zero))
        {
            If (SCMP (_OS, "Microsoft Windows"))
            {
                WNOS = One
            }

            If (SCMP (_OS, "Microsoft Windows NT"))
            {
                WNOS = 0x02
            }

            If (SCMP (_OS, "Microsoft WindowsME: Millennium Edition"))
            {
                WNOS = 0x03
            }

            If (SCMP (_OS, "Windows 2012"))
            {
                WNOS = 0x07
            }

            If (CondRefOf (\_OSI, Local0))
            {
                If (SCMP (_OS, "Windows 2006"))
                {
                    WNOS = 0x05
                }
                ElseIf (SCMP (_OS, "Windows 2009"))
                {
                    WNOS = 0x06
                }
                Else
                {
                    WNOS = 0x04
                }
            }
        }

        Return (WNOS) /* \WNOS */
    }

    Method (SEQL, 2, Serialized)
    {
        Local0 = SizeOf (Arg0)
        Local1 = SizeOf (Arg1)
        If ((Local0 != Local1))
        {
            Return (Zero)
        }

        Name (BUF0, Buffer (Local0){})
        BUF0 = Arg0
        Name (BUF1, Buffer (Local0){})
        BUF1 = Arg1
        Local2 = Zero
        While ((Local2 < Local0))
        {
            Local3 = DerefOf (BUF0 [Local2])
            Local4 = DerefOf (BUF1 [Local2])
            If ((Local3 != Local4))
            {
                Return (Zero)
            }

            Local2++
        }

        Return (One)
    }

    Method (OSTP, 0, NotSerialized)
    {
        If ((OSTB == Ones))
        {
            If (CondRefOf (\_OSI, Local0))
            {
                OSTB = Zero
                TPOS = Zero
                If (_OSI ("Windows 2001"))
                {
                    OSTB = 0x08
                    TPOS = 0x08
                }

                If (_OSI ("Windows 2001.1"))
                {
                    OSTB = 0x20
                    TPOS = 0x20
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    OSTB = 0x10
                    TPOS = 0x10
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    OSTB = 0x11
                    TPOS = 0x11
                }

                If (_OSI ("Windows 2001 SP3"))
                {
                    OSTB = 0x12
                    TPOS = 0x12
                }

                If (_OSI ("Windows 2006"))
                {
                    OSTB = 0x40
                    TPOS = 0x40
                }

                If (_OSI ("Windows 2006 SP1"))
                {
                    OSTB = 0x41
                    TPOS = 0x41
                    OSSP = One
                }

                If (_OSI ("Windows 2009"))
                {
                    OSSP = One
                    OSTB = 0x50
                    TPOS = 0x50
                }

                If (_OSI ("Windows 2012"))
                {
                    OSSP = One
                    OSTB = 0x60
                    TPOS = 0x60
                }

                If (_OSI ("Linux"))
                {
                    LINX = One
                    OSTB = 0x80
                    TPOS = 0x80
                }
            }
            ElseIf (CondRefOf (\_OS, Local0))
            {
                If (SEQL (_OS, "Microsoft Windows"))
                {
                    OSTB = One
                    TPOS = One
                }
                ElseIf (SEQL (_OS, "Microsoft WindowsME: Millennium Edition"))
                {
                    OSTB = 0x02
                    TPOS = 0x02
                }
                ElseIf (SEQL (_OS, "Microsoft Windows NT"))
                {
                    OSTB = 0x04
                    TPOS = 0x04
                }
                Else
                {
                    OSTB = Zero
                    TPOS = Zero
                }
            }
            Else
            {
                OSTB = Zero
                TPOS = Zero
            }
        }

        Return (OSTB) /* \OSTB */
    }

    Method (VTOB, 1, NotSerialized)
    {
        Local0 = One
        Local0 <<= Arg0
        Return (Local0)
    }

    Method (BTOV, 1, NotSerialized)
    {
        Local0 = (Arg0 >> One)
        Local1 = Zero
        While (Local0)
        {
            Local1++
            Local0 >>= One
        }

        Return (Local1)
    }

    Method (MKWD, 2, NotSerialized)
    {
        If ((Arg1 & 0x80))
        {
            Local0 = 0xFFFF0000
        }
        Else
        {
            Local0 = Zero
        }

        Local0 |= Arg0
        Local0 |= (Arg1 << 0x08)
        Return (Local0)
    }

    Method (POSW, 1, NotSerialized)
    {
        If ((Arg0 & 0x8000))
        {
            If ((Arg0 == 0xFFFF))
            {
                Return (Ones)
            }
            Else
            {
                Local0 = ~Arg0
                Local0++
                Local0 &= 0xFFFF
                Return (Local0)
            }
        }
        Else
        {
            Return (Arg0)
        }
    }

    Method (GBFE, 3, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TIDX)
        Arg2 = TIDX /* \GBFE.TIDX */
    }

    Method (PBFE, 3, NotSerialized)
    {
        CreateByteField (Arg0, Arg1, TIDX)
        TIDX = Arg2
    }

    Method (ITOS, 1, NotSerialized)
    {
        Local0 = Buffer (0x09)
            {
                /* 0000 */  0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  /* 0....... */
                /* 0008 */  0x00                                             /* . */
            }
        Local7 = Buffer (0x11)
            {
                "0123456789ABCDEF"
            }
        Local1 = 0x08
        Local2 = Zero
        Local3 = Zero
        While (Local1)
        {
            Local1--
            Local4 = ((Arg0 >> (Local1 << 0x02)) & 0x0F)
            If (Local4)
            {
                Local3 = Ones
            }

            If (Local3)
            {
                GBFE (Local7, Local4, RefOf (Local5))
                PBFE (Local0, Local2, Local5)
                Local2++
            }
        }

        Return (Local0)
    }

    Scope (_PR)
    {
        Processor (C000, 0x00, 0x00000410, 0x06){}
        Processor (C001, 0x01, 0x00000000, 0x00){}
        Processor (C002, 0x02, 0x00000000, 0x00){}
        Processor (C003, 0x03, 0x00000000, 0x00){}
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    If ((DAS3 == One))
    {
        Name (_S3, Package (0x04)  // _S3_: S3 System State
        {
            0x03, 
            0x03, 
            Zero, 
            Zero
        })
    }

    Name (_S4, Package (0x04)  // _S4_: S4 System State
    {
        0x04, 
        0x04, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x05, 
        0x05, 
        Zero, 
        Zero
    })
    Scope (_GPE)
    {
        Method (_L08, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.PB4, 0x02) // Device Wake
            Notify (\_SB.PCI0.PB5, 0x02) // Device Wake
            Notify (\_SB.PCI0.PB6, 0x02) // Device Wake
            Notify (\_SB.PCI0.PB7, 0x02) // Device Wake
            Notify (\_SB.PCI0.SPB0, 0x02) // Device Wake
            Notify (\_SB.PCI0.SPB1, 0x02) // Device Wake
            Notify (\_SB.PCI0.SPB2, 0x02) // Device Wake
            Notify (\_SB.PCI0.SPB3, 0x02) // Device Wake
        }

        Method (TRIE, 0, NotSerialized)
        {
            \_SB.PCI0.SMBS.G05T = ~\_SB.PCI0.SMBS.GE05
        }

        Method (_L05, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Sleep (0xC8)
            If (\_SB.PCI0.SMBS.G05T)
            {
                If (\_SB.PCI0.SMBS.GE05)
                {
                    \_SB.PCI0.SPB0.GHPS (\_SB.PCI0.SMBS.GE05, Zero)
                    P80H = 0x0F05
                }
            }
            ElseIf (!\_SB.PCI0.SMBS.GE05)
            {
                Local0 = \_SB.PCI0.SMBS.MS00
                Local1 = (Local0 | 0x0F)
                \_SB.PCI0.SMBS.MS00 = Local1
                Sleep (0x28)
                \_SB.PCI0.SPB0.GHPS (\_SB.PCI0.SMBS.GE05, Zero)
                P80H = 0x0205
            }

            TRIE ()
            Notify (\_SB.PCI0.SPB0, One) // Device Check
        }

        Method (_L18, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.OHC1, 0x02) // Device Wake
            Notify (\_SB.PCI0.OHC2, 0x02) // Device Wake
            Notify (\_SB.PCI0.OHC3, 0x02) // Device Wake
            Notify (\_SB.PCI0.OHC4, 0x02) // Device Wake
            Notify (\_SB.PCI0.EHC1, 0x02) // Device Wake
            Notify (\_SB.PCI0.EHC2, 0x02) // Device Wake
            Notify (\_SB.PCI0.EHC3, 0x02) // Device Wake
            Notify (\_SB.PCI0.XHC0, 0x02) // Device Wake
            Notify (\_SB.PCI0.XHC1, 0x02) // Device Wake
        }

        Method (_L0F, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            If (\_SB.PCI0.SMBS.G15T)
            {
                Sleep (0x14)
                If (\_SB.PCI0.SMBS.GE15)
                {
                    \_SB.PCI0.SMBS.G15T = Zero
                    \_SB.PCI0.SMBS.P2CO = Zero
                    P80H = 0x0F15
                }
            }
            Else
            {
                Sleep (0x14)
                If (!\_SB.PCI0.SMBS.GE15)
                {
                    \_SB.PCI0.SMBS.G15T = One
                    \_SB.PCI0.SMBS.P2CO = Zero
                    P80H = 0x1F15
                }
            }

            Notify (\_SB.PCI0.SATA.PRT1, Zero) // Bus Check
        }

        Method (_L10, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            If ((\_SB.PCI0.AFD.ODZP == 0x80000001))
            {
                If (\_SB.PCI0.SMBS.G16T)
                {
                    Sleep (0x14)
                    If (\_SB.PCI0.SMBS.GE16)
                    {
                        \_SB.PCI0.SMBS.G16T = Zero
                        If (((\_SB.PCI0.SATA.VIDI == 0x78001022) || (\_SB.PCI0.SATA.VIDI == 0x78011022)))
                        {
                            Notify (\_SB.PCI0.AFD, 0x80) // Status Change
                        }

                        If ((\_SB.PCI0.SATA.VIDI == 0x78041022))
                        {
                            Notify (\_SB.PCI0.SATA.ODDZ, 0x80) // Status Change
                        }

                        P80H = 0xDF15
                    }
                }
                Else
                {
                    Sleep (0x14)
                    If (!\_SB.PCI0.SMBS.GE16)
                    {
                        \_SB.PCI0.SMBS.G16T = One
                        If (((\_SB.PCI0.SATA.VIDI == 0x78001022) || (\_SB.PCI0.SATA.VIDI == 0x78011022)))
                        {
                            Notify (\_SB.PCI0.AFD, 0x80) // Status Change
                        }

                        If ((\_SB.PCI0.SATA.VIDI == 0x78041022))
                        {
                            Notify (\_SB.PCI0.SATA.ODDZ, 0x80) // Status Change
                        }

                        P80H = 0xDF14
                    }
                }
            }
        }
    }

    Name (PICM, Zero)
    Name (GPIC, Zero)
    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        PICM = Arg0
        GPIC = Arg0
        If (PICM)
        {
            \_SB.DSPI ()
        }
    }

    Name (PTSF, Zero)
    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        PTSF = One
        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
        \_SB.PCI0.LPC0.EC0.IESQ = One
        Release (\_SB.PCI0.LPC0.EC0.MUT1)
        SPTS (Arg0)
        If ((Arg0 == One))
        {
            IO80 = 0x51
            \_SB.S80H (0x51)
        }

        If ((Arg0 == 0x03))
        {
            If ((UPIS == One))
            {
                If (\_SB.PCI0.LPC0.EC0.USCE)
                {
                    \_SB.PCI0.LPC0.EC0.USCV = Zero
                }
                Else
                {
                    \_SB.PCI0.LPC0.EC0.USCV = One
                }

                \_SB.PCI0.LPC0.EC0.USNV = One
            }
            Else
            {
            }

            If (\_SB.SSTS)
            {
                If (\_SB.PSS5)
                {
                    \_SB.WLID = One
                }
                Else
                {
                    \_SB.WLID = Zero
                }
            }
            Else
            {
                \_SB.WLID = One
            }

            IO80 = 0x53
            \_SB.S80H (0x53)
            \_SB.PCI0.SMBS.SLPS = One
        }

        If ((Arg0 == 0x04))
        {
            IO80 = 0x54
            \_SB.S80H (0x54)
            \_SB.PCI0.SMBS.SLPS = One
            RSTU = One
            \_SB.TVAP.OAFG = Zero
            \_SB.INS4 = One
            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
            \_SB.PCI0.LPC0.EC0.FLS4 = One
            Release (\_SB.PCI0.LPC0.EC0.MUT1)
            Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
            If (\_SB.SSTS)
            {
                \_SB.PCI0.LPC0.EC0.WLID = Zero
            }
            Else
            {
                \_SB.PCI0.LPC0.EC0.WLID = One
            }

            Release (\_SB.PCI0.LPC0.EC0.MUT1)
        }

        If ((Arg0 == 0x05))
        {
            IO80 = 0x55
            \_SB.S80H (0x55)
            BCMD = 0x90
            \_SB.BSMI (Zero)
            \_SB.GSMI (0x03)
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        PTSF = Zero
        SWAK (Arg0)
        If ((Arg0 == One))
        {
            IO80 = 0xE1
            \_SB.S80H (0xE1)
            \_SB.PCI0.P2P.PR4B = 0xF1
        }

        If ((Arg0 == 0x03))
        {
            \_SB.INS3 = 0x55
            \_SB.PCI0.LPC0.EC0.CPLE = One
            IO80 = 0xE3
            \_SB.S80H (0xE3)
            CHKH ()
            If (\_SB.ECOK)
            {
                If ((TPOS >= 0x40))
                {
                    If ((TPOS == 0x80))
                    {
                        \_SB.OSTP = Zero
                    }
                    Else
                    {
                        \_SB.OSTP = One
                    }

                    If ((MYOS == 0x07DC))
                    {
                        \_SB.OSW8 = One
                    }
                    Else
                    {
                        \_SB.OSW8 = Zero
                    }
                }
                Else
                {
                    \_SB.OSTP = Zero
                }

                Notify (\_SB.BAT1, 0x81) // Information Change
            }

            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        If ((Arg0 == 0x04))
        {
            \_SB.INS3 = 0x55
            \_SB.INS4 = Zero
            IO80 = 0xE4
            \_SB.S80H (0xE4)
            \_SB.PCI0._INI ()
            If (\_SB.ECOK)
            {
                If ((TPOS >= 0x40))
                {
                    If ((TPOS == 0x80))
                    {
                        \_SB.OSTP = Zero
                    }
                    Else
                    {
                        \_SB.OSTP = One
                    }
                }
                Else
                {
                    \_SB.OSTP = Zero
                }

                Notify (\_SB.BAT1, 0x81) // Information Change
            }

            Notify (\_SB.PWRB, 0x02) // Device Wake
        }

        Return (Zero)
    }

    Scope (_SB)
    {
        Name (ECOK, Zero)
        Name (INS3, Zero)
        Name (INS4, One)
        Name (WLWF, Zero)
        Name (L3WF, Zero)
        Name (DCNT, Zero)
        Name (LDSS, Zero)
        Name (SSTS, Zero)
        Device (BT)
        {
            Name (_HID, EisaId ("TOS6205"))  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (BTEN)
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (DUSB, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    ^^PCI0.LPC0.EC0.BLTH = Zero
                    Release (^^PCI0.LPC0.EC0.MUT1)
                }
            }

            Method (AUSB, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    ^^PCI0.LPC0.EC0.BLTH = One
                    Release (^^PCI0.LPC0.EC0.MUT1)
                }
            }

            Method (BTPO, 0, NotSerialized)
            {
                Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                ^^PCI0.LPC0.EC0.BLTH = BTEN /* \BTEN */
                Release (^^PCI0.LPC0.EC0.MUT1)
                FSMI (0x25, Zero)
            }

            Method (BTPF, 0, NotSerialized)
            {
                Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                ^^PCI0.LPC0.EC0.BLTH = BTEN /* \BTEN */
                Release (^^PCI0.LPC0.EC0.MUT1)
                FSMI (0x26, Zero)
            }

            Method (BTST, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local0 = ^^PCI0.LPC0.EC0.KSWH /* \_SB_.PCI0.LPC0.EC0_.KSWH */
                    Local0 ^= One
                    Local7 = ^^PCI0.LPC0.EC0.BTHE /* \_SB_.PCI0.LPC0.EC0_.BTHE */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    If (Local0)
                    {
                        Local6 = (Local7 << 0x06)
                        Local7 <<= 0x07
                        Local1 = (Local7 | Local6)
                        Local2 = (Local0 | Local1)
                        Return (Local2)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }
            }
        }

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0B)
            }
        }

        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                If ((GPIC == Zero)){}
                Else
                {
                    DSPI ()
                }

                \OSTP ()
                MYOS = 0x07D0
                If (CondRefOf (\_OSI, Local0))
                {
                    If (_OSI ("Linux"))
                    {
                        MYOS = 0x03E8
                    }

                    If (_OSI ("Windows 2001"))
                    {
                        MYOS = 0x07D1
                    }

                    If (_OSI ("Windows 2001 SP1"))
                    {
                        MYOS = 0x07D1
                    }

                    If (_OSI ("Windows 2001 SP2"))
                    {
                        MYOS = 0x07D2
                    }

                    If (_OSI ("Windows 2006"))
                    {
                        MYOS = 0x07D6
                    }

                    If (_OSI ("Windows 2009"))
                    {
                        MYOS = 0x07D9
                    }

                    If (_OSI ("Windows 2012"))
                    {
                        MYOS = 0x07DC
                    }
                }
            }

            OperationRegion (NBMS, PCI_Config, 0x60, 0x08)
            Field (NBMS, DWordAcc, NoLock, Preserve)
            {
                MIDX,   32, 
                MIDR,   32
            }

            Mutex (NBMM, 0x00)
            Method (NBMR, 1, NotSerialized)
            {
                Acquire (NBMM, 0xFFFF)
                Local0 = (Arg0 & 0x7F)
                MIDX = Local0
                Local0 = MIDR /* \_SB_.PCI0.MIDR */
                MIDX = 0x7F
                Release (NBMM)
                Return (Local0)
            }

            Method (NBMW, 2, NotSerialized)
            {
                Acquire (NBMM, 0xFFFF)
                Local0 = (Arg0 & 0x7F)
                Local0 |= 0x80
                MIDX = Local0
                MIDR = Arg1
                MIDX = Local0 &= 0x7F
                Release (NBMM)
            }

            OperationRegion (NBXP, PCI_Config, 0xE0, 0x08)
            Field (NBXP, DWordAcc, NoLock, Preserve)
            {
                NBXI,   32, 
                NBXD,   32
            }

            Mutex (NBXM, 0x00)
            Method (NBXR, 1, NotSerialized)
            {
                Acquire (NBXM, 0xFFFF)
                NBXI = Arg0
                Local0 = NBXD /* \_SB_.PCI0.NBXD */
                NBXI = Zero
                Release (NBXM)
                Return (Local0)
            }

            Method (NBXW, 2, NotSerialized)
            {
                Acquire (NBXM, 0xFFFF)
                NBXI = Arg0
                NBXD = Arg1
                NBXI = Zero
                Release (NBXM)
            }

            Method (GFXM, 0, NotSerialized)
            {
                Local0 = NBMR (0x08)
                Local0 >>= 0x08
                Local0 &= 0x0F
                Return (Local0)
            }

            Method (GPPM, 0, NotSerialized)
            {
                Local0 = NBMR (0x67)
                Local0 &= 0x0F
                Return (Local0)
            }

            Method (GPPX, 0, NotSerialized)
            {
                Local0 = NBMR (0x2D)
                Local0 >>= 0x07
                Local0 &= 0x0F
                Return (Local0)
            }

            Method (XPTR, 2, NotSerialized)
            {
                If ((Arg0 < 0x02))
                {
                    Return (Zero)
                }

                If (((Arg0 > 0x0A) || (Arg0 == 0x08)))
                {
                    Return (Zero)
                }
                Else
                {
                    Local0 = GPPM ()
                    Local1 = GPPX ()
                    If ((Arg0 == 0x0A))
                    {
                        If (((Local0 == 0x03) && (Local1 == 0x03)))
                        {
                            Local0 = 0x20
                            Local2 = NBMR (0x2D)
                            If (Arg1)
                            {
                                Local2 &= ~Local0
                            }
                            Else
                            {
                                Local2 |= Local0
                            }

                            NBMW (0x2D, Local2)
                            Return (Ones)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    If ((Arg0 == 0x09))
                    {
                        If (((Local0 >= 0x02) && (Local1 >= 0x02)))
                        {
                            Local0 = 0x10
                            Local2 = NBMR (0x2D)
                            If (Arg1)
                            {
                                Local2 &= ~Local0
                            }
                            Else
                            {
                                Local2 |= Local0
                            }

                            NBMW (0x2D, Local2)
                            Return (Ones)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Local0 = One
                    If ((Arg0 < 0x04))
                    {
                        Local1 = (Arg0 + 0x02)
                    }
                    Else
                    {
                        Local1 = (Arg0 + 0x11)
                    }

                    Local0 <<= Local1
                    Local2 = NBMR (0x08)
                    If (Arg1)
                    {
                        Local2 &= ~Local0
                    }
                    Else
                    {
                        Local2 |= Local0
                    }

                    NBMW (0x08, Local2)
                    Return (Ones)
                }
            }

            Method (XPLP, 2, NotSerialized)
            {
            }

            Method (XPLL, 2, NotSerialized)
            {
            }

            Name (_UID, One)  // _UID: Unique ID
            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Name (AMHP, Zero)
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
                {
                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    If (((SUPP & 0x16) != 0x16))
                    {
                        CTRL &= 0x1E
                    }

                    CTRL &= 0x1D
                    If (~(CDW1 & One))
                    {
                        If ((CTRL & One)){}
                        If ((CTRL & 0x04))
                        {
                            ^SMBS.EPNM = One
                            ^SMBS.DPPF = Zero
                        }
                        Else
                        {
                            ^SMBS.EPNM = Zero
                            ^SMBS.DPPF = One
                        }

                        If ((CTRL & 0x10)){}
                    }

                    If ((Arg1 != One))
                    {
                        CDW1 |= 0x08
                    }

                    If ((CDW3 != CTRL))
                    {
                        CDW1 |= 0x10
                    }

                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
                    Return (Arg3)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Arg3)
                }
            }

            Method (TOM, 0, NotSerialized)
            {
                Local0 = (TOML * 0x00010000)
                Local1 = (TOMH * 0x01000000)
                Local0 += Local1
                Return (Local0)
            }

            Name (CRES, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, SubDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    0x00,, )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    0x00,, , TypeStatic, DenseTranslation)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadOnly,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x80000000,         // Range Minimum
                    0xF7FFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x78000000,         // Length
                    0x00,, _Y00, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFC000000,         // Range Minimum
                    0xFED3FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x02D40000,         // Length
                    0x00,, _Y01, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, SubDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFED45000,         // Range Minimum
                    0xFFFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x012BB000,         // Length
                    0x00,, , AddressRangeMemory, TypeStatic)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
            })
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (CRES, \_SB.PCI0._Y00._MIN, BTMN)  // _MIN: Minimum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y00._MAX, BTMX)  // _MAX: Maximum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y00._LEN, BTLN)  // _LEN: Length
                CreateDWordField (CRES, \_SB.PCI0._Y01._MIN, BTN1)  // _MIN: Minimum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y01._MAX, BTX1)  // _MAX: Maximum Base Address
                CreateDWordField (CRES, \_SB.PCI0._Y01._LEN, BTL1)  // _LEN: Length
                BTMN = TOM ()
                BTLN = (0xF8000000 - BTMN) /* \_SB_.PCI0._CRS.BTMN */
                Return (CRES) /* \_SB_.PCI0.CRES */
            }

            Device (MEMR)
            {
                Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                Name (MEM1, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y02)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y03)
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y02._BAS, MB01)  // _BAS: Base Address
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y02._LEN, ML01)  // _LEN: Length
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y03._BAS, MB02)  // _BAS: Base Address
                    CreateDWordField (MEM1, \_SB.PCI0.MEMR._Y03._LEN, ML02)  // _LEN: Length
                    If (GPIC)
                    {
                        MB01 = 0xFEC00000
                        MB02 = 0xFEE00000
                        ML01 = 0x1000
                        ML02 = 0x1000
                    }

                    Return (MEM1) /* \_SB_.PCI0.MEMR.MEM1 */
                }
            }

            Method (XCMP, 2, NotSerialized)
            {
                If ((0x10 != SizeOf (Arg0)))
                {
                    Return (Zero)
                }

                If ((0x10 != SizeOf (Arg1)))
                {
                    Return (Zero)
                }

                Local0 = Zero
                While ((Local0 < 0x10))
                {
                    If ((DerefOf (Arg0 [Local0]) != DerefOf (Arg1 [Local0]
                        )))
                    {
                        Return (Zero)
                    }

                    Local0++
                }

                Return (One)
            }

            Method (AFN0, 0, Serialized)
            {
                If ((PDDN == One))
                {
                    ^VGA.AFN0 ()
                }

                If ((PDDN == 0x04))
                {
                    ^PB4.VGA.AFN0 ()
                }
            }

            Method (AFN1, 1, Serialized)
            {
            }

            Method (AFN2, 2, Serialized)
            {
            }

            Method (AFN3, 2, Serialized)
            {
                If ((PDDN == One))
                {
                    ^VGA.AFN3 (Arg0, Arg1)
                }

                If ((PDDN == 0x04))
                {
                    ^PB4.VGA.AFN3 (Arg0, Arg1)
                }
            }

            Method (AFN4, 1, Serialized)
            {
                If ((PDDN == One))
                {
                    ^VGA.AFN4 (Arg0)
                }

                If ((PDDN == 0x04))
                {
                    ^PB4.VGA.AFN4 (Arg0)
                }
            }

            Method (AFN5, 0, Serialized)
            {
                If ((PDDN == One))
                {
                    ^VGA.AFN5 ()
                }

                If ((PDDN == 0x04))
                {
                    ^PB4.VGA.AFN5 ()
                }
            }

            Method (AFN6, 0, Serialized)
            {
                If ((PDDN == One))
                {
                    ^VGA.AFN6 ()
                }

                If ((PDDN == 0x04))
                {
                    ^PB4.VGA.AFN6 ()
                }
            }

            Method (AFN7, 1, Serialized)
            {
                If ((PDDN == One))
                {
                    ^VGA.AFN7 (Arg0)
                }

                If ((PDDN == 0x04))
                {
                    ^PB4.VGA.AFN7 (Arg0)
                }
            }

            Name (PR00, Package (0x17)
            {
                Package (0x04)
                {
                    0x0010FFFF, 
                    Zero, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    Zero, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    Zero, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    Zero, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x02, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x03, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    Zero, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    One, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    LNKD, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    Zero, 
                    LNKA, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    Zero, 
                    LNKB, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    Zero, 
                    LNKC, 
                    Zero
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    Zero, 
                    LNKD, 
                    Zero
                }
            })
            Name (AR00, Package (0x17)
            {
                Package (0x04)
                {
                    0x0010FFFF, 
                    Zero, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0010FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0011FFFF, 
                    Zero, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    Zero, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0012FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    Zero, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0013FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0014FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x02, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0015FFFF, 
                    0x03, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    Zero, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0016FFFF, 
                    One, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    Zero, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    One, 
                    Zero, 
                    0x13
                }, 

                Package (0x04)
                {
                    0x0004FFFF, 
                    Zero, 
                    Zero, 
                    0x10
                }, 

                Package (0x04)
                {
                    0x0005FFFF, 
                    Zero, 
                    Zero, 
                    0x11
                }, 

                Package (0x04)
                {
                    0x0006FFFF, 
                    Zero, 
                    Zero, 
                    0x12
                }, 

                Package (0x04)
                {
                    0x0007FFFF, 
                    Zero, 
                    Zero, 
                    0x13
                }
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR00) /* \_SB_.PCI0.AR00 */
                }

                Return (PR00) /* \_SB_.PCI0.PR00 */
            }

            Name (TBHD, Package (0x33)
            {
                Package (0x02)
                {
                    Zero, 
                    One
                }, 

                Package (0x02)
                {
                    0x02, 
                    0x05
                }, 

                Package (0x02)
                {
                    0x04, 
                    0x0A
                }, 

                Package (0x02)
                {
                    0x06, 
                    0x0F
                }, 

                Package (0x02)
                {
                    0x08, 
                    0x14
                }, 

                Package (0x02)
                {
                    0x0A, 
                    0x19
                }, 

                Package (0x02)
                {
                    0x0C, 
                    0x1E
                }, 

                Package (0x02)
                {
                    0x0E, 
                    0x23
                }, 

                Package (0x02)
                {
                    0x10, 
                    0x28
                }, 

                Package (0x02)
                {
                    0x12, 
                    0x2D
                }, 

                Package (0x02)
                {
                    0x14, 
                    0x33
                }, 

                Package (0x02)
                {
                    0x16, 
                    0x38
                }, 

                Package (0x02)
                {
                    0x18, 
                    0x3D
                }, 

                Package (0x02)
                {
                    0x1A, 
                    0x42
                }, 

                Package (0x02)
                {
                    0x1C, 
                    0x47
                }, 

                Package (0x02)
                {
                    0x1E, 
                    0x4C
                }, 

                Package (0x02)
                {
                    0x20, 
                    0x51
                }, 

                Package (0x02)
                {
                    0x22, 
                    0x56
                }, 

                Package (0x02)
                {
                    0x24, 
                    0x5B
                }, 

                Package (0x02)
                {
                    0x26, 
                    0x60
                }, 

                Package (0x02)
                {
                    0x28, 
                    0x66
                }, 

                Package (0x02)
                {
                    0x2A, 
                    0x6B
                }, 

                Package (0x02)
                {
                    0x2C, 
                    0x70
                }, 

                Package (0x02)
                {
                    0x2E, 
                    0x75
                }, 

                Package (0x02)
                {
                    0x30, 
                    0x7A
                }, 

                Package (0x02)
                {
                    0x32, 
                    0x7F
                }, 

                Package (0x02)
                {
                    0x34, 
                    0x84
                }, 

                Package (0x02)
                {
                    0x36, 
                    0x89
                }, 

                Package (0x02)
                {
                    0x38, 
                    0x8E
                }, 

                Package (0x02)
                {
                    0x3A, 
                    0x93
                }, 

                Package (0x02)
                {
                    0x3C, 
                    0x99
                }, 

                Package (0x02)
                {
                    0x3E, 
                    0x9E
                }, 

                Package (0x02)
                {
                    0x40, 
                    0xA3
                }, 

                Package (0x02)
                {
                    0x42, 
                    0xA8
                }, 

                Package (0x02)
                {
                    0x44, 
                    0xAD
                }, 

                Package (0x02)
                {
                    0x46, 
                    0xB2
                }, 

                Package (0x02)
                {
                    0x48, 
                    0xB7
                }, 

                Package (0x02)
                {
                    0x4A, 
                    0xBC
                }, 

                Package (0x02)
                {
                    0x4C, 
                    0xC1
                }, 

                Package (0x02)
                {
                    0x4E, 
                    0xC6
                }, 

                Package (0x02)
                {
                    0x50, 
                    0xCC
                }, 

                Package (0x02)
                {
                    0x52, 
                    0xD1
                }, 

                Package (0x02)
                {
                    0x54, 
                    0xD6
                }, 

                Package (0x02)
                {
                    0x56, 
                    0xDB
                }, 

                Package (0x02)
                {
                    0x58, 
                    0xE0
                }, 

                Package (0x02)
                {
                    0x5A, 
                    0xE5
                }, 

                Package (0x02)
                {
                    0x5C, 
                    0xEA
                }, 

                Package (0x02)
                {
                    0x5E, 
                    0xEF
                }, 

                Package (0x02)
                {
                    0x60, 
                    0xF4
                }, 

                Package (0x02)
                {
                    0x62, 
                    0xF9
                }, 

                Package (0x02)
                {
                    0x64, 
                    0xFF
                }
            })
            Method (DTOH, 1, NotSerialized)
            {
                Local1 = Zero
                Local2 = 0x33
                Local0 = ((Local1 + Local2) >> One)
                Local3 = DerefOf (DerefOf (TBHD [Local0]) [Zero])
                While ((((Local0 != Local1) && (Local0 != Local2)) && 
                    (Arg0 != Local3)))
                {
                    If ((Arg0 > Local3))
                    {
                        Local1 = Local0
                    }
                    Else
                    {
                        Local2 = Local0
                    }

                    Local0 = ((Local1 + Local2) >> One)
                    Local3 = DerefOf (DerefOf (TBHD [Local0]) [Zero])
                }

                Return (DerefOf (DerefOf (TBHD [Local0]) [One]))
            }

            Method (HTOD, 1, NotSerialized)
            {
                Local1 = Zero
                Local2 = 0x33
                Local0 = ((Local1 + Local2) >> One)
                Local3 = DerefOf (DerefOf (TBHD [Local0]) [One])
                While ((((Local0 != Local1) && (Local0 != Local2)) && 
                    (Arg0 != Local3)))
                {
                    If ((Arg0 > Local3))
                    {
                        Local1 = Local0
                    }
                    Else
                    {
                        Local2 = Local0
                    }

                    Local0 = ((Local1 + Local2) >> One)
                    Local3 = DerefOf (DerefOf (TBHD [Local0]) [One])
                }

                Return (DerefOf (DerefOf (TBHD [Local0]) [Zero]))
            }

            Name (BCLB, Package (0x35)
            {
                0x5A, 
                0x3C, 
                Zero, 
                0x02, 
                0x04, 
                0x06, 
                0x08, 
                0x0A, 
                0x0C, 
                0x0E, 
                0x10, 
                0x12, 
                0x14, 
                0x16, 
                0x18, 
                0x1A, 
                0x1C, 
                0x1E, 
                0x20, 
                0x22, 
                0x24, 
                0x26, 
                0x28, 
                0x2A, 
                0x2C, 
                0x2E, 
                0x30, 
                0x32, 
                0x34, 
                0x36, 
                0x38, 
                0x3A, 
                0x3C, 
                0x3E, 
                0x40, 
                0x42, 
                0x44, 
                0x46, 
                0x48, 
                0x4A, 
                0x4C, 
                0x4E, 
                0x50, 
                0x52, 
                0x54, 
                0x56, 
                0x58, 
                0x5A, 
                0x5C, 
                0x5E, 
                0x60, 
                0x62, 
                0x64
            })
            Device (VGA)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Name (PXEN, 0x80000000)
                Name (PXID, 0x00020000)
                Name (PXMX, 0x80000001)
                Name (LCDT, 0x80000000)
                Name (DSCT, 0x80000000)
                Name (PXFX, 0x80000000)
                Name (PXDY, 0x80000000)
                Name (AF7E, 0x80000001)
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Name (DOSA, Zero)
                Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                {
                    DOSA = Arg0
                }

                Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
                {
                    Name (DODL, Package (0x05)
                    {
                        0x00010100, 
                        0x00010110, 
                        0x0200, 
                        0x00010210, 
                        0x00010220
                    })
                    Return (DODL) /* \_SB_.PCI0.VGA_._DOD.DODL */
                }

                Device (LCD)
                {
                    Name (_ADR, 0x0110)  // _ADR: Address
                    Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
                    {
                        If ((MYOS == 0x07DC))
                        {
                            Return (Package (0x67)
                            {
                                0x64, 
                                0x28, 
                                Zero, 
                                One, 
                                0x02, 
                                0x03, 
                                0x04, 
                                0x05, 
                                0x06, 
                                0x07, 
                                0x08, 
                                0x09, 
                                0x0A, 
                                0x0B, 
                                0x0C, 
                                0x0D, 
                                0x0E, 
                                0x0F, 
                                0x10, 
                                0x11, 
                                0x12, 
                                0x13, 
                                0x14, 
                                0x15, 
                                0x16, 
                                0x17, 
                                0x18, 
                                0x19, 
                                0x1A, 
                                0x1B, 
                                0x1C, 
                                0x1D, 
                                0x1E, 
                                0x1F, 
                                0x20, 
                                0x21, 
                                0x22, 
                                0x23, 
                                0x24, 
                                0x25, 
                                0x26, 
                                0x27, 
                                0x28, 
                                0x29, 
                                0x2A, 
                                0x2B, 
                                0x2C, 
                                0x2D, 
                                0x2E, 
                                0x2F, 
                                0x30, 
                                0x31, 
                                0x32, 
                                0x33, 
                                0x34, 
                                0x35, 
                                0x36, 
                                0x37, 
                                0x38, 
                                0x39, 
                                0x3A, 
                                0x3B, 
                                0x3C, 
                                0x3D, 
                                0x3E, 
                                0x3F, 
                                0x40, 
                                0x41, 
                                0x42, 
                                0x43, 
                                0x44, 
                                0x45, 
                                0x46, 
                                0x47, 
                                0x48, 
                                0x49, 
                                0x4A, 
                                0x4B, 
                                0x4C, 
                                0x4D, 
                                0x4E, 
                                0x4F, 
                                0x50, 
                                0x51, 
                                0x52, 
                                0x53, 
                                0x54, 
                                0x55, 
                                0x56, 
                                0x57, 
                                0x58, 
                                0x59, 
                                0x5A, 
                                0x5B, 
                                0x5C, 
                                0x5D, 
                                0x5E, 
                                0x5F, 
                                0x60, 
                                0x61, 
                                0x62, 
                                0x63, 
                                0x64
                            })
                        }
                        Else
                        {
                            Return (Package (0x0A)
                            {
                                0x64, 
                                0x28, 
                                0x0A, 
                                0x14, 
                                0x1E, 
                                0x28, 
                                0x37, 
                                0x46, 
                                0x55, 
                                0x64
                            })
                        }
                    }

                    Method (_BCM, 1, Serialized)  // _BCM: Brightness Control Method
                    {
                        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                        If ((MYOS == 0x07DC))
                        {
                            Local0 = ToInteger (Arg0)
                            If (((Local0 >= Zero) && (Local0 < 0x0D)))
                            {
                                Local1 = PL00 /* \PL00 */
                                Local2 = PL01 /* \PL01 */
                                Local3 = ((((Local2 - Local1) * (Local0 - Zero
                                    )) / 0x0D) + Local1)
                            }
                            ElseIf (((Local0 >= 0x0D) && (Local0 < 0x1B)))
                            {
                                Local1 = PL01 /* \PL01 */
                                Local2 = PL02 /* \PL02 */
                                Local3 = ((((Local2 - Local1) * (Local0 - 0x0D
                                    )) / 0x0E) + Local1)
                            }
                            ElseIf (((Local0 >= 0x1B) && (Local0 < 0x28)))
                            {
                                Local1 = PL02 /* \PL02 */
                                Local2 = PL03 /* \PL03 */
                                Local3 = ((((Local2 - Local1) * (Local0 - 0x1B
                                    )) / 0x0D) + Local1)
                            }
                            ElseIf (((Local0 >= 0x28) && (Local0 < 0x37)))
                            {
                                Local1 = PL03 /* \PL03 */
                                Local2 = PL04 /* \PL04 */
                                Local3 = ((((Local2 - Local1) * (Local0 - 0x28
                                    )) / 0x0F) + Local1)
                            }
                            ElseIf (((Local0 >= 0x37) && (Local0 < 0x46)))
                            {
                                Local1 = PL04 /* \PL04 */
                                Local2 = PL05 /* \PL05 */
                                Local3 = ((((Local2 - Local1) * (Local0 - 0x37
                                    )) / 0x0F) + Local1)
                            }
                            ElseIf (((Local0 >= 0x46) && (Local0 < 0x55)))
                            {
                                Local1 = PL05 /* \PL05 */
                                Local2 = PL06 /* \PL06 */
                                Local3 = ((((Local2 - Local1) * (Local0 - 0x46
                                    )) / 0x0F) + Local1)
                            }
                            Else
                            {
                                Local1 = PL06 /* \PL06 */
                                Local2 = PL07 /* \PL07 */
                                Local3 = ((((Local2 - Local1) * (Local0 - 0x55
                                    )) / 0x0F) + Local1)
                            }

                            ^^^AFN7 (Local3)
                        }
                        Else
                        {
                            While (One)
                            {
                                _T_0 = ToInteger (Arg0)
                                If ((_T_0 == 0x0A))
                                {
                                    Local1 = Zero
                                }
                                ElseIf ((_T_0 == 0x14))
                                {
                                    Local1 = One
                                }
                                ElseIf ((_T_0 == 0x1E))
                                {
                                    Local1 = 0x02
                                }
                                ElseIf ((_T_0 == 0x28))
                                {
                                    Local1 = 0x03
                                }
                                ElseIf ((_T_0 == 0x37))
                                {
                                    Local1 = 0x04
                                }
                                ElseIf ((_T_0 == 0x46))
                                {
                                    Local1 = 0x05
                                }
                                ElseIf ((_T_0 == 0x55))
                                {
                                    Local1 = 0x06
                                }
                                ElseIf ((_T_0 == 0x64))
                                {
                                    Local1 = 0x07
                                }

                                Break
                            }

                            Local0 = ToInteger (Local1)
                            If ((TPOS >= 0x40))
                            {
                                ^^^LPC0.EC0.BLVL = ToInteger (Local1)
                                ^^^LPC0.EC0.SVBN ()
                            }
                        }
                    }

                    Method (_BQC, 0, Serialized)  // _BQC: Brightness Query Current
                    {
                        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                        If (((TPOS >= 0x40) && (MYOS != 0x07DC)))
                        {
                            Local0 = ^^^LPC0.EC0.BLVL /* \_SB_.PCI0.LPC0.EC0_.BLVL */
                            While (One)
                            {
                                _T_0 = ToInteger (Local0)
                                If ((_T_0 == Zero))
                                {
                                    Local1 = 0x0A
                                }
                                ElseIf ((_T_0 == One))
                                {
                                    Local1 = 0x14
                                }
                                ElseIf ((_T_0 == 0x02))
                                {
                                    Local1 = 0x1E
                                }
                                ElseIf ((_T_0 == 0x03))
                                {
                                    Local1 = 0x28
                                }
                                ElseIf ((_T_0 == 0x04))
                                {
                                    Local1 = 0x37
                                }
                                ElseIf ((_T_0 == 0x05))
                                {
                                    Local1 = 0x46
                                }
                                ElseIf ((_T_0 == 0x06))
                                {
                                    Local1 = 0x55
                                }
                                ElseIf ((_T_0 == 0x07))
                                {
                                    Local1 = 0x64
                                }

                                Break
                            }
                        }

                        Return (Local1)
                    }
                }

                Name (ATIB, Buffer (0x0100){})
                Method (ATIF, 2, Serialized)
                {
                    If ((Arg0 == Zero))
                    {
                        Return (AF00 ())
                    }

                    If ((Arg0 == One))
                    {
                        Return (AF01 ())
                    }

                    If ((Arg0 == 0x02))
                    {
                        Return (AF02 ())
                    }

                    If ((Arg0 == 0x03))
                    {
                        Return (AF03 (DerefOf (Arg1 [0x02]), DerefOf (Arg1 [0x04])))
                    }

                    If ((Arg0 == 0x0F))
                    {
                        Return (AF15 ())
                    }
                    Else
                    {
                        CreateWordField (ATIB, Zero, SSZE)
                        CreateWordField (ATIB, 0x02, VERN)
                        CreateDWordField (ATIB, 0x04, NMSK)
                        CreateDWordField (ATIB, 0x08, SFUN)
                        SSZE = Zero
                        VERN = Zero
                        NMSK = Zero
                        SFUN = Zero
                        Return (ATIB) /* \_SB_.PCI0.VGA_.ATIB */
                    }
                }

                Method (AF00, 0, NotSerialized)
                {
                    CreateWordField (ATIB, Zero, SSZE)
                    CreateWordField (ATIB, 0x02, VERN)
                    CreateDWordField (ATIB, 0x04, NMSK)
                    CreateDWordField (ATIB, 0x08, SFUN)
                    SSZE = 0x0C
                    VERN = One
                    If ((PXEN == 0x80000000))
                    {
                        NMSK = 0x11
                    }
                    Else
                    {
                        NMSK = 0x51
                    }

                    NMSK |= 0x80
                    MSKN = NMSK /* \_SB_.PCI0.VGA_.AF00.NMSK */
                    SFUN = 0x4007
                    Return (ATIB) /* \_SB_.PCI0.VGA_.ATIB */
                }

                Method (AF01, 0, NotSerialized)
                {
                    CreateWordField (ATIB, Zero, SSZE)
                    CreateDWordField (ATIB, 0x02, VMSK)
                    CreateDWordField (ATIB, 0x06, FLGS)
                    SSZE = 0x0A
                    VMSK = 0x03
                    FLGS = One
                    Return (ATIB) /* \_SB_.PCI0.VGA_.ATIB */
                }

                Name (PSBR, Buffer (0x04)
                {
                     0x00, 0x00, 0x00, 0x00                           /* .... */
                })
                Name (MSKN, Zero)
                Name (SEXM, Zero)
                Name (STHG, Zero)
                Name (STHI, Zero)
                Name (SFPG, Zero)
                Name (SFPI, Zero)
                Name (SSPS, Zero)
                Name (SSDM, 0x0A)
                Name (SCDY, Zero)
                Name (SACT, Buffer (0x07)
                {
                     0x01, 0x02, 0x08, 0x80, 0x03, 0x09, 0x81         /* ....... */
                })
                Method (AF02, 0, NotSerialized)
                {
                    CreateBitField (PSBR, Zero, PDSW)
                    CreateBitField (PSBR, One, PEXM)
                    CreateBitField (PSBR, 0x02, PTHR)
                    CreateBitField (PSBR, 0x03, PFPS)
                    CreateBitField (PSBR, 0x04, PSPS)
                    CreateBitField (PSBR, 0x05, PDCC)
                    CreateBitField (PSBR, 0x06, PXPS)
                    CreateBitField (PSBR, 0x07, PBRT)
                    CreateWordField (ATIB, Zero, SSZE)
                    CreateDWordField (ATIB, 0x02, PSBI)
                    CreateByteField (ATIB, 0x06, EXPM)
                    CreateByteField (ATIB, 0x07, THRM)
                    CreateByteField (ATIB, 0x08, THID)
                    CreateByteField (ATIB, 0x09, FPWR)
                    CreateByteField (ATIB, 0x0A, FPID)
                    CreateByteField (ATIB, 0x0B, SPWR)
                    CreateByteField (ATIB, 0x0C, BRTL)
                    SSZE = 0x0D
                    PSBI = PSBR /* \_SB_.PCI0.VGA_.PSBR */
                    If (PDSW)
                    {
                        PDSW = Zero
                    }

                    If (PEXM)
                    {
                        EXPM = SEXM /* \_SB_.PCI0.VGA_.SEXM */
                        SEXM = Zero
                        PEXM = Zero
                    }

                    If (PTHR)
                    {
                        THRM = STHG /* \_SB_.PCI0.VGA_.STHG */
                        THID = STHI /* \_SB_.PCI0.VGA_.STHI */
                        STHG = Zero
                        STHI = Zero
                        PTHR = Zero
                    }

                    If (PFPS)
                    {
                        FPWR = SFPG /* \_SB_.PCI0.VGA_.SFPG */
                        FPWR = SFPI /* \_SB_.PCI0.VGA_.SFPI */
                        SFPG = Zero
                        SFPI = Zero
                        PFPS = Zero
                    }

                    If (PSPS)
                    {
                        SPWR = SSPS /* \_SB_.PCI0.VGA_.SSPS */
                        PSPS = Zero
                    }

                    If (PXPS)
                    {
                        PXPS = Zero
                    }

                    If (PBRT)
                    {
                        PBRT = Zero
                    }

                    Return (ATIB) /* \_SB_.PCI0.VGA_.ATIB */
                }

                Method (AF03, 2, NotSerialized)
                {
                    CreateWordField (ATIB, Zero, SSZE)
                    CreateWordField (ATIB, 0x02, SSDP)
                    CreateWordField (ATIB, 0x04, SCDP)
                    SSDP = Arg0
                    SCDP = Arg1
                    Name (NXTD, 0x06)
                    Name (CIDX, 0x06)
                    Local1 = SSDP /* \_SB_.PCI0.VGA_.AF03.SSDP */
                    Local1 &= 0x8B
                    Local2 = SCDP /* \_SB_.PCI0.VGA_.AF03.SCDP */
                    If (CondRefOf (\_SB.LID._LID, Local4))
                    {
                        Local2 &= 0xFFFFFFFE
                        Local2 |= ^^^LID._LID ()
                    }
                    Else
                    {
                        Local2 |= One
                    }

                    P80H = Local2
                    Local0 = Zero
                    While ((Local0 < SizeOf (SACT)))
                    {
                        Local3 = DerefOf (SACT [Local0])
                        If ((Local3 == Local1))
                        {
                            CIDX = Local0
                            Local0 = SizeOf (SACT)
                        }
                        Else
                        {
                            Local0++
                        }
                    }

                    Local0 = CIDX /* \_SB_.PCI0.VGA_.AF03.CIDX */
                    While ((Local0 < SizeOf (SACT)))
                    {
                        Local0++
                        If ((Local0 == SizeOf (SACT)))
                        {
                            Local0 = Zero
                        }

                        Local3 = DerefOf (SACT [Local0])
                        If (((Local3 & Local2) == Local3))
                        {
                            NXTD = Local0
                            Local0 = SizeOf (SACT)
                        }
                    }

                    If ((NXTD == SizeOf (SACT)))
                    {
                        SSDP = Zero
                    }
                    Else
                    {
                        Local0 = NXTD /* \_SB_.PCI0.VGA_.AF03.NXTD */
                        Local3 = DerefOf (SACT [Local0])
                        SSDP &= 0xFFFFFFF4
                        SSDP |= Local3
                    }

                    SSZE = 0x04
                    P80H = SSDP /* \_SB_.PCI0.VGA_.AF03.SSDP */
                    Return (ATIB) /* \_SB_.PCI0.VGA_.ATIB */
                }

                Method (AFN0, 0, Serialized)
                {
                    If ((MSKN & One))
                    {
                        CreateBitField (PSBR, Zero, PDSW)
                        PDSW = One
                        Notify (VGA, 0x81) // Information Change
                    }
                }

                Method (AFN3, 2, Serialized)
                {
                    If ((MSKN & 0x08))
                    {
                        Local0 = Arg0
                        SFPI = Local0
                        Local0 = Arg1
                        SFPG = Local0 &= 0x03
                        CreateBitField (PSBR, 0x03, PFPS)
                        PFPS = One
                        Notify (VGA, 0x81) // Information Change
                    }
                }

                Method (AFN4, 1, Serialized)
                {
                    If ((MSKN & 0x10))
                    {
                        Local0 = Arg0
                        Local1 = SSPS /* \_SB_.PCI0.VGA_.SSPS */
                        SSPS = Local0
                        If ((Local0 == Local1)){}
                        Else
                        {
                            CreateBitField (PSBR, 0x04, PSPS)
                            PSPS = One
                            Notify (VGA, 0x81) // Information Change
                        }
                    }
                }

                Method (AFN5, 0, Serialized)
                {
                    If ((MSKN & 0x20))
                    {
                        CreateBitField (PSBR, 0x05, PDCC)
                        PDCC = One
                        Notify (VGA, 0x81) // Information Change
                    }
                }

                Method (AFN6, 0, Serialized)
                {
                    If ((MSKN & 0x40))
                    {
                        CreateBitField (PSBR, 0x06, PXPS)
                        PXPS = One
                        Notify (VGA, 0x81) // Information Change
                    }
                }

                Method (AFN7, 1, Serialized)
                {
                    CreateBitField (PSBR, 0x07, PBRT)
                    PBRT = One
                    CreateByteField (ATIB, 0x0C, BRTL)
                    BRTL = Arg0
                    Notify (VGA, 0x81) // Information Change
                }

                Method (AF15, 0, NotSerialized)
                {
                    P80H = 0xFF
                    CreateWordField (ATIB, Zero, DNUM)
                    CreateWordField (ATIB, 0x02, DSZE)
                    CreateDWordField (ATIB, 0x04, FLAG)
                    CreateWordField (ATIB, 0x08, BUSN)
                    CreateWordField (ATIB, 0x0A, DEVN)
                    Acquire (^^LPC0.PSMX, 0xFFFF)
                    BCMD = 0x8D
                    DID = 0x0F
                    INFO = ATIB /* \_SB_.PCI0.VGA_.ATIB */
                    BSMI (Zero)
                    ATIB = INFO /* \INFO */
                    Release (^^LPC0.PSMX)
                    DSZE = 0x08
                    DNUM = One
                    FLAG = 0x04
                    BUSN = Zero
                    DEVN = One
                    Return (ATIB) /* \_SB_.PCI0.VGA_.ATIB */
                }

                Scope (\_SB.PCI0.VGA)
                {
                    OperationRegion (REVD, SystemMemory, 0xDFBBED98, 0x00000008)
                    Field (REVD, AnyAcc, NoLock, Preserve)
                    {
                        SROM,   32, 
                        VROM,   32
                    }

                    Name (TVGA, Buffer (0x0004)
                    {
                         0x00                                             /* . */
                    })
                    Method (XTRM, 2, Serialized)
                    {
                        Local0 = (Arg0 + Arg1)
                        If ((Local0 <= SROM))
                        {
                            Local1 = (Arg1 * 0x08)
                            Local2 = (Arg0 * 0x08)
                            TVGA = VROM /* \_SB_.PCI0.VGA_.VROM */
                            CreateField (TVGA, Local2, Local1, TEMP)
                            Name (RETB, Buffer (Arg1){})
                            RETB = TEMP /* \_SB_.PCI0.VGA_.XTRM.TEMP */
                            Return (RETB) /* \_SB_.PCI0.VGA_.XTRM.RETB */
                        }
                        ElseIf ((Arg0 < SROM))
                        {
                            Local3 = (SROM - Arg0)
                            Local1 = (Local3 * 0x08)
                            Local2 = (Arg0 * 0x08)
                            TVGA = VROM /* \_SB_.PCI0.VGA_.VROM */
                            CreateField (TVGA, Local2, Local1, TEM)
                            Name (RETC, Buffer (Local3){})
                            RETC = TEM /* \_SB_.PCI0.VGA_.XTRM.TEM_ */
                            Return (RETC) /* \_SB_.PCI0.VGA_.XTRM.RETC */
                        }
                        Else
                        {
                            Name (RETD, Buffer (One){})
                            Return (RETD) /* \_SB_.PCI0.VGA_.XTRM.RETD */
                        }
                    }
                }

                Scope (\_SB.PCI0.VGA)
                {
                    Name (ATPB, Buffer (0x0100){})
                    Name (DSID, Ones)
                    Name (HSID, Ones)
                    Name (CNT0, Buffer (0x05)
                    {
                         0x05, 0x00, 0x00, 0x10, 0x01                     /* ..... */
                    })
                    Name (CNT1, Buffer (0x05)
                    {
                         0x05, 0x01, 0x00, 0x00, 0x01                     /* ..... */
                    })
                    Name (CNT2, Buffer (0x05)
                    {
                         0x07, 0x03, 0x00, 0x10, 0x02                     /* ..... */
                    })
                    Name (CNT3, Buffer (0x05)
                    {
                         0x07, 0x07, 0x00, 0x20, 0x02                     /* ... . */
                    })
                    Name (CNT4, Buffer (0x05)
                    {
                         0x00, 0x09, 0x00, 0x30, 0x02                     /* ...0. */
                    })
                    Name (CNT5, Buffer (0x05)
                    {
                         0x05, 0x00, 0x01, 0x10, 0x01                     /* ..... */
                    })
                    Name (CNT6, Buffer (0x05)
                    {
                         0x05, 0x01, 0x01, 0x00, 0x01                     /* ..... */
                    })
                    Name (CNT7, Buffer (0x05)
                    {
                         0x07, 0x03, 0x01, 0x10, 0x02                     /* ..... */
                    })
                    Name (CNT8, Buffer (0x05)
                    {
                         0x07, 0x07, 0x01, 0x20, 0x02                     /* ... . */
                    })
                    Name (CNT9, Buffer (0x05)
                    {
                         0x00, 0x09, 0x01, 0x30, 0x02                     /* ...0. */
                    })
                    Method (ATPX, 2, Serialized)
                    {
                        If ((Arg0 == Zero))
                        {
                            Return (PX00 ())
                        }

                        If ((Arg0 == One))
                        {
                            Return (PX01 ())
                        }

                        If ((Arg0 == 0x02))
                        {
                            PX02 (DerefOf (Arg1 [0x02]))
                            Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                        }

                        If ((Arg0 == 0x03))
                        {
                            PX03 (DerefOf (Arg1 [0x02]))
                            Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                        }

                        If ((Arg0 == 0x04))
                        {
                            PX04 (DerefOf (Arg1 [0x02]))
                            Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                        }

                        If ((Arg0 == 0x08))
                        {
                            Return (PX08 ())
                        }

                        If ((Arg0 == 0x09))
                        {
                            Return (PX09 ())
                        }

                        CreateWordField (ATPB, Zero, SSZE)
                        CreateWordField (ATPB, 0x02, VERN)
                        CreateDWordField (ATPB, 0x04, SFUN)
                        SSZE = Zero
                        VERN = Zero
                        SFUN = Zero
                        Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                    }

                    Method (PX00, 0, NotSerialized)
                    {
                        P80H = 0xE0
                        CreateWordField (ATPB, Zero, SSZE)
                        CreateWordField (ATPB, 0x02, VERN)
                        CreateDWordField (ATPB, 0x04, SFUN)
                        SSZE = 0x08
                        VERN = One
                        If ((PXEN == 0x80000000))
                        {
                            SFUN = Zero
                            Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                        }

                        If ((PXMX == 0x80000000))
                        {
                            SFUN = 0x018F
                        }
                        Else
                        {
                            SFUN = 0x0183
                        }

                        If ((PXDY == 0x80000001))
                        {
                            SFUN &= 0xFFFFFFFD
                        }

                        If (((PXDY == 0x80000001) && (PXFX == 0x80000001)))
                        {
                            SFUN |= 0x02
                        }

                        Local0 = ^^PB4.VGA.SVID /* \_SB_.PCI0.PB4_.VGA_.SVID */
                        Local1 = ^^PB4.HDAU.SVID /* \_SB_.PCI0.PB4_.HDAU.SVID */
                        If ((Local0 != Ones))
                        {
                            DSID = Local0
                        }

                        If ((Local1 != Ones))
                        {
                            HSID = Local1
                        }

                        Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                    }

                    Method (PX01, 0, NotSerialized)
                    {
                        P80H = 0xE1
                        CreateWordField (ATPB, Zero, SSZE)
                        CreateDWordField (ATPB, 0x02, VMSK)
                        CreateDWordField (ATPB, 0x06, FLGS)
                        SSZE = 0x0A
                        VMSK = 0xFF
                        If ((PXMX == 0x80000000))
                        {
                            FLGS = 0x4B
                        }
                        Else
                        {
                            FLGS = Zero
                            If ((PXDY == 0x80000001))
                            {
                                FLGS |= 0x80
                            }
                        }

                        Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                    }

                    Method (PX02, 1, NotSerialized)
                    {
                        CreateWordField (ATPB, Zero, SSZE)
                        CreateByteField (ATPB, 0x02, PWST)
                        SSZE = 0x03
                        Local7 = Buffer (0x05){}
                        CreateWordField (Local7, Zero, SZZE)
                        CreateField (Local7, 0x10, 0x03, FUCC)
                        CreateField (Local7, 0x13, 0x05, DEVV)
                        CreateByteField (Local7, 0x03, BUSS)
                        CreateByteField (Local7, 0x04, HPST)
                        SZZE = 0x05
                        BUSS = Zero
                        FUCC = Zero
                        Local6 = Buffer (0x04){}
                        CreateByteField (Local6, 0x02, HPOX)
                        PWST = (Arg0 & One)
                        Name (HPOK, Zero)
                        If (PWST)
                        {
                            P80H = 0x11E2
                            ^^SMBS.O021 = Zero
                            ^^SMBS.E021 = Zero
                            ^^SMBS.O045 = Zero
                            ^^SMBS.E045 = Zero
                            Sleep (0x0A)
                            ^^SMBS.O045 = One
                            ^^SMBS.E045 = Zero
                            Sleep (0x0A)
                            ^^SMBS.O055 = One
                            ^^SMBS.E055 = Zero
                            Local2 = 0x0A
                            ^^SMBS.I028 = One
                            While ((^^SMBS.I028 == Zero))
                            {
                                Sleep (0x05)
                                Local2--
                            }

                            ^^SMBS.O021 = One
                            ^^SMBS.E021 = Zero
                            P80H = 0x12E2
                            HPOK = Zero
                            Sleep (0x64)
                            Sleep (0x64)
                            DEVV = 0x04
                            HPST = One
                            0x06 = ALIB /* External reference */
                            Local7
                            Local6
                            Sleep (0x14)
                            Local2 = Zero
                            While ((Local2 < 0x0F))
                            {
                                ^^PB4.PSDC = One
                                Local4 = One
                                Local5 = 0xC8
                                While ((Local4 && Local5))
                                {
                                    Local0 = ^^PB4.XPRD (0xA5)
                                    Local0 &= 0x7F
                                    If (((Local0 >= 0x10) && (Local0 != 0x7F)))
                                    {
                                        Local4 = Zero
                                    }
                                    Else
                                    {
                                        Sleep (0x05)
                                        Local5--
                                    }
                                }

                                If (!Local4)
                                {
                                    Local5 = ^^PB4.XPDL ()
                                    If (Local5)
                                    {
                                        ^^PB4.XPRT ()
                                        Sleep (0x05)
                                        Local2++
                                    }
                                    Else
                                    {
                                        Local0 = Zero
                                        If ((^^PB4.XPR2 () == Ones))
                                        {
                                            Local0 = One
                                        }

                                        If (Local0)
                                        {
                                            HPOK = One
                                            Local2 = 0x10
                                        }
                                        Else
                                        {
                                            HPOK = Zero
                                            Local2 = 0x10
                                        }
                                    }
                                }
                                Else
                                {
                                    Local2 = 0x10
                                }
                            }

                            If (!HPOK)
                            {
                                P80H = 0x13E2
                                Local1 = ^^PB4.VGA.DVID /* \_SB_.PCI0.PB4_.VGA_.DVID */
                                Sleep (0x0A)
                                Local4 = One
                                Local5 = 0x05
                                While ((Local4 && Local5))
                                {
                                    Local0 = ^^PB4.XPRD (0xA5)
                                    Local0 &= 0x7F
                                    If ((Local0 <= 0x04))
                                    {
                                        Local4 = Zero
                                    }
                                    Else
                                    {
                                        Local1 = ^^PB4.VGA.DVID /* \_SB_.PCI0.PB4_.VGA_.DVID */
                                        Sleep (0x05)
                                        Local5--
                                    }
                                }

                                DEVV = 0x04
                                HPST = Zero
                                ALIB
                                0x06
                                Local7
                            }

                            P80H = 0x14E2
                        }
                        Else
                        {
                            P80H = 0x02E2
                            If ((PXMX == 0x80000000))
                            {
                                MUXF = 0x20
                                BCMD = 0x85
                                BSMI (Zero)
                            }

                            ^^SMBS.P21O = Zero
                            ^^SMBS.P21E = Zero
                            ^^SMBS.O055 = Zero
                            ^^SMBS.E055 = Zero
                            Sleep (0x0A)
                            ^^SMBS.O045 = Zero
                            ^^SMBS.E045 = Zero
                            P80H = 0x03E2
                            ^^PB4.PSDC = One
                            Local1 = ^^PB4.VGA.DVID /* \_SB_.PCI0.PB4_.VGA_.DVID */
                            Sleep (0x0A)
                            Local4 = One
                            Local5 = 0x05
                            While ((Local4 && Local5))
                            {
                                Local0 = ^^PB4.XPRD (0xA5)
                                Local0 &= 0x7F
                                If ((Local0 <= 0x04))
                                {
                                    Local4 = Zero
                                }
                                Else
                                {
                                    Local1 = ^^PB4.VGA.DVID /* \_SB_.PCI0.PB4_.VGA_.DVID */
                                    Sleep (0x05)
                                    Local5--
                                }
                            }

                            DEVV = 0x04
                            HPST = Zero
                            ALIB
                            0x06
                            Local7
                            HPOK = 0x02
                            P80H = 0x04E2
                        }

                        If (HPOK)
                        {
                            If (((HPOK == One) && (DSID != Ones)))
                            {
                                Local1 = DSID /* \_SB_.PCI0.VGA_.DSID */
                                ^^PB4.VGA.SMID = Local1
                                Sleep (0x0A)
                                Local1 = HSID /* \_SB_.PCI0.VGA_.HSID */
                                If ((Local1 != Ones))
                                {
                                    ^^PB4.HDAU.SMID = Local1
                                }

                                Sleep (0x0A)
                            }

                            Notify (PB4, Zero) // Bus Check
                        }
                    }

                    Method (PX03, 1, NotSerialized)
                    {
                        CreateWordField (ATPB, Zero, SSZE)
                        CreateWordField (ATPB, 0x02, DPSW)
                        SSZE = 0x04
                        DPSW = (Arg0 & One)
                    }

                    Method (PX04, 1, NotSerialized)
                    {
                        P80H = 0xE4
                        CreateWordField (ATPB, Zero, SSZE)
                        CreateWordField (ATPB, 0x02, ICSW)
                        SSZE = 0x04
                        ICSW = (Arg0 & One)
                    }

                    Method (PX08, 0, NotSerialized)
                    {
                        P80H = 0xE8
                        CreateWordField (ATPB, Zero, CNUM)
                        CreateWordField (ATPB, 0x02, CSSZ)
                        CNUM = 0x0A
                        CSSZ = 0x05
                        CreateField (ATPB, 0x20, 0x28, CTI0)
                        CTI0 = CNT0 /* \_SB_.PCI0.VGA_.CNT0 */
                        CreateField (ATPB, 0x48, 0x28, CTI1)
                        CTI1 = CNT1 /* \_SB_.PCI0.VGA_.CNT1 */
                        CreateField (ATPB, 0x70, 0x28, CTI2)
                        CreateByteField (CNT2, Zero, FLG2)
                        If ((LPTY == One))
                        {
                            If ((M92D == One))
                            {
                                FLG2 = Zero
                            }

                            If ((M92D == 0x02))
                            {
                                FLG2 = 0x07
                            }
                        }

                        CTI2 = CNT2 /* \_SB_.PCI0.VGA_.CNT2 */
                        CreateField (ATPB, 0x98, 0x28, CTI3)
                        CreateByteField (CNT3, Zero, FLG3)
                        If ((LPTY == Zero))
                        {
                            FLG3 = 0x07
                        }

                        If ((LPTY == One))
                        {
                            FLG3 = Zero
                        }

                        If ((LPTY == 0x02))
                        {
                            FLG3 = Zero
                        }

                        If ((M92D == 0x02))
                        {
                            FLG3 = 0x07
                        }

                        CTI3 = CNT3 /* \_SB_.PCI0.VGA_.CNT3 */
                        CreateField (ATPB, 0xC0, 0x28, CTI4)
                        CTI4 = CNT4 /* \_SB_.PCI0.VGA_.CNT4 */
                        CreateField (ATPB, 0xE8, 0x28, CTI5)
                        CTI5 = CNT5 /* \_SB_.PCI0.VGA_.CNT5 */
                        CreateField (ATPB, 0x0110, 0x28, CTI6)
                        CTI6 = CNT6 /* \_SB_.PCI0.VGA_.CNT6 */
                        CreateField (ATPB, 0x0138, 0x28, CTI7)
                        CreateByteField (CNT7, Zero, FLG7)
                        If ((LPTY == One))
                        {
                            If ((M92D == One))
                            {
                                FLG7 = Zero
                            }

                            If ((M92D == 0x02))
                            {
                                FLG7 = Zero
                            }
                        }

                        CTI7 = CNT7 /* \_SB_.PCI0.VGA_.CNT7 */
                        CreateField (ATPB, 0x0160, 0x28, CTI8)
                        CreateByteField (CNT8, Zero, FLG8)
                        If ((LPTY == Zero))
                        {
                            FLG8 = 0x07
                        }

                        If ((LPTY == One))
                        {
                            FLG8 = Zero
                        }

                        If ((LPTY == 0x02))
                        {
                            FLG8 = Zero
                        }

                        If ((M92D == 0x02))
                        {
                            FLG8 = 0x07
                        }

                        CTI8 = CNT8 /* \_SB_.PCI0.VGA_.CNT8 */
                        CreateField (ATPB, 0x0188, 0x28, CTI9)
                        CreateByteField (CNT9, Zero, FLG9)
                        If ((M92D == 0x02))
                        {
                            FLG9 = 0x07
                        }

                        CTI9 = CNT9 /* \_SB_.PCI0.VGA_.CNT9 */
                        Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                    }

                    Method (PX09, 0, NotSerialized)
                    {
                        P80H = 0xE9
                        CreateWordField (ATPB, Zero, CNUM)
                        CreateWordField (ATPB, 0x02, CSSZ)
                        CNUM = Zero
                        CSSZ = Zero
                        CreateByteField (ATPB, 0x04, ATI0)
                        CreateByteField (ATPB, 0x05, HPD0)
                        CreateByteField (ATPB, 0x06, DDC0)
                        ATI0 = Zero
                        HPD0 = Zero
                        DDC0 = Zero
                        CreateByteField (ATPB, 0x07, ATI1)
                        CreateByteField (ATPB, 0x08, HPD1)
                        CreateByteField (ATPB, 0x09, DDC1)
                        ATI1 = Zero
                        HPD1 = Zero
                        DDC1 = Zero
                        Return (ATPB) /* \_SB_.PCI0.VGA_.ATPB */
                    }
                }

                Name (AT00, Buffer (0xFF){})
                Name (AT01, Buffer (0x03){})
                Method (ATCS, 2, Serialized)
                {
                    If ((Arg0 == Zero))
                    {
                        ATC0 ()
                    }

                    If ((Arg0 == One))
                    {
                        ATC1 ()
                    }

                    If ((Arg0 == 0x02))
                    {
                        ATC2 (Arg1)
                    }

                    If ((Arg0 == 0x03))
                    {
                        ATC3 ()
                    }

                    If ((Arg0 == 0x04))
                    {
                        ATC4 (Arg1)
                    }

                    Return (AT00) /* \_SB_.PCI0.VGA_.AT00 */
                }

                Method (ATC0, 0, NotSerialized)
                {
                    CreateWordField (AT00, Zero, SZZE)
                    CreateWordField (AT00, 0x02, INTF)
                    CreateDWordField (AT00, 0x04, SUPP)
                    SZZE = 0x08
                    INTF = One
                    SUPP = 0x0F
                }

                Method (ATC1, 0, Serialized)
                {
                    CreateWordField (AT00, Zero, SZZE)
                    CreateDWordField (AT00, 0x02, VFMK)
                    CreateDWordField (AT00, 0x06, FLAG)
                    CreateField (AT00, 0x30, One, DOCK)
                    SZZE = 0x0A
                    VFMK = One
                    FLAG = Zero
                    DOCK = One
                }

                Method (ATC2, 1, Serialized)
                {
                    CreateField (Arg0, 0x10, 0x03, FUCC)
                    CreateField (Arg0, 0x13, 0x06, DEVV)
                    CreateByteField (Arg0, 0x03, BUSS)
                    CreateDWordField (Arg0, 0x04, VFMK)
                    CreateDWordField (Arg0, 0x06, FLAG)
                    CreateField (Arg0, 0x30, One, ADVC)
                    CreateField (Arg0, 0x31, One, WFCM)
                    CreateByteField (Arg0, 0x08, RQST)
                    CreateByteField (Arg0, 0x09, PFRQ)
                    CreateWordField (AT00, Zero, SZZE)
                    CreateByteField (AT00, 0x02, RETV)
                    SZZE = 0x03
                    RETV = One
                    0x02 = ALIB /* External reference */
                    Arg0
                    AT00
                }

                Method (ATC3, 0, Serialized)
                {
                    CreateWordField (AT00, Zero, SZZE)
                    CreateByteField (AT00, 0x02, RETV)
                    CreateWordField (AT01, Zero, SZZB)
                    CreateByteField (AT01, 0x02, PSPP)
                    SZZE = 0x03
                    RETV = One
                    SZZB = 0x03
                    PSPP = One
                    0x03 = ALIB /* External reference */
                    AT01
                    AT00
                }

                Method (ATC4, 1, Serialized)
                {
                    CreateField (Arg0, 0x10, 0x03, FUCC)
                    CreateField (Arg0, 0x13, 0x06, DEVV)
                    CreateByteField (Arg0, 0x03, BUSS)
                    CreateByteField (Arg0, 0x04, NULN)
                    CreateWordField (AT00, Zero, SZZE)
                    CreateByteField (AT00, 0x02, NULM)
                    SZZE = 0x03
                    NULM = One
                    0x04 = ALIB /* External reference */
                    Arg0
                    AT00
                }
            }

            Device (PB4)
            {
                Name (_ADR, 0x00040000)  // _ADR: Address
                Name (PR04, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }
                })
                Name (AR04, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR04) /* \_SB_.PCI0.PB4_.AR04 */
                    }

                    Return (PR04) /* \_SB_.PCI0.PB4_.PR04 */
                }

                OperationRegion (XPEX, SystemMemory, 0xF8020100, 0x0100)
                Field (XPEX, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x28), 
                    VC0S,   32
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    PCMS,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
                Field (XPCB, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    LKCN,   16, 
                    LKST,   16, 
                    Offset (0x1A), 
                        ,   3, 
                    PSDC,   1, 
                        ,   2, 
                    PSDS,   1, 
                    Offset (0x1B), 
                    HPCS,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PMES,   1
                }

                OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
                Field (XPRI, ByteAcc, NoLock, Preserve)
                {
                    XPIR,   32, 
                    XPID,   32
                }

                Method (XPDL, 0, NotSerialized)
                {
                    Local0 = Zero
                    If ((VC0S & 0x00020000))
                    {
                        Local0 = Ones
                    }

                    Return (Local0)
                }

                Method (XPRD, 1, NotSerialized)
                {
                    XPIR = Arg0
                    Local0 = XPID /* \_SB_.PCI0.PB4_.XPID */
                    XPIR = Zero
                    Return (Local0)
                }

                Method (XPWR, 2, NotSerialized)
                {
                    XPIR = Arg0
                    XPID = Arg1
                    XPIR = Zero
                }

                Method (XPRT, 0, NotSerialized)
                {
                    Local0 = XPRD (0xA2)
                    Local0 &= 0xFFFFFFF8
                    Local1 = (Local0 >> 0x04)
                    Local1 &= 0x07
                    Local0 |= Local1
                    Local0 |= 0x0100
                    XPWR (0xA2, Local0)
                }

                Method (XPPB, 0, NotSerialized)
                {
                    Local0 = _ADR /* \_SB_.PCI0.PB4_._ADR */
                    Local1 = (Local0 >> 0x10)
                    Local1 = (Local1 << 0x03)
                    Local2 = (Local0 & 0x0F)
                    Local3 = (Local1 | Local2)
                    Return (Local3)
                }

                Method (XPCN, 0, NotSerialized)
                {
                    Local1 = Zero
                    Local0 = XPPB ()
                    If ((0x04 > Local0))
                    {
                        Local1 = Zero
                    }

                    If ((0x08 > Local0))
                    {
                        Local1 = 0x00010000
                    }

                    If ((0x0B > Local0))
                    {
                        Local1 = 0x00020000
                    }

                    Return (Local1)
                }

                Method (XPPD, 0, NotSerialized)
                {
                    Local0 = XPPB ()
                    Local2 = GPPX ()
                    Local3 = GFXM ()
                    Local1 = Zero
                    If ((0x10 == Local0))
                    {
                        Local1 = 0xFFFF
                        If (Local3)
                        {
                            Local1 = 0x0F0F
                        }
                    }

                    If ((0x18 == Local0))
                    {
                        Local1 = 0xF0F0
                    }

                    If ((0x20 == Local0))
                    {
                        Local1 = 0x1010
                    }

                    If ((0x28 == Local0))
                    {
                        Local1 = 0x2020
                    }

                    If ((0x30 == Local0))
                    {
                        Local1 = 0x4040
                    }

                    If ((0x38 == Local0))
                    {
                        Local1 = 0x8080
                    }

                    If ((0x48 == Local0))
                    {
                        Local1 = Zero
                        If ((0x02 == Local2))
                        {
                            Local1 = 0x0303
                        }

                        If ((0x03 == Local2))
                        {
                            Local1 = 0x0101
                        }
                    }

                    If ((0x50 == Local0))
                    {
                        Local1 = Zero
                        If ((0x03 == Local2))
                        {
                            Local1 = 0x0202
                        }
                    }

                    Return (Local1)
                }

                Method (XPLP, 1, NotSerialized)
                {
                    Local1 = XPPD ()
                    If ((Zero != Local1))
                    {
                        Local2 = NBXR ((0x65 + XPCN ()))
                        If (Arg0)
                        {
                            Local2 &= ~Local1
                        }
                        Else
                        {
                            Local2 |= Local1
                        }

                        NBXW ((0x65 + XPCN ()), Local2)
                    }
                }

                Method (XPR2, 0, NotSerialized)
                {
                    Local0 = LKCN /* \_SB_.PCI0.PB4_.LKCN */
                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    Local0 |= 0x20
                    LKCN = Local0
                    Local1 = 0x64
                    Local2 = One
                    While ((Local1 && Local2))
                    {
                        Sleep (One)
                        Local3 = LKST /* \_SB_.PCI0.PB4_.LKST */
                        If ((Local3 & 0x0800))
                        {
                            Local1--
                        }
                        Else
                        {
                            Local2 = Zero
                        }
                    }

                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    If (!Local2)
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (XPLL, 1, NotSerialized)
                {
                    Local0 = GFXM ()
                    Local1 = XPPB ()
                    Local2 = Zero
                    If ((0x10 == Local1))
                    {
                        Local2 = One
                        Local3 = 0x00770070
                        If (Local0)
                        {
                            Local3 = 0x00330030
                        }
                    }

                    If (((0x18 == Local1) && Local0))
                    {
                        Local2 = One
                        Local3 = 0x00440040
                    }

                    Local0 = NBMR (0x07)
                    Local1 = NBXR (0x65)
                    If ((Local0 && 0x0201F000))
                    {
                        Local4 = 0x00440040
                        Local5 = Local4
                        If ((~Local1 && 0xF0F0))
                        {
                            Local5 = Zero
                        }
                    }
                    Else
                    {
                        Local4 = 0x00110010
                        Local5 = Local4
                        If ((~Local1 && 0x0F0F))
                        {
                            Local5 = Zero
                        }
                    }

                    If (Local2)
                    {
                        Local6 = (Local3 | Local4)
                        Local0 = (Local5 & Local4)
                        Local7 = (Local3 | Local0)
                        Local0 = NBMR (0x2E)
                        If (Arg0)
                        {
                            Local0 &= ~Local6
                        }
                        Else
                        {
                            Local0 |= Local7
                        }

                        NBMW (0x2E, Local0)
                    }
                }

                Method (XPPR, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        XPLL (One)
                        XPLP (One)
                        Sleep (0xC8)
                        XPTR ((XPPB () << 0x03), One)
                        Sleep (0x14)
                    }
                    Else
                    {
                        XPTR ((XPPB () << 0x03), Zero)
                        XPLP (Zero)
                        XPLL (Zero)
                    }

                    Return (Ones)
                }

                Device (VGA)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x50)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        Offset (0x2C), 
                        SVID,   32, 
                        Offset (0x4C), 
                        SMID,   32
                    }

                    Name (DOSA, Zero)
                    Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                    {
                        DOSA = Arg0
                    }

                    Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
                    {
                        Name (DODL, Package (0x05)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x0200, 
                            0x00010210, 
                            0x00010220
                        })
                        Return (DODL) /* \_SB_.PCI0.PB4_.VGA_._DOD.DODL */
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)  // _ADR: Address
                        Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
                        {
                            If ((MYOS == 0x07DC))
                            {
                                Return (Package (0x67)
                                {
                                    0x64, 
                                    0x28, 
                                    Zero, 
                                    One, 
                                    0x02, 
                                    0x03, 
                                    0x04, 
                                    0x05, 
                                    0x06, 
                                    0x07, 
                                    0x08, 
                                    0x09, 
                                    0x0A, 
                                    0x0B, 
                                    0x0C, 
                                    0x0D, 
                                    0x0E, 
                                    0x0F, 
                                    0x10, 
                                    0x11, 
                                    0x12, 
                                    0x13, 
                                    0x14, 
                                    0x15, 
                                    0x16, 
                                    0x17, 
                                    0x18, 
                                    0x19, 
                                    0x1A, 
                                    0x1B, 
                                    0x1C, 
                                    0x1D, 
                                    0x1E, 
                                    0x1F, 
                                    0x20, 
                                    0x21, 
                                    0x22, 
                                    0x23, 
                                    0x24, 
                                    0x25, 
                                    0x26, 
                                    0x27, 
                                    0x28, 
                                    0x29, 
                                    0x2A, 
                                    0x2B, 
                                    0x2C, 
                                    0x2D, 
                                    0x2E, 
                                    0x2F, 
                                    0x30, 
                                    0x31, 
                                    0x32, 
                                    0x33, 
                                    0x34, 
                                    0x35, 
                                    0x36, 
                                    0x37, 
                                    0x38, 
                                    0x39, 
                                    0x3A, 
                                    0x3B, 
                                    0x3C, 
                                    0x3D, 
                                    0x3E, 
                                    0x3F, 
                                    0x40, 
                                    0x41, 
                                    0x42, 
                                    0x43, 
                                    0x44, 
                                    0x45, 
                                    0x46, 
                                    0x47, 
                                    0x48, 
                                    0x49, 
                                    0x4A, 
                                    0x4B, 
                                    0x4C, 
                                    0x4D, 
                                    0x4E, 
                                    0x4F, 
                                    0x50, 
                                    0x51, 
                                    0x52, 
                                    0x53, 
                                    0x54, 
                                    0x55, 
                                    0x56, 
                                    0x57, 
                                    0x58, 
                                    0x59, 
                                    0x5A, 
                                    0x5B, 
                                    0x5C, 
                                    0x5D, 
                                    0x5E, 
                                    0x5F, 
                                    0x60, 
                                    0x61, 
                                    0x62, 
                                    0x63, 
                                    0x64
                                })
                            }
                            Else
                            {
                                Return (Package (0x0A)
                                {
                                    0x64, 
                                    0x28, 
                                    0x0A, 
                                    0x14, 
                                    0x1E, 
                                    0x28, 
                                    0x37, 
                                    0x46, 
                                    0x55, 
                                    0x64
                                })
                            }
                        }

                        Method (_BCM, 1, Serialized)  // _BCM: Brightness Control Method
                        {
                            Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                            If ((MYOS == 0x07DC))
                            {
                                Local0 = ToInteger (Arg0)
                                If (((Local0 >= Zero) && (Local0 < 0x0D)))
                                {
                                    Local1 = PL00 /* \PL00 */
                                    Local2 = PL01 /* \PL01 */
                                    Local3 = ((((Local2 - Local1) * (Local0 - Zero
                                        )) / 0x0D) + Local1)
                                }
                                ElseIf (((Local0 >= 0x0D) && (Local0 < 0x1B)))
                                {
                                    Local1 = PL01 /* \PL01 */
                                    Local2 = PL02 /* \PL02 */
                                    Local3 = ((((Local2 - Local1) * (Local0 - 0x0D
                                        )) / 0x0E) + Local1)
                                }
                                ElseIf (((Local0 >= 0x1B) && (Local0 < 0x28)))
                                {
                                    Local1 = PL02 /* \PL02 */
                                    Local2 = PL03 /* \PL03 */
                                    Local3 = ((((Local2 - Local1) * (Local0 - 0x1B
                                        )) / 0x0D) + Local1)
                                }
                                ElseIf (((Local0 >= 0x28) && (Local0 < 0x37)))
                                {
                                    Local1 = PL03 /* \PL03 */
                                    Local2 = PL04 /* \PL04 */
                                    Local3 = ((((Local2 - Local1) * (Local0 - 0x28
                                        )) / 0x0F) + Local1)
                                }
                                ElseIf (((Local0 >= 0x37) && (Local0 < 0x46)))
                                {
                                    Local1 = PL04 /* \PL04 */
                                    Local2 = PL05 /* \PL05 */
                                    Local3 = ((((Local2 - Local1) * (Local0 - 0x37
                                        )) / 0x0F) + Local1)
                                }
                                ElseIf (((Local0 >= 0x46) && (Local0 < 0x55)))
                                {
                                    Local1 = PL05 /* \PL05 */
                                    Local2 = PL06 /* \PL06 */
                                    Local3 = ((((Local2 - Local1) * (Local0 - 0x46
                                        )) / 0x0F) + Local1)
                                }
                                Else
                                {
                                    Local1 = PL06 /* \PL06 */
                                    Local2 = PL07 /* \PL07 */
                                    Local3 = ((((Local2 - Local1) * (Local0 - 0x55
                                        )) / 0x0F) + Local1)
                                }

                                ^^^^AFN7 (Local3)
                            }
                            Else
                            {
                                While (One)
                                {
                                    _T_0 = ToInteger (Arg0)
                                    If ((_T_0 == 0x0A))
                                    {
                                        Local1 = Zero
                                    }
                                    ElseIf ((_T_0 == 0x14))
                                    {
                                        Local1 = One
                                    }
                                    ElseIf ((_T_0 == 0x1E))
                                    {
                                        Local1 = 0x02
                                    }
                                    ElseIf ((_T_0 == 0x28))
                                    {
                                        Local1 = 0x03
                                    }
                                    ElseIf ((_T_0 == 0x37))
                                    {
                                        Local1 = 0x04
                                    }
                                    ElseIf ((_T_0 == 0x46))
                                    {
                                        Local1 = 0x05
                                    }
                                    ElseIf ((_T_0 == 0x55))
                                    {
                                        Local1 = 0x06
                                    }
                                    ElseIf ((_T_0 == 0x64))
                                    {
                                        Local1 = 0x07
                                    }

                                    Break
                                }

                                Local0 = ToInteger (Local1)
                                If ((TPOS >= 0x40))
                                {
                                    ^^^^LPC0.EC0.BLVL = ToInteger (Local1)
                                    ^^^^LPC0.EC0.SVBN ()
                                }
                            }
                        }

                        Method (_BQC, 0, Serialized)  // _BQC: Brightness Query Current
                        {
                            Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                            If (((TPOS >= 0x40) && (MYOS != 0x07DC)))
                            {
                                Local0 = ^^^^LPC0.EC0.BLVL /* \_SB_.PCI0.LPC0.EC0_.BLVL */
                                While (One)
                                {
                                    _T_0 = ToInteger (Local0)
                                    If ((_T_0 == Zero))
                                    {
                                        Local1 = 0x0A
                                    }
                                    ElseIf ((_T_0 == One))
                                    {
                                        Local1 = 0x14
                                    }
                                    ElseIf ((_T_0 == 0x02))
                                    {
                                        Local1 = 0x1E
                                    }
                                    ElseIf ((_T_0 == 0x03))
                                    {
                                        Local1 = 0x28
                                    }
                                    ElseIf ((_T_0 == 0x04))
                                    {
                                        Local1 = 0x37
                                    }
                                    ElseIf ((_T_0 == 0x05))
                                    {
                                        Local1 = 0x46
                                    }
                                    ElseIf ((_T_0 == 0x06))
                                    {
                                        Local1 = 0x55
                                    }
                                    ElseIf ((_T_0 == 0x07))
                                    {
                                        Local1 = 0x64
                                    }

                                    Break
                                }
                            }

                            Return (Local1)
                        }
                    }

                    Name (ATIB, Buffer (0x0100){})
                    Method (ATIF, 2, Serialized)
                    {
                        If ((Arg0 == Zero))
                        {
                            Return (AF00 ())
                        }

                        If ((Arg0 == One))
                        {
                            Return (AF01 ())
                        }

                        If ((Arg0 == 0x02))
                        {
                            Return (AF02 ())
                        }

                        If ((Arg0 == 0x03))
                        {
                            Return (AF03 (DerefOf (Arg1 [0x02]), DerefOf (Arg1 [0x04])))
                        }

                        If ((Arg0 == 0x0F))
                        {
                            Return (AF15 ())
                        }
                        Else
                        {
                            CreateWordField (ATIB, Zero, SSZE)
                            CreateWordField (ATIB, 0x02, VERN)
                            CreateDWordField (ATIB, 0x04, NMSK)
                            CreateDWordField (ATIB, 0x08, SFUN)
                            SSZE = Zero
                            VERN = Zero
                            NMSK = Zero
                            SFUN = Zero
                            Return (ATIB) /* \_SB_.PCI0.PB4_.VGA_.ATIB */
                        }
                    }

                    Method (AF00, 0, NotSerialized)
                    {
                        CreateWordField (ATIB, Zero, SSZE)
                        CreateWordField (ATIB, 0x02, VERN)
                        CreateDWordField (ATIB, 0x04, NMSK)
                        CreateDWordField (ATIB, 0x08, SFUN)
                        SSZE = 0x0C
                        VERN = One
                        If ((^^^VGA.PXEN == 0x80000000))
                        {
                            NMSK = 0x11
                        }
                        Else
                        {
                            NMSK = 0x51
                        }

                        NMSK |= 0x80
                        MSKN = NMSK /* \_SB_.PCI0.PB4_.VGA_.AF00.NMSK */
                        SFUN = 0x4007
                        Return (ATIB) /* \_SB_.PCI0.PB4_.VGA_.ATIB */
                    }

                    Method (AF01, 0, NotSerialized)
                    {
                        CreateWordField (ATIB, Zero, SSZE)
                        CreateDWordField (ATIB, 0x02, VMSK)
                        CreateDWordField (ATIB, 0x06, FLGS)
                        SSZE = 0x0A
                        VMSK = 0x03
                        FLGS = One
                        Return (ATIB) /* \_SB_.PCI0.PB4_.VGA_.ATIB */
                    }

                    Name (PSBR, Buffer (0x04)
                    {
                         0x00, 0x00, 0x00, 0x00                           /* .... */
                    })
                    Name (MSKN, Zero)
                    Name (SEXM, Zero)
                    Name (STHG, Zero)
                    Name (STHI, Zero)
                    Name (SFPG, Zero)
                    Name (SFPI, Zero)
                    Name (SSPS, Zero)
                    Name (SSDM, 0x0A)
                    Name (SCDY, Zero)
                    Name (SACT, Buffer (0x07)
                    {
                         0x01, 0x02, 0x08, 0x80, 0x03, 0x09, 0x81         /* ....... */
                    })
                    Method (AF02, 0, NotSerialized)
                    {
                        CreateBitField (PSBR, Zero, PDSW)
                        CreateBitField (PSBR, One, PEXM)
                        CreateBitField (PSBR, 0x02, PTHR)
                        CreateBitField (PSBR, 0x03, PFPS)
                        CreateBitField (PSBR, 0x04, PSPS)
                        CreateBitField (PSBR, 0x05, PDCC)
                        CreateBitField (PSBR, 0x06, PXPS)
                        CreateBitField (PSBR, 0x07, PBRT)
                        CreateWordField (ATIB, Zero, SSZE)
                        CreateDWordField (ATIB, 0x02, PSBI)
                        CreateByteField (ATIB, 0x06, EXPM)
                        CreateByteField (ATIB, 0x07, THRM)
                        CreateByteField (ATIB, 0x08, THID)
                        CreateByteField (ATIB, 0x09, FPWR)
                        CreateByteField (ATIB, 0x0A, FPID)
                        CreateByteField (ATIB, 0x0B, SPWR)
                        CreateByteField (ATIB, 0x0C, BRTL)
                        SSZE = 0x0D
                        PSBI = PSBR /* \_SB_.PCI0.PB4_.VGA_.PSBR */
                        If (PDSW)
                        {
                            PDSW = Zero
                        }

                        If (PEXM)
                        {
                            EXPM = SEXM /* \_SB_.PCI0.PB4_.VGA_.SEXM */
                            SEXM = Zero
                            PEXM = Zero
                        }

                        If (PTHR)
                        {
                            THRM = STHG /* \_SB_.PCI0.PB4_.VGA_.STHG */
                            THID = STHI /* \_SB_.PCI0.PB4_.VGA_.STHI */
                            STHG = Zero
                            STHI = Zero
                            PTHR = Zero
                        }

                        If (PFPS)
                        {
                            FPWR = SFPG /* \_SB_.PCI0.PB4_.VGA_.SFPG */
                            FPWR = SFPI /* \_SB_.PCI0.PB4_.VGA_.SFPI */
                            SFPG = Zero
                            SFPI = Zero
                            PFPS = Zero
                        }

                        If (PSPS)
                        {
                            SPWR = SSPS /* \_SB_.PCI0.PB4_.VGA_.SSPS */
                            PSPS = Zero
                        }

                        If (PXPS)
                        {
                            PXPS = Zero
                        }

                        If (PBRT)
                        {
                            PBRT = Zero
                        }

                        Return (ATIB) /* \_SB_.PCI0.PB4_.VGA_.ATIB */
                    }

                    Method (AF03, 2, NotSerialized)
                    {
                        CreateWordField (ATIB, Zero, SSZE)
                        CreateWordField (ATIB, 0x02, SSDP)
                        CreateWordField (ATIB, 0x04, SCDP)
                        SSDP = Arg0
                        SCDP = Arg1
                        Name (NXTD, 0x06)
                        Name (CIDX, 0x06)
                        Local1 = SSDP /* \_SB_.PCI0.PB4_.VGA_.AF03.SSDP */
                        Local1 &= 0x8B
                        Local2 = SCDP /* \_SB_.PCI0.PB4_.VGA_.AF03.SCDP */
                        If (CondRefOf (\_SB.LID._LID, Local4))
                        {
                            Local2 &= 0xFFFFFFFE
                            Local2 |= ^^^^LID._LID ()
                        }
                        Else
                        {
                            Local2 |= One
                        }

                        P80H = Local2
                        Local0 = Zero
                        While ((Local0 < SizeOf (SACT)))
                        {
                            Local3 = DerefOf (SACT [Local0])
                            If ((Local3 == Local1))
                            {
                                CIDX = Local0
                                Local0 = SizeOf (SACT)
                            }
                            Else
                            {
                                Local0++
                            }
                        }

                        Local0 = CIDX /* \_SB_.PCI0.PB4_.VGA_.AF03.CIDX */
                        While ((Local0 < SizeOf (SACT)))
                        {
                            Local0++
                            If ((Local0 == SizeOf (SACT)))
                            {
                                Local0 = Zero
                            }

                            Local3 = DerefOf (SACT [Local0])
                            If (((Local3 & Local2) == Local3))
                            {
                                NXTD = Local0
                                Local0 = SizeOf (SACT)
                            }
                        }

                        If ((NXTD == SizeOf (SACT)))
                        {
                            SSDP = Zero
                        }
                        Else
                        {
                            Local0 = NXTD /* \_SB_.PCI0.PB4_.VGA_.AF03.NXTD */
                            Local3 = DerefOf (SACT [Local0])
                            SSDP &= 0xFFFFFFF4
                            SSDP |= Local3
                        }

                        SSZE = 0x04
                        P80H = SSDP /* \_SB_.PCI0.PB4_.VGA_.AF03.SSDP */
                        Return (ATIB) /* \_SB_.PCI0.PB4_.VGA_.ATIB */
                    }

                    Method (AFN0, 0, Serialized)
                    {
                        If ((MSKN & One))
                        {
                            CreateBitField (PSBR, Zero, PDSW)
                            PDSW = One
                            Notify (VGA, 0x81) // Information Change
                        }
                    }

                    Method (AFN3, 2, Serialized)
                    {
                        If ((MSKN & 0x08))
                        {
                            Local0 = Arg0
                            SFPI = Local0
                            Local0 = Arg1
                            SFPG = Local0 &= 0x03
                            CreateBitField (PSBR, 0x03, PFPS)
                            PFPS = One
                            Notify (VGA, 0x81) // Information Change
                        }
                    }

                    Method (AFN4, 1, Serialized)
                    {
                        If ((MSKN & 0x10))
                        {
                            Local0 = Arg0
                            Local1 = SSPS /* \_SB_.PCI0.PB4_.VGA_.SSPS */
                            SSPS = Local0
                            If ((Local0 == Local1)){}
                            Else
                            {
                                CreateBitField (PSBR, 0x04, PSPS)
                                PSPS = One
                                Notify (VGA, 0x81) // Information Change
                            }
                        }
                    }

                    Method (AFN5, 0, Serialized)
                    {
                        If ((MSKN & 0x20))
                        {
                            CreateBitField (PSBR, 0x05, PDCC)
                            PDCC = One
                            Notify (VGA, 0x81) // Information Change
                        }
                    }

                    Method (AFN6, 0, Serialized)
                    {
                        If ((MSKN & 0x40))
                        {
                            CreateBitField (PSBR, 0x06, PXPS)
                            PXPS = One
                            Notify (VGA, 0x81) // Information Change
                        }
                    }

                    Method (AFN7, 1, Serialized)
                    {
                        CreateBitField (PSBR, 0x07, PBRT)
                        PBRT = One
                        CreateByteField (ATIB, 0x0C, BRTL)
                        BRTL = Arg0
                        Notify (VGA, 0x81) // Information Change
                    }

                    Method (AF15, 0, NotSerialized)
                    {
                        P80H = 0xFF
                        CreateWordField (ATIB, Zero, DNUM)
                        CreateWordField (ATIB, 0x02, DSZE)
                        CreateDWordField (ATIB, 0x04, FLAG)
                        CreateWordField (ATIB, 0x08, BUSN)
                        CreateWordField (ATIB, 0x0A, DEVN)
                        Acquire (^^^LPC0.PSMX, 0xFFFF)
                        BCMD = 0x8D
                        DID = 0x0F
                        INFO = ATIB /* \_SB_.PCI0.PB4_.VGA_.ATIB */
                        BSMI (Zero)
                        ATIB = INFO /* \INFO */
                        Release (^^^LPC0.PSMX)
                        DSZE = 0x08
                        DNUM = One
                        FLAG = 0x04
                        BUSN = Zero
                        DEVN = One
                        Return (ATIB) /* \_SB_.PCI0.PB4_.VGA_.ATIB */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        If ((^^^VGA.PXMX != 0x80000000))
                        {
                            Return (Zero)
                        }
                        ElseIf ((0x18 == XPPB ()))
                        {
                            If ((^^^VGA.PXEN != 0x80000000))
                            {
                                Return (Zero)
                            }
                            Else
                            {
                                Return (One)
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Device (HDAU)
                {
                    Name (_ADR, One)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x50)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        Offset (0x2C), 
                        SVID,   32, 
                        Offset (0x4C), 
                        SMID,   32
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        If ((^^^VGA.PXMX != 0x80000000))
                        {
                            Return (Zero)
                        }
                        ElseIf ((0x18 == XPPB ()))
                        {
                            If ((^^^VGA.PXEN != 0x80000000))
                            {
                                Return (Zero)
                            }
                            Else
                            {
                                Return (One)
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }
            }

            Device (PB5)
            {
                Name (_ADR, 0x00050000)  // _ADR: Address
                Name (PR05, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKA, 
                        Zero
                    }
                })
                Name (AR05, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x10
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR05) /* \_SB_.PCI0.PB5_.AR05 */
                    }

                    Return (PR05) /* \_SB_.PCI0.PB5_.PR05 */
                }

                OperationRegion (XPEX, SystemMemory, 0xF8028100, 0x0100)
                Field (XPEX, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x28), 
                    VC0S,   32
                }

                OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
                Field (XPCB, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    LKCN,   16, 
                    LKST,   16, 
                    Offset (0x1A), 
                        ,   3, 
                    PDC2,   1, 
                        ,   2, 
                    PDS2,   1, 
                    Offset (0x1B), 
                    HPCS,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PMES,   1
                }

                OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
                Field (XPRI, ByteAcc, NoLock, Preserve)
                {
                    XPIR,   32, 
                    XPID,   32
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                Method (XPDL, 0, NotSerialized)
                {
                    If ((VC0S & 0x00020000))
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Mutex (XPPM, 0x00)
                Method (XPRD, 1, NotSerialized)
                {
                    Acquire (XPPM, 0xFFFF)
                    XPIR = Arg0
                    Local0 = XPID /* \_SB_.PCI0.PB5_.XPID */
                    XPIR = Zero
                    Release (XPPM)
                    Return (Local0)
                }

                Method (XPWR, 2, NotSerialized)
                {
                    Acquire (XPPM, 0xFFFF)
                    XPIR = Arg0
                    XPID = Arg1
                    XPIR = Zero
                    Release (XPPM)
                }

                Method (XPRT, 0, NotSerialized)
                {
                    Local0 = XPRD (0xA2)
                    Local0 &= 0xFFFFFFF8
                    Local1 = (Local0 >> 0x04)
                    Local1 &= 0x07
                    Local0 |= Local1
                    Local0 |= 0x0100
                    XPWR (0xA2, Local0)
                }

                Method (XPR2, 0, NotSerialized)
                {
                    Local0 = LKCN /* \_SB_.PCI0.PB5_.LKCN */
                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    Local0 |= 0x20
                    LKCN = Local0
                    Local1 = 0x64
                    Local2 = One
                    While ((Local1 && Local2))
                    {
                        Sleep (One)
                        Local3 = LKST /* \_SB_.PCI0.PB5_.LKST */
                        If ((Local3 & 0x0800))
                        {
                            Local1--
                        }
                        Else
                        {
                            Local2 = Zero
                        }
                    }

                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    If (!Local2)
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (XPPB, 0, NotSerialized)
                {
                    Local0 = _ADR /* \_SB_.PCI0.PB5_._ADR */
                    Local1 = (Local0 >> 0x10)
                    Local1 = (Local1 << 0x03)
                    Local2 = (Local0 & 0x0F)
                    Local3 = (Local1 | Local2)
                    Return (Local3)
                }

                Method (XPPR, 1, NotSerialized)
                {
                    Name (HPOK, Zero)
                    HPOK = Zero
                    Local0 = (XPPB () << 0x03)
                    If (Arg0)
                    {
                        XPLL (Local0, One)
                        XPLP (Local0, One)
                        Sleep (0xC8)
                        XPTR (Local0, One)
                        Local5 = 0x0F
                        While ((!HPOK && (Local5 > Zero)))
                        {
                            PDC2 = One
                            Local1 = 0x28
                            While ((!HPOK && (Local1 > Zero)))
                            {
                                Local2 = XPRD (0xA5)
                                If (((Local2 & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If (((Local2 & 0xFF) >= 0x04))
                                {
                                    HPOK = One
                                }

                                Local1--
                            }

                            If (HPOK)
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                                If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                                {
                                    HPOK = Zero
                                }
                            }

                            If (HPOK)
                            {
                                Local1 = 0x07D0
                                HPOK = Zero
                                While ((!HPOK && Local1))
                                {
                                    Local2 = (XPRD (0xA5) & 0xFF)
                                    If ((Local2 == 0x07))
                                    {
                                        Local1 = One
                                        Local4 = XPDL ()
                                        If (Local4)
                                        {
                                            XPRT ()
                                            Local5--
                                        }
                                    }

                                    If ((Local2 == 0x10))
                                    {
                                        HPOK = One
                                    }

                                    Sleep (One)
                                    Local1--
                                }
                            }
                        }
                    }

                    If (HPOK)
                    {
                        XPTR (Local0, Zero)
                        XPLP (Local0, Zero)
                        XPLL (Local0, Zero)
                    }

                    Return (Ones)
                }

                Device (XPDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }
                }
            }

            Name (LANP, Zero)
            Device (PB6)
            {
                Name (_ADR, 0x00060000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If ((WKPM == One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Device (ATHE)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        If ((WKPM == One))
                        {
                            Return (Package (0x02)
                            {
                                0x09, 
                                0x04
                            })
                        }
                        Else
                        {
                            Return (Package (0x02)
                            {
                                0x09, 
                                Zero
                            })
                        }
                    }

                    Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                    {
                        If (Arg0)
                        {
                            LANP = Zero
                        }
                        Else
                        {
                            LANP = One
                        }
                    }
                }

                Name (PR06, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKB, 
                        Zero
                    }
                })
                Name (AR06, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR06) /* \_SB_.PCI0.PB6_.AR06 */
                    }

                    Return (PR06) /* \_SB_.PCI0.PB6_.PR06 */
                }

                OperationRegion (XPEX, SystemMemory, 0xF9030100, 0x0100)
                Field (XPEX, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x28), 
                    VC0S,   32
                }

                OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
                Field (XPCB, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    LKCN,   16, 
                    LKST,   16, 
                    Offset (0x1A), 
                        ,   3, 
                    PDC2,   1, 
                        ,   2, 
                    PDS2,   1, 
                    Offset (0x1B), 
                    HPCS,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PMES,   1
                }

                OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
                Field (XPRI, ByteAcc, NoLock, Preserve)
                {
                    XPIR,   32, 
                    XPID,   32
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                Method (XPDL, 0, NotSerialized)
                {
                    If ((VC0S & 0x00020000))
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Mutex (XPPM, 0x00)
                Method (XPRD, 1, NotSerialized)
                {
                    Acquire (XPPM, 0xFFFF)
                    XPIR = Arg0
                    Local0 = XPID /* \_SB_.PCI0.PB6_.XPID */
                    XPIR = Zero
                    Release (XPPM)
                    Return (Local0)
                }

                Method (XPWR, 2, NotSerialized)
                {
                    Acquire (XPPM, 0xFFFF)
                    XPIR = Arg0
                    XPID = Arg1
                    XPIR = Zero
                    Release (XPPM)
                }

                Method (XPRT, 0, NotSerialized)
                {
                    Local0 = XPRD (0xA2)
                    Local0 &= 0xFFFFFFF8
                    Local1 = (Local0 >> 0x04)
                    Local1 &= 0x07
                    Local0 |= Local1
                    Local0 |= 0x0100
                    XPWR (0xA2, Local0)
                }

                Method (XPR2, 0, NotSerialized)
                {
                    Local0 = LKCN /* \_SB_.PCI0.PB6_.LKCN */
                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    Local0 |= 0x20
                    LKCN = Local0
                    Local1 = 0x64
                    Local2 = One
                    While ((Local1 && Local2))
                    {
                        Sleep (One)
                        Local3 = LKST /* \_SB_.PCI0.PB6_.LKST */
                        If ((Local3 & 0x0800))
                        {
                            Local1--
                        }
                        Else
                        {
                            Local2 = Zero
                        }
                    }

                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    If (!Local2)
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (XPPB, 0, NotSerialized)
                {
                    Local0 = _ADR /* \_SB_.PCI0.PB6_._ADR */
                    Local1 = (Local0 >> 0x10)
                    Local1 = (Local1 << 0x03)
                    Local2 = (Local0 & 0x0F)
                    Local3 = (Local1 | Local2)
                    Return (Local3)
                }

                Method (XPPR, 1, NotSerialized)
                {
                    Name (HPOK, Zero)
                    HPOK = Zero
                    Local0 = (XPPB () << 0x03)
                    If (Arg0)
                    {
                        XPLL (Local0, One)
                        XPLP (Local0, One)
                        Sleep (0xC8)
                        XPTR (Local0, One)
                        Local5 = 0x0F
                        While ((!HPOK && (Local5 > Zero)))
                        {
                            PDC2 = One
                            Local1 = 0x28
                            While ((!HPOK && (Local1 > Zero)))
                            {
                                Local2 = XPRD (0xA5)
                                If (((Local2 & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If (((Local2 & 0xFF) >= 0x04))
                                {
                                    HPOK = One
                                }

                                Local1--
                            }

                            If (HPOK)
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                                If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                                {
                                    HPOK = Zero
                                }
                            }

                            If (HPOK)
                            {
                                Local1 = 0x07D0
                                HPOK = Zero
                                While ((!HPOK && Local1))
                                {
                                    Local2 = (XPRD (0xA5) & 0xFF)
                                    If ((Local2 == 0x07))
                                    {
                                        Local1 = One
                                        Local4 = XPDL ()
                                        If (Local4)
                                        {
                                            XPRT ()
                                            Local5--
                                        }
                                    }

                                    If ((Local2 == 0x10))
                                    {
                                        HPOK = One
                                    }

                                    Sleep (One)
                                    Local1--
                                }
                            }
                        }
                    }

                    If (HPOK)
                    {
                        XPTR (Local0, Zero)
                        XPLP (Local0, Zero)
                        XPLL (Local0, Zero)
                    }

                    Return (Ones)
                }

                Device (XPDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }
                }
            }

            Device (PB7)
            {
                Name (_ADR, 0x00070000)  // _ADR: Address
                Name (PR07, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKC, 
                        Zero
                    }
                })
                Name (AR07, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x12
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR07) /* \_SB_.PCI0.PB7_.AR07 */
                    }

                    Return (PR07) /* \_SB_.PCI0.PB7_.PR07 */
                }

                OperationRegion (XPEX, SystemMemory, 0xF8038100, 0x0100)
                Field (XPEX, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x28), 
                    VC0S,   32
                }

                OperationRegion (XPCB, PCI_Config, 0x58, 0x24)
                Field (XPCB, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x10), 
                    LKCN,   16, 
                    LKST,   16, 
                    Offset (0x1A), 
                        ,   3, 
                    PDC2,   1, 
                        ,   2, 
                    PDS2,   1, 
                    Offset (0x1B), 
                    HPCS,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PMES,   1
                }

                OperationRegion (XPRI, PCI_Config, 0xE0, 0x08)
                Field (XPRI, ByteAcc, NoLock, Preserve)
                {
                    XPIR,   32, 
                    XPID,   32
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                Method (XPDL, 0, NotSerialized)
                {
                    If ((VC0S & 0x00020000))
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Mutex (XPPM, 0x00)
                Method (XPRD, 1, NotSerialized)
                {
                    Acquire (XPPM, 0xFFFF)
                    XPIR = Arg0
                    Local0 = XPID /* \_SB_.PCI0.PB7_.XPID */
                    XPIR = Zero
                    Release (XPPM)
                    Return (Local0)
                }

                Method (XPWR, 2, NotSerialized)
                {
                    Acquire (XPPM, 0xFFFF)
                    XPIR = Arg0
                    XPID = Arg1
                    XPIR = Zero
                    Release (XPPM)
                }

                Method (XPRT, 0, NotSerialized)
                {
                    Local0 = XPRD (0xA2)
                    Local0 &= 0xFFFFFFF8
                    Local1 = (Local0 >> 0x04)
                    Local1 &= 0x07
                    Local0 |= Local1
                    Local0 |= 0x0100
                    XPWR (0xA2, Local0)
                }

                Method (XPR2, 0, NotSerialized)
                {
                    Local0 = LKCN /* \_SB_.PCI0.PB7_.LKCN */
                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    Local0 |= 0x20
                    LKCN = Local0
                    Local1 = 0x64
                    Local2 = One
                    While ((Local1 && Local2))
                    {
                        Sleep (One)
                        Local3 = LKST /* \_SB_.PCI0.PB7_.LKST */
                        If ((Local3 & 0x0800))
                        {
                            Local1--
                        }
                        Else
                        {
                            Local2 = Zero
                        }
                    }

                    Local0 &= 0xFFFFFFDF
                    LKCN = Local0
                    If (!Local2)
                    {
                        Return (Ones)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (XPPB, 0, NotSerialized)
                {
                    Local0 = _ADR /* \_SB_.PCI0.PB7_._ADR */
                    Local1 = (Local0 >> 0x10)
                    Local1 = (Local1 << 0x03)
                    Local2 = (Local0 & 0x0F)
                    Local3 = (Local1 | Local2)
                    Return (Local3)
                }

                Method (XPPR, 1, NotSerialized)
                {
                    Name (HPOK, Zero)
                    HPOK = Zero
                    Local0 = (XPPB () << 0x03)
                    If (Arg0)
                    {
                        XPLL (Local0, One)
                        XPLP (Local0, One)
                        Sleep (0xC8)
                        XPTR (Local0, One)
                        Local5 = 0x0F
                        While ((!HPOK && (Local5 > Zero)))
                        {
                            PDC2 = One
                            Local1 = 0x28
                            While ((!HPOK && (Local1 > Zero)))
                            {
                                Local2 = XPRD (0xA5)
                                If (((Local2 & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If ((((Local2 >> 0x08) & 0xFF) == 0x3F))
                                {
                                    Local1 = One
                                }

                                If (((Local2 & 0xFF) >= 0x04))
                                {
                                    HPOK = One
                                }

                                Local1--
                            }

                            If (HPOK)
                            {
                                Local2 = (XPRD (0xA5) & 0xFF)
                                Local3 = ((XPRD (0xA2) >> 0x04) & 0x07)
                                If (((Local2 == 0x06) && ((Local3 > One) && (Local3 < 0x05))))
                                {
                                    HPOK = Zero
                                }
                            }

                            If (HPOK)
                            {
                                Local1 = 0x07D0
                                HPOK = Zero
                                While ((!HPOK && Local1))
                                {
                                    Local2 = (XPRD (0xA5) & 0xFF)
                                    If ((Local2 == 0x07))
                                    {
                                        Local1 = One
                                        Local4 = XPDL ()
                                        If (Local4)
                                        {
                                            XPRT ()
                                            Local5--
                                        }
                                    }

                                    If ((Local2 == 0x10))
                                    {
                                        HPOK = One
                                    }

                                    Sleep (One)
                                    Local1--
                                }
                            }
                        }
                    }

                    If (HPOK)
                    {
                        XPTR (Local0, Zero)
                        XPLP (Local0, Zero)
                        XPLL (Local0, Zero)
                    }

                    Return (Ones)
                }

                Device (XPDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }
                }
            }

            Device (SPB0)
            {
                Name (_ADR, 0x00150000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If ((WKPM == One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR0A, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKD, 
                        Zero
                    }
                })
                Name (AR0A, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x13
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR0A) /* \_SB_.PCI0.SPB0.AR0A */
                    }

                    Return (PR0A) /* \_SB_.PCI0.SPB0.PR0A */
                }

                Method (XPPB, 0, NotSerialized)
                {
                    Local0 = _ADR /* \_SB_.PCI0.SPB0._ADR */
                    Local1 = (Local0 >> 0x10)
                    Local2 = (Local1 << 0x03)
                    Local1 = (Local0 & 0x0F)
                    Local3 = (Local1 | Local2)
                    Return (Local3)
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    PCMS,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                Device (XPDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }
                }

                Method (GENC, 0, NotSerialized)
                {
                    Local0 = Zero
                    While ((Local0 < 0x04))
                    {
                        Local1 = RDAB (CABR (0x03, Local0, 0xA4))
                        Local1 &= 0x0800
                        If ((Local1 != Zero))
                        {
                            Return (0x0F)
                        }

                        Local0++
                        Stall (0xC8)
                    }

                    Return (Zero)
                }

                Method (GHPS, 2, NotSerialized)
                {
                    If ((Arg0 == Zero))
                    {
                        If ((Arg1 == Zero))
                        {
                            RWAB (CABR (0x06, Zero, 0xC0), 0xFFFFEFFF, Zero)
                            RWAB (CABR (One, Zero, 0x65), 0xFFFFFEFE, Zero)
                        }

                        If ((Arg1 == 0x02))
                        {
                            RWAB (CABR (0x06, Zero, 0xC0), 0xFFFFBFFF, Zero)
                            RWAB (CABR (One, Zero, 0x65), 0xFFFFFBFB, Zero)
                        }

                        Stall (0xC8)
                    }

                    If ((Arg0 == One))
                    {
                        RWAB (CABR (0x03, Arg1, 0xA2), 0xFFFDFFFF, 0x00020000)
                        RWAB (CABR (0x03, Arg1, 0xA2), 0xFFFFFEFF, 0x0100)
                        If ((Arg1 == Zero))
                        {
                            RWAB (CABR (0x06, Zero, 0xC0), 0xFFFFEFFF, 0x1000)
                            RWAB (CABR (One, Zero, 0x65), 0xFFFFFEFE, 0x0101)
                        }

                        If ((Arg1 == 0x02))
                        {
                            RWAB (CABR (0x06, Zero, 0xC0), 0xFFFFBFFF, 0x4000)
                            RWAB (CABR (One, Zero, 0x65), 0xFFFFFBFB, 0x0404)
                        }

                        RWAB (CABR (0x03, Arg1, 0xA2), 0xFFFDFFFF, Zero)
                        Stall (0xC8)
                    }

                    If ((Arg0 == Zero))
                    {
                        GEN2 ()
                        Local0 = RDAB (CABR (0x03, 0x02, 0xA5))
                        Local0 &= 0xFF
                        Local1 = 0x01F4
                        While (((Local1 > Zero) && (Local0 != 0x10)))
                        {
                            Local0 = RDAB (CABR (0x03, 0x02, 0xA5))
                            Local0 &= 0xFF
                            Local1--
                            Stall (0xC8)
                            Stall (0xC8)
                        }

                        If ((Local0 != 0x10))
                        {
                            GEN1 ()
                        }
                    }

                    If ((GENC () == Zero))
                    {
                        RWAB (CABR (One, Zero, 0x40), 0xFFFFFFF7, 0x08)
                    }
                    Else
                    {
                        RWAB (CABR (One, Zero, 0x40), 0xFFFFFFF7, Zero)
                    }

                    Stall (0xC8)
                }

                Method (GEN2, 0, NotSerialized)
                {
                    TLS2 = 0x02
                    RWAB (CABR (0x03, 0x02, 0xA4), 0xFFFFFFFE, One)
                    RWAB (CABR (0x03, 0x02, 0xA2), 0xFFFFDFFF, 0x2000)
                    RWAB (CABR (0x03, 0x02, 0xC0), 0xFFFF7FFF, 0x8000)
                    RWAB (CABR (0x03, 0x02, 0xA4), 0xDFFFFFFF, 0x20000000)
                    Stall (0xC8)
                    Stall (0xC8)
                }

                Method (GEN1, 0, NotSerialized)
                {
                    TLS2 = One
                    RWAB (CABR (0x03, 0x02, 0xA4), 0xFFFFFFFE, Zero)
                    RWAB (CABR (0x03, 0x02, 0xA2), 0xFFFFDFFF, 0x2000)
                    Stall (0xC8)
                    Stall (0xC8)
                }
            }

            Device (SPB1)
            {
                Name (_ADR, 0x00150001)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x08, 
                    0x04
                })
                Name (PR0B, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKA, 
                        Zero
                    }
                })
                Name (AR0B, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x10
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR0B) /* \_SB_.PCI0.SPB1.AR0B */
                    }

                    Return (PR0B) /* \_SB_.PCI0.SPB1.PR0B */
                }

                Method (XPPB, 0, NotSerialized)
                {
                    Local0 = _ADR /* \_SB_.PCI0.SPB1._ADR */
                    Local1 = (Local0 >> 0x10)
                    Local2 = (Local1 << 0x03)
                    Local1 = (Local0 & 0x0F)
                    Local3 = (Local1 | Local2)
                    Return (Local3)
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    PCMS,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                Device (XPDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }
                }
            }

            Device (SPB2)
            {
                Name (_ADR, 0x00150002)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x08, 
                    0x04
                })
                Name (PR0C, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKC, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKB, 
                        Zero
                    }
                })
                Name (AR0C, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x12
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x11
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR0C) /* \_SB_.PCI0.SPB2.AR0C */
                    }

                    Return (PR0C) /* \_SB_.PCI0.SPB2.PR0C */
                }

                Method (XPPB, 0, NotSerialized)
                {
                    Local0 = _ADR /* \_SB_.PCI0.SPB2._ADR */
                    Local1 = (Local0 >> 0x10)
                    Local2 = (Local1 << 0x03)
                    Local1 = (Local0 & 0x0F)
                    Local3 = (Local1 | Local2)
                    Return (Local3)
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    PCMS,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                Device (XPDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }
                }
            }

            Device (SPB3)
            {
                Name (_ADR, 0x00150003)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If ((WKPM == One))
                    {
                        Return (GPRW (0x08, 0x04))
                    }
                    Else
                    {
                        Return (GPRW (0x08, Zero))
                    }
                }

                Name (PR0D, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        LNKD, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        LNKA, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        LNKB, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        LNKC, 
                        Zero
                    }
                })
                Name (AR0D, Package (0x04)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        Zero, 
                        Zero, 
                        0x13
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        One, 
                        Zero, 
                        0x10
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x02, 
                        Zero, 
                        0x11
                    }, 

                    Package (0x04)
                    {
                        0xFFFF, 
                        0x03, 
                        Zero, 
                        0x12
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR0D) /* \_SB_.PCI0.SPB3.AR0D */
                    }

                    Return (PR0D) /* \_SB_.PCI0.SPB3.PR0D */
                }

                OperationRegion (PCFG, PCI_Config, Zero, 0x20)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    DVID,   32, 
                    PCMS,   32, 
                    Offset (0x18), 
                    SBUS,   32
                }

                Device (XPDV)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (PCFG, PCI_Config, Zero, 0x08)
                    Field (PCFG, DWordAcc, NoLock, Preserve)
                    {
                        DVID,   32, 
                        PCMS,   32
                    }
                }
            }

            Device (HPET)
            {
                Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (((HPAD & 0x03) == 0x03))
                    {
                        If ((OSTB >= 0x40))
                        {
                            Return (0x0F)
                        }

                        HPAD = (HPAD & 0xFFFFFFE0)
                        Return (One)
                    }

                    Return (One)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (BUF0, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y04)
                    })
                    CreateDWordField (BUF0, \_SB.PCI0.HPET._CRS._Y04._BAS, HPEB)  // _BAS: Base Address
                    Local0 = HPAD /* \HPAD */
                    HPEB = (Local0 & 0xFFFFFC00)
                    Return (BUF0) /* \_SB_.PCI0.HPET._CRS.BUF0 */
                }
            }

            Device (AZAL)
            {
                Name (_ADR, 0x00140002)  // _ADR: Address
                OperationRegion (PCI, PCI_Config, Zero, 0x0100)
                Field (PCI, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x42), 
                    DNSP,   1, 
                    DNSO,   1, 
                    ENSR,   1
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x19, 0x03))
                }
            }

            Device (OHC1)
            {
                Name (_ADR, 0x00120000)  // _ADR: Address
                OperationRegion (O1CS, PCI_Config, 0xC4, 0x04)
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x18, 0x03))
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        If (^^LPC0.EC0.USCE)
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^SMBS.USRE = One
                        }
                        Else
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^LPC0.EC0.USCV = One
                            ^^SMBS.USRE = One
                        }
                    }
                    ElseIf (^^LPC0.EC0.USCE)
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^LPC0.EC0.USCV = Zero
                        ^^SMBS.USRE = Zero
                    }
                    Else
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^SMBS.USRE = Zero
                    }
                }
            }

            Device (OHC2)
            {
                Name (_ADR, 0x00130000)  // _ADR: Address
                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                        {
                            Buffer (0x10)
                            {
                                 0x81, 0x00, 0x30, 0x00                           /* ..0. */
                            }
                        })
                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (OHC3)
            {
                Name (_ADR, 0x00160000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x18, 0x03))
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        If (^^LPC0.EC0.USCE)
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^SMBS.USRE = One
                        }
                        Else
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^LPC0.EC0.USCV = One
                            ^^SMBS.USRE = One
                        }
                    }
                    ElseIf (^^LPC0.EC0.USCE)
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^LPC0.EC0.USCV = Zero
                        ^^SMBS.USRE = Zero
                    }
                    Else
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^SMBS.USRE = Zero
                    }
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (OHC4)
            {
                Name (_ADR, 0x00140005)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x18, 0x03))
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (0x02)
                }

                Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
                {
                    Return (0x02)
                }
            }

            Device (EHC1)
            {
                Name (_ADR, 0x00120002)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, 0xA0, 0x04)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    OSOW,   32
                }

                Method (STOS, 0, NotSerialized)
                {
                    OSOW |= 0x01000000
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x18, 0x03))
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        If (^^LPC0.EC0.USCE)
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^SMBS.USRE = One
                        }
                        Else
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^LPC0.EC0.USCV = One
                            ^^SMBS.USRE = One
                        }
                    }
                    ElseIf (^^LPC0.EC0.USCE)
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^LPC0.EC0.USCV = Zero
                        ^^SMBS.USRE = Zero
                    }
                    Else
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^SMBS.USRE = Zero
                    }
                }
            }

            Device (EHC2)
            {
                Name (_ADR, 0x00130002)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, 0xA0, 0x04)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    OSOW,   32
                }

                Method (STOS, 0, NotSerialized)
                {
                    OSOW |= 0x01000000
                }

                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                        {
                            ToPLD (
                                PLD_Revision           = 0x2,
                                PLD_IgnoreColor        = 0x1,
                                PLD_Red                = 0x0,
                                PLD_Green              = 0x0,
                                PLD_Blue               = 0x0,
                                PLD_Width              = 0x0,
                                PLD_Height             = 0x0,
                                PLD_UserVisible        = 0x0,
                                PLD_Dock               = 0x0,
                                PLD_Lid                = 0x1,
                                PLD_Panel              = "FRONT",
                                PLD_VerticalPosition   = "UPPER",
                                PLD_HorizontalPosition = "CENTER",
                                PLD_Shape              = "UNKNOWN",
                                PLD_GroupOrientation   = 0x0,
                                PLD_GroupToken         = 0x0,
                                PLD_GroupPosition      = 0x0,
                                PLD_Bay                = 0x0,
                                PLD_Ejectable          = 0x0,
                                PLD_EjectRequired      = 0x0,
                                PLD_CabinetNumber      = 0x0,
                                PLD_CardCageNumber     = 0x0,
                                PLD_Reference          = 0x0,
                                PLD_Rotation           = 0x0,
                                PLD_Order              = 0x0,
                                PLD_VerticalOffset     = 0xFFFF,
                                PLD_HorizontalOffset   = 0xFFFF)

                        })
                        Device (WCAM)
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                            {
                                ToPLD (
                                    PLD_Revision           = 0x2,
                                    PLD_IgnoreColor        = 0x1,
                                    PLD_Red                = 0x0,
                                    PLD_Green              = 0x0,
                                    PLD_Blue               = 0x0,
                                    PLD_Width              = 0x0,
                                    PLD_Height             = 0x0,
                                    PLD_UserVisible        = 0x0,
                                    PLD_Dock               = 0x0,
                                    PLD_Lid                = 0x1,
                                    PLD_Panel              = "FRONT",
                                    PLD_VerticalPosition   = "UPPER",
                                    PLD_HorizontalPosition = "CENTER",
                                    PLD_Shape              = "UNKNOWN",
                                    PLD_GroupOrientation   = 0x0,
                                    PLD_GroupToken         = 0x0,
                                    PLD_GroupPosition      = 0x0,
                                    PLD_Bay                = 0x0,
                                    PLD_Ejectable          = 0x0,
                                    PLD_EjectRequired      = 0x0,
                                    PLD_CabinetNumber      = 0x0,
                                    PLD_CardCageNumber     = 0x0,
                                    PLD_Reference          = 0x0,
                                    PLD_Rotation           = 0x0,
                                    PLD_Order              = 0x0,
                                    PLD_VerticalOffset     = 0xFFFF,
                                    PLD_HorizontalOffset   = 0xFFFF)

                            })
                        }
                    }
                }
            }

            Device (EHC3)
            {
                Name (_ADR, 0x00160002)  // _ADR: Address
                OperationRegion (PCFG, PCI_Config, 0xA0, 0x04)
                Field (PCFG, DWordAcc, NoLock, Preserve)
                {
                    OSOW,   32
                }

                Method (STOS, 0, NotSerialized)
                {
                    OSOW |= 0x01000000
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x18, 0x03))
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        If (^^LPC0.EC0.USCE)
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^SMBS.USRE = One
                        }
                        Else
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^LPC0.EC0.USCV = One
                            ^^SMBS.USRE = One
                        }
                    }
                    ElseIf (^^LPC0.EC0.USCE)
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^LPC0.EC0.USCV = Zero
                        ^^SMBS.USRE = Zero
                    }
                    Else
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^SMBS.USRE = Zero
                    }
                }
            }

            Device (XHC0)
            {
                Name (_ADR, 0x00100000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x18, 0x03))
                }

                Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                {
                    If (Arg0)
                    {
                        If (^^LPC0.EC0.USCE)
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^SMBS.USRE = One
                        }
                        Else
                        {
                            ^^LPC0.EC0.USNV = One
                            ^^LPC0.EC0.USCV = One
                            ^^SMBS.USRE = One
                        }
                    }
                    ElseIf (^^LPC0.EC0.USCE)
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^LPC0.EC0.USCV = Zero
                        ^^SMBS.USRE = Zero
                    }
                    Else
                    {
                        ^^LPC0.EC0.USNV = Zero
                        ^^SMBS.USRE = Zero
                    }
                }
            }

            Device (XHC1)
            {
                Name (_ADR, 0x00100001)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x18, 0x03))
                }
            }

            Device (SMBS)
            {
                Name (_ADR, 0x00140000)  // _ADR: Address
                OperationRegion (IRQF, PCI_Config, Zero, 0x0100)
                Field (IRQF, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x08), 
                    RVID,   8
                }

                OperationRegion (PMIO, SystemIO, 0x0CD6, 0x02)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    INPM,   8, 
                    DAPM,   8
                }

                IndexField (INPM, DAPM, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x24), 
                    MMSO,   32, 
                    Offset (0x60), 
                    P1EB,   16, 
                    Offset (0xF0), 
                        ,   3, 
                    RSTU,   1, 
                        ,   3, 
                    USRE,   1
                }

                OperationRegion (ERMM, SystemMemory, MMSO, 0x1000)
                Field (ERMM, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x105), 
                        ,   5, 
                    E006,   1, 
                    O006,   1, 
                    I006,   1, 
                        ,   5, 
                    E007,   1, 
                    O007,   1, 
                    I007,   1, 
                    Offset (0x10A), 
                        ,   5, 
                    E011,   1, 
                    O011,   1, 
                    I011,   1, 
                        ,   5, 
                    E012,   1, 
                    O012,   1, 
                    I012,   1, 
                        ,   5, 
                    E013,   1, 
                    O013,   1, 
                    I013,   1, 
                        ,   5, 
                    E014,   1, 
                    O014,   1, 
                    I014,   1, 
                        ,   5, 
                    E015,   1, 
                    O015,   1, 
                    I015,   1, 
                        ,   5, 
                    E016,   1, 
                    O016,   1, 
                    I016,   1, 
                    Offset (0x113), 
                        ,   5, 
                    E020,   1, 
                    O020,   1, 
                    I020,   1, 
                        ,   5, 
                    E021,   1, 
                    O021,   1, 
                    I021,   1, 
                    Offset (0x11A), 
                        ,   5, 
                    E027,   1, 
                    O027,   1, 
                    I027,   1, 
                        ,   5, 
                    E028,   1, 
                    O028,   1, 
                    I028,   1, 
                    Offset (0x11F), 
                        ,   5, 
                    E032,   1, 
                    O032,   1, 
                    I032,   1, 
                    Offset (0x122), 
                        ,   5, 
                    E035,   1, 
                    O035,   1, 
                    I035,   1, 
                    Offset (0x128), 
                    GP41,   8, 
                    Offset (0x12B), 
                        ,   5, 
                    E044,   1, 
                    O044,   1, 
                    I044,   1, 
                        ,   5, 
                    E045,   1, 
                    O045,   1, 
                    I045,   1, 
                    GP46,   8, 
                    Offset (0x130), 
                        ,   5, 
                    E049,   1, 
                    O049,   1, 
                    I049,   1, 
                        ,   5, 
                    E050,   1, 
                    O050,   1, 
                    I050,   1, 
                        ,   5, 
                    E051,   1, 
                    O051,   1, 
                    I051,   1, 
                    Offset (0x134), 
                        ,   5, 
                    E053,   1, 
                    O053,   1, 
                    I053,   1, 
                        ,   5, 
                    E054,   1, 
                    O054,   1, 
                    I054,   1, 
                        ,   5, 
                    E055,   1, 
                    O055,   1, 
                    I055,   1, 
                        ,   5, 
                    E056,   1, 
                    O056,   1, 
                    I056,   1, 
                        ,   5, 
                    E057,   1, 
                    O057,   1, 
                    I057,   1, 
                        ,   5, 
                    E058,   1, 
                    O058,   1, 
                    I058,   1, 
                        ,   5, 
                    E059,   1, 
                    O059,   1, 
                    I059,   1, 
                    Offset (0x13E), 
                    GP63,   8, 
                        ,   5, 
                    E064,   1, 
                    O064,   1, 
                    I064,   1, 
                    Offset (0x141), 
                    GP66,   8, 
                    Offset (0x164), 
                        ,   7, 
                    GE05,   1, 
                        ,   5, 
                    E102,   1, 
                    O102,   1, 
                    I102,   1, 
                    Offset (0x16A), 
                    GE11,   8, 
                    Offset (0x16D), 
                        ,   5, 
                    E110,   1, 
                    O110,   1, 
                    I110,   1, 
                        ,   7, 
                    GE15,   1, 
                        ,   7, 
                    GE16,   1, 
                    Offset (0x174), 
                    GE21,   8, 
                        ,   7, 
                    GE22,   1, 
                    Offset (0x1A5), 
                    GPA6,   8, 
                    Offset (0x1A9), 
                        ,   5, 
                    E170,   1, 
                    O170,   1, 
                    I170,   1, 
                        ,   5, 
                    E171,   1, 
                    O171,   1, 
                    I171,   1, 
                    Offset (0x1AE), 
                        ,   5, 
                    E175,   1, 
                    O175,   1, 
                    I175,   1, 
                        ,   5, 
                    E176,   1, 
                    O176,   1, 
                    I176,   1, 
                        ,   5, 
                    E177,   1, 
                    O177,   1, 
                    I177,   1, 
                        ,   5, 
                    E178,   1, 
                    O178,   1, 
                    I178,   1, 
                        ,   5, 
                    E179,   1, 
                    O179,   1, 
                    I179,   1, 
                        ,   5, 
                    E180,   1, 
                    O180,   1, 
                    I180,   1, 
                        ,   5, 
                    E181,   1, 
                    O181,   1, 
                    I181,   1, 
                        ,   5, 
                    E182,   1, 
                    O182,   1, 
                    I182,   1, 
                    Offset (0x1FF), 
                        ,   1, 
                    G01S,   1, 
                        ,   3, 
                    G05S,   1, 
                        ,   9, 
                    G15S,   1, 
                    G16S,   1, 
                        ,   5, 
                    G22S,   1, 
                    Offset (0x203), 
                        ,   1, 
                    G01E,   1, 
                        ,   3, 
                    G05E,   1, 
                        ,   9, 
                    G15E,   1, 
                    G16E,   1, 
                        ,   5, 
                    G22E,   1, 
                    Offset (0x207), 
                        ,   1, 
                    G01T,   1, 
                        ,   3, 
                    G05T,   1, 
                        ,   9, 
                    G15T,   1, 
                    G16T,   1, 
                        ,   5, 
                    G22T,   1, 
                    Offset (0x20B), 
                        ,   1, 
                    G01L,   1, 
                        ,   3, 
                    G05L,   1, 
                        ,   9, 
                    G15L,   1, 
                    G16L,   1, 
                        ,   5, 
                    G22L,   1, 
                    Offset (0x287), 
                        ,   1, 
                    CLPS,   1, 
                    Offset (0x298), 
                        ,   7, 
                    G15A,   1, 
                    Offset (0x2AF), 
                        ,   2, 
                    SLPS,   2, 
                    Offset (0x361), 
                        ,   6, 
                    MT3A,   1, 
                    Offset (0x376), 
                    EPNM,   1, 
                    DPPF,   1, 
                    Offset (0x3BA), 
                        ,   6, 
                    PWDE,   1, 
                    Offset (0x3BD), 
                        ,   5, 
                    ALLS,   1, 
                    Offset (0x3C7), 
                        ,   2, 
                    TFTE,   1, 
                    Offset (0x3DE), 
                    BLNK,   2, 
                    Offset (0x3EF), 
                    PHYD,   1, 
                    Offset (0x3FF), 
                    F0CT,   8, 
                    F0MS,   8, 
                    F0FQ,   8, 
                    F0LD,   8, 
                    F0MD,   8, 
                    F0MP,   8, 
                    LT0L,   8, 
                    LT0H,   8, 
                    MT0L,   8, 
                    MT0H,   8, 
                    HT0L,   8, 
                    HT0H,   8, 
                    LRG0,   8, 
                    LHC0,   8, 
                    Offset (0x40F), 
                    F1CT,   8, 
                    F1MS,   8, 
                    F1FQ,   8, 
                    F1LD,   8, 
                    F1MD,   8, 
                    F1MP,   8, 
                    LT1L,   8, 
                    LT1H,   8, 
                    MT1L,   8, 
                    MT1H,   8, 
                    HT1L,   8, 
                    HT1H,   8, 
                    LRG1,   8, 
                    LHC1,   8, 
                    Offset (0x41F), 
                    F2CT,   8, 
                    F2MS,   8, 
                    F2FQ,   8, 
                    F2LD,   8, 
                    F2MD,   8, 
                    F2MP,   8, 
                    LT2L,   8, 
                    LT2H,   8, 
                    MT2L,   8, 
                    MT2H,   8, 
                    HT2L,   8, 
                    HT2H,   8, 
                    LRG2,   8, 
                    LHC2,   8, 
                    Offset (0x42F), 
                    F3CT,   8, 
                    F3MS,   8, 
                    F3FQ,   8, 
                    F3LD,   8, 
                    F3MD,   8, 
                    F3MP,   8, 
                    LT3L,   8, 
                    LT3H,   8, 
                    MT3L,   8, 
                    MT3H,   8, 
                    HT3L,   8, 
                    HT3H,   8, 
                    LRG3,   8, 
                    LHC3,   8, 
                    Offset (0xD06), 
                    MX07,   8, 
                    Offset (0xD0E), 
                    MX15,   8, 
                    MX16,   8, 
                    Offset (0xD14), 
                    MX21,   8, 
                    Offset (0xD1A), 
                    MX27,   8, 
                    MX28,   8, 
                    Offset (0xD1F), 
                    MX32,   8, 
                    Offset (0xD2B), 
                    MX44,   8, 
                    Offset (0xD30), 
                    MX49,   8, 
                    Offset (0xD34), 
                    MX53,   8, 
                    Offset (0xD38), 
                    MX57,   8, 
                    MX58,   8, 
                    MX59,   8, 
                    Offset (0xD41), 
                    MX66,   8, 
                    Offset (0xD65), 
                    M102,   8, 
                    Offset (0xD6D), 
                    M110,   8, 
                    Offset (0xDAE), 
                    M175,   8, 
                    M176,   8, 
                    Offset (0xDB3), 
                    M180,   8, 
                    Offset (0xDB5), 
                    M182,   8, 
                    Offset (0xE01), 
                    MS02,   8, 
                    MS03,   8, 
                    MS04,   8, 
                    Offset (0xE3F), 
                    MS40,   8, 
                    Offset (0xE80), 
                        ,   2, 
                    ECES,   1
                }

                OperationRegion (ERM1, SystemMemory, MMSO, 0x1000)
                Field (ERM1, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x100), 
                        ,   5, 
                    P01E,   1, 
                    P01O,   1, 
                    P01I,   1, 
                    Offset (0x105), 
                        ,   5, 
                    P06E,   1, 
                    P06O,   1, 
                    P06I,   1, 
                        ,   5, 
                    P07E,   1, 
                    P07O,   1, 
                    P07I,   1, 
                    Offset (0x10A), 
                        ,   5, 
                    P0BE,   1, 
                    P0BO,   1, 
                    P0BI,   1, 
                        ,   5, 
                    P0CE,   1, 
                    P0CO,   1, 
                    P0CI,   1, 
                        ,   5, 
                    P0DE,   1, 
                    P0DO,   1, 
                    P0DI,   1, 
                        ,   5, 
                    P0EE,   1, 
                    P0EO,   1, 
                    P0EI,   1, 
                        ,   5, 
                    P0FE,   1, 
                    P0FO,   1, 
                    P0FI,   1, 
                        ,   5, 
                    P10E,   1, 
                    P10O,   1, 
                    P10I,   1, 
                    Offset (0x113), 
                        ,   5, 
                    P14E,   1, 
                    P14O,   1, 
                    P14I,   1, 
                        ,   5, 
                    P15E,   1, 
                    P15O,   1, 
                    P15I,   1, 
                    Offset (0x11A), 
                        ,   5, 
                    P1BE,   1, 
                    P1BO,   1, 
                    P1BI,   1, 
                    Offset (0x11F), 
                        ,   5, 
                    P20E,   1, 
                    P20O,   1, 
                    P20I,   1, 
                        ,   5, 
                    P21E,   1, 
                    P21O,   1, 
                    P21I,   1, 
                        ,   5, 
                    P22E,   1, 
                    P22O,   1, 
                    P22I,   1, 
                        ,   5, 
                    P23E,   1, 
                    P23O,   1, 
                    P23I,   1, 
                    Offset (0x128), 
                        ,   5, 
                    P29E,   1, 
                    P29O,   1, 
                    P29I,   1, 
                    Offset (0x12B), 
                        ,   5, 
                    P2CE,   1, 
                    P2CO,   1, 
                    P2CI,   1, 
                        ,   5, 
                    P2DE,   1, 
                    P2DO,   1, 
                    P2DI,   1, 
                    PO2E,   8, 
                    Offset (0x132), 
                        ,   5, 
                    P33E,   1, 
                    P33O,   1, 
                    P33I,   1, 
                    Offset (0x134), 
                        ,   5, 
                    P35E,   1, 
                    P35O,   1, 
                    P35I,   1, 
                    Offset (0x136), 
                        ,   5, 
                    P37E,   1, 
                    P37O,   1, 
                    P37I,   1, 
                    Offset (0x138), 
                        ,   5, 
                    P39E,   1, 
                    P39O,   1, 
                    P39I,   1, 
                    Offset (0x13A), 
                        ,   5, 
                    P3BE,   1, 
                    P3BO,   1, 
                    P3BI,   1, 
                    Offset (0x13C), 
                    PO3D,   8, 
                    PO3E,   8, 
                    PO3F,   8, 
                    PO40,   8, 
                    Offset (0x164), 
                        ,   7, 
                    Offset (0x165), 
                        ,   5, 
                    P66E,   1, 
                    P66O,   1, 
                    P66I,   1, 
                    Offset (0x16A), 
                    Offset (0x16B), 
                        ,   5, 
                    P6CE,   1, 
                    P6CO,   1, 
                    P6CI,   1, 
                    Offset (0x16E), 
                        ,   7, 
                    Offset (0x16F), 
                        ,   7, 
                    Offset (0x170), 
                    Offset (0x174), 
                    Offset (0x175), 
                        ,   7, 
                    Offset (0x176), 
                    Offset (0x1A5), 
                    POA6,   8, 
                    Offset (0x1A9), 
                        ,   5, 
                    PAAE,   1, 
                    PAAO,   1, 
                    PAAI,   1, 
                    Offset (0x1AE), 
                        ,   5, 
                    PAFE,   1, 
                    PAFO,   1, 
                    PAFI,   1, 
                        ,   5, 
                    PB0E,   1, 
                    PB0O,   1, 
                    PB0I,   1, 
                        ,   5, 
                    PB1E,   1, 
                    PB1O,   1, 
                    PB1I,   1, 
                        ,   5, 
                    PB2E,   1, 
                    PB2O,   1, 
                    PB2I,   1, 
                        ,   5, 
                    PB3E,   1, 
                    PB3O,   1, 
                    PB3I,   1, 
                        ,   5, 
                    PB4E,   1, 
                    PB4O,   1, 
                    PB4I,   1, 
                        ,   5, 
                    PB5E,   1, 
                    PB5O,   1, 
                    PB5I,   1, 
                        ,   5, 
                    PB6E,   1, 
                    PB6O,   1, 
                    PB6I,   1, 
                    Offset (0x1C6), 
                        ,   5, 
                    PC7E,   1, 
                    PC7O,   1, 
                    PC7I,   1, 
                        ,   5, 
                    PC8E,   1, 
                    PC8O,   1, 
                    PC8I,   1, 
                    Offset (0x207), 
                        ,   1, 
                        ,   1, 
                        ,   3, 
                        ,   1, 
                        ,   9, 
                    Offset (0x209), 
                        ,   1, 
                        ,   5, 
                        ,   1, 
                        ,   3, 
                    E26C,   1, 
                    Offset (0xD00), 
                    MX01,   8, 
                    Offset (0xD1F), 
                    Offset (0xD20), 
                    MX33,   8, 
                    MX34,   8, 
                    Offset (0xD28), 
                    MX41,   8, 
                    Offset (0xDA9), 
                    M170,   8, 
                    Offset (0xDB3), 
                    Offset (0xDB4), 
                    M181,   8, 
                    Offset (0xDB6), 
                    Offset (0xDC6), 
                    M199,   8, 
                    Offset (0xDFF), 
                    MS00,   8, 
                    MS01,   8
                }

                Mutex (SBX0, 0x00)
                OperationRegion (SMB0, SystemIO, 0x0B00, 0x10)
                Field (SMB0, ByteAcc, NoLock, Preserve)
                {
                    HST0,   8, 
                    SLV0,   8, 
                    CNT0,   8, 
                    CMD0,   8, 
                    ADD0,   8, 
                    DT00,   8, 
                    DT10,   8, 
                    BLK0,   8
                }

                Method (WBD0, 1, NotSerialized)
                {
                    Local0 = Arg0
                    Local2 = Zero
                    Local3 = HST0 /* \_SB_.PCI0.SMBS.HST0 */
                    Local1 = (Local3 & 0x80)
                    While ((Local1 != 0x80))
                    {
                        If ((Local0 < 0x0A))
                        {
                            Local2 = 0x18
                            Local1 = Zero
                        }
                        Else
                        {
                            Sleep (0x0A)
                            Local0 -= 0x0A
                            Local3 = HST0 /* \_SB_.PCI0.SMBS.HST0 */
                            Local1 = (Local3 & 0x80)
                        }
                    }

                    If ((Local2 != 0x18))
                    {
                        Local1 = (HST0 & 0x1C)
                        If (Local1)
                        {
                            Local2 = 0x07
                        }
                    }

                    Return (Local2)
                }

                Method (WTC0, 1, NotSerialized)
                {
                    Local0 = Arg0
                    Local2 = 0x07
                    Local1 = One
                    While ((Local1 == One))
                    {
                        Local3 = (HST0 & 0x1D)
                        If ((Local3 != Zero))
                        {
                            If ((Local3 == One))
                            {
                                If ((Local0 < 0x0A))
                                {
                                    Local2 = 0x18
                                    Local1 = Zero
                                }
                                Else
                                {
                                    Sleep (0x0A)
                                    Local0 -= 0x0A
                                }
                            }
                            Else
                            {
                                Local2 = 0x07
                                Local1 = Zero
                            }
                        }
                        Else
                        {
                            Local2 = Zero
                            Local1 = Zero
                        }
                    }

                    HST0 = (HST0 | 0x1F)
                    Return (Local2)
                }

                Method (SBR0, 3, NotSerialized)
                {
                    Local0 = Package (0x03)
                        {
                            0x07, 
                            Zero, 
                            Zero
                        }
                    Local4 = (Arg0 & 0x5F)
                    If ((Local4 != 0x03))
                    {
                        If ((Local4 != 0x05))
                        {
                            If ((Local4 != 0x07))
                            {
                                If ((Local4 != 0x09))
                                {
                                    If ((Local4 != 0x0B))
                                    {
                                        Local0 [Zero] = 0x19
                                        Return (Local0)
                                    }
                                }
                            }
                        }
                    }

                    If ((Acquire (SBX0, 0xFFFF) == Zero))
                    {
                        ADD0 = ((Arg1 << One) | One)
                        CMD0 = Arg2
                        HST0 = (HST0 | 0x1F)
                        Local1 = (Arg0 & 0xA0)
                        CNT0 = ((CNT0 & 0x5F) | Local1)
                        If ((Local4 == 0x03))
                        {
                            CNT0 = ((CNT0 & 0xA0) | 0x40)
                        }

                        If ((Local4 == 0x05))
                        {
                            CNT0 = ((CNT0 & 0xA0) | 0x44)
                        }

                        If ((Local4 == 0x07))
                        {
                            CNT0 = ((CNT0 & 0xA0) | 0x48)
                        }

                        If ((Local4 == 0x09))
                        {
                            CNT0 = ((CNT0 & 0xA0) | 0x4C)
                        }

                        If ((Local4 == 0x0B))
                        {
                            HST0 = (HST0 | 0x80)
                            DT00 = Zero
                            CNT0 = ((CNT0 & 0xA0) | 0x54)
                        }

                        Local1 = WTC0 (0x03E8)
                        Local0 [Zero] = Local1
                        If ((Local1 == Zero))
                        {
                            If ((Local4 == 0x05))
                            {
                                Local0 [One] = One
                                Local0 [0x02] = DT00 /* \_SB_.PCI0.SMBS.DT00 */
                            }

                            If ((Local4 == 0x07))
                            {
                                Local0 [One] = One
                                Local0 [0x02] = DT00 /* \_SB_.PCI0.SMBS.DT00 */
                            }

                            If ((Local4 == 0x09))
                            {
                                Local0 [One] = 0x02
                                Local2 = DT10 /* \_SB_.PCI0.SMBS.DT10 */
                                Local2 <<= 0x08
                                Local2 += DT00 /* \_SB_.PCI0.SMBS.DT00 */
                                Local0 [0x02] = Local2
                            }

                            If ((Local4 == 0x0B))
                            {
                                Local1 = WBD0 (0x01F4)
                                If ((Local1 != Zero))
                                {
                                    Local0 [Zero] = Local1
                                }
                                Else
                                {
                                    Local0 [One] = DT00 /* \_SB_.PCI0.SMBS.DT00 */
                                    Local1 = DT00 /* \_SB_.PCI0.SMBS.DT00 */
                                    Local2 = CNT0 /* \_SB_.PCI0.SMBS.CNT0 */
                                    Local2 = Zero
                                    While ((Local2 < Local1))
                                    {
                                        Local3 = (0x02 + Local2)
                                        Local0 [Local3] = BLK0 /* \_SB_.PCI0.SMBS.BLK0 */
                                        Local2 += One
                                    }

                                    HST0 = (HST0 | 0x80)
                                }
                            }
                        }

                        CNT0 = (CNT0 & 0x5F)
                        Release (SBX0)
                    }

                    Return (Local0)
                }

                Method (SBW0, 5, NotSerialized)
                {
                    Local0 = Package (0x01)
                        {
                            0x07
                        }
                    Local4 = (Arg0 & 0x5F)
                    If ((Local4 != 0x02))
                    {
                        If ((Local4 != 0x04))
                        {
                            If ((Local4 != 0x06))
                            {
                                If ((Local4 != 0x08))
                                {
                                    If ((Local4 != 0x0A))
                                    {
                                        Local0 [Zero] = 0x19
                                        Return (Local0)
                                    }
                                }
                            }
                        }
                    }

                    If ((Acquire (SBX0, 0xFFFF) == Zero))
                    {
                        ADD0 = (Arg1 << One)
                        CMD0 = Arg2
                        HST0 = (HST0 | 0x1F)
                        Local1 = (Arg0 & 0xA0)
                        CNT0 = ((CNT0 & 0x5F) | Local1)
                        If ((Local4 == 0x02))
                        {
                            CNT0 = ((CNT0 & 0xA0) | 0x40)
                        }

                        If ((Local4 == 0x04))
                        {
                            CNT0 = ((CNT0 & 0xA0) | 0x44)
                        }

                        If ((Local4 == 0x06))
                        {
                            DT00 = Arg4
                            CNT0 = ((CNT0 & 0xA0) | 0x48)
                        }

                        If ((Local4 == 0x08))
                        {
                            DT00 = (Arg4 & 0xFF)
                            DT10 = (Arg4 >> 0x08)
                            CNT0 = ((CNT0 & 0xA0) | 0x4C)
                        }

                        If ((Local4 == 0x0A))
                        {
                            HST0 = (HST0 | 0x80)
                            Local1 = CNT0 /* \_SB_.PCI0.SMBS.CNT0 */
                            DT00 = Arg3
                            Local2 = Zero
                            While ((Local2 < Arg3))
                            {
                                BLK0 = Arg4 [Local2]
                                Local2 += One
                            }

                            CNT0 = ((CNT0 & 0xA0) | 0x54)
                        }

                        Local0 [Zero] = WTC0 (0x03E8)
                        CNT0 = (CNT0 & 0x5F)
                        Release (SBX0)
                    }

                    Return (Local0)
                }
            }

            Device (LPC0)
            {
                Name (_ADR, 0x00140003)  // _ADR: Address
                Mutex (PSMX, 0x00)
                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x0F,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x0F,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000") /* 8259-compatible Programmable Interrupt Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (((HPAD & 0x03) == 0x03))
                        {
                            Return (BUF0) /* \_SB_.PCI0.LPC0.RTC_.BUF0 */
                        }

                        Return (BUF1) /* \_SB_.PCI0.LPC0.RTC_.BUF1 */
                    }
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800") /* Microsoft Sound System Compatible Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Name (BUF1, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (((HPAD & 0x03) == 0x03))
                        {
                            Return (BUF0) /* \_SB_.PCI0.LPC0.TMR_.BUF0 */
                        }

                        Return (BUF1) /* \_SB_.PCI0.LPC0.TMR_.BUF1 */
                    }
                }

                Device (KBC0)
                {
                    Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((MYOS != 0x07DC))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }

                Device (KBC1)
                {
                    Name (_HID, EisaId ("TOS1102"))  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _CID: Compatible ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((MYOS == 0x07DC))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }

                Device (MSE0)
                {
                    Name (_HID, EisaId ("TOS0310"))  // _HID: Hardware ID
                    Name (_CID, Package (0x03)  // _CID: Compatible ID
                    {
                        EisaId ("SYN1000"), 
                        EisaId ("SYN0002"), 
                        EisaId ("PNP0F13") /* PS/2 Mouse */
                    })
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }
                }

                Device (SYSR)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x01,               // Alignment
                            0xD0,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D6,             // Range Minimum
                            0x04D6,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0550,             // Range Minimum
                            0x0550,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0680,             // Range Minimum
                            0x0680,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x077A,             // Range Minimum
                            0x077A,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C00,             // Range Minimum
                            0x0C00,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0C14,             // Range Minimum
                            0x0C14,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C50,             // Range Minimum
                            0x0C50,             // Range Maximum
                            0x01,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0C6C,             // Range Minimum
                            0x0C6C,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0C6F,             // Range Minimum
                            0x0C6F,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0CD0,             // Range Minimum
                            0x0CD0,             // Range Maximum
                            0x01,               // Alignment
                            0x0C,               // Length
                            )
                        IO (Decode16,
                            0x0840,             // Range Minimum
                            0x0840,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                    })
                }

                Device (MEM)
                {
                    Name (_HID, EisaId ("PNP0C01") /* System Board */)  // _HID: Hardware ID
                    Name (MSRC, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x000E0000,         // Address Base
                            0x00020000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFFF00000,         // Address Base
                            0x00100000,         // Address Length
                            _Y05)
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        CreateDWordField (MSRC, \_SB.PCI0.LPC0.MEM._Y05._LEN, PSIZ)  // _LEN: Length
                        CreateDWordField (MSRC, \_SB.PCI0.LPC0.MEM._Y05._BAS, PBAS)  // _BAS: Base Address
                        PSIZ = ROMS /* \ROMS */
                        Local0 = (ROMS - One)
                        PBAS = (Ones - Local0)
                        Return (MSRC) /* \_SB_.PCI0.LPC0.MEM_.MSRC */
                    }
                }

                Scope (\_SB)
                {
                    OperationRegion (EMEM, SystemMemory, 0xFF808001, 0x013F)
                    Field (EMEM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1A), 
                        MBMN,   80, 
                        MBPN,   96, 
                        GPB1,   8, 
                        GPB2,   8, 
                        GPB3,   8, 
                        GPB4,   8, 
                        GPB5,   8, 
                        GPB6,   8, 
                        GPB7,   8, 
                        GPB8,   8, 
                        MAXS,   8, 
                        Offset (0x3D), 
                        SMAA,   8, 
                        Offset (0x40), 
                        ACDF,   1, 
                            ,   1, 
                        PFLG,   1, 
                        Offset (0x41), 
                            ,   4, 
                        FPR1,   1, 
                        FLS4,   1, 
                        S5LW,   1, 
                        Offset (0x42), 
                        Offset (0x43), 
                        TMSS,   2, 
                            ,   2, 
                        BANK,   3, 
                        WLID,   1, 
                            ,   2, 
                        HPCF,   1, 
                        USCE,   1, 
                        FLS3,   1, 
                            ,   1, 
                        PWBT,   1, 
                        WLS5,   1, 
                        CBTA,   1, 
                            ,   1, 
                            ,   1, 
                        PSS5,   1, 
                            ,   3, 
                        HEBC,   1, 
                        RL01,   1, 
                        RD01,   1, 
                        RF01,   1, 
                        RP01,   1, 
                        RB01,   1, 
                        RC01,   1, 
                            ,   1, 
                        R701,   1, 
                        R801,   1, 
                        RM01,   1, 
                        RI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA01,   1, 
                        RR01,   1, 
                        RL10,   1, 
                        RD10,   1, 
                        RF10,   1, 
                        RP10,   1, 
                        RB10,   1, 
                        RC10,   1, 
                            ,   1, 
                        R710,   1, 
                        LLED,   1, 
                        RM10,   1, 
                        RI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        FBES,   1, 
                        ECOF,   1, 
                            ,   1, 
                        BAYE,   1, 
                        PRDE,   1, 
                        WP01,   1, 
                        WB01,   1, 
                        WC01,   1, 
                            ,   1, 
                        W701,   1, 
                        W801,   1, 
                        WM01,   1, 
                        WI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA01,   1, 
                        WR01,   1, 
                            ,   1, 
                        BAYI,   1, 
                        PRCT,   1, 
                        WP10,   1, 
                        WB10,   1, 
                        DSPL,   1, 
                        LIDS,   1, 
                        W710,   1, 
                        W810,   1, 
                        WM10,   1, 
                        WI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA10,   1, 
                        WR10,   1, 
                        Offset (0x50), 
                        SLPM,   3, 
                            ,   2, 
                        POLG,   1, 
                        HSFG,   1, 
                        Offset (0x51), 
                        BLVL,   8, 
                        SLPL,   8, 
                        DOFF,   8, 
                        Offset (0x57), 
                        RG57,   8, 
                        CTMP,   8, 
                        RG59,   8, 
                        FSP2,   16, 
                        FSPD,   16, 
                        Offset (0x60), 
                        WLAN,   1, 
                        BLTH,   1, 
                        CPLE,   1, 
                        KSWH,   1, 
                            ,   2, 
                        RFST,   1, 
                        BTHE,   1, 
                        TPAD,   1, 
                            ,   1, 
                        WN3G,   1, 
                        USBP,   1, 
                            ,   1, 
                        W3GE,   1, 
                        Offset (0x64), 
                            ,   5, 
                        UMGA,   1, 
                        Offset (0x70), 
                        BTMD,   8, 
                        MBTS,   1, 
                        MBTF,   1, 
                        Offset (0x72), 
                            ,   1, 
                            ,   2, 
                        LION,   1, 
                            ,   1, 
                        MBTC,   1, 
                        Offset (0x74), 
                            ,   3, 
                        BA3C,   1, 
                            ,   1, 
                        FKME,   1, 
                        Offset (0x75), 
                        BATS,   16, 
                        BA1C,   8, 
                        MCLC,   8, 
                        Offset (0x7A), 
                        MTEM,   16, 
                        MBMD,   16, 
                        MCUR,   16, 
                        MBRM,   16, 
                        MBVG,   16, 
                        Offset (0x87), 
                        BA2C,   8, 
                        LFCC,   16, 
                        BTSN,   16, 
                        BTDC,   16, 
                        BTDV,   16, 
                        BTMN,   8, 
                        Offset (0x93), 
                        BTST,   8, 
                        Offset (0xA0), 
                        HDX1,   16, 
                        HDY1,   16, 
                        HDZ1,   16, 
                        HDX2,   16, 
                        HDY2,   16, 
                        HDZ2,   16, 
                        HDX3,   16, 
                        HDY3,   16, 
                        HDZ3,   16, 
                        HDX4,   16, 
                        HDY4,   16, 
                        HDZ4,   16, 
                        Offset (0xB9), 
                        EXCC,   8, 
                        PPBC,   8, 
                        RFSC,   8, 
                        ACAC,   8, 
                        BTCC,   8, 
                        PAOC,   8, 
                        FPOC,   8, 
                        VOLC,   8, 
                        Offset (0xC3), 
                        EPFE,   8, 
                        EPFF,   8, 
                        PWM1,   8, 
                        PWM2,   8, 
                        ACVO,   8, 
                        ACCU,   16, 
                        ACCA,   8, 
                        REFT,   8, 
                        Offset (0xCE), 
                        PECL,   1, 
                        PECB,   1, 
                        PECC,   1, 
                        Offset (0xD0), 
                        EBPL,   1, 
                            ,   1, 
                        USCV,   1, 
                            ,   2, 
                        USNV,   1, 
                        IESQ,   1, 
                        Offset (0xD1), 
                        PWRE,   1, 
                        LPWR,   1, 
                        Offset (0xD2), 
                            ,   6, 
                        VAUX,   1, 
                        TMOD,   1, 
                        Offset (0xD4), 
                        S3WT,   1, 
                            ,   3, 
                        WS3W,   1, 
                        Offset (0xD6), 
                        DBPL,   8, 
                        Offset (0xDE), 
                        PLID,   8, 
                        Offset (0xE0), 
                        CSV1,   16, 
                        CSV2,   16, 
                        CSV3,   16, 
                        CSV4,   16, 
                        CTTO,   8, 
                        CTTB,   8, 
                        DE4L,   8, 
                        DE4H,   8, 
                        DE5L,   8, 
                        DE5H,   8, 
                        Offset (0xEF), 
                        DALB,   8, 
                        OSTP,   1, 
                        CIRF,   1, 
                            ,   4, 
                        HEUE,   1, 
                        BEUE,   1, 
                        MBEV,   8, 
                        VEVT,   16, 
                        FEVT,   16, 
                        NEVT,   16, 
                        OSW8,   1, 
                        Offset (0xF9), 
                        Offset (0x110), 
                        PSST,   16, 
                        PSET,   16, 
                        STRO,   16, 
                        ETRO,   16, 
                        Offset (0x11A), 
                        PSRO,   8, 
                        Offset (0x120), 
                        BLV0,   8, 
                        BLV1,   8, 
                        BLV2,   8, 
                        BLV3,   8, 
                        BLV4,   8, 
                        BLV5,   8, 
                        BLV6,   8, 
                        BLV7,   8
                    }
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Name (_GPE, 0x03)  // _GPE: General Purpose Events
                    Name (SEL0, 0xF0)
                    Name (BFLG, Zero)
                    Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                    {
                        If ((Arg0 == 0x03))
                        {
                            Local0 = Arg1
                            If (Local0)
                            {
                                ECOK = One
                            }
                            Else
                            {
                                ECOK = Zero
                            }
                        }

                        If (ECOK)
                        {
                            Acquire (MUT1, 0xFFFF)
                            If ((TPOS >= 0x40))
                            {
                                If ((TPOS == 0x80))
                                {
                                    OSTP = Zero
                                }
                                Else
                                {
                                    OSTP = One
                                }

                                If ((MYOS == 0x07DC))
                                {
                                    OSW8 = One
                                }
                                Else
                                {
                                    OSW8 = Zero
                                }
                            }
                            Else
                            {
                                OSTP = Zero
                            }

                            RG59 = 0x03
                            BLTH = BTEN /* \BTEN */
                            WLAN = \WLAN
                            CPLE = One
                            Release (MUT1)
                        }

                        If ((CPUD == Zero))
                        {
                            \_PR.C000._PPC = Zero
                            Notify (\_PR.C000, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                            \_PR.C001._PPC = Zero
                            Notify (\_PR.C001, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                            \_PR.C002._PPC = Zero
                            Notify (\_PR.C002, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                            \_PR.C003._PPC = Zero
                            Notify (\_PR.C003, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                        }
                        Else
                        {
                            \_PR.C000._PPC = 0x04
                            Notify (\_PR.C000, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                            \_PR.C001._PPC = 0x04
                            Notify (\_PR.C001, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                            \_PR.C002._PPC = 0x04
                            Notify (\_PR.C002, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                            \_PR.C003._PPC = 0x04
                            Notify (\_PR.C003, 0x80) // Performance Capability Change
                            Sleep (0x0A)
                        }
                    }

                    OperationRegion (ERAM, EmbeddedControl, Zero, 0xFF)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x04), 
                        CMCM,   8, 
                        CMD1,   8, 
                        CMD2,   8, 
                        CMD3,   8, 
                        Offset (0x18), 
                        SMPR,   8, 
                        SMST,   8, 
                        MBMN,   80, 
                        MBPN,   96, 
                        GPB1,   8, 
                        GPB2,   8, 
                        GPB3,   8, 
                        GPB4,   8, 
                        GPB5,   8, 
                        GPB6,   8, 
                        GPB7,   8, 
                        GPB8,   8, 
                        MAXS,   8, 
                        Offset (0x3D), 
                        SMAA,   8, 
                        Offset (0x40), 
                        ACDF,   1, 
                            ,   1, 
                        PFLG,   1, 
                        Offset (0x41), 
                            ,   4, 
                        FPR1,   1, 
                        FLS4,   1, 
                        S5LW,   1, 
                        Offset (0x42), 
                        Offset (0x43), 
                        TMSS,   2, 
                            ,   2, 
                        BANK,   3, 
                        WLID,   1, 
                            ,   2, 
                        HPCF,   1, 
                        USCE,   1, 
                        FLS3,   1, 
                            ,   1, 
                        PWBT,   1, 
                        WLS5,   1, 
                        CBTA,   1, 
                            ,   1, 
                            ,   1, 
                        PSS5,   1, 
                        Offset (0x46), 
                        RL01,   1, 
                        RD01,   1, 
                        RF01,   1, 
                        RP01,   1, 
                        RB01,   1, 
                        RC01,   1, 
                            ,   1, 
                        R701,   1, 
                        R801,   1, 
                        RM01,   1, 
                        RI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA01,   1, 
                        RR01,   1, 
                        RL10,   1, 
                        RD10,   1, 
                        RF10,   1, 
                        RP10,   1, 
                        RB10,   1, 
                        RC10,   1, 
                            ,   1, 
                        R710,   1, 
                        LLED,   1, 
                        RM10,   1, 
                        RI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        FBES,   1, 
                        ECOF,   1, 
                            ,   1, 
                        BAYE,   1, 
                        PRDE,   1, 
                        WP01,   1, 
                        WB01,   1, 
                        WC01,   1, 
                            ,   1, 
                        W701,   1, 
                        W801,   1, 
                        WM01,   1, 
                        WI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA01,   1, 
                        WR01,   1, 
                            ,   1, 
                        BAYI,   1, 
                        PRCT,   1, 
                        WP10,   1, 
                        WB10,   1, 
                        DSPL,   1, 
                        LIDS,   1, 
                        W710,   1, 
                        W810,   1, 
                        WM10,   1, 
                        WI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA10,   1, 
                        WR10,   1, 
                        Offset (0x50), 
                        SLPM,   3, 
                            ,   2, 
                        POLG,   1, 
                        HSFG,   1, 
                        Offset (0x51), 
                        BLVL,   8, 
                        SLPL,   8, 
                        DOFF,   8, 
                        Offset (0x57), 
                        RG57,   8, 
                        CTMP,   8, 
                        RG59,   8, 
                        FSP2,   16, 
                        FSPD,   16, 
                        Offset (0x60), 
                        WLAN,   1, 
                        BLTH,   1, 
                        CPLE,   1, 
                        KSWH,   1, 
                            ,   2, 
                        RFST,   1, 
                        BTHE,   1, 
                        TPAD,   1, 
                            ,   1, 
                        WN3G,   1, 
                        USBP,   1, 
                            ,   1, 
                        W3GE,   1, 
                        Offset (0x63), 
                            ,   7, 
                        VGAF,   1, 
                            ,   5, 
                        UMGA,   1, 
                        Offset (0x65), 
                            ,   1, 
                            ,   1, 
                        Offset (0x70), 
                        BTMD,   8, 
                        MBTS,   1, 
                        MBTF,   1, 
                        Offset (0x72), 
                            ,   1, 
                            ,   2, 
                            ,   1, 
                            ,   1, 
                        MBTC,   1, 
                        LION,   1, 
                        Offset (0x74), 
                            ,   3, 
                        BA3C,   1, 
                            ,   1, 
                        FKME,   1, 
                        Offset (0x75), 
                        BATS,   16, 
                        BA1C,   8, 
                        MCLC,   8, 
                        Offset (0x7A), 
                        MTEM,   16, 
                        MBMD,   16, 
                        MCUR,   16, 
                        MBRM,   16, 
                        MBVG,   16, 
                        Offset (0x87), 
                        BA2C,   8, 
                        LFCC,   16, 
                        BTSN,   16, 
                        BTDC,   16, 
                        BTDV,   16, 
                        BTMN,   8, 
                        Offset (0x93), 
                        BTST,   8, 
                        Offset (0xA0), 
                        HDX1,   16, 
                        HDY1,   16, 
                        HDZ1,   16, 
                        HDX2,   16, 
                        HDY2,   16, 
                        HDZ2,   16, 
                        HDX3,   16, 
                        HDY3,   16, 
                        HDZ3,   16, 
                        HDX4,   16, 
                        HDY4,   16, 
                        HDZ4,   16, 
                        Offset (0xB9), 
                        EXCC,   8, 
                        PPBC,   8, 
                        RFSC,   8, 
                        ACAC,   8, 
                        BTCC,   8, 
                        PAOC,   8, 
                        FPOC,   8, 
                        VOLC,   8, 
                        Offset (0xC3), 
                        EPFE,   8, 
                        EPFF,   8, 
                        PWM1,   8, 
                        PWM2,   8, 
                        ACVO,   8, 
                        ACCU,   16, 
                        ACCA,   8, 
                        REFT,   8, 
                        Offset (0xCE), 
                        PECL,   1, 
                        PECB,   1, 
                        PECC,   1, 
                        Offset (0xD0), 
                        EBPL,   1, 
                            ,   1, 
                        USCV,   1, 
                            ,   2, 
                        USNV,   1, 
                        IESQ,   1, 
                        Offset (0xD1), 
                        PWRE,   1, 
                        LPWR,   1, 
                        Offset (0xD2), 
                            ,   6, 
                        VAUX,   1, 
                        TMOD,   1, 
                        Offset (0xD4), 
                        S3WT,   1, 
                            ,   3, 
                        WS3W,   1, 
                        Offset (0xD6), 
                        DBPL,   8, 
                        Offset (0xDE), 
                        PLID,   8, 
                        Offset (0xE0), 
                        CSV1,   16, 
                        CSV2,   16, 
                        CSV3,   16, 
                        CSV4,   16, 
                        CTTO,   8, 
                        CTTB,   8, 
                        DE4L,   8, 
                        DE4H,   8, 
                        DE5L,   8, 
                        DE5H,   8, 
                        Offset (0xEF), 
                        DALB,   8, 
                        OSTP,   1, 
                        CIRF,   1, 
                            ,   4, 
                        HEUE,   1, 
                        BEUE,   1, 
                        MBEV,   8, 
                        VEVT,   16, 
                        FEVT,   16, 
                        NEVT,   16, 
                        OSW8,   1, 
                        Offset (0xF9)
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        SMW0,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        SMB0,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD0,   64
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD1,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD2,   192
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD3,   256
                    }

                    Mutex (MUT1, 0x00)
                    Mutex (MUT0, 0x00)
                    Method (APOL, 1, NotSerialized)
                    {
                        DBPL = Arg0
                        EBPL = One
                    }

                    Name (PSTA, Zero)
                    Method (CPOL, 1, NotSerialized)
                    {
                        If ((PSTA == Zero))
                        {
                            If ((ECOK != Zero))
                            {
                                APOL (Arg0)
                                PSTA = One
                            }
                        }
                    }

                    Method (_Q20, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x20
                        If (ECOK)
                        {
                            Acquire (MUT1, 0xFFFF)
                            If ((SMST & 0x40))
                            {
                                Local0 = SMAA /* \_SB_.PCI0.LPC0.EC0_.SMAA */
                                If ((Local0 == 0x14))
                                {
                                    SMST &= 0xBF
                                    Local1 = PWRE /* \_SB_.PCI0.LPC0.EC0_.PWRE */
                                    If (Local1)
                                    {
                                        PWRE = Zero
                                        BFLG = 0x12
                                        CPOL (One)
                                    }
                                }

                                If ((Local0 == 0x16))
                                {
                                    SMST &= 0xBF
                                    ^^^^BAT1.BCRI = 0x04
                                    Notify (BAT1, 0x80) // Status Change
                                }
                                Else
                                {
                                    ^^^^BAT1.BCRI = Zero
                                }
                            }

                            Release (MUT1)
                            If (^^^^ACDF)
                            {
                                P80H = 0xAC
                                Sleep (0x64)
                                If ((CPUD == Zero))
                                {
                                    If (INP4)
                                    {
                                        \_PR.C000._PPC = Zero
                                        Notify (\_PR.C000, 0x80) // Performance Capability Change
                                        Sleep (0x0A)
                                        \_PR.C001._PPC = Zero
                                        Notify (\_PR.C001, 0x80) // Performance Capability Change
                                        Sleep (0x0A)
                                        \_PR.C002._PPC = Zero
                                        Notify (\_PR.C002, 0x80) // Performance Capability Change
                                        Sleep (0x0A)
                                        \_PR.C003._PPC = Zero
                                        Notify (\_PR.C003, 0x80) // Performance Capability Change
                                        Sleep (0x0A)
                                        INP4 = Zero
                                        Local0 = \_PR.C000._PPC /* External reference */
                                        P80H = Local0
                                        Sleep (0x64)
                                    }
                                }
                                Else
                                {
                                    \_PR.C000._PPC = 0x04
                                    Notify (\_PR.C000, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                    \_PR.C001._PPC = 0x04
                                    Notify (\_PR.C001, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                    \_PR.C002._PPC = 0x04
                                    Notify (\_PR.C002, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                    \_PR.C003._PPC = 0x04
                                    Notify (\_PR.C003, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                    Local0 = \_PR.C000._PPC /* External reference */
                                    P80H = Local0
                                    Sleep (0x0A)
                                }
                            }
                            Else
                            {
                                P80H = 0xDC
                                Sleep (0x64)
                                If ((CPUD == One))
                                {
                                    \_PR.C000._PPC = 0x04
                                    Notify (\_PR.C000, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                    \_PR.C001._PPC = 0x04
                                    Notify (\_PR.C001, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                    \_PR.C002._PPC = 0x04
                                    Notify (\_PR.C002, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                    \_PR.C003._PPC = 0x04
                                    Notify (\_PR.C003, 0x80) // Performance Capability Change
                                    Sleep (0x0A)
                                }

                                Local0 = \_PR.C000._PPC /* External reference */
                                P80H = Local0
                                Sleep (0x64)
                            }
                        }
                    }

                    Name (CPUC, One)
                    Name (CONT, Zero)
                    Method (_Q08, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If (FKSF)
                        {
                            Local0 = (FKCS | 0x10)
                            OSMI (0x22, Local0)
                        }
                    }

                    Method (_Q09, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x09
                        If (ECOK)
                        {
                            Acquire (MUT1, 0xFFFF)
                            PSTA = Zero
                            Release (MUT1)
                            ^^^^BAT1.BSTA ()
                            Notify (ACAD, 0x80) // Status Change
                            Sleep (0x01F4)
                            Notify (BAT1, 0x80) // Status Change
                            If (^^^^BAT1.BTCH)
                            {
                                ^^^^BAT1.UBIF ()
                                Notify (BAT1, 0x81) // Information Change
                                ^^^^BAT1.BTCH = Zero
                            }
                        }

                        P80H = 0xB0
                        If (^^^^ACDF)
                        {
                            P80H = 0xAC
                            Sleep (0x64)
                        }
                        Else
                        {
                            P80H = 0xDC
                            Sleep (0x64)
                        }
                    }

                    Name (GSFB, Zero)
                    Name (GSST, Zero)
                    Name (G71F, Zero)
                    Method (_Q76, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            P80H = 0x76
                            ^^^^TVAP.EVNT (0xC0)
                        }
                    }

                    Method (_Q77, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            P80H = 0x77
                            ^^^^TVAP.EVNT (0xC1)
                        }
                    }

                    Method (_Q78, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            P80H = 0x78
                            ^^^^TVAP.EVNT (0xC2)
                        }
                    }

                    Method (_Q79, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            P80H = 0x79
                            ^^^^TVAP.EVNT (0xC3)
                        }
                    }

                    Method (_Q9B, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x11
                        LDSS = One
                        Notify (TVAP, 0x8F) // Device-Specific
                        Notify (LID, 0x80) // Status Change
                    }

                    Method (_Q9C, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x22
                        LDSS = Zero
                        Notify (LID, 0x80) // Status Change
                    }

                    Method (_Q0E, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x0E0E
                        AFN0 ()
                    }

                    Method (_Q0F, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x0F0F
                        If ((MYOS < 0x07DC))
                        {
                            P80H = 0x0F
                            Local0 = BLVL /* \_SB_.PCI0.LPC0.EC0_.BLVL */
                            Local1 = OSTP /* \_SB_.PCI0.LPC0.EC0_.OSTP */
                            If (Local1)
                            {
                                If (Local0)
                                {
                                    Local0--
                                }
                                Else
                                {
                                    Local0 = Zero
                                }

                                BLVL = Local0
                            }

                            SVBN ()
                        }

                        Notify (^^^VGA.LCD, 0x87) // Device-Specific
                        Notify (^^^PB4.VGA.LCD, 0x87) // Device-Specific
                    }

                    Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x1010
                        If ((MYOS < 0x07DC))
                        {
                            Local0 = BLVL /* \_SB_.PCI0.LPC0.EC0_.BLVL */
                            Local1 = OSTP /* \_SB_.PCI0.LPC0.EC0_.OSTP */
                            If (Local1)
                            {
                                If ((Local0 < 0x07))
                                {
                                    Local0++
                                }
                                Else
                                {
                                    Local0 = 0x07
                                }

                                BLVL = Local0
                            }

                            SVBN ()
                        }

                        Notify (^^^VGA.LCD, 0x86) // Device-Specific
                        Notify (^^^PB4.VGA.LCD, 0x86) // Device-Specific
                    }

                    Name (INP4, Zero)
                    Method (_Q8D, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        INP4 = One
                        P80H = 0x8D
                        Sleep (0x64)
                        \_PR.C000._PPC = 0x04
                        Notify (\_PR.C000, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        \_PR.C001._PPC = 0x04
                        Notify (\_PR.C001, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        \_PR.C002._PPC = 0x04
                        Notify (\_PR.C002, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        \_PR.C003._PPC = 0x04
                        Notify (\_PR.C003, 0x80) // Performance Capability Change
                        Sleep (0x96)
                        Local0 = \_PR.C000._PPC /* External reference */
                        P80H = Local0
                    }

                    Method (_Q8E, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        INP4 = Zero
                        P80H = 0x8E
                        Sleep (0x64)
                        If ((CPUD == Zero))
                        {
                            \_PR.C000._PPC = Zero
                            Notify (\_PR.C000, 0x80) // Performance Capability Change
                            Sleep (0x64)
                            \_PR.C001._PPC = Zero
                            Notify (\_PR.C001, 0x80) // Performance Capability Change
                            Sleep (0x64)
                            \_PR.C002._PPC = Zero
                            Notify (\_PR.C002, 0x80) // Performance Capability Change
                            Sleep (0x64)
                            \_PR.C003._PPC = Zero
                            Notify (\_PR.C003, 0x80) // Performance Capability Change
                            Sleep (0x96)
                        }

                        Local0 = \_PR.C000._PPC /* External reference */
                        P80H = Local0
                    }

                    Method (_QA0, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0xA0A0
                        FSMI (0x5A, Zero)
                    }

                    Method (_QA1, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0xA1A1
                        FSMI (0x5B, Zero)
                    }

                    Method (SVBN, 0, NotSerialized)
                    {
                        Local0 = ^^^^BLVL /* \_SB_.BLVL */
                        If ((Local0 == Zero))
                        {
                            OWNS = PL00 /* \PL00 */
                        }
                        ElseIf ((Local0 == One))
                        {
                            OWNS = PL01 /* \PL01 */
                        }
                        ElseIf ((Local0 == 0x02))
                        {
                            OWNS = PL02 /* \PL02 */
                        }
                        ElseIf ((Local0 == 0x03))
                        {
                            OWNS = PL03 /* \PL03 */
                        }
                        ElseIf ((Local0 == 0x04))
                        {
                            OWNS = PL04 /* \PL04 */
                        }
                        ElseIf ((Local0 == 0x05))
                        {
                            OWNS = PL05 /* \PL05 */
                        }
                        ElseIf ((Local0 == 0x06))
                        {
                            OWNS = PL06 /* \PL06 */
                        }
                        Else
                        {
                            OWNS = PL07 /* \PL07 */
                        }

                        FSMI (0x22, One)
                    }

                    Method (_Q01, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (BT, 0x90) // Device-Specific
                    }

                    Method (_Q02, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        ^^^^TVAP.VRFS = One
                        Notify (BT, 0x90) // Device-Specific
                    }

                    Method (_Q03, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        P80H = 0x03
                        Acquire (MUT1, 0xFFFF)
                        Local0 = (DALB & 0x0F)
                        Release (MUT1)
                    }

                    Method (_Q90, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        ^^^^TVAP.EVNT (0x02)
                    }

                    Method (_Q91, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        ^^^^TVAP.EVNT (0x03)
                        Sleep (0x05)
                        ^^^^TVAP.EVNT (0x04)
                    }

                    Method (_Q92, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        ^^^^TVAP.EVNT (0x02)
                        Sleep (0x05)
                        ^^^^TVAP.EVNT (0x03)
                        Sleep (0x05)
                        ^^^^TVAP.EVNT (0x04)
                    }

                    Method (_QB0, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Local0 = ^^^^PECL /* \_SB_.PECL */
                        If (Local0)
                        {
                            ^^^^TVAP.EVNT (0xB2)
                        }
                    }

                    Method (_QB1, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Local0 = ^^^^PECL /* \_SB_.PECL */
                        If (Local0)
                        {
                            ^^^^TVAP.EVNT (0xB3)
                        }
                    }

                    Method (_QB6, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            Local0 = ^^^^PECC /* \_SB_.PECC */
                            If (Local0)
                            {
                                ^^^^TVAP.EVNT (0xB6)
                            }
                        }
                    }

                    Method (_QB7, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            Local0 = ^^^^PECC /* \_SB_.PECC */
                            If (Local0)
                            {
                                ^^^^TVAP.EVNT (0xB7)
                                P80H = 0xB7
                            }
                        }
                    }

                    Method (_QB4, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            While (One)
                            {
                                If ((^^^^TVAP.VZOK == One))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            ^^^^TVAP.EVNT (0xB4)
                        }
                    }

                    Method (_QB5, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        If ((^^^^TVAP.VZOK >= One))
                        {
                            While (One)
                            {
                                If ((^^^^TVAP.VZOK == One))
                                {
                                    Break
                                }

                                Sleep (0x64)
                            }

                            ^^^^TVAP.EVNT (0xB5)
                        }
                    }

                    Method (_Q9A, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Local0 = ^^^^DE4L /* \_SB_.DE4L */
                        If ((Local0 == One))
                        {
                            Local1 = 0x03
                        }
                        ElseIf ((Local0 == 0x02))
                        {
                            Local1 = 0x02
                        }
                        ElseIf ((Local0 == 0x03))
                        {
                            Local1 = One
                        }
                        ElseIf ((Local0 == 0x04))
                        {
                            Local1 = Zero
                        }
                        Else
                        {
                            Local1 = Zero
                        }

                        \_PR.C000._PPC = Local1
                        Notify (\_PR.C000, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        \_PR.C001._PPC = Local1
                        Notify (\_PR.C001, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        \_PR.C002._PPC = Local1
                        Notify (\_PR.C000, 0x80) // Performance Capability Change
                        Sleep (0x64)
                        \_PR.C003._PPC = Local1
                        Notify (\_PR.C001, 0x80) // Performance Capability Change
                        Sleep (0x64)
                    }

                    Method (_Q8F, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Notify (TVAP, 0x8E) // Device-Specific
                    }
                }

                OperationRegion (LCLM, SystemIO, 0x0C50, 0x03)
                Field (LCLM, ByteAcc, NoLock, Preserve)
                {
                    CLMI,   8, 
                    CLMD,   8, 
                    CLGP,   8
                }

                IndexField (CLMI, CLMD, ByteAcc, NoLock, Preserve)
                {
                    IDRG,   8, 
                    Offset (0x02), 
                    TSTS,   8, 
                    TINT,   8, 
                    Offset (0x12), 
                    I2CC,   8, 
                    GPIO,   8
                }

                Method (RGPM, 0, NotSerialized)
                {
                    Local0 = GPIO /* \_SB_.PCI0.LPC0.GPIO */
                    Local0 &= 0xFFFFFF3F
                    GPIO = Local0
                    Local1 = CLGP /* \_SB_.PCI0.LPC0.CLGP */
                    Return (Local1)
                }
            }

            Device (P2P)
            {
                Name (_ADR, 0x00140004)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    If ((WKPM == One))
                    {
                        Return (GPRW (0x04, 0x05))
                    }
                    Else
                    {
                        Return (GPRW (0x04, Zero))
                    }
                }

                OperationRegion (PCPC, PCI_Config, Zero, 0xFF)
                Field (PCPC, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    PCMD,   8, 
                    Offset (0x1C), 
                    IOW1,   8, 
                    IOW2,   8, 
                    Offset (0x48), 
                    PR48,   8, 
                    PR49,   8, 
                    PR4A,   8, 
                    PR4B,   8
                }

                Name (PR09, Package (0x08)
                {
                    Package (0x04)
                    {
                        0x0004FFFF, 
                        Zero, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        One, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        0x02, 
                        LNKH, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        0x03, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        Zero, 
                        LNKE, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        One, 
                        LNKF, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x02, 
                        LNKG, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x03, 
                        LNKH, 
                        Zero
                    }
                })
                Name (AR09, Package (0x0A)
                {
                    Package (0x04)
                    {
                        0x0004FFFF, 
                        Zero, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        One, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x02, 
                        Zero, 
                        0x17
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x03, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        0x02, 
                        Zero, 
                        0x17
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        0x03, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        Zero, 
                        Zero, 
                        0x14
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        One, 
                        Zero, 
                        0x15
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x02, 
                        Zero, 
                        0x16
                    }, 

                    Package (0x04)
                    {
                        0x0005FFFF, 
                        0x03, 
                        Zero, 
                        0x17
                    }
                })
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR09) /* \_SB_.PCI0.P2P_.AR09 */
                    }

                    Return (PR09) /* \_SB_.PCI0.P2P_.PR09 */
                }
            }

            Device (SATA)
            {
                Name (_ADR, 0x00110000)  // _ADR: Address
                Name (B5EN, Zero)
                Name (BA_5, Zero)
                Name (SBAR, 0xF034B000)
                OperationRegion (SATX, PCI_Config, Zero, 0x44)
                Field (SATX, AnyAcc, NoLock, Preserve)
                {
                    VIDI,   32, 
                    Offset (0x0A), 
                    STCL,   16, 
                    Offset (0x24), 
                    BA05,   32, 
                    Offset (0x40), 
                    WTEN,   1, 
                    Offset (0x42), 
                    DIS0,   1, 
                    DIS1,   1, 
                    DIS2,   1, 
                    DIS3,   1, 
                    DIS4,   1, 
                    DIS5,   1
                }

                Field (SATX, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x42), 
                    DISP,   6
                }

                Method (GBAA, 0, Serialized)
                {
                    BA_5 = BA05 /* \_SB_.PCI0.SATA.BA05 */
                    If (((BA_5 == Ones) || (STCL != 0x0101)))
                    {
                        B5EN = Zero
                        Return (SBAR) /* \_SB_.PCI0.SATA.SBAR */
                    }
                    Else
                    {
                        B5EN = One
                        Return (BA_5) /* \_SB_.PCI0.SATA.BA_5 */
                    }
                }

                OperationRegion (BAR5, SystemMemory, GBAA (), 0x1000)
                Field (BAR5, AnyAcc, NoLock, Preserve)
                {
                    NOPT,   5, 
                    Offset (0x0C), 
                    PTI0,   1, 
                    PTI1,   1, 
                    PTI2,   1, 
                    PTI3,   1, 
                    PTI4,   1, 
                    PTI5,   1, 
                    PTI6,   1, 
                    PTI7,   1, 
                    Offset (0x118), 
                    CST0,   1, 
                    Offset (0x120), 
                        ,   7, 
                    BSY0,   1, 
                    Offset (0x128), 
                    DET0,   4, 
                    Offset (0x129), 
                    IPM0,   4, 
                    Offset (0x12C), 
                    DDI0,   4, 
                    Offset (0x198), 
                    CST1,   1, 
                    Offset (0x1A0), 
                        ,   7, 
                    BSY1,   1, 
                    Offset (0x1A8), 
                    DET1,   4, 
                    Offset (0x1A9), 
                    IPM1,   4, 
                    Offset (0x1AC), 
                    DDI1,   4, 
                    Offset (0x218), 
                    CST2,   1, 
                    Offset (0x220), 
                        ,   7, 
                    BSY2,   1, 
                    Offset (0x228), 
                    DET2,   4, 
                    Offset (0x229), 
                    IPM2,   4, 
                    Offset (0x22C), 
                    DDI2,   4, 
                    Offset (0x298), 
                    CST3,   1, 
                    Offset (0x2A0), 
                        ,   7, 
                    BSY3,   1, 
                    Offset (0x2A8), 
                    DET3,   4, 
                    Offset (0x2A9), 
                    IPM3,   4, 
                    Offset (0x2AC), 
                    DDI3,   4, 
                    Offset (0x318), 
                    CST4,   1, 
                    Offset (0x320), 
                        ,   7, 
                    BSY4,   1, 
                    Offset (0x328), 
                    DET4,   4, 
                    Offset (0x329), 
                    IPM4,   4, 
                    Offset (0x32C), 
                    DDI4,   4, 
                    Offset (0x398), 
                    CST5,   1, 
                    Offset (0x3A0), 
                        ,   7, 
                    BSY5,   1, 
                    Offset (0x3A8), 
                    DET5,   4, 
                    Offset (0x3A9), 
                    IPM5,   4, 
                    Offset (0x3AC), 
                    DDI5,   4
                }

                Field (BAR5, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x0C), 
                    PTI,    6
                }

                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    GBAA ()
                }

                Device (PRID)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (SPTM, Buffer (0x14)
                    {
                        /* 0000 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  /* x....... */
                        /* 0008 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  /* x....... */
                        /* 0010 */  0x1F, 0x00, 0x00, 0x00                           /* .... */
                    })
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Return (SPTM) /* \_SB_.PCI0.SATA.PRID.SPTM */
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        SPTM = Arg0
                    }

                    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                    {
                        GBAA ()
                        If ((((TPOS >= 0x40) || (TPOS == 0x04)) && B5EN))
                        {
                            If (IPM2)
                            {
                                Local0 = 0x32
                                While (((BSY2 == One) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }
                        }
                    }

                    Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                    {
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            GBAA ()
                            If ((B5EN == Zero))
                            {
                                Return (Zero)
                            }

                            If ((DET0 == 0x03))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Name (S12P, Zero)
                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((TPOS < 0x40) && (TPOS != 0x04)) && B5EN))
                            {
                                Local0 = 0x32
                                While (((BSY0 == One) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Local0 = Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         /* .F..... */
                                }
                            Return (Local0)
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            GBAA ()
                            If ((B5EN == Zero))
                            {
                                Return (Zero)
                            }

                            If ((DET2 == 0x03))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Name (S12P, Zero)
                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((TPOS < 0x40) && (TPOS != 0x04)) && B5EN))
                            {
                                Local0 = 0x32
                                While (((BSY2 == One) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Local0 = Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         /* .F..... */
                                }
                            Return (Local0)
                        }
                    }
                }

                Device (SECD)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Name (SPTM, Buffer (0x14)
                    {
                        /* 0000 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  /* x....... */
                        /* 0008 */  0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,  /* x....... */
                        /* 0010 */  0x1F, 0x00, 0x00, 0x00                           /* .... */
                    })
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Return (SPTM) /* \_SB_.PCI0.SATA.SECD.SPTM */
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        SPTM = Arg0
                    }

                    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                    {
                        GBAA ()
                        If ((((TPOS >= 0x40) || (TPOS == 0x04)) && B5EN))
                        {
                            If (IPM1)
                            {
                                Local0 = 0x32
                                While (((BSY1 == One) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }

                            If (IPM3)
                            {
                                Local0 = 0x32
                                While (((BSY3 == One) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }
                        }
                    }

                    Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                    {
                    }

                    Device (S_D0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            GBAA ()
                            If ((B5EN == Zero))
                            {
                                Return (Zero)
                            }

                            If ((DET1 == 0x03))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((TPOS < 0x40) && (TPOS != 0x04)) && B5EN))
                            {
                                Local0 = 0x32
                                While (((BSY1 == One) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Local0 = Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         /* .F..... */
                                }
                            Return (Local0)
                        }
                    }

                    Device (S_D1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            GBAA ()
                            If ((B5EN == Zero))
                            {
                                Return (Zero)
                            }

                            If ((DET3 == 0x03))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                        {
                            GBAA ()
                            If ((((TPOS < 0x40) && (TPOS != 0x04)) && B5EN))
                            {
                                Local0 = 0x32
                                While (((BSY3 == One) && Local0))
                                {
                                    Sleep (0xFA)
                                    Local0--
                                }
                            }
                        }

                        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                        {
                        }

                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Local0 = Buffer (0x07)
                                {
                                     0x03, 0x46, 0x00, 0x00, 0x00, 0xA0, 0xEF         /* .F..... */
                                }
                            Return (Local0)
                        }
                    }
                }

                Method (ENP, 2, NotSerialized)
                {
                    If ((Arg0 == Zero))
                    {
                        DIS0 = ~Arg1
                    }
                    ElseIf ((Arg0 == One))
                    {
                        DIS1 = ~Arg1
                    }
                    ElseIf ((Arg0 == 0x02))
                    {
                        DIS2 = ~Arg1
                    }
                    ElseIf ((Arg0 == 0x03))
                    {
                        DIS3 = ~Arg1
                    }
                    ElseIf ((Arg0 == 0x04))
                    {
                        DIS4 = ~Arg1
                    }
                    ElseIf ((Arg0 == 0x05))
                    {
                        DIS5 = ~Arg1
                    }

                    WTEN = One
                    If ((Arg0 == Zero))
                    {
                        PTI0 = Arg1
                    }
                    ElseIf ((Arg0 == One))
                    {
                        PTI1 = Arg1
                    }
                    ElseIf ((Arg0 == 0x02))
                    {
                        PTI2 = Arg1
                    }
                    ElseIf ((Arg0 == 0x03))
                    {
                        PTI3 = Arg1
                    }
                    ElseIf ((Arg0 == 0x04))
                    {
                        PTI4 = Arg1
                    }
                    ElseIf ((Arg0 == 0x05))
                    {
                        PTI5 = Arg1
                    }

                    If ((DISP == 0x3F))
                    {
                        PTI0 = One
                    }
                    ElseIf ((DIS0 && ((DISP & 0x3E) ^ 0x3E)))
                    {
                        PTI0 = Zero
                    }

                    Local0 = PTI /* \_SB_.PCI0.SATA.PTI_ */
                    Local1 = Zero
                    While (Local0)
                    {
                        If ((Local0 & One))
                        {
                            Local1++
                        }

                        Local0 >>= One
                    }

                    NOPT = Local1--
                    WTEN = Zero
                }

                Device (PRT1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((^^^AFD.ODZP == 0x80000001))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Method (DIS, 0, NotSerialized)
                    {
                        ENP (One, Zero)
                    }

                    Method (ENA, 0, NotSerialized)
                    {
                        ENP (One, One)
                    }

                    Device (ODD)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                    }
                }
            }

            Device (IDE)
            {
                Name (_ADR, 0x00140001)  // _ADR: Address
                Name (UDMT, Package (0x08)
                {
                    0x78, 
                    0x5A, 
                    0x3C, 
                    0x2D, 
                    0x1E, 
                    0x14, 
                    Zero, 
                    Zero
                })
                Name (PIOT, Package (0x06)
                {
                    0x0258, 
                    0x0186, 
                    0x010E, 
                    0xB4, 
                    0x78, 
                    Zero
                })
                Name (PITR, Package (0x06)
                {
                    0x99, 
                    0x47, 
                    0x34, 
                    0x22, 
                    0x20, 
                    0x99
                })
                Name (MDMT, Package (0x04)
                {
                    0x01E0, 
                    0x96, 
                    0x78, 
                    Zero
                })
                Name (MDTR, Package (0x04)
                {
                    0x77, 
                    0x21, 
                    0x20, 
                    0xFF
                })
                OperationRegion (IDE, PCI_Config, 0x40, 0x20)
                Field (IDE, WordAcc, NoLock, Preserve)
                {
                    PPIT,   16, 
                    SPIT,   16, 
                    PMDT,   16, 
                    SMDT,   16, 
                    PPIC,   8, 
                    SPIC,   8, 
                    PPIM,   8, 
                    SPIM,   8, 
                    Offset (0x14), 
                    PUDC,   2, 
                    SUDC,   2, 
                    Offset (0x16), 
                    PUDM,   8, 
                    SUDM,   8
                }

                Method (GETT, 1, NotSerialized)
                {
                    Local0 = (Arg0 & 0x0F)
                    Local1 = (Arg0 >> 0x04)
                    Return ((0x1E * ((Local0 + One) + (Local1 + One)
                        )))
                }

                Method (GTM, 1, NotSerialized)
                {
                    CreateByteField (Arg0, Zero, PIT1)
                    CreateByteField (Arg0, One, PIT0)
                    CreateByteField (Arg0, 0x02, MDT1)
                    CreateByteField (Arg0, 0x03, MDT0)
                    CreateByteField (Arg0, 0x04, PICX)
                    CreateByteField (Arg0, 0x05, UDCX)
                    CreateByteField (Arg0, 0x06, UDMX)
                    Name (BUF, Buffer (0x14)
                    {
                        /* 0000 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  /* ........ */
                        /* 0008 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  /* ........ */
                        /* 0010 */  0x00, 0x00, 0x00, 0x00                           /* .... */
                    })
                    CreateDWordField (BUF, Zero, PIO0)
                    CreateDWordField (BUF, 0x04, DMA0)
                    CreateDWordField (BUF, 0x08, PIO1)
                    CreateDWordField (BUF, 0x0C, DMA1)
                    CreateDWordField (BUF, 0x10, FLAG)
                    If ((PICX & One))
                    {
                        Return (BUF) /* \_SB_.PCI0.IDE_.GTM_.BUF_ */
                    }

                    PIO0 = GETT (PIT0)
                    PIO1 = GETT (PIT1)
                    If ((UDCX & One))
                    {
                        FLAG |= One
                        DMA0 = DerefOf (UDMT [(UDMX & 0x0F)])
                    }
                    ElseIf ((MDT0 != 0xFF))
                    {
                        DMA0 = GETT (MDT0)
                    }

                    If ((UDCX & 0x02))
                    {
                        FLAG |= 0x04
                        DMA1 = DerefOf (UDMT [(UDMX >> 0x04)])
                    }
                    ElseIf ((MDT1 != 0xFF))
                    {
                        DMA1 = GETT (MDT1)
                    }

                    FLAG |= 0x1A
                    Return (BUF) /* \_SB_.PCI0.IDE_.GTM_.BUF_ */
                }

                Method (STM, 3, NotSerialized)
                {
                    CreateDWordField (Arg0, Zero, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Name (BUF, Buffer (0x07)
                    {
                         0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         /* ....... */
                    })
                    CreateByteField (BUF, Zero, PIT1)
                    CreateByteField (BUF, One, PIT0)
                    CreateByteField (BUF, 0x02, MDT1)
                    CreateByteField (BUF, 0x03, MDT0)
                    CreateByteField (BUF, 0x04, PIMX)
                    CreateByteField (BUF, 0x05, UDCX)
                    CreateByteField (BUF, 0x06, UDMX)
                    Local0 = Match (PIOT, MLE, PIO0, MTR, Zero, Zero)
                    Local0 %= 0x05
                    Local1 = Match (PIOT, MLE, PIO1, MTR, Zero, Zero)
                    Local1 %= 0x05
                    PIMX = ((Local1 << 0x04) | Local0)
                    PIT0 = DerefOf (PITR [Local0])
                    PIT1 = DerefOf (PITR [Local1])
                    If ((FLAG & One))
                    {
                        Local0 = Match (UDMT, MLE, DMA0, MTR, Zero, Zero)
                        Local0 %= 0x06
                        UDMX |= Local0
                        UDCX |= One
                    }
                    ElseIf ((DMA0 != Ones))
                    {
                        Local0 = Match (MDMT, MLE, DMA0, MTR, Zero, Zero)
                        MDT0 = DerefOf (MDTR [Local0])
                    }

                    If ((FLAG & 0x04))
                    {
                        Local0 = Match (UDMT, MLE, DMA1, MTR, Zero, Zero)
                        Local0 %= 0x06
                        UDMX |= (Local0 << 0x04)
                        UDCX |= 0x02
                    }
                    ElseIf ((DMA1 != Ones))
                    {
                        Local0 = Match (MDMT, MLE, DMA1, MTR, Zero, Zero)
                        MDT1 = DerefOf (MDTR [Local0])
                    }

                    Return (BUF) /* \_SB_.PCI0.IDE_.STM_.BUF_ */
                }

                Method (GTF, 2, NotSerialized)
                {
                    CreateByteField (Arg1, Zero, MDT1)
                    CreateByteField (Arg1, One, MDT0)
                    CreateByteField (Arg1, 0x02, PIMX)
                    CreateByteField (Arg1, 0x03, UDCX)
                    CreateByteField (Arg1, 0x04, UDMX)
                    If ((Arg0 == 0xA0))
                    {
                        Local0 = (PIMX & 0x0F)
                        Local1 = MDT0 /* \_SB_.PCI0.IDE_.GTF_.MDT0 */
                        Local2 = (UDCX & One)
                        Local3 = (UDMX & 0x0F)
                    }
                    Else
                    {
                        Local0 = (PIMX >> 0x04)
                        Local1 = MDT1 /* \_SB_.PCI0.IDE_.GTF_.MDT1 */
                        Local2 = (UDCX & 0x02)
                        Local3 = (UDMX >> 0x04)
                    }

                    Name (BUF, Buffer (0x0E)
                    {
                        /* 0000 */  0x03, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF, 0x03,  /* ........ */
                        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xFF, 0xEF               /* ...... */
                    })
                    CreateByteField (BUF, One, PMOD)
                    CreateByteField (BUF, 0x08, DMOD)
                    CreateByteField (BUF, 0x05, CMDA)
                    CreateByteField (BUF, 0x0C, CMDB)
                    CMDA = Arg0
                    CMDB = Arg0
                    PMOD = (Local0 | 0x08)
                    If (Local2)
                    {
                        DMOD = (Local3 | 0x40)
                    }
                    ElseIf ((Local1 != 0xFF))
                    {
                        Local4 = Match (MDMT, MLE, GETT (Local1), MTR, Zero, Zero)
                        If ((Local4 < 0x03))
                        {
                            DMOD = (0x20 | Local4)
                        }
                    }

                    Return (BUF) /* \_SB_.PCI0.IDE_.GTF_.BUF_ */
                }

                Device (PRID)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         /* ....... */
                        })
                        CreateWordField (BUF, Zero, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIC)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        VPIT = PPIT /* \_SB_.PCI0.IDE_.PPIT */
                        VMDT = PMDT /* \_SB_.PCI0.IDE_.PMDT */
                        VPIC = PPIC /* \_SB_.PCI0.IDE_.PPIC */
                        VUDC = PUDC /* \_SB_.PCI0.IDE_.PUDC */
                        VUDM = PUDM /* \_SB_.PCI0.IDE_.PUDM */
                        Return (GTM (BUF))
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         /* ....... */
                        })
                        CreateWordField (BUF, Zero, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIM)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        BUF = STM (Arg0, Arg1, Arg2)
                        PPIT = VPIT /* \_SB_.PCI0.IDE_.PRID._STM.VPIT */
                        PMDT = VMDT /* \_SB_.PCI0.IDE_.PRID._STM.VMDT */
                        PPIM = VPIM /* \_SB_.PCI0.IDE_.PRID._STM.VPIM */
                        PUDC = VUDC /* \_SB_.PCI0.IDE_.PRID._STM.VUDC */
                        PUDM = VUDM /* \_SB_.PCI0.IDE_.PRID._STM.VUDM */
                    }

                    Device (P_D0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     /* ..... */
                            })
                            CreateWordField (BUF, Zero, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = PMDT /* \_SB_.PCI0.IDE_.PMDT */
                            VPIM = PPIM /* \_SB_.PCI0.IDE_.PPIM */
                            VUDC = PUDC /* \_SB_.PCI0.IDE_.PUDC */
                            VUDM = PUDM /* \_SB_.PCI0.IDE_.PUDM */
                            Return (GTF (0xA0, BUF))
                        }
                    }

                    Device (P_D1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     /* ..... */
                            })
                            CreateWordField (BUF, Zero, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = PMDT /* \_SB_.PCI0.IDE_.PMDT */
                            VPIM = PPIM /* \_SB_.PCI0.IDE_.PPIM */
                            VUDC = PUDC /* \_SB_.PCI0.IDE_.PUDC */
                            VUDM = PUDM /* \_SB_.PCI0.IDE_.PUDM */
                            Return (GTF (0xB0, BUF))
                        }
                    }
                }

                Device (SECD)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0x00         /* ....... */
                        })
                        CreateWordField (BUF, Zero, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIC)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        VPIT = SPIT /* \_SB_.PCI0.IDE_.SPIT */
                        VMDT = SMDT /* \_SB_.PCI0.IDE_.SMDT */
                        VPIC = SPIC /* \_SB_.PCI0.IDE_.SPIC */
                        VUDC = SUDC /* \_SB_.PCI0.IDE_.SUDC */
                        VUDM = SUDM /* \_SB_.PCI0.IDE_.SUDM */
                        Return (GTM (BUF))
                    }

                    Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                    {
                        Name (BUF, Buffer (0x07)
                        {
                             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00         /* ....... */
                        })
                        CreateWordField (BUF, Zero, VPIT)
                        CreateWordField (BUF, 0x02, VMDT)
                        CreateByteField (BUF, 0x04, VPIM)
                        CreateByteField (BUF, 0x05, VUDC)
                        CreateByteField (BUF, 0x06, VUDM)
                        BUF = STM (Arg0, Arg1, Arg2)
                        SPIT = VPIT /* \_SB_.PCI0.IDE_.SECD._STM.VPIT */
                        SMDT = VMDT /* \_SB_.PCI0.IDE_.SECD._STM.VMDT */
                        SPIM = VPIM /* \_SB_.PCI0.IDE_.SECD._STM.VPIM */
                        SUDC = VUDC /* \_SB_.PCI0.IDE_.SECD._STM.VUDC */
                        SUDM = VUDM /* \_SB_.PCI0.IDE_.SECD._STM.VUDM */
                    }

                    Device (S_D0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     /* ..... */
                            })
                            CreateWordField (BUF, Zero, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = SMDT /* \_SB_.PCI0.IDE_.SMDT */
                            VPIM = SPIM /* \_SB_.PCI0.IDE_.SPIM */
                            VUDC = SUDC /* \_SB_.PCI0.IDE_.SUDC */
                            VUDM = SUDM /* \_SB_.PCI0.IDE_.SUDM */
                            Return (GTF (0xA0, BUF))
                        }
                    }

                    Device (S_D1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                        {
                            Name (BUF, Buffer (0x05)
                            {
                                 0x00, 0x00, 0x00, 0x00, 0x00                     /* ..... */
                            })
                            CreateWordField (BUF, Zero, VMDT)
                            CreateByteField (BUF, 0x02, VPIM)
                            CreateByteField (BUF, 0x03, VUDC)
                            CreateByteField (BUF, 0x04, VUDM)
                            VMDT = SMDT /* \_SB_.PCI0.IDE_.SMDT */
                            VPIM = SPIM /* \_SB_.PCI0.IDE_.SPIM */
                            VUDC = SUDC /* \_SB_.PCI0.IDE_.SUDC */
                            VUDM = SUDM /* \_SB_.PCI0.IDE_.SUDM */
                            Return (GTF (0xB0, BUF))
                        }
                    }
                }
            }

            Name (AFCB, Buffer (0xB8){})
            Name (CALB, Buffer (0x05){})
            Device (AFD)
            {
                Name (_HID, "AFD0001")  // _HID: Hardware ID
                Name (AFEN, 0x80000000)
                Name (FU3E, 0x80000001)
                Name (HDD0, 0x80000000)
                Name (ODZP, 0x80000001)
                Name (DAT2, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x03, 0x0C, 0x03, 0x00, 0x00, 0x00,  /* ........ */
                    /* 0008 */  0x92, 0x00, 0x03, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DAT3, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x03, 0x0C, 0x03, 0x00, 0x00, 0x00,  /* ........ */
                    /* 0008 */  0x92, 0x00, 0x03, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DAT4, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x11, 0x0D, 0x03, 0x00, 0x00, 0x00,  /* ........ */
                    /* 0008 */  0xA5, 0x00, 0x02, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DAT5, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x03, 0x0C, 0x03, 0x00, 0x00, 0x00,  /* ........ */
                    /* 0008 */  0xA5, 0x00, 0x02, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DAT6, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0xFF,  /* ........ */
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DAT7, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0xFF,  /* ........ */
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DAT8, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x80, 0x02, 0x00, 0x00, 0x00, 0xFF,  /* ........ */
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DAT9, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x03, 0x0C, 0x03, 0x00, 0x00, 0x00,  /* ........ */
                    /* 0008 */  0x00, 0xFF, 0x00, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DATA, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x80, 0x02, 0x00, 0x00, 0x00, 0xFF,  /* ........ */
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DATB, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x80, 0x02, 0x00, 0x00, 0x00, 0xFF,  /* ........ */
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00               /* ...... */
                })
                Name (DATC, Buffer (0x0E)
                {
                    /* 0000 */  0x0E, 0x00, 0x80, 0x02, 0x00, 0x00, 0x00, 0xFF,  /* ........ */
                    /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00               /* ...... */
                })
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((AFUC == Zero))
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }

                Method (AFCM, 3, NotSerialized)
                {
                    Arg0 &= 0xFF
                    If ((Arg0 == Zero))
                    {
                        Return (AFC0 ())
                    }

                    If ((Arg0 == One))
                    {
                        Return (AFC1 ())
                    }

                    If ((Arg0 == 0x02))
                    {
                        Return (AFC2 (Arg1, Arg2))
                    }
                    Else
                    {
                        CreateWordField (AFCB, Zero, SSZE)
                        CreateWordField (AFCB, 0x02, VERN)
                        CreateDWordField (AFCB, 0x04, SFUN)
                        SSZE = Zero
                        VERN = Zero
                        SFUN = Zero
                        Return (AFCB) /* \_SB_.PCI0.AFCB */
                    }
                }

                Method (AFC0, 0, NotSerialized)
                {
                    P80H = 0xAF00
                    CreateWordField (AFCB, Zero, SSZE)
                    CreateWordField (AFCB, 0x02, VERN)
                    CreateDWordField (AFCB, 0x04, SFUN)
                    SSZE = 0x08
                    VERN = One
                    SFUN = 0x03
                    P80H = 0xAE00
                    Return (AFCB) /* \_SB_.PCI0.AFCB */
                }

                Method (AFC1, 0, NotSerialized)
                {
                    P80H = 0xAF01
                    CreateWordField (AFCB, Zero, SSZE)
                    CreateWordField (AFCB, 0x02, ESZ0)
                    CreateWordField (AFCB, 0x04, CCD0)
                    CreateWordField (AFCB, 0x06, EBU0)
                    CreateWordField (AFCB, 0x08, CFG0)
                    CreateWordField (AFCB, 0x0A, PCA0)
                    CreateWordField (AFCB, 0x0C, DCP0)
                    CreateWordField (AFCB, 0x0E, DRA0)
                    ESZ0 = 0x0E
                    EBU0 = 0x02
                    CFG0 = Zero
                    PCA0 = 0x88
                    If ((^^SATA.VIDI == 0x78001022))
                    {
                        EBU0 = One
                        CCD0 = 0x0101
                        DCP0 = Zero
                        DRA0 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78011022))
                    {
                        CCD0 = 0x0106
                        DCP0 = Zero
                        DRA0 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78021022))
                    {
                        CCD0 = 0x0104
                        DCP0 = Zero
                        DRA0 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78031022))
                    {
                        CCD0 = 0x0104
                        DCP0 = Zero
                        DRA0 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78041022))
                    {
                        CCD0 = 0x0106
                        DCP0 = Zero
                        DRA0 = Zero
                    }

                    CreateWordField (AFCB, 0x10, ESZ1)
                    CreateWordField (AFCB, 0x12, CCD1)
                    CreateWordField (AFCB, 0x14, EBU1)
                    CreateWordField (AFCB, 0x16, CFG1)
                    CreateWordField (AFCB, 0x18, PCA1)
                    CreateWordField (AFCB, 0x1A, DCP1)
                    CreateWordField (AFCB, 0x1C, DRA1)
                    ESZ1 = 0x0E
                    EBU1 = 0x02
                    CFG1 = Zero
                    PCA1 = 0x88
                    If ((^^SATA.VIDI == 0x78001022))
                    {
                        EBU1 = One
                        CCD1 = 0x0101
                        DCP1 = One
                        DRA1 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78011022))
                    {
                        CCD1 = 0x0106
                        DCP1 = One
                        DRA1 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78021022))
                    {
                        CCD1 = 0x0104
                        DCP1 = Zero
                        DRA1 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78031022))
                    {
                        CCD1 = 0x0104
                        DCP1 = Zero
                        DRA1 = Zero
                    }

                    If ((^^SATA.VIDI == 0x78041022))
                    {
                        CCD1 = 0x0106
                        DCP1 = One
                        DRA1 = Zero
                    }

                    CreateField (AFCB, 0xF0, 0x70, IDX2)
                    IDX2 = DAT2 /* \_SB_.PCI0.AFD_.DAT2 */
                    CreateField (AFCB, 0x0160, 0x70, IDX3)
                    IDX3 = DAT3 /* \_SB_.PCI0.AFD_.DAT3 */
                    CreateField (AFCB, 0x01D0, 0x70, IDX4)
                    IDX4 = DAT4 /* \_SB_.PCI0.AFD_.DAT4 */
                    CreateField (AFCB, 0x0240, 0x70, IDX5)
                    IDX5 = DAT5 /* \_SB_.PCI0.AFD_.DAT5 */
                    CreateField (AFCB, 0x02B0, 0x70, IDX6)
                    CreateByteField (DAT6, 0x07, BUS6)
                    If ((^^VGA.PXEN == 0x80000000))
                    {
                        BUS6 = 0xFF
                    }
                    Else
                    {
                        Local0 = ^^PB4.SBUS /* \_SB_.PCI0.PB4_.SBUS */
                        Local0 >>= 0x08
                        Local0 &= 0xFF
                        BUS6 = Local0
                    }

                    IDX6 = DAT6 /* \_SB_.PCI0.AFD_.DAT6 */
                    CreateField (AFCB, 0x0320, 0x70, IDX7)
                    CreateByteField (DAT7, 0x07, BUS7)
                    Local0 = ^^PB6.SBUS /* \_SB_.PCI0.PB6_.SBUS */
                    Local0 >>= 0x08
                    Local0 &= 0xFF
                    BUS7 = Local0
                    IDX7 = DAT7 /* \_SB_.PCI0.AFD_.DAT7 */
                    CreateField (AFCB, 0x0390, 0x70, IDX8)
                    CreateByteField (DAT8, 0x07, BUS8)
                    Local0 = ^^PB7.SBUS /* \_SB_.PCI0.PB7_.SBUS */
                    Local0 >>= 0x08
                    Local0 &= 0xFF
                    BUS8 = Local0
                    IDX8 = DAT8 /* \_SB_.PCI0.AFD_.DAT8 */
                    CreateField (AFCB, 0x0400, 0x70, IDX9)
                    If ((FU3E != 0x80000000))
                    {
                        CreateByteField (DAT9, 0x09, BUS9)
                        Local0 = ^^SPB1.SBUS /* \_SB_.PCI0.SPB1.SBUS */
                        Local0 >>= 0x08
                        Local0 &= 0xFF
                        BUS9 = Local0
                    }

                    IDX9 = DAT9 /* \_SB_.PCI0.AFD_.DAT9 */
                    CreateField (AFCB, 0x0470, 0x70, IDXA)
                    CreateByteField (DATA, 0x07, BUSA)
                    Local0 = ^^SPB2.SBUS /* \_SB_.PCI0.SPB2.SBUS */
                    Local0 >>= 0x08
                    Local0 &= 0xFF
                    BUSA = Local0
                    IDXA = DATA /* \_SB_.PCI0.AFD_.DATA */
                    CreateField (AFCB, 0x04E0, 0x70, IDXB)
                    IDXB = DATB /* \_SB_.PCI0.AFD_.DATB */
                    CreateField (AFCB, 0x0550, 0x70, IDXC)
                    IDXC = DATC /* \_SB_.PCI0.AFD_.DATC */
                    SSZE = 0xB8
                    P80H = 0xAE01
                    Return (AFCB) /* \_SB_.PCI0.AFCB */
                }

                Method (AFC2, 2, NotSerialized)
                {
                    P80H = 0xAF02
                    CreateDWordField (AFCB, Zero, FLAG)
                    CreateByteField (AFCB, 0x04, PWST)
                    CreateByteField (AFCB, 0x05, DIND)
                    CreateWordField (CALB, Zero, SZZE)
                    CreateField (CALB, 0x10, 0x03, FUCC)
                    CreateField (CALB, 0x13, 0x05, DEVV)
                    CreateField (CALB, 0x18, 0x08, BUSS)
                    CreateByteField (CALB, 0x04, HPST)
                    SZZE = 0x05
                    PWST = (Arg0 & 0xFF)
                    DIND = (Arg1 & 0xFF)
                    If ((HDD0 == 0x80000000))
                    {
                        ^^SMBS.PAAO = Zero
                        ^^SMBS.PAAE = Zero
                        ^^SMBS.MX57 = One
                        ^^SMBS.MX53 = One
                        If (^^SATA.IPM0)
                        {
                            ^^SMBS.P0FO = One
                            ^^SMBS.P0FE = Zero
                            Sleep (0xC8)
                        }

                        If (^^SATA.IPM1)
                        {
                            ^^SMBS.P2CO = One
                            ^^SMBS.P2CE = Zero
                            Sleep (0xC8)
                        }
                    }

                    If ((HDD0 == 0x80000000))
                    {
                        If (^^SATA.IPM0)
                        {
                            HDD0 = One
                        }
                        Else
                        {
                            HDD0 = Zero
                        }
                    }

                    If ((DIND == Zero))
                    {
                        If (((^^SATA.VIDI == 0x78021022) || (^^SATA.VIDI == 0x78031022)))
                        {
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        ^^SMBS.MX57 = One
                        If ((PWST == Zero))
                        {
                            If ((^^SATA.VIDI == 0x78001022))
                            {
                                Notify (^^SATA.PRID.P_D0, 0x03) // Eject Request
                            }

                            If (((^^SATA.VIDI == 0x78011022) || (^^SATA.VIDI == 0x78041022)))
                            {
                                Notify (^^SATA.PRID, 0x03) // Eject Request
                            }

                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P39O = Zero
                            ^^SMBS.P39E = Zero
                            Sleep (0x07D0)
                            If ((^^SATA.VIDI == 0x78001022))
                            {
                                Notify (^^SATA.PRID.P_D0, One) // Device Check
                            }

                            If (((^^SATA.VIDI == 0x78011022) || (^^SATA.VIDI == 0x78041022)))
                            {
                                Notify (^^SATA.PRID, One) // Device Check
                            }

                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.P39O /* \_SB_.PCI0.SMBS.P39O */
                        }
                    }

                    If ((DIND == One))
                    {
                        If (((^^SATA.VIDI == 0x78021022) || (^^SATA.VIDI == 0x78031022)))
                        {
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        ^^SMBS.MX53 = One
                        ^^SMBS.M170 = One
                        If ((ODZP == 0x80000000))
                        {
                            If ((PWST == Zero))
                            {
                                If ((^^SATA.VIDI == 0x78001022))
                                {
                                    Notify (^^SATA.PRT1.ODD, 0x03) // Eject Request
                                }

                                If (((^^SATA.VIDI == 0x78011022) || (^^SATA.VIDI == 0x78041022)))
                                {
                                    If ((HDD0 == One))
                                    {
                                        Notify (^^SATA.PRT1, 0x03) // Eject Request
                                    }
                                    ElseIf ((TPOS >= 0x50))
                                    {
                                        Notify (^^SATA.PRT1, 0x03) // Eject Request
                                    }
                                    Else
                                    {
                                        Notify (^^SATA.PRID, 0x03) // Eject Request
                                    }
                                }

                                FLAG = Zero
                            }

                            If ((PWST == One))
                            {
                                ^^SMBS.PAAO = Zero
                                ^^SMBS.PAAE = Zero
                                ^^SMBS.P35O = One
                                ^^SMBS.P35E = Zero
                                Sleep (0x03E8)
                                If ((^^SATA.VIDI == 0x78001022))
                                {
                                    Notify (^^SATA.PRT1.ODD, One) // Device Check
                                }

                                If (((^^SATA.VIDI == 0x78011022) || (^^SATA.VIDI == 0x78041022)))
                                {
                                    If ((HDD0 == One))
                                    {
                                        Notify (^^SATA.PRT1, One) // Device Check
                                    }
                                    ElseIf ((TPOS >= 0x50))
                                    {
                                        Notify (^^SATA.PRT1, One) // Device Check
                                    }
                                    Else
                                    {
                                        Notify (^^SATA.PRID, One) // Device Check
                                    }
                                }

                                FLAG = One
                            }

                            If ((PWST == 0xFF))
                            {
                                FLAG = ^^SMBS.P35O /* \_SB_.PCI0.SMBS.P35O */
                            }
                        }
                        Else
                        {
                            If ((PWST == Zero))
                            {
                                If ((^^SATA.VIDI == 0x78041022))
                                {
                                    FLAG |= 0xC0
                                    Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                                }

                                If ((^^SATA.VIDI == 0x78001022))
                                {
                                    Notify (^^SATA.ODDZ.ODD, 0x03) // Eject Request
                                }

                                If ((^^SATA.VIDI == 0x78011022))
                                {
                                    If ((HDD0 == One))
                                    {
                                        Notify (^^SATA.ODDZ.ODD, 0x03) // Eject Request
                                    }
                                    ElseIf ((TPOS >= 0x50))
                                    {
                                        Notify (^^SATA.ODDZ.ODD, 0x03) // Eject Request
                                    }
                                    Else
                                    {
                                        Notify (^^SATA.PRID, 0x03) // Eject Request
                                    }
                                }

                                FLAG = Zero
                            }

                            If ((PWST == One))
                            {
                                ^^SMBS.PAAO = Zero
                                ^^SMBS.PAAE = Zero
                                ^^SMBS.P35O = One
                                ^^SMBS.P35E = Zero
                                Sleep (0x03E8)
                                If ((^^SATA.VIDI == 0x78001022))
                                {
                                    Notify (^^SATA.ODDZ.ODD, One) // Device Check
                                }

                                If ((^^SATA.VIDI == 0x78011022))
                                {
                                    If ((HDD0 == One))
                                    {
                                        Notify (^^SATA.ODDZ.ODD, One) // Device Check
                                    }
                                    ElseIf ((TPOS >= 0x50))
                                    {
                                        Notify (^^SATA.ODDZ.ODD, One) // Device Check
                                    }
                                    Else
                                    {
                                        Notify (^^SATA.PRID, One) // Device Check
                                    }
                                }

                                FLAG = One
                            }

                            If ((PWST == 0xFF))
                            {
                                FLAG = ^^SMBS.P35O /* \_SB_.PCI0.SMBS.P35O */
                                If (((^^SATA.VIDI == 0x78001022) || (^^SATA.VIDI == 0x78011022)))
                                {
                                    FLAG &= 0x7F
                                }
                                Else
                                {
                                    FLAG |= 0x80
                                }

                                FLAG |= 0x40
                            }
                        }
                    }

                    If ((DIND == 0x02))
                    {
                        If (((^^SATA.VIDI == 0x78021022) || (^^SATA.VIDI == 0x78031022)))
                        {
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        ^^SMBS.MX58 = One
                        ^^SMBS.M170 = One
                        If ((PWST == Zero))
                        {
                            If ((^^SATA.VIDI == 0x78001022))
                            {
                                Notify (^^SATA.PRID.P_D1, 0x03) // Eject Request
                            }

                            If (((^^SATA.VIDI == 0x78011022) || (^^SATA.VIDI == 0x78041022)))
                            {
                                Notify (^^SATA.SECD, 0x03) // Eject Request
                            }

                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P22O = Zero
                            ^^SMBS.P22E = Zero
                            Sleep (0x28)
                            Notify (^^OHC1.RHUB.PRT2, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            Local0 = ^^SMBS.P22O /* \_SB_.PCI0.SMBS.P22O */
                            Local0 &= One
                            Local0 ^= One
                            FLAG = Local0
                        }
                    }

                    If ((DIND == 0x03))
                    {
                        ^^SMBS.MX59 = 0x02
                        If ((PWST == Zero))
                        {
                            Notify (^^OHC1.RHUB.PRT3, 0x03) // Eject Request
                            Notify (^^EHC1.RHUB.PRT3, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P3BO = One
                            ^^SMBS.P3BE = Zero
                            Sleep (0x28)
                            Notify (^^OHC1.RHUB.PRT3, One) // Device Check
                            Notify (^^EHC1.RHUB.PRT3, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.P3BO /* \_SB_.PCI0.SMBS.P3BO */
                        }
                    }

                    If ((DIND == 0x04))
                    {
                        ^^SMBS.MX07 = One
                        If ((PWST == Zero))
                        {
                            Notify (^^OHC4.RHUB.PRT2, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P07O = One
                            ^^SMBS.P07E = Zero
                            Sleep (0x28)
                            Notify (^^OHC4.RHUB.PRT2, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.P07O /* \_SB_.PCI0.SMBS.P07O */
                        }
                    }

                    If ((DIND == 0x05))
                    {
                        ^^SMBS.MX41 = 0x02
                        If ((PWST == Zero))
                        {
                            Notify (^^OHC4.RHUB.PRT1, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P29O = One
                            ^^SMBS.P29E = Zero
                            Sleep (0x28)
                            Notify (^^OHC4.RHUB.PRT1, One) // Device Check
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.P29O /* \_SB_.PCI0.SMBS.P29O */
                        }
                    }

                    If ((DIND == 0x06))
                    {
                        If ((^^VGA.PXEN == 0x80000000))
                        {
                            FLAG = ^^SMBS.P2DO /* \_SB_.PCI0.SMBS.P2DO */
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        If ((PWST == Zero))
                        {
                            Notify (^^PB4.VGA, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^VGA.PX02 (One)
                            Notify (^^PB4.VGA, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.P2DO /* \_SB_.PCI0.SMBS.P2DO */
                        }
                    }

                    If ((DIND == 0x07))
                    {
                        ^^SMBS.M181 = 0x02
                        If ((PWST == Zero))
                        {
                            Notify (^^PB6.XPDV, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.PB5O = One
                            ^^SMBS.PB5E = Zero
                            Sleep (0xC8)
                            Local0 = ^^SMBS.MS01 /* \_SB_.PCI0.SMBS.MS01 */
                            Local0 |= 0xF0
                            ^^SMBS.MS01 = Local0
                            Local0 = ^^SMBS.PO3F /* \_SB_.PCI0.SMBS.PO3F */
                            Local1 = (Local0 & 0xF7)
                            Local0 = (Local1 | 0x05)
                            ^^SMBS.PO3F = Local0
                            Sleep (0xC8)
                            FUCC = Zero
                            DEVV = 0x05
                            BUSS = Zero
                            HPST = One
                            ALIB
                            0x06
                            CALB
                            Sleep (0x28)
                            Notify (^^PB5.XPDV, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.PB5O /* \_SB_.PCI0.SMBS.PB5O */
                        }
                    }

                    If ((DIND == 0x08))
                    {
                        ^^SMBS.M180 = One
                        Local0 = ^^PB6.DVID /* \_SB_.PCI0.PB6_.DVID */
                        Local0 &= 0xFFFF
                        If ((Local0 == 0xFFFF))
                        {
                            Notify (^^PB6.XPDV, 0x03) // Eject Request
                            Local0 = ^^SMBS.PB4O /* \_SB_.PCI0.SMBS.PB4O */
                            Local0 &= One
                            Local0 ^= One
                            FLAG = Local0
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        If ((PWST == Zero))
                        {
                            Notify (^^PB6.XPDV, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.PB4O = Zero
                            ^^SMBS.PB4E = Zero
                            Sleep (0xC8)
                            Local0 = ^^SMBS.MS00 /* \_SB_.PCI0.SMBS.MS00 */
                            Local0 |= 0xF0
                            ^^SMBS.MS00 = Local0
                            Local0 = ^^SMBS.PO3D /* \_SB_.PCI0.SMBS.PO3D */
                            Local1 = (Local0 & 0xF7)
                            Local0 = (Local1 | 0x05)
                            ^^SMBS.PO3D = Local0
                            Sleep (0xC8)
                            FUCC = Zero
                            DEVV = 0x06
                            BUSS = Zero
                            HPST = One
                            ALIB
                            0x06
                            CALB
                            Sleep (0x28)
                            Notify (^^PB7.XPDV, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            Local0 = ^^SMBS.PB4O /* \_SB_.PCI0.SMBS.PB4O */
                            Local0 &= One
                            Local0 ^= One
                            FLAG = Local0
                        }
                    }

                    If ((DIND == 0x09))
                    {
                        If ((FU3E == 0x80000000))
                        {
                            Notify (^^SPB1.XPDV, 0x03) // Eject Request
                            FLAG = ^^SMBS.P66O /* \_SB_.PCI0.SMBS.P66O */
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        If ((PWST == Zero))
                        {
                            Notify (^^SPB1.XPDV, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P6CO = One
                            ^^SMBS.P6CE = Zero
                            Sleep (0x28)
                            Local0 = ^^SMBS.MS03 /* \_SB_.PCI0.SMBS.MS03 */
                            Local0 |= 0xF0
                            ^^SMBS.MS03 = Local0
                            Sleep (0x28)
                            Local0 = ^^SMBS.PO2E /* \_SB_.PCI0.SMBS.PO2E */
                            Local1 = (Local0 & 0xF7)
                            Local0 = (Local1 | 0x05)
                            ^^SMBS.PO2E = Local0
                            Sleep (0x28)
                            ^^SPB0.GHPS (Zero, One)
                            Notify (^^SPB1.XPDV, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.P6CO /* \_SB_.PCI0.SMBS.P6CO */
                        }
                    }

                    If ((DIND == 0x0A))
                    {
                        ^^SMBS.M199 = 0x02
                        Local0 = ^^SPB2.DVID /* \_SB_.PCI0.SPB2.DVID */
                        Local0 &= 0xFFFF
                        If ((Local0 == 0xFFFF))
                        {
                            Notify (^^SPB2.XPDV, 0x03) // Eject Request
                            Local0 = ^^SMBS.PC7O /* \_SB_.PCI0.SMBS.PC7O */
                            Local0 &= One
                            Local0 ^= One
                            FLAG = Local0
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        If ((PWST == Zero))
                        {
                            Notify (^^SPB2.XPDV, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.PC7O = Zero
                            ^^SMBS.PC7E = Zero
                            Sleep (0xC8)
                            Local0 = ^^SMBS.MS01 /* \_SB_.PCI0.SMBS.MS01 */
                            Local0 |= 0x0F
                            ^^SMBS.MS01 = Local0
                            Sleep (0x28)
                            Local0 = ^^SMBS.PO3E /* \_SB_.PCI0.SMBS.PO3E */
                            Local1 = (Local0 & 0xF7)
                            Local0 = (Local1 | 0x05)
                            ^^SMBS.PO3E = Local0
                            Sleep (0x28)
                            ^^SPB0.GHPS (Zero, 0x02)
                            Sleep (0x28)
                            Notify (^^SPB2.XPDV, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            Local0 = ^^SMBS.PC7O /* \_SB_.PCI0.SMBS.PC7O */
                            Local0 &= One
                            Local0 ^= One
                            FLAG = Local0
                        }
                    }

                    If ((DIND == 0x0B))
                    {
                        ^^SMBS.MX01 = One
                        Local0 = ^^SPB3.DVID /* \_SB_.PCI0.SPB3.DVID */
                        Local0 &= 0xFFFF
                        If ((Local0 == 0xFFFF))
                        {
                            Notify (^^SPB3.XPDV, 0x03) // Eject Request
                            Local0 = ^^SMBS.P01O /* \_SB_.PCI0.SMBS.P01O */
                            Local0 &= One
                            Local0 ^= One
                            FLAG = Local0
                            FLAG |= 0x80
                            Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                        }

                        If ((PWST == Zero))
                        {
                            Notify (^^SPB3.XPDV, 0x03) // Eject Request
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P01O = Zero
                            ^^SMBS.P01E = Zero
                            Sleep (0xC8)
                            Local0 = ^^SMBS.MS02 /* \_SB_.PCI0.SMBS.MS02 */
                            Local0 |= 0x0F
                            ^^SMBS.MS02 = Local0
                            Sleep (0x28)
                            Local0 = ^^SMBS.PO40 /* \_SB_.PCI0.SMBS.PO40 */
                            Local1 = (Local0 & 0xF7)
                            Local0 = (Local1 | 0x05)
                            ^^SMBS.PO40 = Local0
                            Sleep (0x28)
                            Notify (^^SPB3.XPDV, One) // Device Check
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            Local0 = ^^SMBS.P01O /* \_SB_.PCI0.SMBS.P01O */
                            Local0 &= One
                            Local0 ^= One
                            FLAG = Local0
                        }
                    }

                    If ((DIND == 0x0C))
                    {
                        ^^SMBS.MX33 = One
                        If ((PWST == Zero))
                        {
                            ^^SMBS.P21O = Zero
                            ^^SMBS.P21E = Zero
                            FLAG = Zero
                        }

                        If ((PWST == One))
                        {
                            ^^SMBS.P21O = One
                            ^^SMBS.P21E = Zero
                            Sleep (0xC8)
                            FLAG = One
                        }

                        If ((PWST == 0xFF))
                        {
                            FLAG = ^^SMBS.P21O /* \_SB_.PCI0.SMBS.P21O */
                        }
                    }

                    P80H = 0xAE02
                    Return (FLAG) /* \_SB_.PCI0.AFD_.AFC2.FLAG */
                }
            }

            Scope (SATA.PRID)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    Sleep (0x28)
                    ^^^SMBS.PAAO = Zero
                    ^^^SMBS.PAAE = Zero
                    If ((^^^AFD.HDD0 == One))
                    {
                        ^^^SMBS.P0FO = Zero
                        ^^^SMBS.P0FE = Zero
                    }
                    Else
                    {
                        ^^^SMBS.P2CO = Zero
                        ^^^SMBS.P2CE = Zero
                    }

                    Sleep (0x28)
                }
            }

            Scope (SATA.PRID.P_D0)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    ^^^^SMBS.P39O = Zero
                    ^^^^SMBS.P39E = Zero
                    Sleep (0x28)
                }
            }

            Scope (SATA.PRT1)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    Sleep (0x28)
                    ^^^SMBS.PAAO = Zero
                    ^^^SMBS.PAAE = Zero
                    ^^^SMBS.P35O = Zero
                    ^^^SMBS.P35E = Zero
                    Sleep (0x28)
                }
            }

            Scope (SATA.PRT1.ODD)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    Sleep (0x28)
                    ^^^^SMBS.PAAO = Zero
                    ^^^^SMBS.PAAE = Zero
                    ^^^^SMBS.P35O = Zero
                    ^^^^SMBS.P35E = Zero
                    Sleep (0x28)
                }
            }

            Scope (SATA.SECD)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    Sleep (0x28)
                    ^^^SMBS.PAAO = Zero
                    ^^^SMBS.PAAE = Zero
                    ^^^SMBS.P10O = Zero
                    ^^^SMBS.P10E = Zero
                    Sleep (0x28)
                }
            }

            Scope (SATA.PRID.P_D1)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    Sleep (0x28)
                    ^^^^SMBS.PAAO = Zero
                    ^^^^SMBS.PAAE = Zero
                    ^^^^SMBS.P10O = Zero
                    ^^^^SMBS.P10E = Zero
                    Sleep (0x28)
                }
            }

            Scope (OHC1)
            {
                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Return (Zero)
                        }

                        Method (XEJX, 1, NotSerialized)
                        {
                            Sleep (0x28)
                            ^^^^SMBS.P22O = One
                            ^^^^SMBS.P22E = Zero
                            Sleep (0x28)
                        }
                    }

                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Method (XEJX, 1, NotSerialized)
                        {
                            Sleep (0x28)
                            ^^^^SMBS.P3BO = Zero
                            ^^^^SMBS.P3BE = Zero
                            Sleep (0x28)
                        }
                    }
                }
            }

            Scope (EHC1)
            {
                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Name (_ADR, 0x02)  // _ADR: Address
                            Return (Zero)
                        }

                        Method (XEJX, 1, NotSerialized)
                        {
                            Sleep (0x28)
                            ^^^^SMBS.P22O = One
                            ^^^^SMBS.P22E = Zero
                            Sleep (0x28)
                        }
                    }

                    Device (PRT3)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Method (XEJX, 1, NotSerialized)
                        {
                            Sleep (0x28)
                            ^^^^SMBS.P3BO = Zero
                            ^^^^SMBS.P3BE = Zero
                            Sleep (0x28)
                        }
                    }
                }
            }

            Scope (OHC4)
            {
                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT1)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (PRT2)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Method (XEJX, 1, NotSerialized)
                        {
                            Sleep (0x28)
                            ^^^^SMBS.O007 = Zero
                            ^^^^SMBS.E007 = Zero
                            Sleep (0x28)
                        }
                    }
                }
            }

            Scope (PB4.VGA)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    Sleep (0x28)
                    ^^^VGA.PX02 (Zero)
                    Sleep (0x28)
                }
            }

            Scope (PB5.XPDV)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    CreateWordField (CALB, Zero, SZZE)
                    CreateField (CALB, 0x10, 0x03, FUCC)
                    CreateField (CALB, 0x13, 0x05, DEVV)
                    CreateField (CALB, 0x18, 0x08, BUSS)
                    CreateByteField (CALB, 0x04, HPST)
                    SZZE = 0x05
                    FUCC = Zero
                    DEVV = 0x05
                    BUSS = Zero
                    HPST = Zero
                    ALIB
                    0x06
                    CALB
                    Sleep (0x28)
                    Local0 = ^^^SMBS.MS01 /* \_SB_.PCI0.SMBS.MS01 */
                    Local0 &= 0x0F
                    ^^^SMBS.MS01 = Local0
                    Sleep (0x28)
                    Local0 = ^^^SMBS.PO3F /* \_SB_.PCI0.SMBS.PO3F */
                    Local0 |= 0x0E
                    ^^^SMBS.PO3F = Local0
                    Sleep (0x28)
                    ^^^SMBS.PB5O = Zero
                    ^^^SMBS.PB5E = Zero
                    Sleep (0x28)
                }
            }

            Scope (PB6.XPDV)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    CreateWordField (CALB, Zero, SZZE)
                    CreateField (CALB, 0x10, 0x03, FUCC)
                    CreateField (CALB, 0x13, 0x05, DEVV)
                    CreateField (CALB, 0x18, 0x08, BUSS)
                    CreateByteField (CALB, 0x04, HPST)
                    SZZE = 0x05
                    FUCC = Zero
                    DEVV = 0x06
                    BUSS = Zero
                    HPST = Zero
                    ALIB
                    0x06
                    CALB
                    Sleep (0x28)
                    Local0 = ^^^SMBS.MS00 /* \_SB_.PCI0.SMBS.MS00 */
                    Local0 &= 0x0F
                    ^^^SMBS.MS00 = Local0
                    Sleep (0x28)
                    Local0 = ^^^SMBS.PO3D /* \_SB_.PCI0.SMBS.PO3D */
                    Local0 |= 0x0E
                    ^^^SMBS.PO3D = Local0
                    Sleep (0x28)
                    ^^^SMBS.PB4O = One
                    ^^^SMBS.PB4E = Zero
                    Sleep (0x28)
                }
            }

            Scope (SPB1.XPDV)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    ^^^SPB0.GHPS (One, One)
                    Local0 = ^^^SMBS.MS03 /* \_SB_.PCI0.SMBS.MS03 */
                    Local0 &= 0x0F
                    ^^^SMBS.MS03 = Local0
                    Local0 = ^^^SMBS.PO2E /* \_SB_.PCI0.SMBS.PO2E */
                    Local0 |= 0x0E
                    ^^^SMBS.PO2E = Local0
                    Sleep (0x28)
                    ^^^SMBS.P6CO = Zero
                    ^^^SMBS.P6CE = Zero
                    Sleep (0x28)
                }
            }

            Scope (SPB2.XPDV)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    ^^^SPB0.GHPS (One, 0x02)
                    Sleep (0x28)
                    Local0 = ^^^SMBS.MS01 /* \_SB_.PCI0.SMBS.MS01 */
                    Local0 &= 0xF0
                    ^^^SMBS.MS01 = Local0
                    Sleep (0x28)
                    Local0 = ^^^SMBS.PO3E /* \_SB_.PCI0.SMBS.PO3E */
                    Local0 |= 0x0E
                    ^^^SMBS.PO3E = Local0
                    Sleep (0x28)
                    ^^^SMBS.PC7O = One
                    ^^^SMBS.PC7E = Zero
                    Sleep (0x28)
                }
            }

            Scope (SPB3.XPDV)
            {
                Method (XEJX, 1, NotSerialized)
                {
                    ^^^SPB0.GHPS (One, 0x03)
                    Sleep (0x28)
                    Local0 = ^^^SMBS.MS02 /* \_SB_.PCI0.SMBS.MS02 */
                    Local0 &= 0xF0
                    ^^^SMBS.MS02 = Local0
                    Sleep (0x28)
                    Local0 = ^^^SMBS.PO40 /* \_SB_.PCI0.SMBS.PO40 */
                    Local0 |= 0x0E
                    ^^^SMBS.PO40 = Local0
                    Sleep (0x28)
                    ^^^SMBS.P01O = One
                    ^^^SMBS.P01E = Zero
                    Sleep (0x28)
                }
            }

            Scope (SATA)
            {
                Device (ODDZ)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Name (ODPS, Zero)
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((^^^AFD.ODZP == 0x80000000))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
                    {
                        P80H = 0xDF00
                        If ((^^^AFD.ODZP == 0x80000001))
                        {
                            If ((VIDI == 0x78041022))
                            {
                                Sleep (0x28)
                                ^^^SMBS.PAAO = Zero
                                ^^^SMBS.PAAE = Zero
                                ^^^SMBS.P35O = One
                                ^^^SMBS.P35E = Zero
                                Sleep (0x28)
                            }
                        }

                        ODPS = Zero
                    }

                    Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
                    {
                        P80H = 0xDF03
                        If ((^^^AFD.ODZP == 0x80000001))
                        {
                            If ((VIDI == 0x78041022))
                            {
                                Sleep (0x28)
                                ^^^SMBS.PAAO = Zero
                                ^^^SMBS.PAAE = Zero
                                ^^^SMBS.P35O = Zero
                                ^^^SMBS.P35E = Zero
                                Sleep (0x28)
                            }
                        }

                        ODPS = 0x03
                    }

                    Method (_PSC, 0, NotSerialized)  // _PSC: Power State Current
                    {
                        Return (ODPS) /* \_SB_.PCI0.SATA.ODDZ.ODPS */
                    }

                    Device (ODD)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }

                        Method (XEJX, 1, NotSerialized)
                        {
                            Sleep (0x28)
                            ^^^^SMBS.PAAO = Zero
                            ^^^^SMBS.PAAE = Zero
                            ^^^^SMBS.P35O = Zero
                            ^^^^SMBS.P35E = Zero
                            Sleep (0x28)
                        }
                    }
                }
            }
        }

        OperationRegion (PIRQ, SystemIO, 0x0C00, 0x02)
        Field (PIRQ, ByteAcc, NoLock, Preserve)
        {
            PIDX,   8, 
            PDAT,   8
        }

        IndexField (PIDX, PDAT, ByteAcc, NoLock, Preserve)
        {
            PIRA,   8, 
            PIRB,   8, 
            PIRC,   8, 
            PIRD,   8, 
            PIRE,   8, 
            PIRF,   8, 
            PIRG,   8, 
            PIRH,   8, 
            Offset (0x10), 
            PIRS,   8, 
            Offset (0x13), 
            HDAD,   8, 
            Offset (0x15), 
            GEC,    8, 
            Offset (0x30), 
            USB1,   8, 
            USB2,   8, 
            USB3,   8, 
            USB4,   8, 
            USB5,   8, 
            USB6,   8, 
            USB7,   8, 
            Offset (0x40), 
            IDE,    8, 
            SATA,   8, 
            Offset (0x50), 
            GPP0,   8, 
            GPP1,   8, 
            GPP2,   8, 
            GPP3,   8
        }

        OperationRegion (KBDD, SystemIO, 0x64, One)
        Field (KBDD, ByteAcc, NoLock, Preserve)
        {
            PD64,   8
        }

        Method (DSPI, 0, NotSerialized)
        {
            INTA (0x1F)
            INTB (0x1F)
            INTC (0x1F)
            INTD (0x1F)
            Local1 = PD64 /* \_SB_.PD64 */
            PIRE = 0x1F
            PIRF = 0x1F
            PIRG = 0x1F
            PIRH = 0x1F
        }

        Method (INTA, 1, NotSerialized)
        {
            PIRA = Arg0
            If (PICM)
            {
                HDAD = Arg0
                GEC = Arg0
                GPP0 = Arg0
                GPP0 = Arg0
            }
        }

        Method (INTB, 1, NotSerialized)
        {
            PIRB = Arg0
            If (PICM)
            {
                USB2 = Arg0
                USB4 = Arg0
                USB6 = Arg0
                GPP1 = Arg0
                IDE = Arg0
            }
        }

        Method (INTC, 1, NotSerialized)
        {
            PIRC = Arg0
            If (PICM)
            {
                USB1 = Arg0
                USB3 = Arg0
                USB5 = Arg0
                USB7 = Arg0
                GPP2 = Arg0
            }
        }

        Method (INTD, 1, NotSerialized)
        {
            PIRD = Arg0
            If (PICM)
            {
                SATA = Arg0
                GPP3 = Arg0
            }
        }

        Name (PRS1, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,7,10,11,12,14,15}
        })
        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {15}
        })
        Name (IPRA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,10,11}
        })
        Name (IPRB, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,10,11}
        })
        Name (IPRC, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,10,11}
        })
        Name (IPRD, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,10,11}
        })
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRA)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTA (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRA) /* \_SB_.PIRA */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRA = Local0
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRB)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTB (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRB) /* \_SB_.PIRB */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRB = Local0
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRC)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTC (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRC) /* \_SB_.PIRC */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRC = Local0
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRD)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                INTD (0x1F)
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRD) /* \_SB_.PIRD */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRD = Local0
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x05)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRE)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRE = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRE) /* \_SB_.PIRE */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRE = Local0
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x06)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRF)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRF = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRF) /* \_SB_.PIRF */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRF = Local0
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x07)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRG)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRG = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRG) /* \_SB_.PIRG */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRG = Local0
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
            Name (_UID, 0x08)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (PIRH)
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (0x09)
                }
            }

            Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
            {
                Return (PRS1) /* \_SB_.PRS1 */
            }

            Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
            {
                PIRH = 0x1F
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUFA, One, IRQX)
                IRQX = (One << PIRH) /* \_SB_.PIRH */
                Return (BUFA) /* \_SB_.BUFA */
            }

            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Local0--
                PIRH = Local0
            }
        }

        Mutex (LSMI, 0x00)
        Method (GSMI, 1, NotSerialized)
        {
            Acquire (LSMI, 0xFFFF)
            APMD = Arg0
            APMC = 0xE4
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Release (LSMI)
        }

        Method (S80H, 1, NotSerialized)
        {
            Acquire (LSMI, 0xFFFF)
            APMD = Arg0
            APMC = 0xE5
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Stall (0xFF)
            Release (LSMI)
        }

        Method (BSMI, 1, NotSerialized)
        {
            Acquire (LSMI, 0xFFFF)
            APMD = Arg0
            APMC = 0xBE
            Stall (0xFF)
            Release (LSMI)
        }

        Method (OSMI, 2, NotSerialized)
        {
            Acquire (LSMI, 0xFFFF)
            OPR0 = Arg0
            OPR1 = Arg1
            OPR2 = Zero
            APMC = 0xC7
            Stall (0xFF)
            Release (LSMI)
        }

        Method (MSMI, 2, NotSerialized)
        {
            Acquire (LSMI, 0xFFFF)
            OPR0 = Arg0
            OPR1 = Arg1
            OPR2 = One
            APMC = 0xC7
            Stall (0xFF)
            Release (LSMI)
        }

        Method (HSMI, 2, NotSerialized)
        {
            Acquire (LSMI, 0xFFFF)
            OPR0 = Arg0
            OPR1 = Arg1
            OPR2 = 0x02
            APMC = 0xC7
            Stall (0xFF)
            Release (LSMI)
        }

        Method (FSMI, 2, NotSerialized)
        {
            Acquire (LSMI, 0xFFFF)
            OPR0 = Arg0
            OPR1 = Arg1
            OPR2 = 0x03
            APMC = 0xC7
            Stall (0xFF)
            Release (LSMI)
        }

        Device (TVAP)
        {
            Name (_HID, EisaId ("TOS1900"))  // _HID: Hardware ID
            Scope (\_SB)
            {
                Name (HM01, Zero)
                Name (HM02, Zero)
                Name (HM03, Zero)
                Name (HM04, Zero)
                Name (HM05, Zero)
                Name (HM06, Zero)
                Name (HM07, Zero)
                Name (HM08, Zero)
                Name (HM09, Zero)
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((MYOS >= 0x07D6))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (_DDN, "VALZeneral")  // _DDN: DOS Device Name
            Name (VZOK, Zero)
            Name (VBFG, 0x11)
            Name (VALF, Zero)
            Name (VRFS, Zero)
            Name (SPFG, Zero)
            Name (GSFX, Zero)
            Name (GSFY, Zero)
            Name (GSFZ, Zero)
            Name (GSBF, Zero)
            Name (OAFG, Zero)
            Name (HMX1, Zero)
            Name (HMY1, Zero)
            Name (HMX3, Zero)
            Name (HMY3, Zero)
            Name (HMX4, Zero)
            Name (HMY4, Zero)
            Name (REFT, Zero)
            Name (INTC, Zero)
            Name (PECT, Zero)
            Name (EXCC, Zero)
            Name (RFSC, Zero)
            Name (GPBA, Buffer (0x04){})
            Name (GPBB, Buffer (0x04){})
            Name (FSP2, Zero)
            Method (ENAB, 0, NotSerialized)
            {
                VZOK = One
                Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                Local0 = ^^PCI0.LPC0.EC0.RFST /* \_SB_.PCI0.LPC0.EC0_.RFST */
                Release (^^PCI0.LPC0.EC0.MUT1)
                VRFS = Local0
            }

            Method (EVNT, 1, NotSerialized)
            {
                While (VZOK)
                {
                    If ((VZOK == One))
                    {
                        VZOK = Arg0
                        Notify (TVAP, 0x80) // Status Change
                        Return (Zero)
                    }
                    Else
                    {
                        If ((VALF == 0x1E))
                        {
                            VZOK = One
                            VALF = Zero
                            Return (Zero)
                        }

                        Sleep (0x64)
                        VALF += One
                    }
                }
            }

            Name (OA30, Buffer (0x34){})
            CreateField (OA30, Zero, 0x20, OA01)
            CreateField (OA30, 0x20, 0x20, OA02)
            CreateField (OA30, 0x40, 0x20, OA03)
            CreateField (OA30, 0x60, 0x20, OA04)
            CreateField (OA30, 0x80, 0x20, OA05)
            CreateField (OA30, 0xA0, 0x20, OA06)
            CreateField (OA30, 0xC0, 0x20, OA07)
            CreateField (OA30, 0xE0, 0x20, OA08)
            CreateField (OA30, 0x0100, 0x20, OA09)
            CreateField (OA30, 0x0120, 0x20, OA0A)
            CreateField (OA30, 0x0140, 0x20, OA0B)
            CreateField (OA30, 0x0160, 0x20, OA0C)
            CreateField (OA30, 0x0180, 0x20, OA0D)
            Name (HMBB, Buffer (0x1C){})
            CreateField (HMBB, Zero, 0x60, HMPN)
            CreateField (HMBB, 0x60, 0x60, HMMN)
            CreateField (HMBB, 0xC0, 0x10, HMMD)
            CreateField (HMBB, 0xD0, 0x10, HMSN)
            Name (HMBT, Package (0x06)
            {
                Buffer (0x1C){}, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (BRBU, Zero)
            Method (ABCD, 0, NotSerialized)
            {
                Return (Zero)
            }

            Method (HMB1, 0, NotSerialized)
            {
                If (MBTS)
                {
                    HMPN = MBPN /* \_SB_.MBPN */
                    HMMN = MBMN /* \_SB_.MBMN */
                    HMMD = MBMD /* \_SB_.MBMD */
                    HMSN = BTSN /* \_SB_.BTSN */
                    HMBT [One] = ToBCD (MCLC)
                    HMBT [Zero] = HMBB /* \_SB_.TVAP.HMBB */
                    Return (HMBT) /* \_SB_.TVAP.HMBT */
                }
                Else
                {
                    HMPN = Zero
                    HMMN = Zero
                    HMMD = Zero
                    HMSN = Zero
                    HMBT [One] = Zero
                    HMBT [Zero] = HMBB /* \_SB_.TVAP.HMBB */
                    Return (HMBT) /* \_SB_.TVAP.HMBT */
                }
            }

            Method (HMB2, 0, NotSerialized)
            {
                Return (Zero)
            }

            Method (INFO, 0, Serialized)
            {
                If ((VZOK == 0x02))
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local0 = ^^PCI0.LPC0.EC0.VEVT /* \_SB_.PCI0.LPC0.EC0_.VEVT */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0x03))
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local0 = ^^PCI0.LPC0.EC0.FEVT /* \_SB_.PCI0.LPC0.EC0_.FEVT */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0x04))
                {
                    Local0 = 0x0C9F
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xC0))
                {
                    Local0 = 0x1BB2
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xC1))
                {
                    Local0 = 0x1BB3
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xC2))
                {
                    Local0 = 0x1BB0
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xC3))
                {
                    Local0 = 0x1BB1
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB0))
                {
                    Local0 = 0x19B0
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB1))
                {
                    Local0 = 0x19B1
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB2))
                {
                    Local0 = 0x19B2
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB3))
                {
                    Local0 = 0x19B3
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB6))
                {
                    Local0 = 0x19B6
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB7))
                {
                    Local0 = 0x19B7
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB4))
                {
                    Local0 = 0x0401
                    VZOK = One
                    Return (Local0)
                }
                ElseIf ((VZOK == 0xB5))
                {
                    Local0 = 0x0402
                    VZOK = One
                    Return (Local0)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (VALI, Package (0x06)
            {
                Ones, 
                Ones, 
                Ones, 
                Ones, 
                Ones, 
                Ones
            })
            Name (VALO, Package (0x06)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (GWFS, Package (0x06)
            {
                0xFE00, 
                0x56, 
                Zero, 
                One, 
                Zero, 
                Zero
            })
            Name (SWRN, Package (0x06)
            {
                0xFF00, 
                0x56, 
                One, 
                0x0200, 
                Zero, 
                Zero
            })
            Name (SWRF, Package (0x06)
            {
                0xFF00, 
                0x56, 
                Zero, 
                0x0200, 
                Zero, 
                Zero
            })
            Name (SURN, Package (0x06)
            {
                0xFF00, 
                0x56, 
                One, 
                0x0800, 
                Zero, 
                Zero
            })
            Name (SURF, Package (0x06)
            {
                0xFF00, 
                0x56, 
                Zero, 
                0x0800, 
                Zero, 
                Zero
            })
            Name (DI3G, Package (0x06)
            {
                0xFE00, 
                0x56, 
                Zero, 
                0x03, 
                Zero, 
                Zero
            })
            Name (TGRN, Package (0x06)
            {
                0xFF00, 
                0x56, 
                One, 
                0x2000, 
                Zero, 
                Zero
            })
            Name (TGRF, Package (0x06)
            {
                0xFF00, 
                0x56, 
                Zero, 
                0x2000, 
                Zero, 
                Zero
            })
            Name (TGPN, Package (0x06)
            {
                0xFF00, 
                0x56, 
                One, 
                0x4000, 
                Zero, 
                Zero
            })
            Name (TGPF, Package (0x06)
            {
                0xFF00, 
                0x56, 
                Zero, 
                0x4000, 
                Zero, 
                Zero
            })
            Name (GTPS, Package (0x06)
            {
                0xF300, 
                0x050E, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (STPD, Package (0x06)
            {
                0xF400, 
                0x050E, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (STPE, Package (0x06)
            {
                0xF400, 
                0x050E, 
                One, 
                Zero, 
                Zero, 
                Zero
            })
            Name (GFBS, Package (0x06)
            {
                0xF300, 
                0x015D, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (FBME, Package (0x06)
            {
                0xF400, 
                0x015D, 
                One, 
                Zero, 
                Zero, 
                Zero
            })
            Name (FBMD, Package (0x06)
            {
                0xF400, 
                0x015D, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (FNDS, Package (0x06)
            {
                0xFF00, 
                0x5A, 
                Zero, 
                One, 
                Zero, 
                Zero
            })
            Name (FNTP, Package (0x06)
            {
                0xFF00, 
                0x5A, 
                One, 
                One, 
                Zero, 
                Zero
            })
            Name (FNTC, Package (0x06)
            {
                0xFF00, 
                0x5A, 
                0x02, 
                One, 
                Zero, 
                Zero
            })
            Name (GCCM, Package (0x06)
            {
                0xFE00, 
                0x7F, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SCMP, Package (0x06)
            {
                0xFF00, 
                0x7F, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SCMS, Package (0x06)
            {
                0xFF00, 
                0x7F, 
                One, 
                Zero, 
                Zero, 
                Zero
            })
            Name (CESS, Package (0x06)
            {
                0xFE00, 
                0x62, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (GPNL, Package (0x06)
            {
                0xFE00, 
                0x11, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SHK0, Package (0x06)
            {
                0xFF00, 
                0xC000, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SHK1, Package (0x06)
            {
                0xFF00, 
                0xC000, 
                Zero, 
                One, 
                Zero, 
                Zero
            })
            Name (GHKM, Package (0x06)
            {
                0xFE00, 
                0xC000, 
                0x03, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SBED, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                One, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SBEE, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                0x03, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SHEE, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                0x09, 
                Zero, 
                Zero, 
                Zero
            })
            Name (SBHE, Package (0x06)
            {
                0xFF00, 
                0x1E, 
                0x0B, 
                Zero, 
                Zero, 
                Zero
            })
            Name (GBEM, Package (0x06)
            {
                0xFE00, 
                0x1E, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (HPG1, Package (0x06)
            {
                0xFE00, 
                0x6D, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (HPG2, Package (0x06)
            {
                0xFE00, 
                0x6D, 
                Zero, 
                One, 
                Zero, 
                Zero
            })
            Name (HPG3, Package (0x06)
            {
                0xFE00, 
                0x6D, 
                Zero, 
                0x0200, 
                Zero, 
                Zero
            })
            Name (HPG4, Package (0x06)
            {
                0xFE00, 
                0x6D, 
                Zero, 
                0x0201, 
                Zero, 
                Zero
            })
            Name (HPS1, Package (0x06)
            {
                0xFE00, 
                0x6D, 
                Zero, 
                0x0100, 
                Zero, 
                Zero
            })
            Name (HPS2, Package (0x06)
            {
                0xFE00, 
                0x6D, 
                Zero, 
                0x0102, 
                Zero, 
                Zero
            })
            Name (RMGW, Package (0x06)
            {
                0xFE00, 
                0x47, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (RMCW, Package (0x06)
            {
                0xFF00, 
                0x47, 
                0x5A00, 
                Zero, 
                Zero, 
                Zero
            })
            Name (RMGS, Package (0x06)
            {
                0xFE00, 
                0x61, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (RMSD, Package (0x06)
            {
                0xFF00, 
                0x61, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (RMSE, Package (0x06)
            {
                0xFF00, 
                0x61, 
                One, 
                Zero, 
                Zero, 
                Zero
            })
            Name (PANS, Package (0x06)
            {
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Name (PT01, Package (0x06)
            {
                0x02, 
                0x80, 
                One, 
                0xE0, 
                Zero, 
                Zero
            })
            Name (PT02, Package (0x06)
            {
                0x03, 
                0x20, 
                0x02, 
                0x58, 
                Zero, 
                Zero
            })
            Name (PT03, Package (0x06)
            {
                0x04, 
                Zero, 
                0x03, 
                Zero, 
                Zero, 
                Zero
            })
            Name (PT04, Package (0x06)
            {
                0x04, 
                Zero, 
                0x02, 
                0x58, 
                Zero, 
                Zero
            })
            Name (PT05, Package (0x06)
            {
                0x03, 
                0x20, 
                One, 
                0xE0, 
                Zero, 
                Zero
            })
            Name (PT06, Package (0x06)
            {
                0x05, 
                Zero, 
                0x04, 
                Zero, 
                Zero, 
                Zero
            })
            Name (PT07, Package (0x06)
            {
                0x05, 
                0x78, 
                0x04, 
                0x1A, 
                Zero, 
                Zero
            })
            Name (PT08, Package (0x06)
            {
                0x06, 
                0x40, 
                0x04, 
                0xB0, 
                Zero, 
                Zero
            })
            Name (PT09, Package (0x06)
            {
                0x05, 
                Zero, 
                0x02, 
                0x58, 
                Zero, 
                Zero
            })
            Name (PT0A, Package (0x06)
            {
                0x05, 
                Zero, 
                0x03, 
                0x20, 
                Zero, 
                Zero
            })
            Name (PT0B, Package (0x06)
            {
                0x05, 
                0xA0, 
                0x03, 
                0x84, 
                Zero, 
                Zero
            })
            Name (PT0C, Package (0x06)
            {
                0x06, 
                0x90, 
                0x04, 
                0x1A, 
                Zero, 
                Zero
            })
            Name (PT0D, Package (0x06)
            {
                0x07, 
                0x80, 
                0x04, 
                0xB0, 
                Zero, 
                Zero
            })
            Name (PT0E, Package (0x06)
            {
                0x05, 
                Zero, 
                0x03, 
                Zero, 
                Zero, 
                Zero
            })
            Name (PT0F, Package (0x06)
            {
                0x07, 
                0x80, 
                0x04, 
                0x38, 
                Zero, 
                Zero
            })
            Name (PT10, Package (0x06)
            {
                0x06, 
                0x90, 
                0x03, 
                0xB1, 
                Zero, 
                Zero
            })
            Name (PT11, Package (0x06)
            {
                0x05, 
                0x56, 
                0x03, 
                Zero, 
                Zero, 
                Zero
            })
            Name (PT12, Package (0x06)
            {
                0x06, 
                0x40, 
                0x03, 
                0x84, 
                Zero, 
                Zero
            })
            Name (PT13, Package (0x06)
            {
                0x04, 
                Zero, 
                0x02, 
                0x40, 
                Zero, 
                Zero
            })
            Method (MTCH, 2, NotSerialized)
            {
                If ((DerefOf (Arg0 [Zero]) != DerefOf (Arg1 [Zero]
                    )))
                {
                    Return (Zero)
                }

                If ((DerefOf (Arg0 [One]) != DerefOf (Arg1 [One]
                    )))
                {
                    Return (Zero)
                }

                If ((DerefOf (Arg0 [0x02]) != DerefOf (Arg1 [0x02]
                    )))
                {
                    Return (Zero)
                }

                If ((DerefOf (Arg0 [0x03]) != DerefOf (Arg1 [0x03]
                    )))
                {
                    Return (Zero)
                }

                If ((DerefOf (Arg0 [0x04]) != DerefOf (Arg1 [0x04]
                    )))
                {
                    Return (Zero)
                }

                If ((DerefOf (Arg0 [0x05]) != DerefOf (Arg1 [0x05]
                    )))
                {
                    Return (Zero)
                }

                Return (One)
            }

            Method (SPFC, 6, Serialized)
            {
                Name (_T_K, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_J, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_I, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_H, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_G, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_F, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_E, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_D, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_C, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_B, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_A, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_9, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_8, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_7, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_6, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_5, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_4, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_3, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_2, Zero)  // _T_x: Emitted by ASL Compiler
                Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                VALI [Zero] = ToInteger (Arg0)
                VALI [One] = ToInteger (Arg1)
                VALI [0x02] = ToInteger (Arg2)
                VALI [0x03] = ToInteger (Arg3)
                VALI [0x04] = ToInteger (Arg4)
                VALI [0x05] = ToInteger (Arg5)
                VALO [Zero] = Zero
                VALO [One] = Zero
                VALO [0x02] = Zero
                VALO [0x03] = Zero
                VALO [0x04] = Zero
                VALO [0x05] = Zero
                Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                Local0 = ^^PCI0.LPC0.EC0.POLG /* \_SB_.PCI0.LPC0.EC0_.POLG */
                Release (^^PCI0.LPC0.EC0.MUT1)
                If ((Local0 == Zero))
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    ^^PCI0.LPC0.EC0.POLG = One
                    Release (^^PCI0.LPC0.EC0.MUT1)
                }

                Local0 = ToInteger (Arg1)
                Local0 &= 0x00FFFFFF
                Local1 = ToInteger (Arg1)
                Local1 &= 0xFFFF
                Switch (ToInteger (Local0))
                {
                    Case (0x56)
                    {
                        If (MTCH (VALI, GWFS))
                        {
                            Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Local0 = ^^PCI0.LPC0.EC0.KSWH /* \_SB_.PCI0.LPC0.EC0_.KSWH */
                            Local0 ^= One
                            Local2 = ^^PCI0.LPC0.EC0.W3GE /* \_SB_.PCI0.LPC0.EC0_.W3GE */
                            Local1 = VRFS /* \_SB_.TVAP.VRFS */
                            Local1 <<= 0x09
                            Release (^^PCI0.LPC0.EC0.MUT1)
                            Local2 <<= 0x0D
                            If (Local0)
                            {
                                Local0 |= Local1
                                Local0 |= Local2
                            }

                            VALO [0x02] = Local0
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, SWRN))
                        {
                            FSMI (0x23, Zero)
                            VALO [Zero] = Zero
                            Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            ^^PCI0.LPC0.EC0.WLAN = WLAN /* \_SB_.WLAN */
                            Release (^^PCI0.LPC0.EC0.MUT1)
                            VRFS = One
                        }
                        ElseIf (MTCH (VALI, SWRF))
                        {
                            FSMI (0x24, Zero)
                            VALO [Zero] = Zero
                            Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            ^^PCI0.LPC0.EC0.WLAN = WLAN /* \_SB_.WLAN */
                            Release (^^PCI0.LPC0.EC0.MUT1)
                            VRFS = Zero
                        }
                        ElseIf (MTCH (VALI, SURN)){}
                        ElseIf (MTCH (VALI, SURF)){}
                        ElseIf (MTCH (VALI, TGRN))
                        {
                            FSMI (0x3A, Zero)
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, TGRF))
                        {
                            FSMI (0x3B, Zero)
                            VALO [Zero] = Zero
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x050E)
                    {
                        If (MTCH (VALI, GTPS))
                        {
                            Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Local0 = ^^PCI0.LPC0.EC0.TPAD /* \_SB_.PCI0.LPC0.EC0_.TPAD */
                            Local0 ^= One
                            Release (^^PCI0.LPC0.EC0.MUT1)
                            VALO [0x02] = Local0
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, STPE))
                        {
                            FSMI (0x5A, Zero)
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, STPD))
                        {
                            FSMI (0x5B, Zero)
                            VALO [Zero] = Zero
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x015D)
                    {
                        If (MTCH (VALI, GFBS))
                        {
                            If (OG09)
                            {
                                VALO [0x02] = Zero
                            }
                            Else
                            {
                                VALO [0x02] = One
                            }

                            VALO [Zero] = One
                            VALO [0x04] = Zero
                        }
                        ElseIf (MTCH (VALI, FBME))
                        {
                            VALO [Zero] = One
                            OG09 = Zero
                            OSMI (0x1A, One)
                        }
                        ElseIf (MTCH (VALI, FBMD))
                        {
                            VALO [Zero] = One
                            OG09 = One
                            OSMI (0x1A, One)
                        }
                        Else
                        {
                            VALO [Zero] = 0x8300
                        }
                    }
                    Case (0x5A)
                    {
                        If (MTCH (VALI, FNDS))
                        {
                            OWNS = Zero
                            HSMI (0x02, One)
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, FNTP))
                        {
                            OWNS = One
                            HSMI (0x02, One)
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, FNTC))
                        {
                            OWNS = 0x02
                            HSMI (0x02, One)
                            VALO [Zero] = Zero
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x7F)
                    {
                        If (MTCH (VALI, GCCM))
                        {
                            Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            Local0 = ^^PCI0.LPC0.EC0.TMOD /* \_SB_.PCI0.LPC0.EC0_.TMOD */
                            Release (^^PCI0.LPC0.EC0.MUT1)
                            VALO [0x02] = Local0
                            VALO [0x03] = One
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, SCMP))
                        {
                            Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            ^^PCI0.LPC0.EC0.TMOD = Zero
                            Release (^^PCI0.LPC0.EC0.MUT1)
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, SCMS))
                        {
                            Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                            ^^PCI0.LPC0.EC0.TMOD = One
                            Release (^^PCI0.LPC0.EC0.MUT1)
                            VALO [Zero] = Zero
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x62)
                    {
                        If ((ToInteger (Arg0) == 0xFE00))
                        {
                            If ((ENSR == 0x02))
                            {
                                VALO [Zero] = Zero
                                VALO [0x03] = 0x21
                            }
                            Else
                            {
                                VALO [Zero] = Zero
                                VALO [0x03] = Zero
                            }
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x11)
                    {
                        Name (PBUF, Buffer (0x0200)
                        {
                             0x00                                             /* . */
                        })
                        CreateField (PBUF, Zero, 0x10, P000)
                        OSMI (0x0B, Zero)
                        PBUF = OWNS /* \OWNS */
                        Local0 = P000 /* \_SB_.TVAP.SPFC.P000 */
                        VALO [Zero] = Zero
                        VALO [0x02] = ToInteger (Local0)
                    }
                    Case (0xC000)
                    {
                        If (MTCH (VALI, SHK0))
                        {
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, SHK1))
                        {
                            VALO [Zero] = Zero
                        }
                        ElseIf (MTCH (VALI, GHKM))
                        {
                            VALO [0x03] = Zero
                            VALO [Zero] = Zero
                            Local0 = Zero
                            If ((^^PCI0.SMBS.I050 == Zero))
                            {
                                Local0 |= 0x10
                                VALO [0x03] = Local0
                            }
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x1E)
                    {
                        If ((ToInteger (Arg0) == 0xFF00))
                        {
                            Local0 = ToInteger (Arg2)
                            VBFG = (Local0 & 0x1B)
                            Local1 = ((Local1 = (Local0 >> One)) ^ One)
                            BEUE = Local1
                            Local1 = ((Local1 = (Local0 >> 0x03)) ^ One)
                            HEUE = Local1
                            If ((FKSF && FKCS))
                            {
                                If (((Local2 = (Local0 & 0x10)) == 0x10))
                                {
                                    OSMI (0x22, 0x11)
                                }
                                Else
                                {
                                    OSMI (0x22, 0x10)
                                }
                            }

                            Local0 = ToInteger (Arg3)
                            If ((Local0 & 0xFE))
                            {
                                VALO [Zero] = 0x8300
                            }
                            ElseIf (Local0)
                            {
                                HEBC = One
                            }
                            Else
                            {
                                HEBC = Zero
                            }
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFE00))
                        {
                            If (FKME)
                            {
                                VBFG |= 0x10
                            }
                            Else
                            {
                                VBFG &= 0x0F
                            }

                            VALO [0x02] = VBFG /* \_SB_.TVAP.VBFG */
                            VALO [0x03] = HEBC /* \_SB_.HEBC */
                        }
                    }
                    Case (0xB7)
                    {
                        While (One)
                        {
                            _T_1 = ToInteger (Arg0)
                            If ((_T_1 == 0xFE00))
                            {
                                VALO [Zero] = Zero
                                FSMI (0x10, Zero)
                                Local0 = ToInteger (KBIN)
                                If ((Local0 == One))
                                {
                                    VALO [0x02] = One
                                }
                                ElseIf ((Local0 == Zero))
                                {
                                    VALO [0x02] = Zero
                                }
                            }
                            ElseIf ((_T_1 == 0xFF00))
                            {
                                Local0 = ToInteger (Arg2)
                                If ((Local0 == One))
                                {
                                    VALO [Zero] = Zero
                                    FSMI (0x11, One)
                                }
                                ElseIf ((Local0 == Zero))
                                {
                                    VALO [Zero] = Zero
                                    FSMI (0x11, Zero)
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8000
                            }

                            Break
                        }
                    }
                    Case (0x0150)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            If ((ToInteger (^^PCI0.SMBS.I171) == Zero))
                            {
                                VALO [Zero] = Zero
                                If ((ToInteger (Arg5) == Zero))
                                {
                                    VALO [One] = 0x800C
                                    OSMI (0x0E, Zero)
                                    VALO [0x02] = SLPB /* \SLPB */
                                    VALO [0x03] = 0x04000029
                                    VALO [0x04] = 0x04000000
                                }
                                ElseIf ((ToInteger (Arg5) == 0x0100))
                                {
                                    VALO [One] = 0x8001
                                    VALO [0x02] = One
                                }
                                ElseIf ((ToInteger (Arg5) == 0x0101))
                                {
                                    VALO [One] = 0x800C
                                    VALO [0x02] = 0x04000029
                                }
                                ElseIf ((ToInteger (Arg5) == 0x0200))
                                {
                                    VALO [One] = 0x800D
                                    Local0 = Zero
                                    VALO [0x02] = ((^^PCI0.LPC0.EC0.SLPL << 0x10) | ^^PCI0.LPC0.EC0.SLPM) /* \_SB_.PCI0.LPC0.EC0_.SLPM */
                                    If ((^^PCI0.LPC0.EC0.MBTS == One))
                                    {
                                        VALO [0x03] = 0x00640005
                                    }
                                    Else
                                    {
                                        VALO [0x03] = 0x00640001
                                    }

                                    If ((^^PCI0.LPC0.EC0.MBTS == One))
                                    {
                                        VALO [0x04] = 0x000A0004
                                    }
                                    Else
                                    {
                                        VALO [0x04] = 0x000A0001
                                    }
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            If ((ToInteger (^^PCI0.SMBS.I171) == Zero))
                            {
                                If ((ToInteger (Arg5) == Zero))
                                {
                                    Local0 = ToInteger (Arg2)
                                    If ((((Local0 == 0x04000000) || (Local0 == 0x04000009)) || (Local0 == 0x04000021)))
                                    {
                                        SLPB = ToInteger (Arg2)
                                        OSMI (0x0E, One)
                                        VALO [Zero] = Zero
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }
                                }
                                ElseIf ((ToInteger (Arg5) == 0x0200))
                                {
                                    Local0 = ToInteger (Arg2)
                                    If (((Local0 & 0xFF80FFF8) != Zero))
                                    {
                                        VALO [Zero] = 0x8300
                                    }
                                    ElseIf ((((Local0 & 0x07) == One) || ((Local0 & 
                                        0x07) == 0x04)))
                                    {
                                        If (((Local0 >> 0x10) > 0x64))
                                        {
                                            VALO [Zero] = 0x8300
                                        }
                                        ElseIf ((((Local0 & 0x07) == 0x04) && (^^PCI0.LPC0.EC0.MBTS == Zero)))
                                        {
                                            VALO [Zero] = 0x8300
                                        }
                                        Else
                                        {
                                            ^^PCI0.LPC0.EC0.SLPM = (Local0 & 0x07)
                                            ^^PCI0.LPC0.EC0.SLPL = (Local0 >> 0x10)
                                            VALO [Zero] = Zero
                                        }
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8000
                            }
                        }
                    }
                    Case (0x67)
                    {
                        If ((ToInteger (Arg0) == 0xFE00))
                        {
                            If ((ToInteger (Arg3) == Zero))
                            {
                                VALO [Zero] = Zero
                                Local1 = Zero
                                Local1 = ((ACDF << 0x07) | PSRO) /* \_SB_.PSRO */
                                VALO [0x02] = Local1
                                VALO [0x04] = One
                            }
                            ElseIf ((ToInteger (Arg3) == One))
                            {
                                VALO [0x02] = ((PSST << 0x10) | PSET) /* \_SB_.PSET */
                                VALO [0x04] = One
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            If ((ToInteger (Arg3) == Zero))
                            {
                                Local0 = ToInteger (Arg2)
                                If ((((((((Local0 == Zero) || (Local0 == 
                                    0x10)) || (Local0 == 0x11)) || (Local0 == 0x20)) || (Local0 == 0x21)) || (Local0 == 0x40)) || 
                                    (Local0 == 0x41)))
                                {
                                    If ((Local0 == Zero))
                                    {
                                        PE00 = Zero
                                        PE01 = Zero
                                        PE02 = Zero
                                        OWNS = Zero
                                        HSMI (0x20, One)
                                    }
                                    ElseIf ((Local0 == 0x10))
                                    {
                                        PE00 = One
                                        OWNS = One
                                        HSMI (0x20, One)
                                    }
                                    ElseIf ((Local0 == 0x11))
                                    {
                                        PE00 = Zero
                                        OWNS = 0x04
                                        HSMI (0x20, One)
                                    }
                                    ElseIf ((Local0 == 0x20))
                                    {
                                        PE01 = One
                                        OWNS = 0x02
                                        HSMI (0x20, One)
                                    }
                                    ElseIf ((Local0 == 0x21))
                                    {
                                        PE01 = Zero
                                        OWNS = 0x05
                                        HSMI (0x20, One)
                                    }
                                    ElseIf ((Local0 == 0x40))
                                    {
                                        PE02 = One
                                        OWNS = 0x03
                                        HSMI (0x20, One)
                                    }
                                    ElseIf ((Local0 == 0x41))
                                    {
                                        PE02 = Zero
                                        OWNS = 0x06
                                        HSMI (0x20, One)
                                    }

                                    Local1 = Zero
                                    Local1 = (PE00 | ((PE01 << One) | (PE02 << 0x02)
                                        ))
                                    VALO [Zero] = Zero
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }
                            }
                            ElseIf ((ToInteger (Arg3) == One))
                            {
                                Local0 = ToInteger (Arg2)
                                If (((Local0 & 0xFFFF) > 0x05A0))
                                {
                                    VALO [Zero] = 0x8300
                                }
                                ElseIf ((((Local0 & 0xFFFF0000) >> 0x10) > 0x05A0))
                                {
                                    VALO [Zero] = 0x8300
                                }
                                ElseIf (((Local0 > Zero) && (((Local0 & 0xFFFF0000
                                    ) >> 0x10) >= (Local0 & 0xFFFF))))
                                {
                                    VALO [Zero] = 0x8300
                                }
                                Else
                                {
                                    PSST = (Local0 >> 0x10)
                                    PSET = (Local0 & 0xFFFF)
                                    If ((Local0 > Zero))
                                    {
                                        OWNS = 0x07
                                        HSMI (0x20, One)
                                    }

                                    VALO [Zero] = Zero
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0xC3)
                    {
                        If ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [Zero] = Zero
                            VALO [0x02] = PSS5 /* \_SB_.PSS5 */
                            VALO [0x04] = Zero
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            Local0 = ToInteger (Arg2)
                            If (((Local0 == Zero) || (Local0 == One)))
                            {
                                PSS5 = Local0
                                If ((Local0 == One))
                                {
                                    OSMI (0x14, One)
                                }

                                If ((((ToInteger (Arg3) == Zero) || (ToInteger (Arg3) == 
                                    One)) || (ToInteger (Arg3) == 0x02)))
                                {
                                    OWNS = ToInteger (Arg3)
                                    HSMI (0x1F, One)
                                    VALO [Zero] = Zero
                                }
                            }
                        }
                    }
                    Case (0x2A)
                    {
                        If ((MYOS == 0x07DC))
                        {
                            VALO [Zero] = 0x8000
                        }
                        Else
                        {
                            VALO [Zero] = Zero
                            While (One)
                            {
                                _T_2 = BLVL /* \_SB_.BLVL */
                                If ((_T_2 == Zero))
                                {
                                    VALO [0x02] = Zero
                                }
                                ElseIf ((_T_2 == One))
                                {
                                    VALO [0x02] = 0x2000
                                }
                                ElseIf ((_T_2 == 0x02))
                                {
                                    VALO [0x02] = 0x4000
                                }
                                ElseIf ((_T_2 == 0x03))
                                {
                                    VALO [0x02] = 0x6000
                                }
                                ElseIf ((_T_2 == 0x04))
                                {
                                    VALO [0x02] = 0x8000
                                }
                                ElseIf ((_T_2 == 0x05))
                                {
                                    VALO [0x02] = 0xA000
                                }
                                ElseIf ((_T_2 == 0x06))
                                {
                                    VALO [0x02] = 0xC000
                                }
                                ElseIf ((_T_2 == 0x07))
                                {
                                    VALO [0x02] = 0xE000
                                }

                                Break
                            }

                            VALO [0x03] = 0xE000
                        }
                    }
                    Case (0x42)
                    {
                        While (One)
                        {
                            _T_3 = ToInteger (Arg2)
                            If ((_T_3 == One))
                            {
                                ^^REFT = One
                                VALO [Zero] = Zero
                            }
                            ElseIf ((_T_3 == 0x10))
                            {
                                ^^REFT = 0x10
                                VALO [Zero] = Zero
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }

                            Break
                        }
                    }
                    Case (0x9F)
                    {
                        If ((ToInteger (Arg0) == 0xFE00))
                        {
                            While (One)
                            {
                                _T_4 = ToInteger (Arg2)
                                If ((_T_4 == Zero))
                                {
                                    VALO [Zero] = Zero
                                    Local0 = EPFF /* \_SB_.EPFF */
                                    Local1 = EPFE /* \_SB_.EPFE */
                                    VALO [0x03] = ((Local0 << 0x08) | Local1)
                                }
                                ElseIf ((_T_4 == 0xFFFF))
                                {
                                    VALO [Zero] = Zero
                                    VALO [0x03] = 0x0200
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }

                                Break
                            }
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            While (One)
                            {
                                _T_5 = ToInteger (Arg2)
                                If ((_T_5 == Zero))
                                {
                                    VALO [Zero] = Zero
                                    Local0 = ToInteger (Arg3)
                                    EPFE = (Local0 & 0xFF)
                                    EPFF = ((Local0 >> 0x08) & 0xFF)
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }

                                Break
                            }
                        }
                    }
                    Case (0xA1)
                    {
                        While (One)
                        {
                            _T_6 = ToInteger (Arg5)
                            If ((_T_6 == Zero))
                            {
                                HM01 = One
                                VALO [Zero] = Zero
                            }
                            ElseIf ((_T_6 == One))
                            {
                                If ((HM01 == One))
                                {
                                    VALO [Zero] = Zero
                                    If ((ToInteger (Arg2) == One))
                                    {
                                        Local0 = MBTS /* \_SB_.MBTS */
                                        If (((PE00 == Zero) && (PE01 == One)))
                                        {
                                            Local0 = Zero
                                        }

                                        If (Local0)
                                        {
                                            Local0 = MBVG /* \_SB_.MBVG */
                                            Divide (Local0, 0x64, Local1, VALO [0x02])
                                        }
                                        Else
                                        {
                                            VALO [0x02] = 0xFF
                                        }
                                    }
                                    Else
                                    {
                                        VALO [0x02] = 0xFF
                                    }
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8D50
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }

                            Break
                        }
                    }
                    Case (0xA2)
                    {
                        While (One)
                        {
                            _T_7 = ToInteger (Arg5)
                            If ((_T_7 == Zero))
                            {
                                HM02 = One
                                VALO [Zero] = Zero
                            }
                            ElseIf ((_T_7 == One))
                            {
                                If ((HM02 == One))
                                {
                                    VALO [Zero] = Zero
                                    If ((ToInteger (Arg2) == Zero))
                                    {
                                        If ((ToInteger (Arg3) == Zero))
                                        {
                                            Local0 = FSPD /* \_SB_.FSPD */
                                            Divide (0x000F0000, Local0, Local0, VALO [0x02])
                                        }
                                        ElseIf ((ToInteger (Arg3) == One))
                                        {
                                            Divide (0x000F0000, FSPD, Local0, VALO [0x02])
                                            VALO [0x03] = (MAXS * 0x64)
                                        }
                                    }
                                    ElseIf ((ToInteger (Arg2) == One))
                                    {
                                        If ((ToInteger (Arg3) == Zero))
                                        {
                                            Divide (0x000F0000, FSP2, Local0, VALO [0x02])
                                        }
                                        ElseIf ((ToInteger (Arg3) == One))
                                        {
                                            Divide (0x000F0000, FSP2, Local0, VALO [0x02])
                                            VALO [0x03] = Zero
                                        }
                                    }
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8D50
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }

                            Break
                        }
                    }
                    Case (0xA6)
                    {
                        VALO [Zero] = 0x8000
                    }
                    Case (0xA7)
                    {
                        While (One)
                        {
                            _T_8 = ToInteger (Arg5)
                            If ((_T_8 == Zero))
                            {
                                HM04 = One
                                VALO [Zero] = Zero
                            }
                            ElseIf ((_T_8 == One))
                            {
                                If ((HM04 == One))
                                {
                                    VALO [Zero] = Zero
                                    Local0 = ACDF /* \_SB_.ACDF */
                                    If ((PE00 == One))
                                    {
                                        Local0 = Zero
                                    }

                                    If (Local0)
                                    {
                                        Local0 = Zero
                                        Local1 = ACCU /* \_SB_.ACCU */
                                        Local2 = ACCA /* \_SB_.ACCA */
                                        Local3 = ACVO /* \_SB_.ACVO */
                                        Local4 = CTMP /* \_SB_.CTMP */
                                        If (UMGA)
                                        {
                                            Local5 = 0xFF
                                        }
                                        Else
                                        {
                                            Local5 = RG59 /* \_SB_.RG59 */
                                        }

                                        VALO [0x02] = ((((((Local5 << 0x08
                                            ) | INTC) << 0x08) | Local4) << 0x08) | Local3)
                                        VALO [0x03] = ((Local2 << 0x10) | Local1)
                                    }
                                    Else
                                    {
                                        Local0 = Zero
                                        Local1 = CTMP /* \_SB_.CTMP */
                                        Local2 = RG59 /* \_SB_.RG59 */
                                        VALO [0x02] = ((((((Local2 << 0x08
                                            ) | INTC) << 0x08) | Local1) << 0x08) | 0xFF)
                                        VALO [0x03] = 0xFFFF
                                    }
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8D50
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }

                            Break
                        }
                    }
                    Case (0xA8)
                    {
                        While (One)
                        {
                            _T_9 = ToInteger (Arg4)
                            If ((_T_9 == 0x98))
                            {
                                While (One)
                                {
                                    _T_A = ToInteger (Arg5)
                                    If ((_T_A == Zero))
                                    {
                                        HM05 = One
                                        VALO [Zero] = Zero
                                    }
                                    ElseIf ((_T_A == One))
                                    {
                                        If ((HM05 == One))
                                        {
                                            VALO [Zero] = Zero
                                            If ((ToInteger (Arg2) == One))
                                            {
                                                If (MBTS)
                                                {
                                                    If (ACDF)
                                                    {
                                                        Local1 = MCUR /* \_SB_.MCUR */
                                                        VALO [0x02] = Local1
                                                        If ((PE00 == One))
                                                        {
                                                            Local1 = MCUR /* \_SB_.MCUR */
                                                            VALO [0x02] = (0xFFFF - Local1)
                                                        }
                                                    }
                                                    Else
                                                    {
                                                        Local1 = MCUR /* \_SB_.MCUR */
                                                        VALO [0x02] = (0xFFFF - Local1)
                                                    }

                                                    If (((PE00 == Zero) && (PE01 == One)))
                                                    {
                                                        VALO [0x02] = 0xFFFF
                                                    }

                                                    Local0 = MTEM /* \_SB_.MTEM */
                                                    Local0 -= 0x0AAC
                                                    Divide (Local0, 0x0A, Local0, VALO [0x03])
                                                }
                                                Else
                                                {
                                                    VALO [0x02] = 0xFFFF
                                                    VALO [0x03] = 0xFF
                                                }
                                            }
                                            Else
                                            {
                                                VALO [0x02] = 0xFFFF
                                                VALO [0x03] = 0xFF
                                            }
                                        }
                                        Else
                                        {
                                            VALO [Zero] = 0x8D50
                                        }
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }

                                    Break
                                }
                            }
                            ElseIf ((_T_9 == 0x9A))
                            {
                                While (One)
                                {
                                    _T_B = ToInteger (Arg5)
                                    If ((_T_B == Zero))
                                    {
                                        HM06 = One
                                        VALO [Zero] = Zero
                                    }
                                    ElseIf ((_T_B == One))
                                    {
                                        If ((HM06 == One))
                                        {
                                            VALO [Zero] = Zero
                                            If ((ToInteger (Arg2) == Zero))
                                            {
                                                VALO [0x02] = PWM1 /* \_SB_.PWM1 */
                                            }
                                            ElseIf ((ToInteger (Arg2) == One))
                                            {
                                                Local0 = PWM2 /* \_SB_.PWM2 */
                                                VALO [0x02] = Local0
                                            }
                                        }
                                        Else
                                        {
                                            VALO [Zero] = 0x8D50
                                        }
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }

                                    Break
                                }
                            }
                            ElseIf ((_T_9 == 0x9B))
                            {
                                While (One)
                                {
                                    _T_C = ToInteger (Arg5)
                                    If ((_T_C == Zero))
                                    {
                                        HM07 = One
                                        VALO [Zero] = Zero
                                    }
                                    ElseIf ((_T_C == One))
                                    {
                                        If ((HM07 == One))
                                        {
                                            VALO [Zero] = Zero
                                            If ((ToInteger (Arg2) == Zero))
                                            {
                                                VALO [0x03] = (Zero | VOLC) /* \_SB_.VOLC */
                                                VALO [0x02] = ((((((PAOC << 0x08
                                                    ) | ACAC) << 0x08) | FPOC) << 0x08) | PPBC) /* \_SB_.PPBC */
                                                VOLC = Zero
                                                PAOC = Zero
                                                ACAC = Zero
                                                FPOC = Zero
                                                PPBC = Zero
                                            }
                                            ElseIf ((ToInteger (Arg2) == One))
                                            {
                                                VALO [0x02] = BTCC /* \_SB_.BTCC */
                                                BTCC = Zero
                                            }
                                            ElseIf ((ToInteger (Arg2) == 0x02))
                                            {
                                                VALO [0x02] = GPBA /* \_SB_.TVAP.GPBA */
                                                VALO [0x03] = GPBB /* \_SB_.TVAP.GPBB */
                                            }
                                            Else
                                            {
                                                VALO [Zero] = 0x8300
                                            }
                                        }
                                        Else
                                        {
                                            VALO [Zero] = 0x8D50
                                        }
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }

                                    Break
                                }
                            }
                            ElseIf ((_T_9 == 0xA0))
                            {
                                If ((ToInteger (Arg0) == 0xFE00))
                                {
                                    While (One)
                                    {
                                        _T_D = ToInteger (Arg5)
                                        If ((_T_D == Zero))
                                        {
                                            HM08 = One
                                            VALO [Zero] = Zero
                                        }
                                        ElseIf ((_T_D == One))
                                        {
                                            If ((HM08 == One))
                                            {
                                                VALO [Zero] = Zero
                                                Local0 = ((PECC << 0x03) | (PECL << One))
                                                VALO [0x02] = (Local0 | PECB) /* \_SB_.PECB */
                                            }
                                            Else
                                            {
                                                VALO [Zero] = 0x8D50
                                            }
                                        }
                                        Else
                                        {
                                            VALO [Zero] = 0x8300
                                        }

                                        Break
                                    }

                                    If ((ToInteger (Arg3) != Zero))
                                    {
                                        VALO [Zero] = 0x8300
                                    }
                                }
                            }
                            ElseIf ((_T_9 == 0xA9))
                            {
                                While (One)
                                {
                                    _T_E = ToInteger (Arg5)
                                    If ((_T_E == Zero))
                                    {
                                        HM09 = One
                                        VALO [Zero] = Zero
                                    }
                                    ElseIf ((_T_E == One))
                                    {
                                        If ((HM09 == One))
                                        {
                                            VALO [Zero] = Zero
                                            While (One)
                                            {
                                                _T_F = ToInteger (Arg2)
                                                If ((_T_F == One))
                                                {
                                                    If (MBTS)
                                                    {
                                                        Local0 = MBRM /* \_SB_.MBRM */
                                                        Local1 = BTDC /* \_SB_.BTDC */
                                                        Local2 = LFCC /* \_SB_.LFCC */
                                                        Local3 = BTDV /* \_SB_.BTDV */
                                                        Local0 /= 0x64
                                                        Local1 /= 0x64
                                                        Local2 /= 0x64
                                                        Local3 /= 0x64
                                                        Local0 *= Local3
                                                        Local1 *= Local3
                                                        Local2 *= Local3
                                                        VALO [0x02] = ((Local0 << 0x10) | BATS) /* \_SB_.BATS */
                                                        VALO [0x03] = ((CSV2 << 0x10) | CSV1) /* \_SB_.CSV1 */
                                                        VALO [0x04] = ((Local1 << 0x10) | Local2)
                                                        VALO [0x05] = ((CSV4 << 0x10) | CSV3) /* \_SB_.CSV3 */
                                                    }
                                                    Else
                                                    {
                                                        VALO [0x02] = 0xFFFF
                                                        VALO [0x03] = 0xFFFF
                                                        VALO [0x04] = 0xFFFF
                                                        VALO [0x05] = 0xFFFF
                                                    }
                                                }
                                                ElseIf ((_T_F == 0x8001))
                                                {
                                                    If (MBTS)
                                                    {
                                                        VALO [0x02] = BTDV /* \_SB_.BTDV */
                                                    }
                                                    Else
                                                    {
                                                        VALO [0x02] = 0xFFFF
                                                        VALO [0x03] = 0xFFFF
                                                        VALO [0x04] = 0xFFFF
                                                        VALO [0x05] = 0xFFFF
                                                    }
                                                }
                                                Else
                                                {
                                                    VALO [0x02] = 0xFFFF
                                                    VALO [0x03] = 0xFFFF
                                                    VALO [0x04] = 0xFFFF
                                                    VALO [0x05] = 0xFFFF
                                                }

                                                Break
                                            }
                                        }
                                        Else
                                        {
                                            VALO [Zero] = 0x8D50
                                        }
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }

                                    Break
                                }
                            }
                            ElseIf ((_T_9 == 0x9D))
                            {
                                While (One)
                                {
                                    _T_G = ToInteger (Arg5)
                                    If ((_T_G == Zero))
                                    {
                                        VALO [Zero] = Zero
                                    }
                                    ElseIf ((_T_G == One))
                                    {
                                        VALO [Zero] = Zero
                                        VALO [0x02] = HPCF /* \_SB_.HPCF */
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }

                                    Break
                                }
                            }

                            Break
                        }
                    }
                    Case (0x9D)
                    {
                        If ((ToInteger (Arg0) == 0xFF00))
                        {
                            While (One)
                            {
                                _T_H = ToInteger (Arg3)
                                If ((_T_H == Zero))
                                {
                                    While (One)
                                    {
                                        _T_I = ToInteger (Arg2)
                                        If ((_T_I == Zero))
                                        {
                                            HPCF = Zero
                                            VALO [Zero] = Zero
                                        }
                                        ElseIf ((_T_I == One))
                                        {
                                            HPCF = One
                                            VALO [Zero] = Zero
                                        }
                                        Else
                                        {
                                            VALO [Zero] = 0x8300
                                        }

                                        Break
                                    }
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }

                                Break
                            }
                        }
                    }
                    Case (0xA0)
                    {
                        If ((ToInteger (Arg3) == Zero))
                        {
                            Local0 = ToInteger (Arg2)
                            Local0 &= 0xF4
                            If (!Local0)
                            {
                                VALO [Zero] = Zero
                                Local1 = ToInteger (Arg2)
                                PECB = (Local1 & One)
                                PECL = ((Local1 >> One) & One)
                                PECC = ((Local1 >> 0x03) & One)
                                If (PECL)
                                {
                                    If (DSPL)
                                    {
                                        EVNT (0xB2)
                                    }
                                    Else
                                    {
                                        EVNT (0xB3)
                                    }
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                        Else
                        {
                            VALO [Zero] = 0x8300
                        }
                    }
                    Case (0xAA)
                    {
                        VALO [Zero] = Zero
                        VALO [0x02] = CTTO /* \_SB_.CTTO */
                        VALO [0x03] = CTTB /* \_SB_.CTTB */
                    }
                    Case (0xC5)
                    {
                        Local1 = ToInteger (Arg1)
                        Local1 &= 0xFF000000
                        If ((Local1 != Zero))
                        {
                            VALO [Zero] = 0x8300
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [Zero] = Zero
                            VALO [0x02] = Zero
                        }
                    }
                    Case (0x000100C5)
                    {
                        Local1 = ToInteger (Arg1)
                        Local1 &= 0xFF000000
                        If ((Local1 != Zero))
                        {
                            VALO [Zero] = 0x8300
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFE00))
                        {
                            HSMI (0xC5, Zero)
                            OA30 = OWNS /* \OWNS */
                            VALO [Zero] = OAST /* \OAST */
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            OWNS = OA30 /* \_SB_.TVAP.OA30 */
                            OADK = ToInteger (Arg2)
                            HSMI (0xC5, One)
                            VALO [Zero] = OAST /* \OAST */
                            OADK = Zero
                        }
                    }
                    Case (0x000200C5)
                    {
                        Local1 = ToInteger (Arg1)
                        Local1 &= 0xFF000000
                        If ((Local1 != Zero))
                        {
                            VALO [Zero] = 0x8300
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            If ((OAFG == One))
                            {
                                VALO [Zero] = 0x8400
                            }
                            Else
                            {
                                OADK = ToInteger (Arg2)
                                HSMI (0xC5, 0x02)
                                VALO [Zero] = OAST /* \OAST */
                                If ((OAST == 0x8400))
                                {
                                    OAFG = One
                                }

                                OADK = Zero
                            }
                        }
                    }
                    Case (0x000300C5)
                    {
                        Local1 = ToInteger (Arg1)
                        Local1 &= 0xFF000000
                        If ((Local1 != Zero))
                        {
                            VALO [Zero] = 0x8300
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [0x02] = OA01 /* \_SB_.TVAP.OA01 */
                            VALO [0x03] = OA02 /* \_SB_.TVAP.OA02 */
                            VALO [0x04] = OA03 /* \_SB_.TVAP.OA03 */
                            VALO [0x05] = OA04 /* \_SB_.TVAP.OA04 */
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            OA01 = Arg2
                            OA02 = Arg3
                            OA03 = Arg4
                            OA04 = Arg5
                        }
                    }
                    Case (0x000400C5)
                    {
                        Local1 = ToInteger (Arg1)
                        Local1 &= 0xFF000000
                        If ((Local1 != Zero))
                        {
                            VALO [Zero] = 0x8300
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [0x02] = OA05 /* \_SB_.TVAP.OA05 */
                            VALO [0x03] = OA06 /* \_SB_.TVAP.OA06 */
                            VALO [0x04] = OA07 /* \_SB_.TVAP.OA07 */
                            VALO [0x05] = OA08 /* \_SB_.TVAP.OA08 */
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            OA05 = Arg2
                            OA06 = Arg3
                            OA07 = Arg4
                            OA08 = Arg5
                        }
                    }
                    Case (0x000500C5)
                    {
                        Local1 = ToInteger (Arg1)
                        Local1 &= 0xFF000000
                        If ((Local1 != Zero))
                        {
                            VALO [Zero] = 0x8300
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [0x02] = OA09 /* \_SB_.TVAP.OA09 */
                            VALO [0x03] = OA0A /* \_SB_.TVAP.OA0A */
                            VALO [0x04] = OA0B /* \_SB_.TVAP.OA0B */
                            VALO [0x05] = OA0C /* \_SB_.TVAP.OA0C */
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            OA09 = Arg2
                            OA0A = Arg3
                            OA0B = Arg4
                            OA0C = Arg5
                        }
                    }
                    Case (0x000600C5)
                    {
                        Local1 = ToInteger (Arg1)
                        Local1 &= 0xFF000000
                        If ((Local1 != Zero))
                        {
                            VALO [Zero] = 0x8300
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [0x02] = OA0D /* \_SB_.TVAP.OA0D */
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            OA0D = Arg2
                        }
                    }
                    Case (0x0522)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            If ((FKSF == Zero))
                            {
                                VALO [Zero] = 0x8000
                            }
                            Else
                            {
                                VALO [Zero] = One
                                VALO [One] = Zero
                                VALO [0x02] = FKCS /* \FKCS */
                                VALO [0x04] = FKSD /* \FKSD */
                            }
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            If (((ToInteger (Arg2) == Zero) || (ToInteger (Arg2) == One)))
                            {
                                FKCS = ToInteger (Arg2)
                                OSMI (0x22, One)
                                VALO [Zero] = Zero
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x96)
                    {
                        If ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [Zero] = Zero
                            VALO [0x02] = 0xFF50
                            VALO [0x03] = 0x0665
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x95)
                    {
                        While (One)
                        {
                            _T_J = ToInteger (Arg0)
                            If ((_T_J == 0xFE00))
                            {
                                VALO [Zero] = 0x8000
                            }
                            ElseIf ((_T_J == 0xFF00))
                            {
                                While (One)
                                {
                                    _T_K = ToInteger (Arg2)
                                    If ((_T_K == Zero))
                                    {
                                        VALO [Zero] = 0x8000
                                    }
                                    ElseIf ((_T_K == One))
                                    {
                                        VALO [Zero] = 0x8000
                                    }
                                    Else
                                    {
                                        VALO [Zero] = 0x8300
                                    }

                                    Break
                                }
                            }
                            Else
                            {
                                VALO [Zero] = 0x8000
                            }

                            Break
                        }
                    }
                    Case (0x97)
                    {
                        If ((ToInteger (Arg0) == 0xFE00))
                        {
                            VALO [Zero] = 0x8000
                        }
                        ElseIf ((ToInteger (Arg0) == 0xFF00))
                        {
                            If (((ToInteger (Arg3) == One) && (ToInteger (Arg2) == Zero)))
                            {
                                VALO [Zero] = 0x8000
                            }
                            ElseIf (((ToInteger (Arg3) == One) && (ToInteger (Arg2) == 
                                One)))
                            {
                                VALO [Zero] = 0x8000
                            }
                            ElseIf (((ToInteger (Arg3) == Zero) && (ToInteger (Arg2) == 
                                Zero)))
                            {
                                VALO [Zero] = 0x8000
                            }
                            ElseIf (((ToInteger (Arg3) == Zero) && (ToInteger (Arg2) == 
                                One)))
                            {
                                VALO [Zero] = 0x8000
                            }
                            ElseIf (((ToInteger (Arg3) == Zero) && (ToInteger (Arg2) == 
                                0x02)))
                            {
                                VALO [Zero] = 0x8000
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x010D)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = Zero
                            VALO [One] = Zero
                            VALO [0x02] = OG16 /* \OG16 */
                            VALO [0x04] = Zero
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If (((Local0 == Zero) || (Local0 == One)))
                            {
                                VALO [Zero] = Zero
                                OG16 = Local0
                                OSMI (0x1C, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x0130)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = One
                            VALO [One] = Zero
                            VALO [0x02] = OG01 /* \OG01 */
                            VALO [0x04] = One
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If (((Local0 == Zero) || (Local0 == One)))
                            {
                                VALO [Zero] = One
                                OG01 = Local0
                                OSMI (0x08, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x0137)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = One
                            VALO [One] = 0x800A
                            VALO [0x02] = (OG05 << 0x03)
                            VALO [0x03] = 0x08
                            VALO [0x04] = Zero
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If ((Local0 == Zero))
                            {
                                VALO [Zero] = One
                                OG05 = Zero
                                OSMI (0x06, One)
                            }
                            ElseIf ((Local0 == 0x08))
                            {
                                VALO [Zero] = One
                                OG05 = One
                                OSMI (0x06, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x0157)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = Zero
                            VALO [One] = 0x8505
                            OSMI (0x24, Zero)
                            BRBU = ((((BP00 | (BP01 << 0x04)) | (
                                BP02 << 0x08)) | (BP03 << 0x0C)) | (BP04 << 0x10))
                            BRBU = (((BRBU | (BP05 << 0x14)) | (BP06 << 
                                0x18)) | (BP07 << 0x1C))
                            VALO [0x02] = BRBU /* \_SB_.TVAP.BRBU */
                            VALO [0x03] = 0x04
                            VALO [0x04] = 0xFFFF3291
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            BP00 = (Local0 & 0x0F)
                            BP01 = ((Local0 >> 0x04) & 0x0F)
                            BP02 = ((Local0 >> 0x08) & 0x0F)
                            BP03 = ((Local0 >> 0x0C) & 0x0F)
                            BP04 = ((Local0 >> 0x10) & 0x0F)
                            BP05 = ((Local0 >> 0x14) & 0x0F)
                            BP06 = ((Local0 >> 0x18) & 0x0F)
                            BP07 = ((Local0 >> 0x1C) & 0x0F)
                            BPFG = Zero
                            OSMI (0x24, One)
                            If ((BPFG != 0xFF))
                            {
                                VALO [Zero] = Zero
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x0169)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = One
                            VALO [One] = Zero
                            VALO [0x02] = OG21 /* \OG21 */
                            VALO [0x04] = One
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If (((Local0 == Zero) || (Local0 == One)))
                            {
                                VALO [Zero] = One
                                OG21 = Local0
                                OSMI (0x23, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x016B)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            If ((SEBO == One))
                            {
                                VALO [Zero] = 0x03
                            }
                            Else
                            {
                                VALO [Zero] = One
                                VALO [One] = Zero
                                VALO [0x02] = (BOMO - One)
                                VALO [0x04] = One
                            }
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            If ((SEBO == One))
                            {
                                VALO [Zero] = 0x8400
                            }
                            Else
                            {
                                Local0 = ToInteger (Arg2)
                                If (((Local0 == Zero) || (Local0 == One)))
                                {
                                    VALO [Zero] = One
                                    BOMO = (Local0 + One)
                                    OSMI (0x25, One)
                                }
                                Else
                                {
                                    VALO [Zero] = 0x8300
                                }
                            }
                        }
                    }
                    Case (0x0300)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = One
                            VALO [One] = 0x8200
                            If ((OG04 == Zero))
                            {
                                VALO [0x02] = 0x3250
                            }
                            ElseIf ((OG04 == One))
                            {
                                VALO [0x02] = 0x1250
                            }

                            VALO [0x03] = 0x3250
                            VALO [0x04] = 0x3250
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If ((Local0 == 0x3250))
                            {
                                VALO [Zero] = One
                                OG04 = Zero
                                OSMI (0x03, One)
                            }
                            ElseIf ((Local0 == 0x1250))
                            {
                                VALO [Zero] = One
                                OG04 = One
                                OSMI (0x03, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x0406)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = One
                            VALO [One] = Zero
                            VALO [0x02] = OG08 /* \OG08 */
                            VALO [0x04] = Zero
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If (((Local0 == Zero) || (Local0 == One)))
                            {
                                VALO [Zero] = One
                                OG08 = Local0
                                OSMI (0x19, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x050C)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            VALO [Zero] = One
                            VALO [One] = Zero
                            VALO [0x02] = OG00 /* \OG00 */
                            VALO [0x04] = One
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If (((Local0 == Zero) || (Local0 == One)))
                            {
                                VALO [Zero] = One
                                OG00 = Local0
                                OSMI (0x07, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x0700)
                    {
                        If ((ToInteger (Arg0) == 0xF300))
                        {
                            If ((ToInteger (Arg2) == 0x0800))
                            {
                                VALO [Zero] = Zero
                                VALO [One] = 0x8700
                                VALO [0x02] = (0x0800 | OG02)
                                VALO [0x04] = 0x0800
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                        ElseIf ((ToInteger (Arg0) == 0xF400))
                        {
                            Local0 = ToInteger (Arg2)
                            If (((Local0 == 0x0800) || (Local0 == 0x0801)))
                            {
                                VALO [Zero] = Zero
                                OG02 = (Local0 & 0x0F)
                                OSMI (0x14, One)
                            }
                            Else
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                    }
                    Case (0x010E)
                    {
                        Local0 = ToInteger (Arg0)
                        If ((Local0 == 0xF300))
                        {
                            VALO [Zero] = Zero
                            VALO [One] = 0x8005
                            If (ALMF)
                            {
                                VALO [0x02] = ((YALM << 0x0A) | ((MALM << 
                                    0x06) | (DALM << One)))
                            }
                            Else
                            {
                                VALO [0x02] = Zero
                            }

                            VALO [0x03] = 0xFFFE
                        }
                        ElseIf ((Local0 == 0xF400))
                        {
                            Local1 = ToInteger (Arg2)
                            ToBCD (((Local1 & 0x3E) >> One), ALMD) /* \ALMD */
                            DALM = ((Local1 & 0x3E) >> One)
                            ToBCD (((Local1 & 0x03C0) >> 0x06), ALMO) /* \ALMO */
                            MALM = ((Local1 & 0x03C0) >> 0x06)
                            ToBCD (((Local1 & 0xFCC0) >> 0x0A), ALMY) /* \ALMY */
                            YALM = ((Local1 & 0xFCC0) >> 0x0A)
                            VALO [Zero] = Zero
                            OSMI (0x1F, One)
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Case (0x010F)
                    {
                        Local0 = ToInteger (Arg0)
                        If ((Local0 == 0xF300))
                        {
                            VALO [Zero] = Zero
                            VALO [One] = 0x8004
                            If (ALMF)
                            {
                                VALO [0x02] = ((FromBCD (ALMH, Local1) << 0x07) | (
                                    FromBCD (ALMM, Local2) << One))
                            }
                            Else
                            {
                                VALO [0x02] = One
                            }

                            VALO [0x03] = 0x0FFF
                            VALO [0x04] = One
                        }
                        ElseIf ((Local0 == 0xF400))
                        {
                            Local1 = ToInteger (Arg2)
                            ALMF = ((Local2 = (Local1 ^ One)) & One)
                            ToBCD (((Local1 & 0x7E) >> One), ALMM) /* \ALMM */
                            ToBCD (((Local1 & 0x0F80) >> 0x07), ALMH) /* \ALMH */
                            VALO [Zero] = Zero
                            OSMI (0x1F, One)
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }
                    Default
                    {
                        If ((Local1 == 0xC5))
                        {
                            If (((ToInteger (Arg0) == 0xFE00) || (ToInteger (Arg0) == 0xFF00)))
                            {
                                VALO [Zero] = 0x8300
                            }
                        }
                        Else
                        {
                            VALO [Zero] = 0x8000
                        }
                    }

                }

                Return (VALO) /* \_SB_.TVAP.VALO */
            }
        }

        Device (QITR)
        {
            Name (_HID, EisaId ("QCI0701"))  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If ((MYOS >= 0x07D6))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Name (VZOK, Zero)
            Name (VALI, Package (0x06)
            {
                Ones, 
                Ones, 
                Ones, 
                Ones, 
                Ones, 
                Ones
            })
            Name (VALO, Package (0x06)
            {
                0x88888888, 
                0x88888888, 
                0x88888888, 
                0x88888888, 
                0x88888888, 
                0x88888888
            })
            Name (BBBB, Package (0x05)
            {
                "ABCD", 
                "SRJING", 
                Buffer (0x05)
                {
                     0x12, 0x34, 0x56, 0x78, 0x90                     /* .4Vx. */
                }, 

                Package (0x02)
                {
                    0x07, 
                    0x09
                }, 

                0x13572468
            })
            Method (ENAB, 0, NotSerialized)
            {
                VZOK = 0x02
            }

            Method (EVNT, 1, NotSerialized)
            {
                VZOK = Arg0
                Notify (QITR, 0x80) // Status Change
                Return (VZOK) /* \_SB_.QITR.VZOK */
            }

            Method (INFO, 0, NotSerialized)
            {
                Local0 = 0x12
                Return (Local0)
            }

            Method (AB00, 0, NotSerialized)
            {
                VZOK = 0x02
            }

            Method (AB11, 1, NotSerialized)
            {
                VZOK = Arg0
                Return (VZOK) /* \_SB_.QITR.VZOK */
            }

            Method (AB01, 0, NotSerialized)
            {
                Local0 = 0x12
                Return (Local0)
            }

            Method (BBAA, 0, NotSerialized)
            {
                Return (BBBB) /* \_SB_.QITR.BBBB */
            }

            Method (SPFC, 6, NotSerialized)
            {
                VALI [Zero] = Arg0
                VALI [One] = Arg1
                VALI [0x02] = Arg2
                VALI [0x03] = Arg3
                VALI [0x04] = Arg4
                VALI [0x05] = Arg5
                Local0 = Arg0
                Local1 = Arg1
                Local2 = Arg2
                Local3 = Arg3
                Local4 = Arg4
                Local5 = Arg5
                VALO [Zero] = Local0
                VALO [One] = Local1
                VALO [0x02] = Local2
                VALO [0x03] = Local3
                VALO [0x04] = Local4
                VALO [0x05] = Local5
                Return (VALO) /* \_SB_.QITR.VALO */
            }

            Method (AB66, 6, NotSerialized)
            {
                VALI [Zero] = Arg0
                VALI [One] = Arg1
                VALI [0x02] = Arg2
                VALI [0x03] = Arg3
                VALI [0x04] = Arg4
                VALI [0x05] = Arg5
                Local0 = Arg0
                Local1 = Arg1
                Local2 = Arg2
                Local3 = Arg3
                Local4 = Arg4
                Local5 = Arg5
                VALO [Zero] = Local0
                VALO [One] = Local1
                VALO [0x02] = Local2
                VALO [0x03] = Local3
                VALO [0x04] = Local4
                VALO [0x05] = Local5
                Return (VALO) /* \_SB_.QITR.VALO */
            }

            Name (HMBB, Buffer (0x1C){})
            CreateField (HMBB, Zero, 0x60, HMPN)
            CreateField (HMBB, 0x60, 0x60, HMMN)
            CreateField (HMBB, 0xC0, 0x10, HMMD)
            CreateField (HMBB, 0xD0, 0x10, HMSN)
            Name (HMBT, Package (0x06)
            {
                Buffer (0x1C){}, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero
            })
            Method (HMB1, 0, NotSerialized)
            {
                HMPN = "NS2P3SZSV4WO"
                HMMN = "SANYO       "
                HMMD = "12"
                HMSN = "34"
                HMBT [Zero] = HMBB /* \_SB_.QITR.HMBB */
                HMBT [One] = One
                HMBT [0x02] = 0x02
                HMBT [0x03] = 0x03
                HMBT [0x04] = 0x04
                HMBT [0x05] = 0x05
                Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                ^^PCI0.LPC0.EC0.POLG = One
                Release (^^PCI0.LPC0.EC0.MUT1)
                Return (HMBT) /* \_SB_.QITR.HMBT */
            }

            Method (HMB2, 0, NotSerialized)
            {
                Return (Zero)
            }
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (CBTI, Zero)
            Name (PBTI, Zero)
            Name (BTIN, Zero)
            Name (BTCH, Zero)
            Name (BIFI, Zero)
            Name (SEL0, Zero)
            Name (BCRI, Zero)
            Name (PBIF, Package (0x0D)
            {
                One, 
                0x0FA0, 
                0x0FA0, 
                One, 
                0x2B5C, 
                0x012C, 
                0xC8, 
                0x20, 
                0x20, 
                "PA3593U-1BRS", 
                "", 
                "LION      ", 
                "         "
            })
            Name (PBIX, Package (0x14)
            {
                Zero, 
                One, 
                0x0FA0, 
                0x0FA0, 
                One, 
                0x2B5C, 
                0x012C, 
                0xC8, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                0x20, 
                0x20, 
                "PA3593U-1BRS", 
                "     ", 
                "LION      ", 
                "         "
            })
            Name (PBST, Package (0x04)
            {
                Zero, 
                Ones, 
                Ones, 
                0x2710
            })
            Name (ERRC, Zero)
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (BTIN)
                {
                    Return (0x1F)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                If ((BIFI == Zero))
                {
                    UBIF ()
                    BIFI = One
                }

                Return (PBIF) /* \_SB_.BAT1.PBIF */
            }

            Method (_BIX, 0, NotSerialized)  // _BIX: Battery Information Extended
            {
                If ((BIFI == Zero))
                {
                    UBIX ()
                    BIFI = One
                }

                Return (PBIX) /* \_SB_.BAT1.PBIX */
            }

            Name (LFCC, 0x1130)
            Method (UBIF, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local0 = ^^PCI0.LPC0.EC0.BTDC /* \_SB_.PCI0.LPC0.EC0_.BTDC */
                    Local1 = ^^PCI0.LPC0.EC0.LFCC /* \_SB_.PCI0.LPC0.EC0_.LFCC */
                    Local2 = ^^PCI0.LPC0.EC0.BTDV /* \_SB_.PCI0.LPC0.EC0_.BTDV */
                    Local3 = ^^PCI0.LPC0.EC0.BTMD /* \_SB_.PCI0.LPC0.EC0_.BTMD */
                    Local4 = ^^PCI0.LPC0.EC0.BTMN /* \_SB_.PCI0.LPC0.EC0_.BTMN */
                    Local5 = ^^PCI0.LPC0.EC0.BTSN /* \_SB_.PCI0.LPC0.EC0_.BTSN */
                    Local6 = ^^PCI0.LPC0.EC0.LION /* \_SB_.PCI0.LPC0.EC0_.LION */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    PBIF [One] = Local0
                    PBIF [0x02] = Local1
                    PBIF [0x04] = Local2
                    LFCC = Local1
                    If ((Local1 < 0x0FA0))
                    {
                        PBIF [0x06] = 0x64
                    }
                    Else
                    {
                        PBIF [0x06] = 0xC8
                    }

                    If (Local6)
                    {
                        PBIF [0x0B] = "NiMH"
                    }
                    Else
                    {
                        PBIF [0x0B] = "LION"
                    }

                    PBIF [0x09] = MBPN /* \_SB_.MBPN */
                    PBIF [0x0C] = MBMN /* \_SB_.MBMN */
                    PBIF [0x0A] = ITOS (ToBCD (Local5))
                }
            }

            Method (UBIX, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    PBIX [0x02] = ^^PCI0.LPC0.EC0.BTDC /* \_SB_.PCI0.LPC0.EC0_.BTDC */
                    PBIX [0x03] = ^^PCI0.LPC0.EC0.LFCC /* \_SB_.PCI0.LPC0.EC0_.LFCC */
                    PBIX [0x05] = ^^PCI0.LPC0.EC0.BTDV /* \_SB_.PCI0.LPC0.EC0_.BTDV */
                    Local1 = ^^PCI0.LPC0.EC0.LFCC /* \_SB_.PCI0.LPC0.EC0_.LFCC */
                    LFCC = Local1
                    If ((Local1 < 0x0FA0))
                    {
                        PBIX [0x07] = 0x64
                    }
                    Else
                    {
                        PBIX [0x07] = 0xC8
                    }

                    Local6 = ^^PCI0.LPC0.EC0.LION /* \_SB_.PCI0.LPC0.EC0_.LION */
                    If (Local6)
                    {
                        PBIX [0x12] = "NiMH"
                    }
                    Else
                    {
                        PBIX [0x12] = "LION"
                    }

                    PBIX [0x08] = ^^PCI0.LPC0.EC0.MCLC /* \_SB_.PCI0.LPC0.EC0_.MCLC */
                    PBIX [0x10] = ^^PCI0.LPC0.EC0.MBPN /* \_SB_.PCI0.LPC0.EC0_.MBPN */
                    PBIX [0x13] = ^^PCI0.LPC0.EC0.MBMN /* \_SB_.PCI0.LPC0.EC0_.MBMN */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                }
            }

            Name (RCAP, Zero)
            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                If ((BTIN == Zero))
                {
                    PBST [Zero] = Zero
                    PBST [One] = Ones
                    PBST [0x02] = Ones
                    PBST [0x03] = Ones
                    Return (PBST) /* \_SB_.BAT1.PBST */
                }

                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local0 = ^^PCI0.LPC0.EC0.MBTC /* \_SB_.PCI0.LPC0.EC0_.MBTC */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local1 = ^^PCI0.LPC0.EC0.MBRM /* \_SB_.PCI0.LPC0.EC0_.MBRM */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local2 = ^^PCI0.LPC0.EC0.MBVG /* \_SB_.PCI0.LPC0.EC0_.MBVG */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local3 = ^^PCI0.LPC0.EC0.MCUR /* \_SB_.PCI0.LPC0.EC0_.MCUR */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local4 = ^^PCI0.LPC0.EC0.BTST /* \_SB_.PCI0.LPC0.EC0_.BTST */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local5 = ^^PCI0.LPC0.EC0.MBTF /* \_SB_.PCI0.LPC0.EC0_.MBTF */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local6 = ^^PCI0.LPC0.EC0.ACDF /* \_SB_.PCI0.LPC0.EC0_.ACDF */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    Sleep (0x32)
                    If (Local6)
                    {
                        If ((Local5 == One))
                        {
                            Local7 = Zero
                            Local1 = LFCC /* \_SB_.BAT1.LFCC */
                        }
                        ElseIf ((Local0 == One))
                        {
                            Local7 = 0x02
                        }
                        Else
                        {
                            Local7 = Zero
                        }
                    }
                    ElseIf ((Local4 && One))
                    {
                        Local7 = One
                    }
                    Else
                    {
                        Local7 = Zero
                    }

                    Local4 &= 0x04
                    If ((Local4 == 0x04))
                    {
                        Local7 |= Local4
                    }

                    PBST [Zero] = Local7
                    If (!(Local1 & 0x8000))
                    {
                        PBST [0x02] = Local1
                    }

                    If (!(Local2 & 0x8000))
                    {
                        PBST [0x03] = Local2
                    }

                    If ((Local3 && 0x8000))
                    {
                        If ((Local3 != 0xFFFF))
                        {
                            Local3 = ~Local3
                            Local3++
                            Local3 &= 0xFFFF
                        }
                    }

                    PBST [One] = Local3
                }

                Return (PBST) /* \_SB_.BAT1.PBST */
            }

            Method (BSTA, 0, NotSerialized)
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    Local0 = ^^PCI0.LPC0.EC0.MBTS /* \_SB_.PCI0.LPC0.EC0_.MBTS */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                    If ((Local0 == One))
                    {
                        If ((BTIN == Zero))
                        {
                            BTCH = One
                            BIFI = Zero
                        }

                        BTIN = One
                    }
                    Else
                    {
                        If ((BTIN == One))
                        {
                            BTCH = One
                            BIFI = Zero
                        }

                        BTIN = Zero
                    }
                }
            }
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
            Name (ACST, Zero)
            Name (XX00, Buffer (0x03){})
            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                If (ECOK)
                {
                    Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                    ACST = ^^PCI0.LPC0.EC0.ACDF /* \_SB_.PCI0.LPC0.EC0_.ACDF */
                    Release (^^PCI0.LPC0.EC0.MUT1)
                }
                Else
                {
                    ACST = One
                }

                If (ACST)
                {
                    Local0 = One
                    ^^BAT1.BCRI = Zero
                }
                Else
                {
                    Local0 = Zero
                }

                Return (Local0)
                CreateWordField (XX00, Zero, SSZE)
                CreateByteField (XX00, 0x02, ACST)
                SSZE = 0x03
                If (Local0)
                {
                    P80H = 0xAC
                    ^^PCI0.VGA.AFN4 (One)
                    ACST = Zero
                }
                Else
                {
                    P80H = 0xDC
                    ^^PCI0.VGA.AFN4 (0x02)
                    ACST = One
                }

                ALIB
                One
                XX00
                Return (Local0)
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HID: Hardware ID
            Name (LSTS, Zero)
            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                If ((INS3 == 0x55))
                {
                    INS3 = Zero
                    Return (One)
                }

                If (ECOK)
                {
                    LSTS = LIDS /* \_SB_.LIDS */
                    P80H = LSTS /* \_SB_.LID_.LSTS */
                }
                Else
                {
                    LSTS = One
                }

                Return (LSTS) /* \_SB_.LID_.LSTS */
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x17, 
                0x05
            })
            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
                If (Arg0)
                {
                    SSTS = One
                }
                Else
                {
                    SSTS = Zero
                }
            }
        }

        Device (QWMI)
        {
            Name (_HID, "PNP0C14" /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_WDG, Buffer (0x3C)
            {
                /* 0000 */  0x69, 0xA4, 0x2B, 0xC6, 0x2C, 0x69, 0x4C, 0x4A,  /* i.+.,iLJ */
                /* 0008 */  0x98, 0x69, 0x31, 0xB8, 0x3E, 0x0C, 0x76, 0x71,  /* .i1.>.vq */
                /* 0010 */  0x41, 0x41, 0x01, 0x00, 0x76, 0xF0, 0x58, 0x15,  /* AA..v.X. */
                /* 0018 */  0x69, 0x3C, 0xDB, 0x4C, 0x80, 0xA5, 0xD2, 0xF3,  /* i<.L.... */
                /* 0020 */  0x9C, 0x62, 0x94, 0x9B, 0x41, 0x42, 0x01, 0x00,  /* .b..AB.. */
                /* 0028 */  0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11,  /* !...f... */
                /* 0030 */  0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10,  /* ......). */
                /* 0038 */  0x42, 0x41, 0x01, 0x00                           /* BA.. */
            })
            Name (FCOD, Zero)
            Name (RCOD, Zero)
            Name (SFAI, Zero)
            Name (SFLG, Zero)
            Name (UFAI, Zero)
            Name (UFLG, Zero)
            Name (VERB, Buffer (0x0201)
            {
                 0x00                                             /* . */
            })
            CreateField (VERB, Zero, 0x08, QMJV)
            CreateField (VERB, 0x08, 0x08, QMNV)
            Name (FBUF, Buffer (0x0201)
            {
                 0x00                                             /* . */
            })
            CreateField (FBUF, Zero, 0x08, F000)
            CreateField (FBUF, 0x08, 0x08, F001)
            Name (RBUF, Buffer (0x0201)
            {
                 0x00                                             /* . */
            })
            Name (QBUF, Buffer (0x0201)
            {
                 0x00                                             /* . */
            })
            CreateField (QBUF, Zero, 0x08, Q000)
            CreateField (QBUF, 0x08, 0x08, Q001)
            CreateField (QBUF, 0x10, 0x08, Q002)
            CreateField (QBUF, 0x18, 0x08, Q003)
            CreateField (QBUF, 0x20, 0x08, Q004)
            CreateField (QBUF, 0x28, 0x08, Q005)
            CreateField (QBUF, 0x30, 0x08, Q006)
            CreateField (QBUF, 0x38, 0x08, Q007)
            CreateField (QBUF, 0x40, 0x08, Q008)
            CreateField (QBUF, 0x48, 0x08, Q009)
            CreateField (QBUF, 0x50, 0x08, Q010)
            CreateField (QBUF, 0x58, 0x08, Q011)
            CreateField (QBUF, 0x60, 0x08, Q012)
            CreateField (QBUF, 0x68, 0x08, Q013)
            CreateField (QBUF, 0x70, 0x08, Q014)
            CreateField (QBUF, 0x78, 0x08, Q015)
            CreateField (QBUF, 0x80, 0x08, Q016)
            CreateField (QBUF, 0x88, 0x08, Q017)
            CreateField (QBUF, 0x90, 0x08, Q018)
            CreateField (QBUF, 0x98, 0x08, Q019)
            CreateField (QBUF, 0xA0, 0x08, Q020)
            CreateField (QBUF, Zero, 0xA0, QL20)
            CreateField (QBUF, Zero, 0x1000, Q512)
            CreateField (QBUF, 0x1000, 0x08, QZZZ)
            Method (WQAA, 1, NotSerialized)
            {
                QMJV = One
                QMNV = One
                Return (VERB) /* \_SB_.QWMI.VERB */
            }

            Method (WSAA, 2, NotSerialized)
            {
                FBUF = Arg1
                FCOD = F000 /* \_SB_.QWMI.F000 */
                RCOD = F001 /* \_SB_.QWMI.F001 */
                If ((RCOD == One))
                {
                    RQ01 (Arg0)
                }

                If ((RCOD == 0x02))
                {
                    RQ02 (Arg0)
                }

                If ((RCOD == 0x03))
                {
                    RQ03 (Arg0)
                }

                If ((RCOD == 0x04))
                {
                    RQ04 (Arg0)
                }

                If ((RCOD == 0x06))
                {
                    RQ06 (Arg0)
                }

                If ((RCOD == 0x07))
                {
                    RQ07 (Arg0)
                }

                If ((RCOD == 0x08))
                {
                    RQ08 (Arg0)
                }

                If ((RCOD == 0x09))
                {
                    RQ09 (Arg0)
                }

                If ((RCOD == 0x0A))
                {
                    RQ0A (Arg0)
                }

                If ((RCOD == 0x0B))
                {
                    RQ0B (Arg0)
                }

                If ((RCOD == 0x0C))
                {
                    RQ0C (Arg0)
                }

                If ((RCOD == 0x12))
                {
                    RQ12 (Arg0)
                }

                If ((RCOD == 0x13))
                {
                    RQ13 (Arg0)
                }

                If ((RCOD == 0x14))
                {
                    RQ14 (Arg0)
                }

                If ((RCOD == 0x15))
                {
                    RQ15 (Arg0)
                }

                If ((RCOD == 0x16))
                {
                    RQ16 (Arg0)
                }

                If ((RCOD == 0x17))
                {
                    RQ17 (Arg0)
                }

                If ((RCOD == 0x19))
                {
                    RQ19 (Arg0)
                }

                If ((RCOD == 0x20))
                {
                    RQ20 (Arg0)
                }

                If ((RCOD == 0x21))
                {
                    RQ21 (Arg0)
                }

                If ((RCOD == 0x22))
                {
                    RQ22 (Arg0)
                }

                If ((RCOD == 0x24))
                {
                    RQ23 (Arg0)
                }

                If ((RCOD == 0x25))
                {
                    RQ25 (Arg0)
                }

                If ((RCOD == 0x26))
                {
                    RQ26 (Arg0)
                }

                If ((RCOD == 0x27))
                {
                    RQ27 (Arg0)
                }

                If ((RCOD == 0x28))
                {
                    RQ28 (Arg0)
                }

                If ((RCOD == 0xF0))
                {
                    RQF0 (Arg0)
                }

                RBUF = QBUF /* \_SB_.QWMI.QBUF */
            }

            Method (WQAB, 1, NotSerialized)
            {
                Return (RBUF) /* \_SB_.QWMI.RBUF */
            }

            Method (WSAB, 2, NotSerialized)
            {
                If ((RCOD == One))
                {
                    RS01 (Arg0, Arg1)
                }

                If ((RCOD == 0x02))
                {
                    RS02 (Arg0, Arg1)
                }

                If ((RCOD == 0x03))
                {
                    RS03 (Arg0, Arg1)
                }

                If ((RCOD == 0x04))
                {
                    RS04 (Arg0, Arg1)
                }

                If ((RCOD == 0x06))
                {
                    RS06 (Arg0, Arg1)
                }

                If ((RCOD == 0x07))
                {
                    RS07 (Arg0, Arg1)
                }

                If ((RCOD == 0x08))
                {
                    RS08 (Arg0, Arg1)
                }

                If ((RCOD == 0x09))
                {
                    RS09 (Arg0, Arg1)
                }

                If ((RCOD == 0x0A))
                {
                    RS0A (Arg0, Arg1)
                }

                If ((RCOD == 0x0B))
                {
                    RS0B (Arg0, Arg1)
                }

                If ((RCOD == 0x0C))
                {
                    RS0C (Arg0, Arg1)
                }

                If ((RCOD == 0x12))
                {
                    RS12 (Arg0, Arg1)
                }

                If ((RCOD == 0x14))
                {
                    RS14 (Arg0, Arg1)
                }

                If ((RCOD == 0x15))
                {
                    RS15 (Arg0, Arg1)
                }

                If ((RCOD == 0x16))
                {
                    RS16 (Arg0, Arg1)
                }

                If ((RCOD == 0x17))
                {
                    RS17 (Arg0, Arg1)
                }

                If ((RCOD == 0x19))
                {
                    RS19 (Arg0, Arg1)
                }

                If ((RCOD == 0x20))
                {
                    RS20 (Arg0, Arg1)
                }

                If ((RCOD == 0x21))
                {
                    RS21 (Arg0, Arg1)
                }

                If ((RCOD == 0x22))
                {
                    RS22 (Arg0, Arg1)
                }

                If ((RCOD == 0x24))
                {
                    RS23 (Arg0, Arg1)
                }

                If ((RCOD == 0x25))
                {
                    RS25 (Arg0, Arg1)
                }

                If ((RCOD == 0x26))
                {
                    RS26 (Arg0, Arg1)
                }

                If ((RCOD == 0x27))
                {
                    RS27 (Arg0, Arg1)
                }

                If ((RCOD == 0x28))
                {
                    RS28 (Arg0, Arg1)
                }

                If ((RCOD == 0xF0))
                {
                    RSF0 (Arg0, Arg1)
                }

                RBUF = QBUF /* \_SB_.QWMI.QBUF */
            }

            Method (RQ01, 1, NotSerialized)
            {
                If ((FCOD == 0x02))
                {
                    OSMI (One, Zero)
                    Q512 = OWNS /* \OWNS */
                }

                If ((FCOD == 0x05))
                {
                    Q000 = SFAI /* \_SB_.QWMI.SFAI */
                }

                If ((FCOD == 0x04))
                {
                    If ((SFLG == Zero))
                    {
                        Q000 = One
                    }
                    Else
                    {
                        Q000 = Zero
                    }
                }
            }

            Method (RS01, 2, NotSerialized)
            {
                Q512 = Arg1
                OWNS = Q512 /* \_SB_.QWMI.Q512 */
                If ((FCOD == 0x04))
                {
                    SFLG = Zero
                    OSMI (One, 0x04)
                    Q512 = OWNS /* \OWNS */
                    SFLG = Q000 /* \_SB_.QWMI.Q000 */
                    If ((SFLG == Zero))
                    {
                        Q000 = One
                    }
                    Else
                    {
                        Q000 = Zero
                    }
                }

                If ((FCOD == One))
                {
                    OSMI (One, 0x02)
                }

                If ((FCOD == 0x03))
                {
                    OG13 = One
                    OSMI (One, 0x03)
                }

                If ((FCOD == 0x05))
                {
                    Q512 = OWNS /* \OWNS */
                    SFAI = Q000 /* \_SB_.QWMI.Q000 */
                }
            }

            Method (RQ02, 1, NotSerialized)
            {
                If ((FCOD == 0x02))
                {
                    OSMI (0x02, Zero)
                    Q512 = OWNS /* \OWNS */
                }

                If ((FCOD == 0x05))
                {
                    Q000 = UFAI /* \_SB_.QWMI.UFAI */
                }

                If ((FCOD == 0x04))
                {
                    If ((UFLG == Zero))
                    {
                        Q000 = One
                    }
                    Else
                    {
                        Q000 = Zero
                    }
                }
            }

            Method (RS02, 2, NotSerialized)
            {
                OWNS = Arg1
                If ((FCOD == 0x04))
                {
                    UFLG = Zero
                    OSMI (0x02, 0x04)
                    Q512 = OWNS /* \OWNS */
                    UFLG = Q000 /* \_SB_.QWMI.Q000 */
                }

                If ((FCOD == One))
                {
                    OSMI (0x02, 0x02)
                }

                If ((FCOD == 0x03))
                {
                    OSMI (0x02, 0x03)
                }

                If ((FCOD == 0x05))
                {
                    Q512 = OWNS /* \OWNS */
                    UFAI = Q000 /* \_SB_.QWMI.Q000 */
                }
            }

            Method (RQ03, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = Zero
                }
                Else
                {
                    Q000 = OG04 /* \OG04 */
                }
            }

            Method (RS03, 2, NotSerialized)
            {
                OG04 = Arg1
                OSMI (0x03, One)
            }

            Method (RQ04, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = Zero
                    Q001 = 0x08
                    Q002 = 0x12
                    Q003 = 0x11
                    Q004 = 0x3F
                }
                Else
                {
                    OSMI (0x04, Zero)
                    Q512 = OWNS /* \OWNS */
                }
            }

            Method (RS04, 2, NotSerialized)
            {
                OWNS = Arg1
                OSMI (0x04, One)
            }

            Method (RQ06, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = Zero
                }
                Else
                {
                    Q000 = OG05 /* \OG05 */
                }
            }

            Method (RS06, 2, NotSerialized)
            {
                OG05 = Arg1
                OSMI (0x06, One)
            }

            Method (RQ07, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = One
                }
                Else
                {
                    Q000 = OG00 /* \OG00 */
                }
            }

            Method (RS07, 2, NotSerialized)
            {
                OG00 = Arg1
                OSMI (0x07, One)
            }

            Method (RQ08, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = One
                }
                Else
                {
                    Q000 = OG01 /* \OG01 */
                }
            }

            Method (RS08, 2, NotSerialized)
            {
                OG01 = Arg1
                OSMI (0x08, One)
            }

            Method (RQ09, 1, NotSerialized)
            {
                OSMI (Zero, Zero)
                Q512 = OWNS /* \OWNS */
                QZZZ = Zero
            }

            Method (RS09, 2, NotSerialized)
            {
                OWNS = Arg1
                OSMI (Zero, One)
            }

            Method (RQ0A, 1, NotSerialized)
            {
                Q000 = OG15 /* \OG15 */
            }

            Method (RS0A, 2, NotSerialized)
            {
            }

            Method (RQ0B, 1, NotSerialized)
            {
                Q000 = OG13 /* \OG13 */
            }

            Method (RS0B, 2, NotSerialized)
            {
                OG13 = Arg1
                OSMI (0x0A, One)
            }

            Method (RQ0C, 1, NotSerialized)
            {
                OSMI (0x0B, Zero)
                Q512 = OWNS /* \OWNS */
            }

            Method (RS0C, 2, NotSerialized)
            {
            }

            Method (RQ12, 1, NotSerialized)
            {
                OSMI (0x10, Zero)
                Q512 = OWNS /* \OWNS */
                Q001 = Zero
                Q003 = Zero
                Q004 = TPDV /* \TPDV */
                If ((^^PCI0.SMBS.I050 == Zero))
                {
                    Q005 = One
                }

                Q006 = Zero
                Acquire (^^PCI0.LPC0.EC0.MUT1, 0xFFFF)
                Q007 = Zero
                Q008 = ^^PCI0.LPC0.EC0.PLID /* \_SB_.PCI0.LPC0.EC0_.PLID */
                Release (^^PCI0.LPC0.EC0.MUT1)
                Q009 = Zero
                Q018 = Zero
                If (FKSF)
                {
                    Q019 = One
                }
                Else
                {
                    Q019 = Zero
                }

                Local0 = ^^PCI0.SMBS.I056 /* \_SB_.PCI0.SMBS.I056 */
                Local1 = ^^PCI0.SMBS.I057 /* \_SB_.PCI0.SMBS.I057 */
                If (((Local0 == Zero) && (Local1 == Zero)))
                {
                    Q020 = Zero
                }
                Else
                {
                    Q020 = One
                }
            }

            Method (RS12, 2, NotSerialized)
            {
            }

            Method (RQ13, 1, NotSerialized)
            {
                OSMI (0x12, Zero)
                QL20 = DVDI /* \DVDI */
            }

            Method (RQ14, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = One
                }
                Else
                {
                    Q000 = OG10 /* \OG10 */
                }
            }

            Method (RS14, 2, NotSerialized)
            {
                OG10 = Arg1
                OSMI (0x13, One)
            }

            Method (RQ15, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = Zero
                }
                Else
                {
                    Q000 = OG02 /* \OG02 */
                }
            }

            Method (RS15, 2, NotSerialized)
            {
                OG02 = Arg1
                OSMI (0x14, One)
            }

            Method (RQ16, 1, NotSerialized)
            {
            }

            Method (RS16, 2, NotSerialized)
            {
            }

            Method (RQ17, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = One
                }
                Else
                {
                    Q000 = OG11 /* \OG11 */
                }
            }

            Method (RS17, 2, NotSerialized)
            {
                OG11 = Arg1
                OSMI (0x16, One)
            }

            Method (RQ19, 1, NotSerialized)
            {
                Q001 = ^^BLVL /* \_SB_.BLVL */
                Q000 = 0x08
                Q002 = One
            }

            Name (BLVL, Zero)
            Method (RS19, 2, NotSerialized)
            {
                Q512 = Arg1
                BLVL = Q000 /* \_SB_.QWMI.Q000 */
                ^^BLVL = BLVL /* \_SB_.QWMI.BLVL */
                ^^PCI0.LPC0.EC0.SVBN ()
            }

            Method (RQ20, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = One
                }
                Else
                {
                    Q000 = OG07 /* \OG07 */
                }
            }

            Method (RS20, 2, NotSerialized)
            {
                OG07 = Arg1
                OSMI (0x18, One)
            }

            Method (RQ21, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = Zero
                }
                Else
                {
                    Q000 = OG08 /* \OG08 */
                }
            }

            Method (RS21, 2, NotSerialized)
            {
                OG08 = Arg1
                OSMI (0x19, One)
            }

            Method (RQ22, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = One
                }
                Else
                {
                    Q000 = OG09 /* \OG09 */
                }
            }

            Method (RS22, 2, NotSerialized)
            {
                OG09 = Arg1
                OSMI (0x1A, One)
            }

            Method (RQF0, 1, NotSerialized)
            {
            }

            Method (RSF0, 2, NotSerialized)
            {
                Q512 = Arg1
                If ((ToInteger (Q000) == One))
                {
                    OSMI (0x17, One)
                }
            }

            Method (RQ23, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = Zero
                }
                Else
                {
                    Q000 = OG16 /* \OG16 */
                }
            }

            Method (RS23, 2, NotSerialized)
            {
                OG16 = ToInteger (Arg1)
                OSMI (0x1C, One)
            }

            Method (RQ25, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Q000 = FKSD /* \FKSD */
                }
                Else
                {
                    Q000 = FKCS /* \FKCS */
                }
            }

            Method (RS25, 2, NotSerialized)
            {
                FKCS = ToInteger (Arg1)
                OSMI (0x22, One)
            }

            Method (RQ26, 1, NotSerialized)
            {
                If ((FCOD == One))
                {
                    Local0 = ^^PCI0.SMBS.I056 /* \_SB_.PCI0.SMBS.I056 */
                    Local1 = ^^PCI0.SMBS.I057 /* \_SB_.PCI0.SMBS.I057 */
                    If (((Local0 == Zero) && (Local1 == Zero)))
                    {
                        Q000 = Zero
                    }
                    Else
                    {
                        Q000 = One
                    }
                }
                Else
                {
                    Q000 = OG21 /* \OG21 */
                }
            }

            Method (RS26, 2, NotSerialized)
            {
                OG21 = ToInteger (Arg1)
                OSMI (0x23, One)
            }

            Method (RQ27, 1, NotSerialized)
            {
                If ((FCOD == One)){}
                Else
                {
                    Q000 = BOMO--
                }
            }

            Method (RS27, 2, NotSerialized)
            {
                Local0 = ToInteger (Arg1)
                BOMO = Local0++
                If ((BOMO == One))
                {
                    SEBO = Zero
                }

                OSMI (0x25, One)
            }

            Method (RQ28, 1, NotSerialized)
            {
                If ((FCOD == One)){}
                Else
                {
                    Q000 = SEBO /* \SEBO */
                }
            }

            Method (RS28, 2, NotSerialized)
            {
                Local0 = ToInteger (Arg1)
                If (Local0)
                {
                    BOMO = 0x02
                    SEBO = One
                    OSMI (0x25, One)
                }
                Else
                {
                }
            }

            Name (WQBA, Buffer (0x02C0)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  /* FOMB.... */
                /* 0008 */  0xB0, 0x02, 0x00, 0x00, 0xC0, 0x08, 0x00, 0x00,  /* ........ */
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  /* DS...}.T */
                /* 0018 */  0x28, 0x5F, 0x84, 0x00, 0x01, 0x06, 0x18, 0x42,  /* (_.....B */
                /* 0020 */  0x10, 0x05, 0x10, 0x92, 0x28, 0x81, 0x42, 0x04,  /* ....(.B. */
                /* 0028 */  0x12, 0x4F, 0x24, 0x51, 0x30, 0x28, 0x0D, 0x20,  /* .O$Q0(.  */
                /* 0030 */  0x92, 0x04, 0x21, 0x17, 0x4C, 0x4C, 0x80, 0x10,  /* ..!.LL.. */
                /* 0038 */  0x58, 0x0B, 0x30, 0x2F, 0x40, 0xB7, 0x00, 0xC3,  /* X.0/@... */
                /* 0040 */  0x02, 0x6C, 0x0B, 0x30, 0x2D, 0xC0, 0x31, 0x90,  /* .l.0-.1. */
                /* 0048 */  0xFA, 0xF7, 0x87, 0x28, 0x0D, 0x44, 0x9B, 0x10,  /* ...(.D.. */
                /* 0050 */  0x01, 0x91, 0x02, 0x21, 0xA1, 0x02, 0x94, 0x0B,  /* ...!.... */
                /* 0058 */  0xF0, 0x2D, 0x40, 0x3B, 0xA2, 0x24, 0x0B, 0xB0,  /* .-@;.$.. */
                /* 0060 */  0x0C, 0x23, 0x02, 0x7B, 0x15, 0x60, 0x53, 0x80,  /* .#.{.`S. */
                /* 0068 */  0x49, 0x34, 0x04, 0x41, 0x39, 0xC3, 0x40, 0xC1,  /* I4.A9.@. */
                /* 0070 */  0x1B, 0x90, 0x0D, 0x82, 0xC9, 0x1D, 0x04, 0x4A,  /* .......J */
                /* 0078 */  0xCC, 0x68, 0xC8, 0x0C, 0x3A, 0x9F, 0x8B, 0xE0,  /* .h..:... */
                /* 0080 */  0x4F, 0xA2, 0x70, 0x01, 0xD2, 0x31, 0x34, 0x82,  /* O.p..14. */
                /* 0088 */  0x23, 0x4A, 0xD0, 0xA3, 0x00, 0xD9, 0x28, 0x52,  /* #J....(R */
                /* 0090 */  0x3C, 0x27, 0x81, 0x14, 0x24, 0xC0, 0x21, 0x16,  /* <'..$.!. */
                /* 0098 */  0xC1, 0x3B, 0x11, 0x03, 0x79, 0x0E, 0x71, 0x3C,  /* .;..y.q< */
                /* 00A0 */  0x20, 0x6B, 0x46, 0x14, 0x7E, 0x94, 0x04, 0x46,  /*  kF.~..F */
                /* 00A8 */  0x3B, 0x0E, 0x8C, 0x8C, 0x11, 0x10, 0xAB, 0xA8,  /* ;....... */
                /* 00B0 */  0x9A, 0x48, 0x02, 0xBB, 0x1F, 0x81, 0xB4, 0x09,  /* .H...... */
                /* 00B8 */  0x50, 0x26, 0x40, 0xA1, 0x00, 0x83, 0xA3, 0x14,  /* P&@..... */
                /* 00C0 */  0x4A, 0x73, 0x02, 0x6C, 0x61, 0x10, 0xA4, 0x60,  /* Js.la..` */
                /* 00C8 */  0x51, 0x22, 0x9D, 0x41, 0x88, 0x43, 0x88, 0x12,  /* Q".A.C.. */
                /* 00D0 */  0xA9, 0x38, 0x3C, 0xEA, 0x4C, 0x80, 0x31, 0x5C,  /* .8<.L.1\ */
                /* 00D8 */  0xE1, 0x04, 0x69, 0x51, 0x80, 0x30, 0x4C, 0x79,  /* ..iQ.0Ly */
                /* 00E0 */  0x03, 0x13, 0x44, 0xA8, 0xF6, 0x07, 0x41, 0x86,  /* ..D...A. */
                /* 00E8 */  0x8D, 0x1B, 0xBF, 0xE7, 0xE6, 0x01, 0x9C, 0x9B,  /* ........ */
                /* 00F0 */  0xC7, 0xC4, 0x26, 0xDB, 0xE9, 0x58, 0x05, 0x5E,  /* ..&..X.^ */
                /* 00F8 */  0x3C, 0xAA, 0x30, 0x0E, 0x22, 0x81, 0x83, 0x3D,  /* <.0."..= */
                /* 0100 */  0x0A, 0x64, 0x01, 0x44, 0x91, 0xE0, 0x51, 0xA3,  /* .d.D..Q. */
                /* 0108 */  0x4E, 0x70, 0xF0, 0x9E, 0xA4, 0x87, 0x7C, 0x94,  /* Np....|. */
                /* 0110 */  0x27, 0x10, 0xE4, 0x20, 0xAD, 0xF3, 0x48, 0x40,  /* '.. ..H@ */
                /* 0118 */  0xC6, 0xC0, 0xB0, 0x12, 0x74, 0x70, 0x0C, 0x80,  /* ....tp.. */
                /* 0120 */  0xE2, 0x1A, 0x50, 0x97, 0x83, 0xC7, 0x00, 0x36,  /* ..P....6 */
                /* 0128 */  0xEA, 0x04, 0xFF, 0xFF, 0x70, 0x7C, 0xBC, 0xF6,  /* ....p|.. */
                /* 0130 */  0x7E, 0x09, 0x20, 0x23, 0x37, 0x20, 0x1B, 0xD1,  /* ~. #7 .. */
                /* 0138 */  0xC1, 0x61, 0x07, 0x79, 0x32, 0x47, 0x56, 0xAA,  /* .a.y2GV. */
                /* 0140 */  0x00, 0xB3, 0xC7, 0x03, 0x0D, 0x34, 0xC1, 0xF1,  /* .....4.. */
                /* 0148 */  0x18, 0xD9, 0xF3, 0xE9, 0x19, 0x92, 0x1C, 0x0D,  /* ........ */
                /* 0150 */  0x3C, 0x08, 0x3E, 0x32, 0x43, 0x7B, 0xFA, 0xA7,  /* <.>2C{.. */
                /* 0158 */  0xF5, 0x62, 0xE0, 0x93, 0xC2, 0x61, 0xB1, 0x71,  /* .b...a.q */
                /* 0160 */  0x3F, 0x4A, 0xB0, 0x71, 0xC0, 0xBF, 0x01, 0x1C,  /* ?J.q.... */
                /* 0168 */  0xF7, 0xE3, 0x81, 0xB1, 0xCF, 0xD3, 0xC7, 0x05,  /* ........ */
                /* 0170 */  0x51, 0xCB, 0xC8, 0xE2, 0x3C, 0x0E, 0xD4, 0x45,  /* Q...<..E */
                /* 0178 */  0xC1, 0x83, 0x8D, 0x10, 0xD1, 0xD7, 0x88, 0x04,  /* ........ */
                /* 0180 */  0xA3, 0x43, 0x68, 0xEC, 0x16, 0x35, 0x5E, 0x7A,  /* .Ch..5^z */
                /* 0188 */  0xA0, 0xE0, 0x67, 0x88, 0xF7, 0x0A, 0x9F, 0x12,  /* ..g..... */
                /* 0190 */  0x82, 0x1E, 0xBB, 0x87, 0x12, 0xD6, 0x23, 0xF2,  /* ......#. */
                /* 0198 */  0x31, 0x02, 0xB8, 0x9D, 0x03, 0xE0, 0x1F, 0x0B,  /* 1....... */
                /* 01A0 */  0x3C, 0x32, 0x3E, 0x22, 0x8F, 0xF7, 0xD4, 0x8B,  /* <2>".... */
                /* 01A8 */  0xA5, 0xF1, 0x61, 0x41, 0xB2, 0xC6, 0x0D, 0xDD,  /* ..aA.... */
                /* 01B0 */  0xFA, 0x69, 0x80, 0x8C, 0xE1, 0x19, 0xC0, 0x22,  /* .i....." */
                /* 01B8 */  0x61, 0xD1, 0xE3, 0xB6, 0x5F, 0x01, 0x08, 0xA1,  /* a..._... */
                /* 01C0 */  0xCB, 0x9C, 0x84, 0x0E, 0x11, 0x11, 0x12, 0x44,  /* .......D */
                /* 01C8 */  0x0F, 0x74, 0x84, 0xB8, 0xC9, 0xE1, 0xFE, 0xFF,  /* .t...... */
                /* 01D0 */  0x93, 0xE3, 0x43, 0xC0, 0x8D, 0xD9, 0x43, 0xE0,  /* ..C...C. */
                /* 01D8 */  0xA7, 0x88, 0x33, 0x38, 0x9E, 0xB3, 0x39, 0x84,  /* ..38..9. */
                /* 01E0 */  0xE3, 0x89, 0x72, 0x16, 0x07, 0xE4, 0xE9, 0x1A,  /* ..r..... */
                /* 01E8 */  0xE1, 0x04, 0x1E, 0x00, 0x1E, 0x52, 0x3C, 0x02,  /* .....R<. */
                /* 01F0 */  0x4F, 0xEA, 0x2C, 0x5E, 0x26, 0x3C, 0x02, 0x8C,  /* O.,^&<.. */
                /* 01F8 */  0xA4, 0xE3, 0x0B, 0x95, 0xFD, 0x14, 0x90, 0x08,  /* ........ */
                /* 0200 */  0x18, 0xD4, 0x09, 0x06, 0x78, 0x63, 0x3E, 0x2B,  /* ....xc>+ */
                /* 0208 */  0x80, 0x65, 0xA8, 0xC7, 0x18, 0xE8, 0x44, 0x3C,  /* .e....D< */
                /* 0210 */  0x16, 0x23, 0xC6, 0x8A, 0xF2, 0x8C, 0x10, 0xFF,  /* .#...... */
                /* 0218 */  0xBC, 0xC2, 0x44, 0x78, 0x43, 0x08, 0xE4, 0x03,  /* ..DxC... */
                /* 0220 */  0x84, 0x8F, 0x2F, 0xB0, 0x2F, 0x2B, 0xAD, 0x21,  /* .././+.! */
                /* 0228 */  0xE8, 0x60, 0x50, 0xE3, 0x51, 0x43, 0x27, 0x16,  /* .`P.QC'. */
                /* 0230 */  0x5F, 0x5B, 0x7C, 0x86, 0xF1, 0xC9, 0xC5, 0xA7,  /* _[|..... */
                /* 0238 */  0x17, 0x4F, 0xE0, 0x95, 0x20, 0x4A, 0xC0, 0x78,  /* .O.. J.x */
                /* 0240 */  0x4F, 0x01, 0x41, 0xA3, 0x04, 0x7F, 0x8A, 0x09,  /* O.A..... */
                /* 0248 */  0x1B, 0x32, 0xE0, 0xCB, 0x0C, 0x03, 0x89, 0x19,  /* .2...... */
                /* 0250 */  0xE2, 0x89, 0xE3, 0xF1, 0x05, 0xCC, 0x71, 0x8E,  /* ......q. */
                /* 0258 */  0x2F, 0xA0, 0xF9, 0xFF, 0x1F, 0x5F, 0x00, 0xBF,  /* /...._.. */
                /* 0260 */  0x22, 0x8E, 0x2F, 0xE8, 0xC1, 0x59, 0xEB, 0xF8,  /* "./..Y.. */
                /* 0268 */  0xC9, 0x51, 0xE1, 0x34, 0x1C, 0xFA, 0xF4, 0x02,  /* .Q.4.... */
                /* 0270 */  0xBA, 0x23, 0x04, 0xF0, 0x39, 0xBA, 0x00, 0xCF,  /* .#..9... */
                /* 0278 */  0x6B, 0x85, 0x8F, 0x2E, 0x70, 0xFE, 0xFF, 0x47,  /* k...p..G */
                /* 0280 */  0x17, 0xBC, 0xD2, 0x69, 0x09, 0xFC, 0x10, 0x8D,  /* ...i.... */
                /* 0288 */  0x7E, 0x44, 0x67, 0xF0, 0xAA, 0xC3, 0xAE, 0x0B,  /* ~Dg..... */
                /* 0290 */  0x3E, 0xB9, 0x00, 0x23, 0x85, 0x36, 0x7D, 0x6A,  /* >..#.6}j */
                /* 0298 */  0x34, 0x6A, 0xD5, 0xA0, 0x4C, 0x8D, 0x32, 0x0D,  /* 4j..L.2. */
                /* 02A0 */  0x6A, 0xF5, 0xA9, 0xD4, 0x98, 0xB1, 0x73, 0x8B,  /* j.....s. */
                /* 02A8 */  0xE5, 0x0C, 0x53, 0x83, 0xB5, 0x78, 0x10, 0x1A,  /* ..S..x.. */
                /* 02B0 */  0x85, 0x42, 0x20, 0x96, 0x4A, 0x27, 0x10, 0x07,  /* .B .J'.. */
                /* 02B8 */  0x03, 0xA1, 0xF1, 0x3C, 0x80, 0xB0, 0xFF, 0x3F   /* ...<...? */
            })
        }

        Scope (\_TZ)
        {
            ThermalZone (THRM)
            {
                Method (_TMP, 0, NotSerialized)  // _TMP: Temperature
                {
                    If (\_SB.ECOK)
                    {
                        Acquire (\_SB.PCI0.LPC0.EC0.MUT1, 0xFFFF)
                        Local0 = \_SB.PCI0.LPC0.EC0.CTMP
                        Release (\_SB.PCI0.LPC0.EC0.MUT1)
                        Return (((Local0 * 0x0A) + 0x0AAC))
                    }

                    Return (0x0C3C)
                }

                Method (_PSL, 0, Serialized)  // _PSL: Passive List
                {
                    Return (Package (0x01)
                    {
                        \_PR.C000
                    })
                }

                Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
                {
                    Return (0x0EC6)
                }

                Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
                {
                    Return (0x0E76)
                }

                Name (_TC1, 0x02)  // _TC1: Thermal Constant 1
                Name (_TC2, 0x03)  // _TC2: Thermal Constant 2
                Name (_TSP, 0x28)  // _TSP: Thermal Sampling Period
            }
        }
    }
}

