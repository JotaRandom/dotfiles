/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20250404 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of dsdt.dat
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000D170 (53616)
 *     Revision         0x02
 *     Checksum         0xE7
 *     OEM ID           "LENOVO"
 *     OEM Table ID     "TP-8G   "
 *     OEM Revision     0x00001230 (4656)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20060912 (537266450)
 */
DefinitionBlock ("", "DSDT", 2, "LENOVO", "TP-8G   ", 0x00001230)
{
    /*
     * iASL Warning: There were 3 external control methods found during
     * disassembly, but only 0 were resolved (3 unresolved). Additional
     * ACPI tables may be required to properly disassemble the code. This
     * resulting disassembler output file may not compile because the
     * disassembler did not know how many arguments to assign to the
     * unresolved methods. Note: SSDTs can be dynamically loaded at
     * runtime and may or may not be available via the host OS.
     *
     * To specify the tables needed to resolve external control method
     * references, the -e option can be used to specify the filenames.
     * Example iASL invocations:
     *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
     *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
     *     iasl -e ssdt*.aml -d dsdt.aml
     *
     * In addition, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (_PR_.CPU0._PPC, UnknownObj)
    External (_PR_.CPU1._PPC, UnknownObj)
    External (CFGD, UnknownObj)
    External (HDOS, MethodObj)    // Warning: Unknown method, guessing 0 arguments
    External (HNOT, MethodObj)    // Warning: Unknown method, guessing 1 arguments
    External (PDC0, UnknownObj)
    External (PDC1, UnknownObj)
    External (PDC2, UnknownObj)
    External (PDC3, UnknownObj)
    External (PDC4, UnknownObj)
    External (PDC5, UnknownObj)
    External (PDC6, UnknownObj)
    External (PDC7, UnknownObj)
    External (TNOT, MethodObj)    // Warning: Unknown method, guessing 0 arguments

    Name (SS1, One)
    Name (SS2, Zero)
    Name (SS3, One)
    Name (SS4, One)
    Name (SP2O, 0x4E)
    Name (SP1O, 0x164E)
    Name (IO1B, 0x0600)
    Name (IO1L, 0x70)
    Name (IO2B, 0x0680)
    Name (IO2L, 0x20)
    Name (IO3B, 0x0290)
    Name (IO3L, 0x10)
    Name (SP3O, 0x2E)
    Name (IO4B, 0x0A20)
    Name (IO4L, 0x20)
    Name (MCHB, 0xFED10000)
    Name (MCHL, 0x8000)
    Name (EGPB, 0xFED19000)
    Name (EGPL, 0x1000)
    Name (DMIB, 0xFED18000)
    Name (DMIL, 0x1000)
    Name (IFPB, 0xFED14000)
    Name (IFPL, 0x1000)
    Name (PEBS, 0xF8000000)
    Name (PELN, 0x04000000)
    Name (SMBS, 0x0580)
    Name (SMBL, 0x20)
    Name (PBLK, 0x0410)
    Name (PMBS, 0x0400)
    Name (PMLN, 0x80)
    Name (LVL2, 0x0414)
    Name (LVL3, 0x0415)
    Name (LVL4, 0x0416)
    Name (SMIP, 0xB2)
    Name (GPBS, 0x0500)
    Name (GPLN, 0x80)
    Name (APCB, 0xFEC00000)
    Name (APCL, 0x1000)
    Name (PM30, 0x0430)
    Name (SRCB, 0xFED1C000)
    Name (SRCL, 0x4000)
    Name (HPTB, 0xFED00000)
    Name (HPTC, 0xFED1F404)
    Name (ACPH, 0xDE)
    Name (ASSB, Zero)
    Name (AOTB, Zero)
    Name (AAXB, Zero)
    Name (PEHP, One)
    Name (SHPC, One)
    Name (PEPM, One)
    Name (PEER, One)
    Name (PECS, One)
    Name (DSSP, Zero)
    Name (FHPP, Zero)
    Name (FMBL, One)
    Name (FDTP, 0x02)
    Name (FUPS, 0x03)
    Name (BSH, Zero)
    Name (BEL, One)
    Name (BEH, 0x02)
    Name (BRH, 0x03)
    Name (BTF, 0x04)
    Name (BHC, 0x05)
    Name (BYB, 0x06)
    Name (BPH, 0x07)
    Name (BSHS, 0x08)
    Name (BELS, 0x09)
    Name (BRHS, 0x0A)
    Name (BTFS, 0x0B)
    Name (BEHS, 0x0C)
    Name (BPHS, 0x0D)
    Name (BTL, 0x10)
    Name (BSR, 0x14)
    Name (BOF, 0x20)
    Name (BEF, 0x21)
    Name (BLLE, 0x22)
    Name (BLLC, 0x23)
    Name (BLCA, 0x24)
    Name (BLLS, 0x25)
    Name (BLLP, 0x26)
    Name (BLLD, 0x27)
    Name (BHBE, 0x30)
    Name (BHBC, 0x31)
    Name (BHBN, 0x32)
    Name (BHBM, 0x33)
    Name (TCGM, One)
    Name (TRTP, One)
    Name (WDTE, One)
    Name (TRTD, 0x02)
    Name (TRTI, 0x03)
    Name (PDBR, 0x4D)
    Name (DPPB, 0xFED98000)
    Name (DPPL, 0x8000)
    OperationRegion (GNVS, SystemMemory, 0xC6F8CAA4, 0x0300)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        SCIF,   8, 
        PRM2,   8, 
        PRM3,   8, 
        LCKF,   8, 
        PRM4,   8, 
        PRM5,   8, 
        P80D,   32, 
        LIDS,   8, 
        PWRS,   8, 
        DBGS,   8, 
        THOF,   8, 
        ACT1,   8, 
        ACTT,   8, 
        PSVT,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        CRTT,   8, 
        DTSE,   8, 
        DTS1,   8, 
        DTS2,   8, 
        DTSF,   8, 
        Offset (0x25), 
        REVN,   8, 
        Offset (0x28), 
        APIC,   8, 
        TCNT,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PPCM,   8, 
        PPMF,   32, 
        C67L,   8, 
        NATP,   8, 
        CMAP,   8, 
        CMBP,   8, 
        LPTP,   8, 
        FDCP,   8, 
        CMCP,   8, 
        CIRP,   8, 
        SMSC,   8, 
        W381,   8, 
        SMC1,   8, 
        IGDS,   8, 
        TLST,   8, 
        CADL,   8, 
        PADL,   8, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        NDID,   8, 
        DID1,   32, 
        DID2,   32, 
        DID3,   32, 
        DID4,   32, 
        DID5,   32, 
        KSV0,   32, 
        KSV1,   8, 
        Offset (0x67), 
        BLCS,   8, 
        BRTL,   8, 
        ALSE,   8, 
        ALAF,   8, 
        LLOW,   8, 
        LHIH,   8, 
        Offset (0x6E), 
        EMAE,   8, 
        EMAP,   16, 
        EMAL,   16, 
        Offset (0x74), 
        MEFE,   8, 
        DSTS,   8, 
        Offset (0x82), 
        GTF0,   112, 
        GTF2,   56, 
        IDEM,   8, 
        GTF1,   56, 
        BID,    8, 
        Offset (0xAA), 
        ASLB,   32, 
        IBTT,   8, 
        IPAT,   8, 
        ITVF,   8, 
        ITVM,   8, 
        IPSC,   8, 
        IBLC,   8, 
        IBIA,   8, 
        ISSC,   8, 
        I409,   8, 
        I509,   8, 
        I609,   8, 
        I709,   8, 
        IPCF,   8, 
        IDMS,   8, 
        IF1E,   8, 
        HVCO,   8, 
        NXD1,   32, 
        NXD2,   32, 
        NXD3,   32, 
        NXD4,   32, 
        NXD5,   32, 
        NXD6,   32, 
        NXD7,   32, 
        NXD8,   32, 
        GSMI,   8, 
        PAVP,   8, 
        Offset (0xE1), 
        OSCC,   8, 
        NEXP,   8, 
        SBV1,   8, 
        SBV2,   8, 
        Offset (0xEB), 
        DSEN,   8, 
        ECON,   8, 
        GPIC,   8, 
        CTYP,   8, 
        L01C,   8, 
        VFN0,   8, 
        VFN1,   8, 
        VFN2,   8, 
        VFN3,   8, 
        VFN4,   8, 
        Offset (0x100), 
        NVGA,   32, 
        NVHA,   32, 
        AMDA,   32, 
        DID6,   32, 
        DID7,   32, 
        DID8,   32, 
        EBAS,   32, 
        CPSP,   32, 
        EECP,   32, 
        EVCP,   32, 
        XBAS,   32, 
        OBS1,   32, 
        OBS2,   32, 
        OBS3,   32, 
        OBS4,   32, 
        OBS5,   32, 
        OBS6,   32, 
        OBS7,   32, 
        OBS8,   32, 
        Offset (0x157), 
        ATMC,   8, 
        PTMC,   8, 
        ATRA,   8, 
        PTRA,   8, 
        PNHM,   32, 
        TBAB,   32, 
        TBAH,   32, 
        RTIP,   8, 
        TSOD,   8, 
        ATPC,   8, 
        PTPC,   8, 
        PFLV,   8, 
        BREV,   8, 
        HGMD,   8, 
        PWOK,   8, 
        HLRS,   8, 
        DSEL,   8, 
        ESEL,   8, 
        PSEL,   8, 
        PWEN,   8, 
        PRST,   8, 
        DPBM,   8, 
        DPCM,   8, 
        DPDM,   8, 
        ALFP,   8, 
        IMON,   8, 
        PDTS,   8, 
        PKGA,   8, 
        PAMT,   8, 
        AC0F,   8, 
        AC1F,   8, 
        DTS3,   8, 
        DTS4,   8, 
        Offset (0x195), 
        PH01,   8, 
        PH02,   8, 
        PH03,   8, 
        PPRQ,   8, 
        PPLO,   8, 
        PPRP,   8, 
        PPOR,   8, 
        TPRS,   8, 
        TPMV,   8, 
        MOR,    8, 
        RSV0,   8, 
        LIDB,   1, 
        Offset (0x1A1), 
        TCG0,   1, 
        Offset (0x1A2), 
        CHKC,   32, 
        CHKE,   32, 
        DKLG,   1, 
        Offset (0x1AB), 
        Offset (0x1B0), 
        WOLN,   8, 
        BRNS,   4, 
            ,   2, 
        VCDB,   1, 
        LFMG,   1, 
        ACST,   1, 
        Offset (0x1B3), 
        USBP,   8, 
        ESG0,   1, 
        ESG1,   1, 
        C4WR,   1, 
        C4AC,   1, 
        OSC4,   1, 
        Offset (0x1B5), 
        LANO,   1, 
        LIDW,   1, 
        Offset (0x1B6), 
        BTMD,   1, 
        WLNP,   1, 
        WANP,   1, 
        MCMU,   1, 
        CMAB,   1, 
        WOFF,   1, 
        CMAT,   1, 
        BTHA,   1, 
        CBCI,   1, 
        CWAI,   1, 
        CBTP,   1, 
        WWAP,   1, 
        WANA,   1, 
        WWNA,   1, 
        WALA,   1, 
        BTHG,   1, 
        OSFG,   8, 
        VCTR,   8, 
        Offset (0x1BB), 
        TJ90,   8, 
        LIDX,   1, 
        Offset (0x1BD), 
        GCDE,   8, 
        I3CP,   8, 
        DADD,   8, 
        SKS3,   8, 
        TMCP,   8, 
        Offset (0x1CF), 
        SXFG,   8, 
        CMD,    8, 
        ERR,    32, 
        PAR0,   32, 
        PAR1,   32, 
        PAR2,   32, 
        PAR3,   32, 
        Offset (0x1F0), 
        DB00,   8, 
        DB01,   8, 
        DB02,   8, 
        DB03,   8, 
        DB04,   8, 
        DB05,   8, 
        DB06,   8, 
        DB07,   8, 
        DB08,   8, 
        DB09,   8, 
        DB0A,   8, 
        DB0B,   8, 
        DB0C,   8, 
        DB0D,   8, 
        DB0E,   8, 
        DB0F,   8, 
        BFWB,   296, 
        Offset (0x230), 
        IPMS,   8, 
        IPMB,   120, 
        IPMR,   24, 
        IPMO,   24, 
        IPMA,   8, 
        Offset (0x249), 
        SPEN,   1, 
        SCRM,   1, 
        Offset (0x24A), 
        FTPS,   8, 
        ODDS,   1, 
        Offset (0x24C), 
        CWAC,   1, 
        CWAS,   1, 
        CWUE,   1, 
        CWUS,   1, 
        C4NA,   1, 
        Offset (0x24D), 
        CWAP,   16, 
        CWAT,   16, 
        Offset (0x253), 
        CDFL,   8, 
        CDAH,   8, 
        Offset (0x280), 
        FW00,   100, 
        Offset (0x2A0), 
        WLS0,   8, 
        WLS1,   8, 
        WLS2,   8, 
        WLS3,   8, 
        WLS4,   8, 
        WLS5,   8, 
        Offset (0x2B0), 
        LAG0,   8, 
        LAG1,   8, 
        LAG2,   8, 
        LAG3,   8, 
        LAG4,   8, 
        LAG5,   8, 
        LAG6,   8, 
        LAG7,   8
    }

    Scope (_SB)
    {
        Name (PR00, Package (0x1E)
        {
            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                LNKF, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                LNKH, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                LNKG, 
                Zero
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                Zero, 
                LNKE, 
                Zero
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                Zero, 
                LNKE, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKA, 
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
                0x0004FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x03, 
                LNKD, 
                Zero
            }
        })
        Name (AR00, Package (0x1E)
        {
            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x03, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                Zero, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                Zero, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x03, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                Zero, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                One, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x02, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x03, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x10
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
                0x0004FFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x03, 
                Zero, 
                0x13
            }
        })
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
        Name (PR08, Package (0x04)
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
        Name (AR08, Package (0x04)
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
        Name (PR09, Package (0x04)
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
        Name (AR09, Package (0x04)
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
        Name (PR0E, Package (0x04)
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
        Name (AR0E, Package (0x04)
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
        Name (PR0F, Package (0x04)
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
        Name (AR0F, Package (0x04)
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
        Name (PR02, Package (0x04)
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
        Name (AR02, Package (0x04)
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
        Name (PR0A, Package (0x04)
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
        Name (AR0A, Package (0x04)
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
        Name (PR0B, Package (0x04)
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
        Name (AR0B, Package (0x04)
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
        Name (PR0C, Package (0x04)
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
        Name (AR0C, Package (0x04)
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
        Name (PR01, Package (0x0C)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKF, 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                LNKG, 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                LNKH, 
                Zero
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                LNKE, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKG, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKF, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKE, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKH, 
                Zero
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                One, 
                LNKE, 
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
                LNKF, 
                Zero
            }
        })
        Name (AR01, Package (0x0C)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0xFFFF, 
                One, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x02, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0xFFFF, 
                0x03, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                Zero, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                One, 
                Zero, 
                0x14
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
                0x15
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {1,3,4,5,6,10,11,12,14,15}
        })
        Alias (PRSA, PRSB)
        Alias (PRSA, PRSC)
        Alias (PRSA, PRSD)
        Alias (PRSA, PRSE)
        Alias (PRSA, PRSF)
        Alias (PRSA, PRSG)
        Alias (PRSA, PRSH)
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            Method (^BN00, 0, NotSerialized)
            {
                Return (Zero)
            }

            Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
            {
                Return (BN00 ())
            }

            Name (_UID, Zero)  // _UID: Unique ID
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR00 ())
                }

                Return (PR00 ())
            }

            OperationRegion (HBUS, PCI_Config, Zero, 0x0100)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x40), 
                EPEN,   1, 
                    ,   11, 
                EPBR,   20, 
                Offset (0x48), 
                MHEN,   1, 
                    ,   14, 
                MHBR,   17, 
                Offset (0x50), 
                GCLK,   1, 
                Offset (0x54), 
                D0EN,   1, 
                Offset (0x60), 
                PXEN,   1, 
                PXSZ,   2, 
                    ,   23, 
                PXBR,   6, 
                Offset (0x68), 
                DIEN,   1, 
                    ,   11, 
                DIBR,   20, 
                Offset (0x70), 
                    ,   20, 
                MEBR,   12, 
                Offset (0x80), 
                    ,   4, 
                PM0H,   2, 
                Offset (0x81), 
                PM1L,   2, 
                    ,   2, 
                PM1H,   2, 
                Offset (0x82), 
                PM2L,   2, 
                    ,   2, 
                PM2H,   2, 
                Offset (0x83), 
                PM3L,   2, 
                    ,   2, 
                PM3H,   2, 
                Offset (0x84), 
                PM4L,   2, 
                    ,   2, 
                PM4H,   2, 
                Offset (0x85), 
                PM5L,   2, 
                    ,   2, 
                PM5H,   2, 
                Offset (0x86), 
                PM6L,   2, 
                    ,   2, 
                PM6H,   2, 
                Offset (0x87), 
                Offset (0xA8), 
                    ,   20, 
                TUUD,   19, 
                Offset (0xBC), 
                    ,   20, 
                TLUD,   12, 
                Offset (0xC8), 
                    ,   7, 
                HTSE,   1
            }

            OperationRegion (MCHT, SystemMemory, 0xFED10000, 0x1100)
            Field (MCHT, ByteAcc, NoLock, Preserve)
            {
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, _Y00)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000CF7,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000CF8,         // Length
                    ,, , TypeStatic, DenseTranslation)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000D00,         // Range Minimum
                    0x0000FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0000F300,         // Length
                    ,, , TypeStatic, DenseTranslation)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y01, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y02, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y03, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y04, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y05, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y06, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y07, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y08, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y09, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0A, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0B, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0C, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000F0000,         // Range Minimum
                    0x000FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00010000,         // Length
                    ,, _Y0D, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0xFEAFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0xFEB00000,         // Length
                    ,, _Y0E, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFED40000,         // Range Minimum
                    0xFED44FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00005000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFEAFF000,         // Range Minimum
                    0xFEB00000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00001000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUF0, \_SB.PCI0._Y00._MAX, PBMX)  // _MAX: Maximum Base Address
                PBMX = ((PELN >> 0x14) - 0x02)
                CreateWordField (BUF0, \_SB.PCI0._Y00._LEN, PBLN)  // _LEN: Length
                PBLN = ((PELN >> 0x14) - One)
                If (PM1L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y01._LEN, C0LN)  // _LEN: Length
                    C0LN = Zero
                }

                If ((PM1L == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y01._RW, C0RW)  // _RW_: Read-Write Status
                    C0RW = Zero
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y02._LEN, C4LN)  // _LEN: Length
                    C4LN = Zero
                }

                If ((PM1H == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y02._RW, C4RW)  // _RW_: Read-Write Status
                    C4RW = Zero
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y03._LEN, C8LN)  // _LEN: Length
                    C8LN = Zero
                }

                If ((PM2L == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y03._RW, C8RW)  // _RW_: Read-Write Status
                    C8RW = Zero
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y04._LEN, CCLN)  // _LEN: Length
                    CCLN = Zero
                }

                If ((PM2H == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y04._RW, CCRW)  // _RW_: Read-Write Status
                    CCRW = Zero
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y05._LEN, D0LN)  // _LEN: Length
                    D0LN = Zero
                }

                If ((PM3L == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y05._RW, D0RW)  // _RW_: Read-Write Status
                    D0RW = Zero
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y06._LEN, D4LN)  // _LEN: Length
                    D4LN = Zero
                }

                If ((PM3H == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y06._RW, D4RW)  // _RW_: Read-Write Status
                    D4RW = Zero
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y07._LEN, D8LN)  // _LEN: Length
                    D8LN = Zero
                }

                If ((PM4L == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y07._RW, D8RW)  // _RW_: Read-Write Status
                    D8RW = Zero
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y08._LEN, DCLN)  // _LEN: Length
                    DCLN = Zero
                }

                If ((PM4H == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y08._RW, DCRW)  // _RW_: Read-Write Status
                    DCRW = Zero
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y09._LEN, E0LN)  // _LEN: Length
                    E0LN = Zero
                }

                If ((PM5L == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y09._RW, E0RW)  // _RW_: Read-Write Status
                    E0RW = Zero
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0A._LEN, E4LN)  // _LEN: Length
                    E4LN = Zero
                }

                If ((PM5H == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0A._RW, E4RW)  // _RW_: Read-Write Status
                    E4RW = Zero
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0B._LEN, E8LN)  // _LEN: Length
                    E8LN = Zero
                }

                If ((PM6L == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0B._RW, E8RW)  // _RW_: Read-Write Status
                    E8RW = Zero
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0C._LEN, ECLN)  // _LEN: Length
                    ECLN = Zero
                }

                If ((PM6H == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0C._RW, ECRW)  // _RW_: Read-Write Status
                    ECRW = Zero
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0D._LEN, F0LN)  // _LEN: Length
                    F0LN = Zero
                }

                If ((PM0H == One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0D._RW, F0RW)  // _RW_: Read-Write Status
                    F0RW = Zero
                }

                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MIN, M1MN)  // _MIN: Minimum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MAX, M1MX)  // _MAX: Maximum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._LEN, M1LN)  // _LEN: Length
                M1MN = (TLUD << 0x14)
                M1LN = ((M1MX - M1MN) + One)
                Return (BUF0) /* \_SB_.PCI0.BUF0 */
            }

            Name (GUID, ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */)
            Name (SUPP, Zero)
            Name (CTRL, Zero)
            Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
            {
                Local0 = Arg3
                CreateDWordField (Local0, Zero, CDW1)
                CreateDWordField (Local0, 0x04, CDW2)
                CreateDWordField (Local0, 0x08, CDW3)
                If (((Arg0 == GUID) && NEXP))
                {
                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
                    If (~(CDW1 & One))
                    {
                        If ((CTRL & One))
                        {
                            NHPG ()
                        }

                        If ((CTRL & 0x04))
                        {
                            NPME ()
                        }
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
                    OSCC = CTRL /* \_SB_.PCI0.CTRL */
                    Return (Local0)
                }
                Else
                {
                    CDW1 |= 0x04
                    Return (Local0)
                }
            }

            Scope (\_SB.PCI0)
            {
                Method (AR00, 0, NotSerialized)
                {
                    Return (^^AR00) /* \_SB_.AR00 */
                }

                Method (PR00, 0, NotSerialized)
                {
                    Return (^^PR00) /* \_SB_.PR00 */
                }

                Method (AR01, 0, NotSerialized)
                {
                    Return (^^AR01) /* \_SB_.AR01 */
                }

                Method (PR01, 0, NotSerialized)
                {
                    Return (^^PR01) /* \_SB_.PR01 */
                }

                Method (AR02, 0, NotSerialized)
                {
                    Return (^^AR02) /* \_SB_.AR02 */
                }

                Method (PR02, 0, NotSerialized)
                {
                    Return (^^PR02) /* \_SB_.PR02 */
                }

                Method (AR04, 0, NotSerialized)
                {
                    Return (^^AR04) /* \_SB_.AR04 */
                }

                Method (PR04, 0, NotSerialized)
                {
                    Return (^^PR04) /* \_SB_.PR04 */
                }

                Method (AR05, 0, NotSerialized)
                {
                    Return (^^AR05) /* \_SB_.AR05 */
                }

                Method (PR05, 0, NotSerialized)
                {
                    Return (^^PR05) /* \_SB_.PR05 */
                }

                Method (AR06, 0, NotSerialized)
                {
                    Return (^^AR06) /* \_SB_.AR06 */
                }

                Method (PR06, 0, NotSerialized)
                {
                    Return (^^PR06) /* \_SB_.PR06 */
                }

                Method (AR07, 0, NotSerialized)
                {
                    Return (^^AR07) /* \_SB_.AR07 */
                }

                Method (PR07, 0, NotSerialized)
                {
                    Return (^^PR07) /* \_SB_.PR07 */
                }

                Method (AR08, 0, NotSerialized)
                {
                    Return (^^AR08) /* \_SB_.AR08 */
                }

                Method (PR08, 0, NotSerialized)
                {
                    Return (^^PR08) /* \_SB_.PR08 */
                }

                Method (AR09, 0, NotSerialized)
                {
                    Return (^^AR09) /* \_SB_.AR09 */
                }

                Method (PR09, 0, NotSerialized)
                {
                    Return (^^PR09) /* \_SB_.PR09 */
                }

                Method (AR0A, 0, NotSerialized)
                {
                    Return (^^AR0A) /* \_SB_.AR0A */
                }

                Method (PR0A, 0, NotSerialized)
                {
                    Return (^^PR0A) /* \_SB_.PR0A */
                }

                Method (AR0B, 0, NotSerialized)
                {
                    Return (^^AR0B) /* \_SB_.AR0B */
                }

                Method (PR0B, 0, NotSerialized)
                {
                    Return (^^PR0B) /* \_SB_.PR0B */
                }
            }

            Device (P0P1)
            {
                Name (_ADR, 0x001E0000)  // _ADR: Address
                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (GPRW (0x0B, 0x04))
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (PICM)
                    {
                        Return (AR01 ())
                    }

                    Return (PR01 ())
                }
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)  // _ADR: Address
                Scope (\_SB)
                {
                    OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
                    Field (SMI0, AnyAcc, NoLock, Preserve)
                    {
                        SMIC,   8
                    }

                    OperationRegion (SMI1, SystemMemory, 0xC6F8CEBD, 0x00000090)
                    Field (SMI1, AnyAcc, NoLock, Preserve)
                    {
                        BCMD,   8, 
                        DID,    32, 
                        INFO,   1024
                    }

                    Field (SMI1, AnyAcc, NoLock, Preserve)
                    {
                        AccessAs (ByteAcc, 0x00), 
                        Offset (0x05), 
                        INF,    8
                    }

                    Method (PHSR, 1, Serialized)
                    {
                        BCMD = Arg0
                        DID = Zero
                        SMIC = Zero
                        If ((BCMD == Arg0)){}
                        BCMD = Zero
                        DID = Zero
                        Return (Zero)
                    }

                    OperationRegion (PCI0.LPCB.LPC1, PCI_Config, 0x40, 0xC0)
                    Field (PCI0.LPCB.LPC1, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x20), 
                        PARC,   8, 
                        PBRC,   8, 
                        PCRC,   8, 
                        PDRC,   8, 
                        Offset (0x28), 
                        PERC,   8, 
                        PFRC,   8, 
                        PGRC,   8, 
                        PHRC,   8
                    }

                    Device (LNKA)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, One)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PARC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSA) /* \_SB_.PRSA */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLA, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLA, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PARC & 0x0F))
                            Return (RTLA) /* \_SB_.LNKA._CRS.RTLA */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PARC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PARC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKB)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x02)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PBRC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSB) /* \_SB_.PRSB */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLB, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLB, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PBRC & 0x0F))
                            Return (RTLB) /* \_SB_.LNKB._CRS.RTLB */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PBRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PBRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKC)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x03)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PCRC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSC) /* \_SB_.PRSC */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLC, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLC, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PCRC & 0x0F))
                            Return (RTLC) /* \_SB_.LNKC._CRS.RTLC */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PCRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PCRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKD)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x04)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PDRC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSD) /* \_SB_.PRSD */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLD, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLD, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PDRC & 0x0F))
                            Return (RTLD) /* \_SB_.LNKD._CRS.RTLD */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PDRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PDRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKE)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x05)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PERC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSE) /* \_SB_.PRSE */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLE, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLE, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PERC & 0x0F))
                            Return (RTLE) /* \_SB_.LNKE._CRS.RTLE */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PERC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PERC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKF)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x06)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PFRC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSF) /* \_SB_.PRSF */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLF, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLF, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PFRC & 0x0F))
                            Return (RTLF) /* \_SB_.LNKF._CRS.RTLF */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PFRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PFRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKG)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x07)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PGRC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSG) /* \_SB_.PRSG */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLG, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLG, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PGRC & 0x0F))
                            Return (RTLG) /* \_SB_.LNKG._CRS.RTLG */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PGRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PGRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKH)
                    {
                        Name (_HID, EisaId ("PNP0C0F") /* PCI Interrupt Link Device */)  // _HID: Hardware ID
                        Name (_UID, 0x08)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            PHRC |= 0x80
                        }

                        Method (_PRS, 0, Serialized)  // _PRS: Possible Resource Settings
                        {
                            Return (PRSH) /* \_SB_.PRSH */
                        }

                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLH, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLH, One, IRQ0)
                            IRQ0 = Zero
                            IRQ0 = (One << (PHRC & 0x0F))
                            Return (RTLH) /* \_SB_.LNKH._CRS.RTLH */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Local0--
                            PHRC = Local0
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If ((PHRC & 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }
                }

                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    IOD0,   8, 
                    IOD1,   8, 
                    Offset (0xB0), 
                    RAEN,   1, 
                        ,   13, 
                    RCBA,   18
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x11,               // Length
                            )
                        IO (Decode16,
                            0x0093,             // Range Minimum
                            0x0093,             // Range Maximum
                            0x01,               // Alignment
                            0x0D,               // Length
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

                Device (FWHD)
                {
                    Name (_HID, EisaId ("INT0800") /* Intel 82802 Firmware Hub Device */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadOnly,
                            0xFF000000,         // Address Base
                            0x01000000,         // Address Length
                            )
                    })
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103") /* HPET System Timer */)  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y0F)
                    })
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If ((OSYS >= 0x07D1))
                        {
                            If (HPAE)
                            {
                                Return (0x0F)
                            }
                        }
                        ElseIf (HPAE)
                        {
                            Return (0x0B)
                        }

                        Return (Zero)
                    }

                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        If (HPAE)
                        {
                            CreateDWordField (BUF0, \_SB.PCI0.LPCB.HPET._Y0F._BAS, HPT0)  // _BAS: Base Address
                            If ((HPAS == One))
                            {
                                HPT0 = 0xFED01000
                            }

                            If ((HPAS == 0x02))
                            {
                                HPT0 = 0xFED02000
                            }

                            If ((HPAS == 0x03))
                            {
                                HPT0 = 0xFED03000
                            }
                        }

                        Return (BUF0) /* \_SB_.PCI0.LPCB.HPET.BUF0 */
                    }
                }

                Device (IPIC)
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
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B4,             // Range Minimum
                            0x00B4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04") /* x87-compatible Floating Point Processing Unit */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x004E,             // Range Minimum
                            0x004E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0680,             // Range Minimum
                            0x0680,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0800,             // Range Minimum
                            0x0800,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0xFFFF,             // Range Minimum
                            0xFFFF,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0xFFFF,             // Range Minimum
                            0xFFFF,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x01,               // Alignment
                            0x54,               // Length
                            )
                        IO (Decode16,
                            0x0458,             // Range Minimum
                            0x0458,             // Range Maximum
                            0x01,               // Alignment
                            0x28,               // Length
                            )
                        IO (Decode16,
                            0x0500,             // Range Minimum
                            0x0500,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x1600,             // Range Minimum
                            0x1600,             // Range Maximum
                            0x01,               // Alignment
                            0xFF,               // Length
                            )
                        IO (Decode16,
                            0xFE00,             // Range Minimum
                            0xFE00,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0068,             // Range Minimum
                            0x0068,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x006C,             // Range Minimum
                            0x006C,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0700,             // Range Minimum
                            0x0700,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {8}
                    })
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100") /* PC-class System Timer */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }

                Device (CWDT)
                {
                    Name (_HID, EisaId ("INT3F0D") /* ACPI Motherboard Resources */)  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _CID: Compatible ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0454,             // Range Minimum
                            0x0454,             // Range Maximum
                            0x04,               // Alignment
                            0x04,               // Length
                            )
                    })
                    Method (_STA, 0, Serialized)  // _STA: Status
                    {
                        If ((WDTE == One))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Return (BUF0) /* \_SB_.PCI0.LPCB.CWDT.BUF0 */
                    }
                }

                OperationRegion (PKBS, SystemIO, 0x60, 0x05)
                Field (PKBS, ByteAcc, Lock, Preserve)
                {
                    PKBD,   8, 
                    Offset (0x02), 
                    Offset (0x03), 
                    Offset (0x04), 
                    PKBC,   8
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard (101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
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
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {1}
                    })
                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            FixedIO (
                                0x0060,             // Address
                                0x01,               // Length
                                )
                            FixedIO (
                                0x0064,             // Address
                                0x01,               // Length
                                )
                            IRQNoFlags ()
                                {1}
                        }
                        EndDependentFn ()
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("IBM0057"))  // _HID: Hardware ID
                    Name (_CID, EisaId ("PNP0F13") /* PS/2 Mouse */)  // _CID: Compatible ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IRQNoFlags ()
                                {12}
                        }
                        EndDependentFn ()
                    })
                    Method (MHID, 0, NotSerialized)
                    {
                        _HID = 0x1700AE30
                    }
                }

                Device (TPM)
                {
                    Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
                    {
                        TPHY (Zero)
                        If ((TPMV == One))
                        {
                            Return (0x0201D824)
                        }

                        If ((TPMV == 0x02))
                        {
                            Return (0x0435CF4D)
                        }

                        If ((TPMV == 0x03))
                        {
                            Return (0x02016D08)
                        }

                        If ((TPMV == 0x04))
                        {
                            Return (0x01016D08)
                        }

                        If (((TPMV == 0x05) || (TPMV == 0x06)))
                        {
                            Return (0x0010A35C)
                        }

                        If ((TPMV == 0x08))
                        {
                            Return (0x00128D06)
                        }

                        If ((TPMV == 0x09))
                        {
                            Return ("INTC0102")
                        }

                        If ((TPMV == 0x0A))
                        {
                            Return ("SMO1200")
                        }

                        Return (0x310CD041)
                    }

                    Name (_CID, EisaId ("PNP0C31"))  // _CID: Compatible ID
                    Name (_UID, One)  // _UID: Unique ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        TPHY (Zero)
                        If (TPRS)
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }

                    Name (BUF1, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xFED40000,         // Address Base
                            0x00005000,         // Address Length
                            )
                    })
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Return (BUF1) /* \_SB_.PCI0.LPCB.TPM_.BUF1 */
                    }

                    Method (UCMP, 2, NotSerialized)
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

                    Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                    {
                        Name (PPRC, Zero)
                        Name (RQS1, Package (0x02)
                        {
                            0x0C, 
                            0x0D
                        })
                        Name (TTMP, Buffer (One)
                        {
                             0x00                                             // .
                        })
                        CreateByteField (TTMP, Zero, TMPV)
                        If ((UCMP (Arg0, ToUUID ("3dddfaa6-361b-4eb4-a424-8d10089d1653") /* Physical Presence Interface */) == One))
                        {
                            If ((Arg2 == Zero))
                            {
                                Return (Buffer (One)
                                {
                                     0x7F                                             // .
                                })
                            }

                            If ((Arg2 == One))
                            {
                                Return (Buffer (0x04)
                                {
                                    "1.0"
                                })
                            }

                            If ((Arg2 == 0x02))
                            {
                                If (TPRS)
                                {
                                    PPRC = Zero
                                    If (LFLS ())
                                    {
                                        PPRC = 0x02
                                    }
                                    Else
                                    {
                                        If ((DerefOf (Arg3 [Zero]) == Zero))
                                        {
                                            PPRQ = Zero
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == One))
                                        {
                                            PPRQ = One
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x02))
                                        {
                                            PPRQ = 0x02
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x03))
                                        {
                                            PPRQ = 0x03
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x04))
                                        {
                                            PPRQ = 0x04
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x05))
                                        {
                                            PPRQ = 0x05
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x06))
                                        {
                                            PPRQ = 0x06
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x07))
                                        {
                                            PPRQ = 0x07
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x08))
                                        {
                                            PPRQ = 0x08
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x09))
                                        {
                                            PPRQ = 0x09
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x0A))
                                        {
                                            PPRQ = 0x0A
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x0B))
                                        {
                                            PPRQ = 0x0B
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x0C))
                                        {
                                            PPRQ = 0x0C
                                            Return (One)
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x0D))
                                        {
                                            PPRQ = 0x0D
                                            Return (One)
                                        }

                                        If ((DerefOf (Arg3 [Zero]) == 0x0E))
                                        {
                                            PPRQ = 0x0E
                                        }

                                        If ((DerefOf (Arg3 [Zero]) >= 0x0F))
                                        {
                                            Return (One)
                                        }

                                        SFLS ()
                                        Return (PPRC) /* \_SB_.PCI0.LPCB.TPM_._DSM.PPRC */
                                    }
                                }

                                Return (One)
                            }

                            If ((Arg2 == 0x03))
                            {
                                Name (TMP1, Package (0x02)
                                {
                                    Zero, 
                                    0xFFFFFFFF
                                })
                                If (LFLS ())
                                {
                                    TMP1 [Zero] = One
                                    Return (TMP1) /* \_SB_.PCI0.LPCB.TPM_._DSM.TMP1 */
                                }

                                TMP1 [One] = PPRQ /* \PPRQ */
                                Return (TMP1) /* \_SB_.PCI0.LPCB.TPM_._DSM.TMP1 */
                            }

                            If ((Arg2 == 0x04))
                            {
                                Return (One)
                            }

                            If ((Arg2 == 0x05))
                            {
                                Name (TMP2, Package (0x03)
                                {
                                    Zero, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF
                                })
                                If (LFLS ())
                                {
                                    TMP2 [Zero] = One
                                    Return (TMP2) /* \_SB_.PCI0.LPCB.TPM_._DSM.TMP2 */
                                }

                                TMP2 [One] = PPLO /* \PPLO */
                                If ((PPLO > 0x0E))
                                {
                                    TMP2 [0x02] = 0xFFFFFFF1
                                    Return (TMP2) /* \_SB_.PCI0.LPCB.TPM_._DSM.TMP2 */
                                }

                                If ((PPRQ == 0x1F))
                                {
                                    TMP2 [0x02] = 0xFFFFFFF1
                                    Return (TMP2) /* \_SB_.PCI0.LPCB.TPM_._DSM.TMP2 */
                                }

                                If (PPOR)
                                {
                                    TMP2 [0x02] = 0xFFFFFFF0
                                    Return (TMP2) /* \_SB_.PCI0.LPCB.TPM_._DSM.TMP2 */
                                }

                                TMP2 [0x02] = Zero
                                Return (TMP2) /* \_SB_.PCI0.LPCB.TPM_._DSM.TMP2 */
                            }

                            If ((Arg2 == 0x06))
                            {
                                CreateByteField (Arg3, 0x04, LAN0)
                                CreateByteField (Arg3, 0x05, LAN1)
                                If (((LAN0 == 0x65) || (LAN0 == 0x45)))
                                {
                                    If (((LAN1 == 0x6E) || (LAN1 == 0x4E)))
                                    {
                                        Return (Zero)
                                    }
                                }

                                Return (One)
                            }

                            Return (One)
                        }

                        If ((UCMP (Arg0, ToUUID ("376054ed-cc13-4675-901c-4756d7f2d45d") /* Unknown UUID */) == One))
                        {
                            If ((Arg2 == Zero))
                            {
                                Return (Buffer (One)
                                {
                                     0x01                                             // .
                                })
                            }

                            If ((Arg2 == One))
                            {
                                If ((DerefOf (Arg3 [Zero]) == Zero))
                                {
                                    If (LFLS ())
                                    {
                                        Return (0x02)
                                    }

                                    MOR = Zero
                                    SFLS ()
                                    Return (Zero)
                                }

                                If ((DerefOf (Arg3 [Zero]) == One))
                                {
                                    If (LFLS ())
                                    {
                                        Return (0x02)
                                    }

                                    MOR = One
                                    SFLS ()
                                    Return (Zero)
                                }
                            }

                            Return (One)
                        }

                        Return (Buffer (One)
                        {
                             0x00                                             // .
                        })
                    }

                    Method (LFLS, 0, NotSerialized)
                    {
                        Name (TMPB, Buffer (0x02)
                        {
                             0x00, 0x00                                       // ..
                        })
                        CreateByteField (TMPB, Zero, LPCT)
                        CreateByteField (TMPB, One, SSUM)
                        TPHY (Zero)
                        LPCT = PH02 /* \PH02 */
                        If (LPCT)
                        {
                            SSUM = Zero
                            SSUM += PH01 /* \PH01 */
                            SSUM += PH02 /* \PH02 */
                            SSUM += PH03 /* \PH03 */
                            SSUM += PPRQ /* \PPRQ */
                            SSUM += PPLO /* \PPLO */
                            SSUM += PPRP /* \PPRP */
                            SSUM += PPOR /* \PPOR */
                            SSUM += TPRS /* \TPRS */
                            SSUM += TPMV /* \TPMV */
                            SSUM += MOR /* \MOR_ */
                            SSUM += RSV0 /* \RSV0 */
                            If (SSUM)
                            {
                                Return (0x02)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Return (0x02)
                    }

                    Method (SFLS, 0, NotSerialized)
                    {
                        Name (TMPB, Buffer (0x02)
                        {
                             0x00, 0x00                                       // ..
                        })
                        CreateByteField (TMPB, Zero, LPCT)
                        CreateByteField (TMPB, One, SSUM)
                        LPCT = PH02 /* \PH02 */
                        If (LPCT)
                        {
                            SSUM = Zero
                            SSUM += PH01 /* \PH01 */
                            SSUM += PH02 /* \PH02 */
                            SSUM += PH03 /* \PH03 */
                            SSUM += PPRQ /* \PPRQ */
                            SSUM += PPLO /* \PPLO */
                            SSUM += PPRP /* \PPRP */
                            SSUM += PPOR /* \PPOR */
                            SSUM += TPRS /* \TPRS */
                            SSUM += TPMV /* \TPMV */
                            SSUM += MOR /* \MOR_ */
                            SSUM += RSV0 /* \RSV0 */
                            PH03 = (Zero - SSUM) /* \_SB_.PCI0.LPCB.TPM_.SFLS.SSUM */
                            TPHY (One)
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x02)
                        }
                    }
                }
            }
        }
    }

    Mutex (MUTX, 0x00)
    OperationRegion (PRT0, SystemIO, 0x80, 0x04)
    Field (PRT0, DWordAcc, Lock, Preserve)
    {
        P80H,   32
    }

    Method (P8XH, 2, Serialized)
    {
        If ((Arg0 == Zero))
        {
            P80D = ((P80D & 0xFFFFFF00) | Arg1)
        }

        If ((Arg0 == One))
        {
            P80D = ((P80D & 0xFFFF00FF) | (Arg1 << 0x08))
        }

        If ((Arg0 == 0x02))
        {
            P80D = ((P80D & 0xFF00FFFF) | (Arg1 << 0x10))
        }

        If ((Arg0 == 0x03))
        {
            P80D = ((P80D & 0x00FFFFFF) | (Arg1 << 0x18))
        }

        P80H = P80D /* \P80D */
    }

    OperationRegion (SPRT, SystemIO, 0xB2, 0x02)
    Field (SPRT, ByteAcc, Lock, Preserve)
    {
        SSMP,   8
    }

    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        GPIC = Arg0
        PICM = Arg0
    }

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        P80D = Zero
        P8XH (Zero, Arg0)
        SXFG = Arg0
        SKS3 = Arg0
        If ((Arg0 == 0x03))
        {
            \_SB.PCI0.LPCB.EC.S3FG = One
            \_SB.PHSR (0x81)
        }

        If ((Arg0 == 0x04))
        {
            \_SB.PCI0.LPCB.EC.S3FG = One
            \_SB.PHSR (0x81)
        }

        If ((Arg0 == 0x03))
        {
            If ((DTSE && (TCNT > One)))
            {
                TRAP (TRTD, 0x1E)
            }
        }
    }

    Method (_WAK, 1, Serialized)  // _WAK: Wake
    {
        P8XH (Zero, 0xAB)
        SXFG = Arg0
        SKS3 = Zero
        SPS = Zero
        C4AC = One
        ODDS = Zero
        If (NEXP)
        {
            If ((OSCC & 0x02))
            {
                \_SB.PCI0.NHPG ()
            }

            If ((OSCC & 0x04))
            {
                \_SB.PCI0.NPME ()
            }
        }

        GU07 = Zero
        GU09 = Zero
        \_SB.PCI0.PEG0.VGA.LCD.CC01 = Zero
        LIDX = Zero
        If (IGDS)
        {
            If ((\_SB.PCI0.LPCB.EC.HPLD == One))
            {
                LIDS = One
                \_SB.PCI0.GFX0.CLID = One
            }
            Else
            {
                LIDS = Zero
                \_SB.PCI0.GFX0.CLID = Zero
            }
        }
        ElseIf (((OSYS > 0x07D0) && (OSYS < 0x07D6)))
        {
            If ((\_SB.PCI0.LPCB.EC.HPLD == One))
            {
                \_SB.PHSR (0x9F)
            }
            Else
            {
                \_SB.PHSR (0x9E)
            }
        }

        If ((Arg0 == 0x03))
        {
            \_SB.PCI0.LPCB.EC.HKEY.HKS3 ()
        }

        If ((Arg0 == 0x04))
        {
            \_SB.PHSR (0x82)
            \_SB.PCI0.LPCB.EC.HSUN = 0x03
            Notify (\_TZ.TZ00, 0x80) // Thermal Status Change
            Notify (\_SB.PWRB, 0x02) // Device Wake
            If (IGDS)
            {
                If ((OSYS < 0x07D6))
                {
                    Notify (\_SB.PCI0.GFX0, 0x80) // Status Change
                }
            }
        }

        If (((Arg0 == 0x03) || (Arg0 == 0x04)))
        {
            If (SCRM)
            {
                \_SB.PCI0.LPCB.EC.SCRS = One
                \_SB.PCI0.LPCB.EC.HFSP = 0x07
            }

            If ((DTSE && (TCNT > One)))
            {
                TRAP (TRTD, 0x14)
            }

            If ((OSYS == 0x07D2))
            {
                If ((CFGD & One))
                {
                    If ((\_PR.CPU0._PPC > Zero))
                    {
                        \_PR.CPU0._PPC -= One
                        PNOT ()
                        \_PR.CPU0._PPC += One
                        PNOT ()
                    }
                    Else
                    {
                        \_PR.CPU0._PPC += One
                        PNOT ()
                        \_PR.CPU0._PPC -= One
                        PNOT ()
                    }
                }
            }

            If ((RP1D == Zero))
            {
                Notify (\_SB.PCI0.RP01, Zero) // Bus Check
            }

            If ((RP2D == Zero))
            {
                Notify (\_SB.PCI0.RP02, Zero) // Bus Check
            }

            If ((RP3D == Zero))
            {
                Notify (\_SB.PCI0.RP03, Zero) // Bus Check
            }

            If ((RP4D == Zero))
            {
                Notify (\_SB.PCI0.RP04, Zero) // Bus Check
            }

            If ((RP5D == Zero))
            {
                Notify (\_SB.PCI0.RP05, Zero) // Bus Check
            }

            If ((RP6D == Zero))
            {
                Notify (\_SB.PCI0.RP06, Zero) // Bus Check
            }

            If ((RP7D == Zero))
            {
                Notify (\_SB.PCI0.RP07, Zero) // Bus Check
            }

            If ((RP8D == Zero))
            {
                Notify (\_SB.PCI0.RP08, Zero) // Bus Check
            }
        }

        If ((Arg0 < 0x04))
        {
            If ((((Local1 = (\_SB.PCI0.LPCB.EC.HB0S & 0x0F)) == Zero) && !\_SB.PCI0.LPCB.EC.ACPW))
            {
                \_SB.PCI0.LPCB.EC.ETHB = 0x0A
            }
        }

        P8XH (Zero, 0xCD)
        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Method (GETB, 3, Serialized)
    {
        Local0 = (Arg0 * 0x08)
        Local1 = (Arg1 * 0x08)
        CreateField (Arg2, Local0, Local1, TBF3)
        Return (TBF3) /* \GETB.TBF3 */
    }

    Method (PNOT, 0, Serialized)
    {
        If ((TCNT > One))
        {
            If ((PDC0 & 0x08))
            {
                Notify (\_PR.CPU0, 0x80) // Performance Capability Change
                If ((PDC0 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU0, 0x81) // C-State Change
                }
            }

            If ((PDC1 & 0x08))
            {
                Notify (\_PR.CPU1, 0x80) // Performance Capability Change
                If ((PDC1 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU1, 0x81) // C-State Change
                }
            }

            If ((PDC2 & 0x08))
            {
                Notify (\_PR.CPU2, 0x80) // Performance Capability Change
                If ((PDC2 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU2, 0x81) // C-State Change
                }
            }

            If ((PDC3 & 0x08))
            {
                Notify (\_PR.CPU3, 0x80) // Performance Capability Change
                If ((PDC3 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU3, 0x81) // C-State Change
                }
            }

            If ((PDC4 & 0x08))
            {
                Notify (\_PR.CPU4, 0x80) // Performance Capability Change
                If ((PDC4 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU4, 0x81) // C-State Change
                }
            }

            If ((PDC5 & 0x08))
            {
                Notify (\_PR.CPU5, 0x80) // Performance Capability Change
                If ((PDC5 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU5, 0x81) // C-State Change
                }
            }

            If ((PDC6 & 0x08))
            {
                Notify (\_PR.CPU6, 0x80) // Performance Capability Change
                If ((PDC6 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU6, 0x81) // C-State Change
                }
            }

            If ((PDC7 & 0x08))
            {
                Notify (\_PR.CPU7, 0x80) // Performance Capability Change
                If ((PDC7 & 0x10))
                {
                    Sleep (0x64)
                    Notify (\_PR.CPU7, 0x81) // C-State Change
                }
            }
        }
        Else
        {
            Notify (\_PR.CPU0, 0x80) // Performance Capability Change
            Sleep (0x64)
            Notify (\_PR.CPU0, 0x81) // C-State Change
        }
    }

    Method (TRAP, 2, Serialized)
    {
        SMIF = Arg1
        If ((Arg0 == TRTP))
        {
            TRP0 = Zero
        }

        If ((Arg0 == TRTD))
        {
            DTSF = Arg1
            TRPD = Zero
            Return (DTSF) /* \DTSF */
        }

        If ((Arg0 == TRTI))
        {
            TRPH = Zero
        }

        Return (SMIF) /* \SMIF */
    }

    Scope (_SB.PCI0)
    {
        Name (EBRL, 0x64)
        Name (EBRV, Zero)
        Name (IBCL, Package (0x12)
        {
            0x64, 
            0x23, 
            0x14, 
            0x19, 
            0x1E, 
            0x23, 
            0x28, 
            0x2D, 
            0x32, 
            0x37, 
            0x3C, 
            0x41, 
            0x46, 
            0x4B, 
            0x50, 
            0x55, 
            0x5A, 
            0x64
        })
        Method (IBCM, 1, NotSerialized)
        {
            EBRL = Arg0
            If ((EBRL < (DerefOf (IBCL [0x02]) + One)))
            {
                BRNS = Zero
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x03]) + One)))
            {
                BRNS = One
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x04]) + One)))
            {
                BRNS = 0x02
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x05]) + One)))
            {
                BRNS = 0x03
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x06]) + One)))
            {
                BRNS = 0x04
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x07]) + One)))
            {
                BRNS = 0x05
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x08]) + One)))
            {
                BRNS = 0x06
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x09]) + One)))
            {
                BRNS = 0x07
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x0A]) + One)))
            {
                BRNS = 0x08
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x0B]) + One)))
            {
                BRNS = 0x09
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x0C]) + One)))
            {
                BRNS = 0x0A
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x0D]) + One)))
            {
                BRNS = 0x0B
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x0E]) + One)))
            {
                BRNS = 0x0C
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x0F]) + One)))
            {
                BRNS = 0x0D
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x10]) + One)))
            {
                BRNS = 0x0E
            }
            ElseIf ((EBRL < (DerefOf (IBCL [0x11]) + One)))
            {
                BRNS = 0x0F
            }

            If (!IGDS)
            {
                If ((OSYS >= 0x07D6))
                {
                    UCMS (0x14)
                }

                If (IGDS)
                {
                    UCMS (0x06)
                    BRTL = DerefOf (PNLS [BRNS])
                    ISBC (DerefOf (PNLS [BRNS]))
                    ^GFX0.ASLE = One
                }
                ElseIf ((EBRV != BRNS))
                {
                    UCMS (0x06)
                }

                EBRV = BRNS /* \BRNS */
            }
        }

        Name (ISCT, Zero)
        Method (ISBC, 1, NotSerialized)
        {
            ^GFX0.PARD ()
            ^GFX0.BCLP = Arg0
            ^GFX0.BCLP |= 0x80000000
            ^GFX0.ASLC = 0x02
            ISCT = 0x05
            While ((^GFX0.ASLC && ISCT))
            {
                ^GFX0.LBPC = Zero
                ISCT--
            }
        }

        Name (PNLS, Buffer (0x10)
        {
            /* 0000 */  0x04, 0x08, 0x0D, 0x12, 0x16, 0x1D, 0x24, 0x2C,  // ......$,
            /* 0008 */  0x35, 0x3F, 0x4E, 0x62, 0x7E, 0x9E, 0xC8, 0xFF   // 5?Nb~...
        })
        Name (BRTB, Package (0x03)
        {
            Package (0x10)
            {
                0x04, 
                0x08, 
                0x0D, 
                0x12, 
                0x16, 
                0x1D, 
                0x24, 
                0x2C, 
                0x35, 
                0x3F, 
                0x4E, 
                0x62, 
                0x7E, 
                0x9E, 
                0xC8, 
                0xFF
            }, 

            Package (0x10)
            {
                0x04, 
                0x08, 
                0x0D, 
                0x12, 
                0x16, 
                0x1D, 
                0x24, 
                0x2C, 
                0x35, 
                0x3F, 
                0x4E, 
                0x62, 
                0x7E, 
                0x9E, 
                0xC8, 
                0xFF
            }, 

            Package (0x05)
            {
                0xC8, 
                0xC8, 
                Zero, 
                Zero, 
                Zero
            }
        })
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            OSYS = 0x07D0
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    OSYS = 0x03E8
                    LNUX = One
                }

                If (_OSI ("Windows 2001"))
                {
                    OSYS = 0x07D1
                    WNTF = One
                    WXPF = One
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    OSYS = 0x07D1
                    WSPV = One
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    OSYS = 0x07D2
                    WSPV = 0x02
                }

                If (_OSI ("Windows 2001.1"))
                {
                    OSYS = 0x07D3
                }

                If (_OSI ("Windows 2006"))
                {
                    OSYS = 0x07D6
                    WVIS = One
                }

                If (_OSI ("Windows 2009"))
                {
                    OSYS = 0x07D9
                }
            }

            ^LPCB.PS2M.MHID ()
        }

        Method (NHPG, 0, Serialized)
        {
            ^RP01.HPEX = Zero
            ^RP02.HPEX = Zero
            ^RP03.HPEX = Zero
            ^RP04.HPEX = Zero
            ^RP01.HPSX = One
            ^RP02.HPSX = One
            ^RP03.HPSX = One
            ^RP04.HPSX = One
        }

        Method (NPME, 0, Serialized)
        {
            ^RP01.PMEX = Zero
            ^RP02.PMEX = Zero
            ^RP03.PMEX = Zero
            ^RP04.PMEX = Zero
            ^RP05.PMEX = Zero
            ^RP06.PMEX = Zero
            ^RP07.PMEX = Zero
            ^RP08.PMEX = Zero
            ^RP01.PMSX = One
            ^RP02.PMSX = One
            ^RP03.PMSX = One
            ^RP04.PMSX = One
            ^RP05.PMSX = One
            ^RP06.PMSX = One
            ^RP07.PMSX = One
            ^RP08.PMSX = One
        }
    }

    Scope (\)
    {
        Name (PICM, Zero)
        Name (PRWP, Package (0x02)
        {
            Zero, 
            Zero
        })
        Method (GPRW, 2, NotSerialized)
        {
            PRWP [Zero] = Arg0
            Local0 = (SS1 << One)
            Local0 |= (SS2 << 0x02)
            Local0 |= (SS3 << 0x03)
            Local0 |= (SS4 << 0x04)
            If (((One << Arg1) & Local0))
            {
                PRWP [One] = Arg1
            }
            Else
            {
                Local0 >>= One
                FindSetLeftBit (Local0, PRWP [One])
            }

            Return (PRWP) /* \PRWP */
        }
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00000410, 0x06){}
        Processor (CPU1, 0x01, 0x00000410, 0x06){}
        Processor (CPU2, 0x02, 0x00000410, 0x06){}
        Processor (CPU3, 0x03, 0x00000410, 0x06){}
        Processor (CPU4, 0x04, 0x00000410, 0x06){}
        Processor (CPU5, 0x05, 0x00000410, 0x06){}
        Processor (CPU6, 0x06, 0x00000410, 0x06){}
        Processor (CPU7, 0x07, 0x00000410, 0x06){}
    }

    Scope (\)
    {
        Method (PNTF, 1, NotSerialized)
        {
            If ((PPMF & 0x01000000))
            {
                If ((((PDC0 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC0 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU0, Arg0)
                }

                If ((((PDC1 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC1 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU1, Arg0)
                }

                If ((((PDC2 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC2 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU2, Arg0)
                }

                If ((((PDC3 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC3 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU3, Arg0)
                }

                If ((((PDC4 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC4 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU4, Arg0)
                }

                If ((((PDC5 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC5 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU5, Arg0)
                }

                If ((((PDC6 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC6 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU6, Arg0)
                }

                If ((((PDC7 & 0x08) && ((Arg0 == 0x80) || (
                    Arg0 == 0x82))) || ((PDC7 & 0x10) && (Arg0 == 0x81))))
                {
                    Notify (\_PR.CPU7, Arg0)
                }
            }
            ElseIf (((Arg0 == 0x80) || ((Arg0 == 0x81) || (Arg0 == 
                0x82))))
            {
                Notify (\_PR.CPU0, Arg0)
            }
        }
    }

    OperationRegion (SMI2, SystemIO, 0xB2, One)
    Field (SMI2, ByteAcc, NoLock, Preserve)
    {
        APMC,   8
    }

    Mutex (MSMI, 0x07)
    Method (SMI, 5, NotSerialized)
    {
        Acquire (MSMI, 0xFFFF)
        CMD = Arg0
        PAR0 = Arg1
        PAR1 = Arg2
        PAR2 = Arg3
        PAR3 = Arg4
        APMC = 0xB5
        While ((ERR == One))
        {
            Sleep (0x64)
            APMC = 0xB5
        }

        Local0 = PAR0 /* \PAR0 */
        Release (MSMI)
        Return (Local0)
    }

    Method (RPCI, 1, NotSerialized)
    {
        Return (SMI (Zero, Zero, Arg0, Zero, Zero))
    }

    Method (WPCI, 2, NotSerialized)
    {
        SMI (Zero, One, Arg0, Arg1, Zero)
    }

    Method (MPCI, 3, NotSerialized)
    {
        SMI (Zero, 0x02, Arg0, Arg1, Arg2)
    }

    Method (RBEC, 1, NotSerialized)
    {
        Return (SMI (Zero, 0x03, Arg0, Zero, Zero))
    }

    Method (WBEC, 2, NotSerialized)
    {
        SMI (Zero, 0x04, Arg0, Arg1, Zero)
    }

    Method (MBEC, 3, NotSerialized)
    {
        SMI (Zero, 0x05, Arg0, Arg1, Arg2)
    }

    Method (RISA, 1, NotSerialized)
    {
        Return (SMI (Zero, 0x06, Arg0, Zero, Zero))
    }

    Method (WISA, 2, NotSerialized)
    {
        SMI (Zero, 0x07, Arg0, Arg1, Zero)
    }

    Method (MISA, 3, NotSerialized)
    {
        SMI (Zero, 0x08, Arg0, Arg1, Arg2)
    }

    Method (VDYN, 2, NotSerialized)
    {
        Return (SMI (One, 0x11, Arg0, Arg1, Zero))
    }

    Method (UCMS, 1, NotSerialized)
    {
        Return (SMI (0x02, Arg0, Zero, Zero, Zero))
    }

    Method (BCHK, 0, NotSerialized)
    {
        Return (SMI (0x05, 0x04, Zero, Zero, Zero))
    }

    Method (BLTH, 1, NotSerialized)
    {
        Return (SMI (0x06, Arg0, Zero, Zero, Zero))
    }

    Method (WGSV, 1, NotSerialized)
    {
        Return (SMI (0x09, Arg0, Zero, Zero, Zero))
    }

    Method (WMIS, 1, NotSerialized)
    {
        Return (SMI (0x0B, Arg0, Zero, Zero, Zero))
    }

    Method (TPHY, 1, NotSerialized)
    {
        SMI (0x0C, Arg0, Zero, Zero, Zero)
    }

    Method (TMOR, 1, NotSerialized)
    {
        SMI (0x0D, Arg0, Zero, Zero, Zero)
    }

    Method (THRO, 1, NotSerialized)
    {
        Return (SMI (0x0E, Arg0, Zero, Zero, Zero))
    }

    Method (UAWS, 1, NotSerialized)
    {
        Return (SMI (0x10, Arg0, Zero, Zero, Zero))
    }

    Method (OSSV, 1, NotSerialized)
    {
        Return (SMI (0x12, Arg0, Zero, Zero, Zero))
    }

    Method (BFWC, 1, NotSerialized)
    {
        Return (SMI (0x14, Zero, Arg0, Zero, Zero))
    }

    Method (BFWP, 0, NotSerialized)
    {
        Return (SMI (0x14, One, Zero, Zero, Zero))
    }

    Method (BFWG, 1, NotSerialized)
    {
        SMI (0x14, 0x03, Arg0, Zero, Zero)
    }

    Method (BDMC, 1, NotSerialized)
    {
        SMI (0x14, 0x04, Arg0, Zero, Zero)
    }

    Method (WMIQ, 4, NotSerialized)
    {
        Return (SMI (0x15, Arg0, Arg1, Arg2, Arg3))
    }

    Scope (_TZ)
    {
        Name (TPAS, 0x62)
        Name (TPC, 0x63)
        Name (TI3S, 0x53)
        Name (TI3C, 0x54)
        ThermalZone (TZ00)
        {
            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If ((I3CP == 0x33))
                {
                    Return ((0x0AAC + (TI3C * 0x0A)))
                }
                Else
                {
                    Return ((0x0AAC + (TPC * 0x0A)))
                }
            }

            Method (_SCP, 1, Serialized)  // _SCP: Set Cooling Policy
            {
                CTYP = Arg0
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If ((SKS3 != 0x03))
                {
                    If (ECON)
                    {
                        If (DTSE)
                        {
                            If ((DTS1 >= DTS2))
                            {
                                Local1 = DTS1 /* \DTS1 */
                            }
                            Else
                            {
                                Local1 = DTS2 /* \DTS2 */
                            }

                            If ((\_SB.PCI0.LPCB.EC.TMP2 != Zero))
                            {
                                If ((Local1 >= \_SB.PCI0.LPCB.EC.TMP2))
                                {
                                    Local7 = (Local1 - \_SB.PCI0.LPCB.EC.TMP2)
                                }
                                Else
                                {
                                    Local7 = Zero
                                }

                                \_SB.PCI0.LPCB.EC.TMP3 = Local7
                            }

                            If ((Local1 > \_SB.PCI0.LPCB.EC.TMP1))
                            {
                                Local0 = Local1
                            }
                            Else
                            {
                                Local0 = \_SB.PCI0.LPCB.EC.TMP1
                            }

                            If (((Local0 < 0x23) | (Local0 > 0x73)))
                            {
                                Local0 = 0x23
                            }
                        }
                        Else
                        {
                            If ((\_SB.PCI0.LPCB.EC.TMP0 > \_SB.PCI0.LPCB.EC.TMP1))
                            {
                                Local0 = \_SB.PCI0.LPCB.EC.TMP0
                            }
                            Else
                            {
                                Local0 = \_SB.PCI0.LPCB.EC.TMP1
                            }

                            If (((Local0 < 0x23) | (Local0 > 0x73)))
                            {
                                Local0 = 0x23
                            }
                        }

                        TMCP = Local0
                        Return ((0x0AAC + (Local0 * 0x0A)))
                    }
                    Else
                    {
                        Return (0x0BB8)
                    }
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

            Method (_PSL, 0, Serialized)  // _PSL: Passive List
            {
                If ((TCNT == 0x08))
                {
                    Return (Package (0x08)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3, 
                        \_PR.CPU4, 
                        \_PR.CPU5, 
                        \_PR.CPU6, 
                        \_PR.CPU7
                    })
                }

                If ((TCNT == 0x04))
                {
                    Return (Package (0x04)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3
                    })
                }

                If ((TCNT == 0x02))
                {
                    Return (Package (0x02)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1
                    })
                }

                Return (Package (0x01)
                {
                    \_PR.CPU0
                })
            }

            Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
            {
                If ((I3CP == 0x33))
                {
                    Return ((0x0AAC + (TI3S * 0x0A)))
                }
                Else
                {
                    Return ((0x0AAC + (TPAS * 0x0A)))
                }
            }

            Method (_TC1, 0, Serialized)  // _TC1: Thermal Constant 1
            {
                Return (0x02)
            }

            Method (_TC2, 0, Serialized)  // _TC2: Thermal Constant 2
            {
                Return (0x03)
            }

            Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
            {
                Return (0x64)
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (PDRC)
        {
            Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (BUF0, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00004000,         // Address Length
                    _Y10)
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00008000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    _Y11)
                Memory32Fixed (ReadWrite,
                    0xFED20000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0xFED90000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFED40000,         // Address Base
                    0x00005000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFED45000,         // Address Base
                    0x0004B000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0xFF000000,         // Address Base
                    0x01000000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0xFEE00000,         // Address Base
                    0x00100000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFEAFF000,         // Address Base
                    0x00001000,         // Address Length
                    )
            })
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y10._BAS, RBR0)  // _BAS: Base Address
                RBR0 = (^^LPCB.RCBA << 0x0E)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y11._BAS, XBR0)  // _BAS: Base Address
                XBR0 = (PXBR << 0x1A)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y11._LEN, XSZ0)  // _LEN: Length
                XSZ0 = (0x10000000 >> PXSZ) /* \_SB_.PCI0.PXSZ */
                Return (BUF0) /* \_SB_.PCI0.PDRC.BUF0 */
            }
        }
    }

    Scope (_GPE)
    {
        Method (_L0B, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.P0P1, 0x02) // Device Wake
        }

        Method (_L09, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            If ((RP1D == Zero))
            {
                \_SB.PCI0.RP01.HPME ()
                Notify (\_SB.PCI0.RP01, 0x02) // Device Wake
            }

            If ((RP2D == Zero))
            {
                \_SB.PCI0.RP02.HPME ()
                Notify (\_SB.PCI0.RP02, 0x02) // Device Wake
            }

            If ((RP3D == Zero))
            {
                \_SB.PCI0.RP03.HPME ()
                Notify (\_SB.PCI0.RP03, 0x02) // Device Wake
            }

            If ((RP4D == Zero))
            {
                \_SB.PCI0.RP04.HPME ()
                Notify (\_SB.PCI0.RP04, 0x02) // Device Wake
            }

            If ((RP5D == Zero))
            {
                \_SB.PCI0.RP05.HPME ()
                Notify (\_SB.PCI0.RP05, 0x02) // Device Wake
            }

            If ((RP6D == Zero))
            {
                \_SB.PCI0.RP06.HPME ()
                Notify (\_SB.PCI0.RP06, 0x02) // Device Wake
            }

            If ((RP7D == Zero))
            {
                \_SB.PCI0.RP07.HPME ()
                Notify (\_SB.PCI0.RP07, 0x02) // Device Wake
            }

            If ((RP8D == Zero))
            {
                \_SB.PCI0.RP08.HPME ()
                Notify (\_SB.PCI0.RP08, 0x02) // Device Wake
            }

            Notify (\_SB.PCI0.PEG0, 0x02) // Device Wake
            Notify (\_SB.PCI0.PEG0.PEGP, 0x02) // Device Wake
            Notify (\_SB.PCI0.PEG1, 0x02) // Device Wake
            Notify (\_SB.PCI0.PEG2, 0x02) // Device Wake
            Notify (\_SB.PCI0.PEG3, 0x02) // Device Wake
        }

        Method (_L0D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            Notify (\_SB.PCI0.EHC1, 0x02) // Device Wake
            Notify (\_SB.PCI0.EHC2, 0x02) // Device Wake
            Notify (\_SB.PCI0.HDEF, 0x02) // Device Wake
            Notify (\_SB.SLPB, 0x02) // Device Wake
        }

        Method (_L01, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            L01C += One
            P8XH (Zero, One)
            If (((RP1D == Zero) && \_SB.PCI0.RP01.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP01.PDCX)
                {
                    \_SB.PCI0.RP01.PDCX = One
                    \_SB.PCI0.RP01.HPSX = One
                    If (!\_SB.PCI0.RP01.PDSX)
                    {
                        \_SB.PCI0.RP01.L0SE = Zero
                    }

                    Notify (\_SB.PCI0.RP01, Zero) // Bus Check
                }
                Else
                {
                    \_SB.PCI0.RP01.HPSX = One
                }
            }

            If (((RP2D == Zero) && \_SB.PCI0.RP02.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP02.PDCX)
                {
                    \_SB.PCI0.RP02.PDCX = One
                    \_SB.PCI0.RP02.HPSX = One
                    If (!\_SB.PCI0.RP02.PDSX)
                    {
                        \_SB.PCI0.RP02.L0SE = Zero
                    }

                    Notify (\_SB.PCI0.RP02, Zero) // Bus Check
                }
                Else
                {
                    \_SB.PCI0.RP02.HPSX = One
                }
            }

            If (((RP3D == Zero) && \_SB.PCI0.RP03.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP03.PDCX)
                {
                    \_SB.PCI0.RP03.PDCX = One
                    \_SB.PCI0.RP03.HPSX = One
                    If (!\_SB.PCI0.RP03.PDSX)
                    {
                        \_SB.PCI0.RP03.L0SE = Zero
                    }

                    Notify (\_SB.PCI0.RP03, Zero) // Bus Check
                }
                Else
                {
                    \_SB.PCI0.RP03.HPSX = One
                }
            }

            If (((RP4D == Zero) && \_SB.PCI0.RP04.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP04.PDCX)
                {
                    \_SB.PCI0.RP04.PDCX = One
                    \_SB.PCI0.RP04.HPSX = One
                    If (!\_SB.PCI0.RP04.PDSX)
                    {
                        \_SB.PCI0.RP04.L0SE = Zero
                    }

                    \_SB.PCI0.RP04.RETR = One
                    Notify (\_SB.PCI0.RP04, Zero) // Bus Check
                }
                Else
                {
                    \_SB.PCI0.RP04.HPSX = One
                }
            }

            If (((RP5D == Zero) && \_SB.PCI0.RP05.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP05.PDCX)
                {
                    \_SB.PCI0.RP05.PDCX = One
                    \_SB.PCI0.RP05.HPSX = One
                    If (!\_SB.PCI0.RP05.PDSX)
                    {
                        \_SB.PCI0.RP05.L0SE = Zero
                    }

                    Notify (\_SB.PCI0.RP05, Zero) // Bus Check
                }
                Else
                {
                    \_SB.PCI0.RP05.HPSX = One
                }
            }

            If (((RP6D == Zero) && \_SB.PCI0.RP06.HPSX))
            {
                Sleep (0x64)
                If (\_SB.PCI0.RP06.PDCX)
                {
                    \_SB.PCI0.RP06.PDCX = One
                    \_SB.PCI0.RP06.HPSX = One
                    If (!\_SB.PCI0.RP06.PDSX)
                    {
                        \_SB.PCI0.RP06.L0SE = Zero
                    }

                    Notify (\_SB.PCI0.RP06, Zero) // Bus Check
                }
                Else
                {
                    \_SB.PCI0.RP06.HPSX = One
                }
            }
        }

        Method (_L02, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            GPEC = Zero
            Notify (\_TZ.TZ00, 0x80) // Thermal Status Change
            If (CondRefOf (TNOT))
            {
                TNOT ()
            }
        }

        Method (_L06, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            If ((\_SB.PCI0.GFX0.GSSE && !GSMI))
            {
                \_SB.PCI0.GFX0.GSCI ()
            }
        }

        Method (_L07, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            \_SB.PCI0.SBUS.HSTS = 0x20
        }
    }

    Scope (\)
    {
        OperationRegion (IO_T, SystemIO, 0x0800, 0x10)
        Field (IO_T, ByteAcc, NoLock, Preserve)
        {
            TRPI,   16, 
            Offset (0x04), 
            Offset (0x06), 
            Offset (0x08), 
            TRP0,   8, 
            Offset (0x0A), 
            Offset (0x0B), 
            Offset (0x0C), 
            Offset (0x0D), 
            Offset (0x0E), 
            Offset (0x0F), 
            Offset (0x10)
        }

        OperationRegion (IO_D, SystemIO, 0x0810, 0x04)
        Field (IO_D, ByteAcc, NoLock, Preserve)
        {
            TRPD,   8
        }

        OperationRegion (IO_H, SystemIO, 0x1000, 0x04)
        Field (IO_H, ByteAcc, NoLock, Preserve)
        {
            TRPH,   8
        }

        OperationRegion (PMIO, SystemIO, PMBS, 0x80)
        Field (PMIO, ByteAcc, NoLock, Preserve)
        {
            Offset (0x20), 
                ,   2, 
            SPST,   1, 
                ,   16, 
            GPS3,   1, 
            Offset (0x28), 
                ,   19, 
            GPE3,   1, 
            Offset (0x3C), 
                ,   1, 
            UPRW,   1, 
            Offset (0x42), 
                ,   1, 
            GPEC,   1, 
            Offset (0x64), 
                ,   9, 
            SCIS,   1, 
            Offset (0x66)
        }

        OperationRegion (GPIO, SystemIO, GPBS, 0x64)
        Field (GPIO, ByteAcc, NoLock, Preserve)
        {
            GU00,   8, 
            GU01,   8, 
            GU02,   8, 
            GU03,   8, 
            GIO0,   8, 
            GIO1,   8, 
            GIO2,   8, 
            GIO3,   8, 
            Offset (0x0C), 
                ,   1, 
                ,   1, 
            GI02,   1, 
            GI03,   1, 
            GI04,   1, 
                ,   1, 
                ,   1, 
            Offset (0x0D), 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
            Offset (0x0E), 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
            MDID,   1, 
            BKLT,   1, 
                ,   3, 
            GP27,   1, 
            GP28,   1, 
            Offset (0x10), 
            Offset (0x18), 
            Offset (0x2C), 
            GIV0,   8, 
            GIV1,   8, 
            GIV2,   8, 
            GIV3,   8, 
            GU04,   8, 
            GU05,   8, 
            GU06,   8, 
                ,   1, 
                ,   1, 
            GU07,   1, 
            Offset (0x34), 
            GIO4,   8, 
            GIO5,   8, 
            GIO6,   8, 
            GIO7,   8, 
                ,   1, 
                ,   1, 
            GO34,   1, 
            GO35,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
            Offset (0x39), 
            Offset (0x3A), 
            GO48,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
            Offset (0x3B), 
            Offset (0x40), 
            GU08,   8, 
            GU09,   8, 
            GU0A,   8, 
            GU0B,   8, 
            GIO8,   8, 
            GIO9,   8, 
            GIOA,   8, 
            GIOB,   8, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
            GO70,   1, 
            GO71,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
                ,   1, 
            Offset (0x4A), 
            GL0A,   8, 
            GL0B,   8
        }

        OperationRegion (RCRB, SystemMemory, SRCB, 0x4000)
        Field (RCRB, DWordAcc, Lock, Preserve)
        {
            Offset (0x1000), 
            Offset (0x3000), 
            Offset (0x3404), 
            HPAS,   2, 
                ,   5, 
            HPAE,   1, 
            Offset (0x3418), 
                ,   1, 
                ,   1, 
            SATD,   1, 
            SMBD,   1, 
            HDAD,   1, 
            Offset (0x341A), 
            RP1D,   1, 
            RP2D,   1, 
            RP3D,   1, 
            RP4D,   1, 
            RP5D,   1, 
            RP6D,   1, 
            RP7D,   1, 
            RP8D,   1, 
            TTDR,   1, 
            Offset (0x359C), 
            UP0D,   1, 
            UP1D,   1, 
            UP2D,   1, 
            UP3D,   1, 
            UP4D,   1, 
            UP5D,   1, 
            UP6D,   1, 
            UP7D,   1, 
            UP8D,   1, 
            UP9D,   1, 
            UPAD,   1, 
            UPBD,   1, 
            UPCD,   1, 
            UPDD,   1, 
                ,   1, 
            Offset (0x359E)
        }

        Method (GETP, 1, Serialized)
        {
            If (((Arg0 & 0x09) == Zero))
            {
                Return (0xFFFFFFFF)
            }

            If (((Arg0 & 0x09) == 0x08))
            {
                Return (0x0384)
            }

            Local0 = ((Arg0 & 0x0300) >> 0x08)
            Local1 = ((Arg0 & 0x3000) >> 0x0C)
            Return ((0x1E * (0x09 - (Local0 + Local1))))
        }

        Method (GDMA, 5, Serialized)
        {
            If (Arg0)
            {
                If ((Arg1 && Arg4))
                {
                    Return (0x14)
                }

                If ((Arg2 && Arg4))
                {
                    Return (((0x04 - Arg3) * 0x0F))
                }

                Return (((0x04 - Arg3) * 0x1E))
            }

            Return (0xFFFFFFFF)
        }

        Method (GETT, 1, Serialized)
        {
            Return ((0x1E * (0x09 - (((Arg0 >> 0x02) & 0x03
                ) + (Arg0 & 0x03)))))
        }

        Method (GETF, 3, Serialized)
        {
            Name (TMPF, Zero)
            If (Arg0)
            {
                TMPF |= One
            }

            If ((Arg2 & 0x02))
            {
                TMPF |= 0x02
            }

            If (Arg1)
            {
                TMPF |= 0x04
            }

            If ((Arg2 & 0x20))
            {
                TMPF |= 0x08
            }

            If ((Arg2 & 0x4000))
            {
                TMPF |= 0x10
            }

            Return (TMPF) /* \GETF.TMPF */
        }

        Method (SETP, 3, Serialized)
        {
            If ((Arg0 > 0xF0))
            {
                Return (0x08)
            }
            Else
            {
                If ((Arg1 & 0x02))
                {
                    If (((Arg0 <= 0x78) && (Arg2 & 0x02)))
                    {
                        Return (0x2301)
                    }

                    If (((Arg0 <= 0xB4) && (Arg2 & One)))
                    {
                        Return (0x2101)
                    }
                }

                Return (0x1001)
            }
        }

        Method (SDMA, 1, Serialized)
        {
            If ((Arg0 <= 0x14))
            {
                Return (One)
            }

            If ((Arg0 <= 0x1E))
            {
                Return (0x02)
            }

            If ((Arg0 <= 0x2D))
            {
                Return (One)
            }

            If ((Arg0 <= 0x3C))
            {
                Return (0x02)
            }

            If ((Arg0 <= 0x5A))
            {
                Return (One)
            }

            Return (Zero)
        }

        Method (SETT, 3, Serialized)
        {
            If ((Arg1 & 0x02))
            {
                If (((Arg0 <= 0x78) && (Arg2 & 0x02)))
                {
                    Return (0x0B)
                }

                If (((Arg0 <= 0xB4) && (Arg2 & One)))
                {
                    Return (0x09)
                }
            }

            Return (0x04)
        }

        Method (DPIO, 2, NotSerialized)
        {
            If (!Arg0)
            {
                Return (Zero)
            }

            If ((Arg0 > 0xF0))
            {
                Return (Zero)
            }

            If ((Arg0 > 0xB4))
            {
                If (Arg1)
                {
                    Return (0x02)
                }
                Else
                {
                    Return (One)
                }
            }

            If ((Arg0 > 0x78))
            {
                Return (0x03)
            }

            Return (0x04)
        }

        Method (DUDM, 2, NotSerialized)
        {
            If (!Arg1)
            {
                Return (0xFF)
            }

            If ((Arg0 > 0x5A))
            {
                Return (Zero)
            }

            If ((Arg0 > 0x3C))
            {
                Return (One)
            }

            If ((Arg0 > 0x2D))
            {
                Return (0x02)
            }

            If ((Arg0 > 0x1E))
            {
                Return (0x03)
            }

            If ((Arg0 > 0x14))
            {
                Return (0x04)
            }

            Return (0x05)
        }

        Method (FDMA, 2, NotSerialized)
        {
            If ((Arg1 != 0xFF))
            {
                Return ((Arg1 | 0x40))
            }

            If ((Arg0 >= 0x03))
            {
                Return (((Arg0 - 0x02) | 0x20))
            }

            If (Arg0)
            {
                Return (0x12)
            }

            Return (Zero)
        }

        Method (FPIO, 1, NotSerialized)
        {
            If ((Arg0 >= 0x03))
            {
                Return ((Arg0 | 0x08))
            }

            If ((Arg0 == One))
            {
                Return (One)
            }

            Return (Zero)
        }
    }

    Scope (_SB.PCI0)
    {
        Device (EHC1)
        {
            Name (_ADR, 0x001D0000)  // _ADR: Address
            OperationRegion (U1CS, PCI_Config, 0x62, 0x04)
            Field (U1CS, DWordAcc, NoLock, Preserve)
            {
                    ,   1, 
                E1EN,   8
            }

            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
                If (Arg0)
                {
                    E1EN = Ones
                }
                Else
                {
                    E1EN = Zero
                }

                ESG0 = Arg0
            }

            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x0D, 
                0x03
            })
            Device (HUB0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (PRT1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                    {
                        Zero, 
                        0xFF, 
                        Zero, 
                        Zero
                    })
                    Device (PRO3)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            0xFF, 
                            0x02, 
                            Zero, 
                            Zero
                        })
                        Name (_PLD, ToPLD (
                            PLD_Revision           = 0x1,
                            PLD_IgnoreColor        = 0x1,
                            PLD_Red                = 0x0,
                            PLD_Green              = 0x0,
                            PLD_Blue               = 0x0,
                            PLD_Width              = 0x0,
                            PLD_Height             = 0x0,
                            PLD_UserVisible        = 0x1,
                            PLD_Dock               = 0x0,
                            PLD_Lid                = 0x0,
                            PLD_Panel              = "LEFT",
                            PLD_VerticalPosition   = "UPPER",
                            PLD_HorizontalPosition = "LEFT",
                            PLD_Shape              = "HORIZONTALRECTANGLE",
                            PLD_GroupOrientation   = 0x0,
                            PLD_GroupToken         = 0x0,
                            PLD_GroupPosition      = 0x0,
                            PLD_Bay                = 0x0,
                            PLD_Ejectable          = 0x1,
                            PLD_EjectRequired      = 0x1,
                            PLD_CabinetNumber      = 0x0,
                            PLD_CardCageNumber     = 0x0,
                            PLD_Reference          = 0x0,
                            PLD_Rotation           = 0x0,
                            PLD_Order              = 0x0)
)  // _PLD: Physical Location of Device
                    }

                    Device (PRO4)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            Zero, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                    }

                    Device (PRO5)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            Zero, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                    }

                    Device (PRO6)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            Zero, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                    }
                }
            }
        }

        Device (EHC2)
        {
            Name (_ADR, 0x001A0000)  // _ADR: Address
            OperationRegion (U1CS, PCI_Config, 0x62, 0x04)
            Field (U1CS, DWordAcc, NoLock, Preserve)
            {
                    ,   1, 
                E2EN,   6
            }

            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
                If (Arg0)
                {
                    E2EN = Ones
                }
                Else
                {
                    E2EN = Zero
                }

                ESG1 = Arg0
            }

            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x0D, 
                0x03
            })
            Device (HUB0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Device (PRT1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                    {
                        Zero, 
                        0xFF, 
                        Zero, 
                        Zero
                    })
                    Device (POR3)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            Zero, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                    }

                    Device (POR5)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            Zero, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                    }

                    Device (POR6)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                        Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                        {
                            Zero, 
                            0xFF, 
                            Zero, 
                            Zero
                        })
                    }
                }
            }
        }

        Device (HDEF)
        {
            Name (_ADR, 0x001B0000)  // _ADR: Address
            OperationRegion (HDAR, PCI_Config, 0x4C, 0x10)
            Field (HDAR, WordAcc, NoLock, Preserve)
            {
                DCKA,   1, 
                Offset (0x01), 
                DCKM,   1, 
                    ,   6, 
                DCKS,   1, 
                Offset (0x08), 
                    ,   15, 
                PMES,   1
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x0D, 
                0x04
            })
        }

        Device (RP01)
        {
            Name (_ADR, 0x001C0000)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR04 ())
                }

                Return (PR04 ())
            }
        }

        Device (RP02)
        {
            Name (_ADR, 0x001C0001)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR05 ())
                }

                Return (PR05 ())
            }
        }

        Device (RP03)
        {
            Name (_ADR, 0x001C0002)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR06 ())
                }

                Return (PR06 ())
            }
        }

        Device (RP04)
        {
            Name (_ADR, 0x001C0003)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (PXSX._RMV, One)  // _RMV: Removal Status
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR07 ())
                }

                Return (PR07 ())
            }
        }

        Device (RP05)
        {
            Name (_ADR, 0x001C0004)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR08 ())
                }

                Return (PR08 ())
            }
        }

        Device (RP06)
        {
            Name (_ADR, 0x001C0005)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR09 ())
                }

                Return (PR09 ())
            }
        }

        Device (RP07)
        {
            Name (_ADR, 0x001C0006)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0E) /* \_SB_.AR0E */
                }

                Return (PR0E) /* \_SB_.PR0E */
            }
        }

        Device (RP08)
        {
            Name (_ADR, 0x001C0007)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0F) /* \_SB_.AR0F */
                }

                Return (PR0F) /* \_SB_.PR0F */
            }
        }

        Device (SAT0)
        {
            Name (_ADR, 0x001F0002)  // _ADR: Address
            OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
            Field (SACS, DWordAcc, NoLock, Preserve)
            {
                PRIT,   16, 
                SECT,   16, 
                PSIT,   4, 
                SSIT,   4, 
                Offset (0x08), 
                SYNC,   4, 
                Offset (0x0A), 
                SDT0,   2, 
                    ,   2, 
                SDT1,   2, 
                Offset (0x0B), 
                SDT2,   2, 
                    ,   2, 
                SDT3,   2, 
                Offset (0x14), 
                ICR0,   4, 
                ICR1,   4, 
                ICR2,   4, 
                ICR3,   4, 
                ICR4,   4, 
                ICR5,   4, 
                Offset (0x50), 
                MAPV,   2
            }

            Device (PRT0)
            {
                Name (_ADR, 0xFFFF)  // _ADR: Address
                Name (DIP0, Zero)
                Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
                {
                    If ((SizeOf (Arg0) == 0x0200))
                    {
                        CreateWordField (Arg0, 0x9C, M078)
                        If ((M078 & 0x08))
                        {
                            DIP0 = One
                        }
                    }
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If (DIP0)
                    {
                        Return (HPTF) /* \_SB_.PCI0.SAT0.HPTF */
                    }

                    Return (HDTF) /* \_SB_.PCI0.SAT0.HDTF */
                }
            }

            Device (PRT1)
            {
                Name (DIP1, Zero)
                Name (_ADR, 0x0001FFFF)  // _ADR: Address
                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                {
                    If (Arg0)
                    {
                        ^^^LPCB.EC.ODDP = Zero
                        Sleep (0x1E)
                        ODDS = One
                    }
                    Else
                    {
                        ^^^LPCB.EC.ODDP = One
                        Sleep (0x1E)
                        ODDS = Zero
                    }
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((^^^LPCB.EC.ODDP == One))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Name (_PLD, ToPLD (
                    PLD_Revision           = 0x1,
                    PLD_IgnoreColor        = 0x1,
                    PLD_Red                = 0x0,
                    PLD_Green              = 0x0,
                    PLD_Blue               = 0x0,
                    PLD_Width              = 0x0,
                    PLD_Height             = 0x0,
                    PLD_UserVisible        = 0x1,
                    PLD_Dock               = 0x0,
                    PLD_Lid                = 0x0,
                    PLD_Panel              = "RIGHT",
                    PLD_VerticalPosition   = "CENTER",
                    PLD_HorizontalPosition = "CENTER",
                    PLD_Shape              = "HORIZONTALRECTANGLE",
                    PLD_GroupOrientation   = 0x0,
                    PLD_GroupToken         = 0x0,
                    PLD_GroupPosition      = 0x0,
                    PLD_Bay                = 0x1,
                    PLD_Ejectable          = 0x1,
                    PLD_EjectRequired      = 0x1,
                    PLD_CabinetNumber      = 0x0,
                    PLD_CardCageNumber     = 0x0,
                    PLD_Reference          = 0x0,
                    PLD_Rotation           = 0x0,
                    PLD_Order              = 0x0)
)  // _PLD: Physical Location of Device
                Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
                {
                    If ((SizeOf (Arg0) == 0x0200))
                    {
                        CreateWordField (Arg0, 0x9C, M078)
                        If ((M078 & 0x08))
                        {
                            DIP1 = One
                        }
                    }
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If (DIP1)
                    {
                        GTFT = CDFL /* \CDFL */
                        GTAT = CDAH /* \CDAH */
                        Return (DGTF) /* \_SB_.PCI0.SAT0.DGTF */
                    }

                    DTFT = CDFL /* \CDFL */
                    DTAT = CDAH /* \CDAH */
                    Return (DDTF) /* \_SB_.PCI0.SAT0.DDTF */
                }
            }

            Device (PRT2)
            {
                Name (_ADR, 0x0002FFFF)  // _ADR: Address
                Name (DIP2, Zero)
                Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
                {
                    If ((SizeOf (Arg0) == 0x0200))
                    {
                        CreateWordField (Arg0, 0x9C, M078)
                        If ((M078 & 0x08))
                        {
                            DIP2 = One
                        }
                    }
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    If (DIP2)
                    {
                        Return (HPTF) /* \_SB_.PCI0.SAT0.HPTF */
                    }

                    Return (HDTF) /* \_SB_.PCI0.SAT0.HDTF */
                }
            }

            Device (PRT4)
            {
                Name (_ADR, 0x0004FFFF)  // _ADR: Address
                Name (DIP4, Zero)
                Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
                {
                    If ((SizeOf (Arg0) == 0x0200))
                    {
                        CreateWordField (Arg0, 0x9C, M078)
                        If ((M078 & 0x08))
                        {
                            DIP4 = One
                        }
                    }
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    Return (HDTF) /* \_SB_.PCI0.SAT0.HDTF */
                }
            }

            Device (PRT5)
            {
                Name (_ADR, 0x0005FFFF)  // _ADR: Address
                Name (DIP5, Zero)
                Method (_SDD, 1, NotSerialized)  // _SDD: Set Device Data
                {
                    If ((SizeOf (Arg0) == 0x0200))
                    {
                        CreateWordField (Arg0, 0x9C, M078)
                        If ((M078 & 0x08))
                        {
                            DIP5 = One
                        }
                    }
                }

                Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                {
                    Return (HDTF) /* \_SB_.PCI0.SAT0.HDTF */
                }
            }

            Name (HDTF, Buffer (0x0E)
            {
                /* 0000 */  0x02, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xA0, 0xF5               // ......
            })
            Name (HPTF, Buffer (0x15)
            {
                /* 0000 */  0x02, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xA0, 0xF5, 0x10, 0x03,  // ........
                /* 0010 */  0x00, 0x00, 0x00, 0xA0, 0xEF                     // .....
            })
            Name (DDTF, Buffer (0x0E)
            {
                /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xE3, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xA0, 0xE3               // ......
            })
            CreateByteField (DDTF, One, DTAT)
            CreateByteField (DDTF, 0x08, DTFT)
            Name (DGTF, Buffer (0x15)
            {
                /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xE3, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xA0, 0xE3, 0x10, 0x03,  // ........
                /* 0010 */  0x00, 0x00, 0x00, 0xA0, 0xEF                     // .....
            })
            CreateByteField (DGTF, One, GTAT)
            CreateByteField (DGTF, 0x08, GTFT)
            Device (PRID)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (BPI0, Zero)
                Name (BDM0, Zero)
                Name (BPI1, Zero)
                Name (BDM1, Zero)
                Name (DIP0, Zero)
                Name (DIP1, Zero)
                Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
                {
                    Name (PBUF, Buffer (0x14)
                    {
                        /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                        /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                        /* 0010 */  0x00, 0x00, 0x00, 0x00                           // ....
                    })
                    Name (GTME, Zero)
                    CreateDWordField (PBUF, Zero, GTP0)
                    CreateDWordField (PBUF, 0x04, GTD0)
                    CreateDWordField (PBUF, 0x08, GTP1)
                    CreateDWordField (PBUF, 0x0C, GTD1)
                    CreateDWordField (PBUF, 0x10, GTMF)
                    If (!GTME)
                    {
                        GTMF |= One
                        GTP0 = 0x78
                        GTD0 = 0x14
                        GTP1 = Zero
                        GTD1 = Zero
                        GTMF |= 0x10
                    }

                    GTME = One
                    Return (PBUF) /* \_SB_.PCI0.SAT0.PRID._GTM.PBUF */
                }

                Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
                {
                    CreateDWordField (Arg0, Zero, STP0)
                    CreateDWordField (Arg0, 0x04, STD0)
                    CreateDWordField (Arg0, 0x08, STP1)
                    CreateDWordField (Arg0, 0x0C, STD1)
                    CreateDWordField (Arg0, 0x10, STMF)
                    If ((SizeOf (Arg1) == 0x0200))
                    {
                        Local0 = DPIO (STP0, (STMF & 0x02))
                        Local1 = DUDM (STD0, (STMF & One))
                        CreateWordField (Arg1, 0x9C, M078)
                        If ((M078 & 0x08))
                        {
                            DIP0 = One
                        }

                        BDM0 = FDMA (Local0, Local1)
                        BPI0 = FPIO (Local0)
                    }

                    If ((SizeOf (Arg2) == 0x0200))
                    {
                        Local0 = DPIO (STP1, (STMF & 0x08))
                        Local1 = DUDM (STD1, (STMF & 0x04))
                        CreateWordField (Arg2, 0x9C, S078)
                        If ((S078 & 0x08))
                        {
                            DIP1 = One
                        }

                        BDM1 = FDMA (Local0, Local1)
                        BPI1 = FPIO (Local0)
                    }
                }

                Device (P_D0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Name (HDTF, Buffer (0x1C)
                        {
                            /* 0000 */  0x02, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x00,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xA0, 0xF5, 0x03, 0x00,  // ........
                            /* 0010 */  0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 0x00, 0x00,  // ........
                            /* 0018 */  0x00, 0x00, 0xA0, 0xEF                           // ....
                        })
                        CreateByteField (HDTF, 0x0F, HDMA)
                        CreateByteField (HDTF, 0x16, HPIO)
                        Name (HPTF, Buffer (0x23)
                        {
                            /* 0000 */  0x02, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF, 0x00,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xA0, 0xF5, 0x03, 0x00,  // ........
                            /* 0010 */  0x00, 0x00, 0x00, 0xA0, 0xEF, 0x03, 0x00, 0x00,  // ........
                            /* 0018 */  0x00, 0x00, 0xA0, 0xEF, 0x10, 0x03, 0x00, 0x00,  // ........
                            /* 0020 */  0x00, 0xA0, 0xEF                                 // ...
                        })
                        CreateByteField (HPTF, 0x0F, PDMA)
                        CreateByteField (HPTF, 0x16, PPIO)
                        If (DIP0)
                        {
                            PDMA = BDM0 /* \_SB_.PCI0.SAT0.PRID.BDM0 */
                            PPIO = BPI0 /* \_SB_.PCI0.SAT0.PRID.BPI0 */
                            Return (HPTF) /* \_SB_.PCI0.SAT0.PRID.P_D0._GTF.HPTF */
                        }

                        HDMA = BDM0 /* \_SB_.PCI0.SAT0.PRID.BDM0 */
                        HPIO = BPI0 /* \_SB_.PCI0.SAT0.PRID.BPI0 */
                        Return (HDTF) /* \_SB_.PCI0.SAT0.PRID.P_D0._GTF.HDTF */
                    }
                }

                Device (P_D1)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
                    {
                        Name (HDTF, Buffer (0x1C)
                        {
                            /* 0000 */  0x02, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x00,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xB0, 0xF5, 0x03, 0x00,  // ........
                            /* 0010 */  0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03, 0x00, 0x00,  // ........
                            /* 0018 */  0x00, 0x00, 0xB0, 0xEF                           // ....
                        })
                        CreateByteField (HDTF, 0x0F, HDMA)
                        CreateByteField (HDTF, 0x16, HPIO)
                        Name (HPTF, Buffer (0x23)
                        {
                            /* 0000 */  0x02, 0x00, 0x00, 0x00, 0x00, 0xB0, 0xEF, 0x00,  // ........
                            /* 0008 */  0x00, 0x00, 0x00, 0x00, 0xB0, 0xF5, 0x03, 0x00,  // ........
                            /* 0010 */  0x00, 0x00, 0x00, 0xB0, 0xEF, 0x03, 0x00, 0x00,  // ........
                            /* 0018 */  0x00, 0x00, 0xB0, 0xEF, 0x10, 0x03, 0x00, 0x00,  // ........
                            /* 0020 */  0x00, 0xB0, 0xEF                                 // ...
                        })
                        CreateByteField (HPTF, 0x0F, PDMA)
                        CreateByteField (HPTF, 0x16, PPIO)
                        If (DIP1)
                        {
                            PDMA = BDM1 /* \_SB_.PCI0.SAT0.PRID.BDM1 */
                            PPIO = BPI1 /* \_SB_.PCI0.SAT0.PRID.BPI1 */
                            Return (HPTF) /* \_SB_.PCI0.SAT0.PRID.P_D1._GTF.HPTF */
                        }

                        HDMA = BDM1 /* \_SB_.PCI0.SAT0.PRID.BDM1 */
                        HPIO = BPI1 /* \_SB_.PCI0.SAT0.PRID.BPI1 */
                        Return (HDTF) /* \_SB_.PCI0.SAT0.PRID.P_D1._GTF.HDTF */
                    }
                }
            }
        }

        Device (SAT1)
        {
            Name (_ADR, 0x001F0005)  // _ADR: Address
            OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
            Field (SACS, DWordAcc, NoLock, Preserve)
            {
                PRIT,   16, 
                SECT,   16, 
                PSIT,   4, 
                SSIT,   4, 
                Offset (0x08), 
                SYNC,   4, 
                Offset (0x0A), 
                SDT0,   2, 
                    ,   2, 
                SDT1,   2, 
                Offset (0x0B), 
                SDT2,   2, 
                    ,   2, 
                SDT3,   2, 
                Offset (0x14), 
                ICR0,   4, 
                ICR1,   4, 
                ICR2,   4, 
                ICR3,   4, 
                ICR4,   4, 
                ICR5,   4, 
                Offset (0x50), 
                MAPV,   2
            }
        }

        Device (SBUS)
        {
            Name (_ADR, 0x001F0003)  // _ADR: Address
            OperationRegion (SMBP, PCI_Config, 0x40, 0xC0)
            Field (SMBP, DWordAcc, NoLock, Preserve)
            {
                    ,   2, 
                I2CE,   1
            }

            OperationRegion (SMPB, PCI_Config, 0x20, 0x04)
            Field (SMPB, DWordAcc, NoLock, Preserve)
            {
                    ,   5, 
                SBAR,   11
            }

            OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
            Field (SMBI, ByteAcc, NoLock, Preserve)
            {
                HSTS,   8, 
                Offset (0x02), 
                HCON,   8, 
                HCOM,   8, 
                TXSA,   8, 
                DAT0,   8, 
                DAT1,   8, 
                HBDR,   8, 
                PECR,   8, 
                RXSA,   8, 
                SDAT,   16
            }

            Method (SSXB, 2, Serialized)
            {
                If (STRT ())
                {
                    Return (Zero)
                }

                I2CE = Zero
                HSTS = 0xBF
                TXSA = Arg0
                HCOM = Arg1
                HCON = 0x48
                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (One)
                }

                Return (Zero)
            }

            Method (SRXB, 1, Serialized)
            {
                If (STRT ())
                {
                    Return (0xFFFF)
                }

                I2CE = Zero
                HSTS = 0xBF
                TXSA = (Arg0 | One)
                HCON = 0x44
                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                }

                Return (0xFFFF)
            }

            Method (SWRB, 3, Serialized)
            {
                If (STRT ())
                {
                    Return (Zero)
                }

                I2CE = Zero
                HSTS = 0xBF
                TXSA = Arg0
                HCOM = Arg1
                DAT0 = Arg2
                HCON = 0x48
                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (One)
                }

                Return (Zero)
            }

            Method (SRDB, 2, Serialized)
            {
                If (STRT ())
                {
                    Return (0xFFFF)
                }

                I2CE = Zero
                HSTS = 0xBF
                TXSA = (Arg0 | One)
                HCOM = Arg1
                HCON = 0x48
                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                }

                Return (0xFFFF)
            }

            Method (SWRW, 3, Serialized)
            {
                If (STRT ())
                {
                    Return (Zero)
                }

                I2CE = Zero
                HSTS = 0xBF
                TXSA = Arg0
                HCOM = Arg1
                DAT1 = (Arg2 & 0xFF)
                DAT0 = ((Arg2 >> 0x08) & 0xFF)
                HCON = 0x4C
                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (One)
                }

                Return (Zero)
            }

            Method (SRDW, 2, Serialized)
            {
                If (STRT ())
                {
                    Return (0xFFFF)
                }

                I2CE = Zero
                HSTS = 0xBF
                TXSA = (Arg0 | One)
                HCOM = Arg1
                HCON = 0x4C
                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (((DAT0 << 0x08) | DAT1))
                }

                Return (0xFFFFFFFF)
            }

            Method (SBLW, 4, Serialized)
            {
                If (STRT ())
                {
                    Return (Zero)
                }

                I2CE = Arg3
                HSTS = 0xBF
                TXSA = Arg0
                HCOM = Arg1
                DAT0 = SizeOf (Arg2)
                Local1 = Zero
                HBDR = DerefOf (Arg2 [Zero])
                HCON = 0x54
                While ((SizeOf (Arg2) > Local1))
                {
                    Local0 = 0x0FA0
                    While ((!(HSTS & 0x80) && Local0))
                    {
                        Local0--
                        Stall (0x32)
                    }

                    If (!Local0)
                    {
                        KILL ()
                        Return (Zero)
                    }

                    HSTS = 0x80
                    Local1++
                    If ((SizeOf (Arg2) > Local1))
                    {
                        HBDR = DerefOf (Arg2 [Local1])
                    }
                }

                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (One)
                }

                Return (Zero)
            }

            Method (SBLR, 3, Serialized)
            {
                Name (TBUF, Buffer (0x0100){})
                If (STRT ())
                {
                    Return (Zero)
                }

                I2CE = Arg2
                HSTS = 0xBF
                TXSA = (Arg0 | One)
                HCOM = Arg1
                HCON = 0x54
                Local0 = 0x0FA0
                While ((!(HSTS & 0x80) && Local0))
                {
                    Local0--
                    Stall (0x32)
                }

                If (!Local0)
                {
                    KILL ()
                    Return (Zero)
                }

                TBUF [Zero] = DAT0 /* \_SB_.PCI0.SBUS.DAT0 */
                HSTS = 0x80
                Local1 = One
                While ((Local1 < DerefOf (TBUF [Zero])))
                {
                    Local0 = 0x0FA0
                    While ((!(HSTS & 0x80) && Local0))
                    {
                        Local0--
                        Stall (0x32)
                    }

                    If (!Local0)
                    {
                        KILL ()
                        Return (Zero)
                    }

                    TBUF [Local1] = HBDR /* \_SB_.PCI0.SBUS.HBDR */
                    HSTS = 0x80
                    Local1++
                }

                If (COMP ())
                {
                    HSTS |= 0xFF
                    Return (TBUF) /* \_SB_.PCI0.SBUS.SBLR.TBUF */
                }

                Return (Zero)
            }

            Method (STRT, 0, Serialized)
            {
                Local0 = 0xC8
                While (Local0)
                {
                    If ((HSTS & 0x40))
                    {
                        Local0--
                        Sleep (One)
                        If ((Local0 == Zero))
                        {
                            Return (One)
                        }
                    }
                    Else
                    {
                        Local0 = Zero
                    }
                }

                Local0 = 0x0FA0
                While (Local0)
                {
                    If ((HSTS & One))
                    {
                        Local0--
                        Stall (0x32)
                        If ((Local0 == Zero))
                        {
                            KILL ()
                        }
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Return (One)
            }

            Method (COMP, 0, Serialized)
            {
                Local0 = 0x0FA0
                While (Local0)
                {
                    If ((HSTS & 0x02))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Local0--
                        Stall (0x32)
                        If ((Local0 == Zero))
                        {
                            KILL ()
                        }
                    }
                }

                Return (Zero)
            }

            Method (KILL, 0, Serialized)
            {
                HCON |= 0x02
                HSTS |= 0xFF
            }
        }
    }

    Scope (_SB.PCI0)
    {
        Device (PEG0)
        {
            Name (_ADR, 0x00010000)  // _ADR: Address
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR02 ())
                }

                Return (PR02 ())
            }

            Device (PEGP)
            {
                Name (_ADR, 0xFFFF)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }
        }

        Device (PEG1)
        {
            Name (_ADR, 0x00010001)  // _ADR: Address
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0A ())
                }

                Return (PR0A ())
            }
        }

        Device (PEG2)
        {
            Name (_ADR, 0x00010002)  // _ADR: Address
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0B ())
                }

                Return (PR0B ())
            }
        }

        Device (PEG3)
        {
            Name (_ADR, 0x00060000)  // _ADR: Address
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (PICM)
                {
                    Return (AR0C) /* \_SB_.AR0C */
                }

                Return (PR0C) /* \_SB_.PR0C */
            }
        }

        Device (GFX0)
        {
            Name (_ADR, 0x00020000)  // _ADR: Address
            Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
            {
                DSEN = (Arg0 & 0x07)
                If (((Arg0 & 0x03) == Zero))
                {
                    If (CondRefOf (HDOS))
                    {
                        HDOS ()
                    }
                }
            }

            Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
            {
                If (CondRefOf (IDAB)){}
                Else
                {
                    NDID = Zero
                    If ((DIDL != Zero))
                    {
                        DID1 = SDDL (DIDL)
                    }

                    If ((DDL2 != Zero))
                    {
                        DID2 = SDDL (DDL2)
                    }

                    If ((DDL3 != Zero))
                    {
                        DID3 = SDDL (DDL3)
                    }

                    If ((DDL4 != Zero))
                    {
                        DID4 = SDDL (DDL4)
                    }

                    If ((DDL5 != Zero))
                    {
                        DID5 = SDDL (DDL5)
                    }

                    If ((DDL6 != Zero))
                    {
                        DID6 = SDDL (DDL6)
                    }

                    If ((DDL7 != Zero))
                    {
                        DID7 = SDDL (DDL7)
                    }

                    If ((DDL8 != Zero))
                    {
                        DID8 = SDDL (DDL8)
                    }
                }

                If ((NDID == One))
                {
                    Name (TMP1, Package (0x01)
                    {
                        0xFFFFFFFF
                    })
                    TMP1 [Zero] = (0x00010000 | DID1)
                    Return (TMP1) /* \_SB_.PCI0.GFX0._DOD.TMP1 */
                }

                If ((NDID == 0x02))
                {
                    Name (TMP2, Package (0x02)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    TMP2 [Zero] = (0x00010000 | DID1)
                    TMP2 [One] = (0x00010000 | DID2)
                    Return (TMP2) /* \_SB_.PCI0.GFX0._DOD.TMP2 */
                }

                If ((NDID == 0x03))
                {
                    Name (TMP3, Package (0x03)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    TMP3 [Zero] = (0x00010000 | DID1)
                    TMP3 [One] = (0x00010000 | DID2)
                    TMP3 [0x02] = (0x00010000 | DID3)
                    Return (TMP3) /* \_SB_.PCI0.GFX0._DOD.TMP3 */
                }

                If ((NDID == 0x04))
                {
                    Name (TMP4, Package (0x04)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    TMP4 [Zero] = (0x00010000 | DID1)
                    TMP4 [One] = (0x00010000 | DID2)
                    TMP4 [0x02] = (0x00010000 | DID3)
                    TMP4 [0x03] = (0x00010000 | DID4)
                    Return (TMP4) /* \_SB_.PCI0.GFX0._DOD.TMP4 */
                }

                If ((NDID == 0x05))
                {
                    Name (TMP5, Package (0x05)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    TMP5 [Zero] = (0x00010000 | DID1)
                    TMP5 [One] = (0x00010000 | DID2)
                    TMP5 [0x02] = (0x00010000 | DID3)
                    TMP5 [0x03] = (0x00010000 | DID4)
                    TMP5 [0x04] = (0x00010000 | DID5)
                    Return (TMP5) /* \_SB_.PCI0.GFX0._DOD.TMP5 */
                }

                If ((NDID == 0x06))
                {
                    Name (TMP6, Package (0x06)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    TMP6 [Zero] = (0x00010000 | DID1)
                    TMP6 [One] = (0x00010000 | DID2)
                    TMP6 [0x02] = (0x00010000 | DID3)
                    TMP6 [0x03] = (0x00010000 | DID4)
                    TMP6 [0x04] = (0x00010000 | DID5)
                    TMP6 [0x05] = (0x00010000 | DID6)
                    Return (TMP6) /* \_SB_.PCI0.GFX0._DOD.TMP6 */
                }

                If ((NDID == 0x07))
                {
                    Name (TMP7, Package (0x07)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    TMP7 [Zero] = (0x00010000 | DID1)
                    TMP7 [One] = (0x00010000 | DID2)
                    TMP7 [0x02] = (0x00010000 | DID3)
                    TMP7 [0x03] = (0x00010000 | DID4)
                    TMP7 [0x04] = (0x00010000 | DID5)
                    TMP7 [0x05] = (0x00010000 | DID6)
                    TMP7 [0x06] = (0x00010000 | DID7)
                    Return (TMP7) /* \_SB_.PCI0.GFX0._DOD.TMP7 */
                }

                If ((NDID == 0x08))
                {
                    Name (TMP8, Package (0x08)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    })
                    TMP8 [Zero] = (0x00010000 | DID1)
                    TMP8 [One] = (0x00010000 | DID2)
                    TMP8 [0x02] = (0x00010000 | DID3)
                    TMP8 [0x03] = (0x00010000 | DID4)
                    TMP8 [0x04] = (0x00010000 | DID5)
                    TMP8 [0x05] = (0x00010000 | DID6)
                    TMP8 [0x06] = (0x00010000 | DID7)
                    TMP8 [0x07] = (0x00010000 | DID8)
                    Return (TMP8) /* \_SB_.PCI0.GFX0._DOD.TMP8 */
                }

                Return (Package (0x01)
                {
                    0x0400
                })
            }

            Device (DD01)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID1 == Zero))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID1))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    Return (CDDS (DID1))
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD1) /* \NXD1 */
                    }

                    Return (NDDS (DID1))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }
            }

            Device (DD02)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID2 == Zero))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID2))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If ((LIDS == Zero))
                    {
                        Return (Zero)
                    }

                    Return (CDDS (DID2))
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD2) /* \NXD2 */
                    }

                    Return (NDDS (DID2))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }

                Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
                {
                    Return (Package (0x12)
                    {
                        0x64, 
                        0x23, 
                        0x14, 
                        0x19, 
                        0x1E, 
                        0x23, 
                        0x28, 
                        0x2D, 
                        0x32, 
                        0x37, 
                        0x3C, 
                        0x41, 
                        0x46, 
                        0x4B, 
                        0x50, 
                        0x55, 
                        0x5A, 
                        0x64
                    })
                }

                Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
                {
                    If (((Arg0 >= Zero) && (Arg0 <= 0x64)))
                    {
                        IBCM (Arg0)
                        UCMS (0x16)
                        ^^^LPCB.EC.BLCL ()
                    }
                }

                Method (_BQC, 0, NotSerialized)  // _BQC: Brightness Query Current
                {
                    Return (BRTL) /* \BRTL */
                }
            }

            Device (DD03)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID3 == Zero))
                    {
                        Return (0x03)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID3))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If ((DID3 == Zero))
                    {
                        Return (0x0B)
                    }
                    Else
                    {
                        Return (CDDS (DID3))
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD3) /* \NXD3 */
                    }

                    Return (NDDS (DID3))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }
            }

            Device (DD04)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID4 == Zero))
                    {
                        Return (0x04)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID4))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If ((DID4 == Zero))
                    {
                        Return (0x0B)
                    }
                    Else
                    {
                        Return (CDDS (DID4))
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD4) /* \NXD4 */
                    }

                    Return (NDDS (DID4))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }
            }

            Device (DD05)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID5 == Zero))
                    {
                        Return (0x05)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID5))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If ((DID5 == Zero))
                    {
                        Return (0x0B)
                    }
                    Else
                    {
                        Return (CDDS (DID5))
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD5) /* \NXD5 */
                    }

                    Return (NDDS (DID5))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }
            }

            Device (DD06)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID6 == Zero))
                    {
                        Return (0x06)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID6))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If ((DID6 == Zero))
                    {
                        Return (0x0B)
                    }
                    Else
                    {
                        Return (CDDS (DID6))
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD6) /* \NXD6 */
                    }

                    Return (NDDS (DID6))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }
            }

            Device (DD07)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID7 == Zero))
                    {
                        Return (0x07)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID7))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If ((DID7 == Zero))
                    {
                        Return (0x0B)
                    }
                    Else
                    {
                        Return (CDDS (DID7))
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD7) /* \NXD7 */
                    }

                    Return (NDDS (DID7))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }
            }

            Device (DD08)
            {
                Method (_ADR, 0, Serialized)  // _ADR: Address
                {
                    If ((DID8 == Zero))
                    {
                        Return (0x08)
                    }
                    Else
                    {
                        Return ((0xFFFF & DID8))
                    }
                }

                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If ((DID8 == Zero))
                    {
                        Return (0x0B)
                    }
                    Else
                    {
                        Return (CDDS (DID8))
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CondRefOf (SNXD))
                    {
                        Return (NXD8) /* \NXD8 */
                    }

                    Return (NDDS (DID8))
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                    If (((Arg0 & 0xC0000000) == 0xC0000000))
                    {
                        CSTE = NSTE /* \NSTE */
                    }
                }
            }

            Method (SDDL, 1, NotSerialized)
            {
                NDID++
                Local0 = (Arg0 & 0x0F0F)
                Local1 = (0x80000000 | Local0)
                If ((DIDL == Local0))
                {
                    Return (Local1)
                }

                If ((DDL2 == Local0))
                {
                    Return (Local1)
                }

                If ((DDL3 == Local0))
                {
                    Return (Local1)
                }

                If ((DDL4 == Local0))
                {
                    Return (Local1)
                }

                If ((DDL5 == Local0))
                {
                    Return (Local1)
                }

                If ((DDL6 == Local0))
                {
                    Return (Local1)
                }

                If ((DDL7 == Local0))
                {
                    Return (Local1)
                }

                If ((DDL8 == Local0))
                {
                    Return (Local1)
                }

                Return (Zero)
            }

            Method (CDDS, 1, NotSerialized)
            {
                Local0 = (Arg0 & 0x0F0F)
                If ((Zero == Local0))
                {
                    Return (0x1D)
                }

                If ((CADL == Local0))
                {
                    Return (0x1F)
                }

                If ((CAL2 == Local0))
                {
                    Return (0x1F)
                }

                If ((CAL3 == Local0))
                {
                    Return (0x1F)
                }

                If ((CAL4 == Local0))
                {
                    Return (0x1F)
                }

                If ((CAL5 == Local0))
                {
                    Return (0x1F)
                }

                If ((CAL6 == Local0))
                {
                    Return (0x1F)
                }

                If ((CAL7 == Local0))
                {
                    Return (0x1F)
                }

                If ((CAL8 == Local0))
                {
                    Return (0x1F)
                }

                Return (0x1D)
            }

            Method (NDDS, 1, NotSerialized)
            {
                Local0 = (Arg0 & 0x0F0F)
                If ((Zero == Local0))
                {
                    Return (Zero)
                }

                If ((NADL == Local0))
                {
                    Return (One)
                }

                If ((NDL2 == Local0))
                {
                    Return (One)
                }

                If ((NDL3 == Local0))
                {
                    Return (One)
                }

                If ((NDL4 == Local0))
                {
                    Return (One)
                }

                If ((NDL5 == Local0))
                {
                    Return (One)
                }

                If ((NDL6 == Local0))
                {
                    Return (One)
                }

                If ((NDL7 == Local0))
                {
                    Return (One)
                }

                If ((NDL8 == Local0))
                {
                    Return (One)
                }

                Return (Zero)
            }

            Scope (^^PCI0)
            {
                OperationRegion (MCHP, PCI_Config, 0x40, 0xC0)
                Field (MCHP, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x60), 
                    TASM,   10, 
                    Offset (0x62)
                }
            }

            OperationRegion (IGDP, PCI_Config, 0x40, 0xC0)
            Field (IGDP, AnyAcc, NoLock, Preserve)
            {
                Offset (0x12), 
                    ,   1, 
                GIVD,   1, 
                    ,   2, 
                GUMA,   3, 
                Offset (0x14), 
                    ,   4, 
                GMFN,   1, 
                Offset (0x18), 
                Offset (0xA4), 
                ASLE,   8, 
                Offset (0xA8), 
                GSSE,   1, 
                GSSB,   14, 
                GSES,   1, 
                Offset (0xB0), 
                    ,   12, 
                CDVL,   1, 
                Offset (0xB2), 
                Offset (0xB5), 
                LBPC,   8, 
                Offset (0xBC), 
                ASLS,   32
            }

            OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)
            Field (IGDM, AnyAcc, NoLock, Preserve)
            {
                SIGN,   128, 
                SIZE,   32, 
                OVER,   32, 
                SVER,   256, 
                VVER,   128, 
                GVER,   128, 
                MBOX,   32, 
                DMOD,   32, 
                Offset (0x100), 
                DRDY,   32, 
                CSTS,   32, 
                CEVT,   32, 
                Offset (0x120), 
                DIDL,   32, 
                DDL2,   32, 
                DDL3,   32, 
                DDL4,   32, 
                DDL5,   32, 
                DDL6,   32, 
                DDL7,   32, 
                DDL8,   32, 
                CPDL,   32, 
                CPL2,   32, 
                CPL3,   32, 
                CPL4,   32, 
                CPL5,   32, 
                CPL6,   32, 
                CPL7,   32, 
                CPL8,   32, 
                CADL,   32, 
                CAL2,   32, 
                CAL3,   32, 
                CAL4,   32, 
                CAL5,   32, 
                CAL6,   32, 
                CAL7,   32, 
                CAL8,   32, 
                NADL,   32, 
                NDL2,   32, 
                NDL3,   32, 
                NDL4,   32, 
                NDL5,   32, 
                NDL6,   32, 
                NDL7,   32, 
                NDL8,   32, 
                ASLP,   32, 
                TIDX,   32, 
                CHPD,   32, 
                CLID,   32, 
                CDCK,   32, 
                SXSW,   32, 
                EVTS,   32, 
                CNOT,   32, 
                NRDY,   32, 
                Offset (0x200), 
                SCIE,   1, 
                GEFC,   4, 
                GXFC,   3, 
                GESF,   8, 
                Offset (0x204), 
                PARM,   32, 
                DSLP,   32, 
                Offset (0x300), 
                ARDY,   32, 
                ASLC,   32, 
                TCHE,   32, 
                ALSI,   32, 
                BCLP,   32, 
                PFIT,   32, 
                CBLV,   32, 
                BCLM,   320, 
                CPFM,   32, 
                EPFM,   32, 
                PLUT,   592, 
                PFMB,   32, 
                CCDV,   32, 
                PCFT,   32, 
                Offset (0x400), 
                GVD1,   49152, 
                PHED,   32, 
                BDDC,   2048
            }

            Name (DBTB, Package (0x15)
            {
                Zero, 
                0x07, 
                0x38, 
                0x01C0, 
                0x0E00, 
                0x3F, 
                0x01C7, 
                0x0E07, 
                0x01F8, 
                0x0E38, 
                0x0FC0, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                Zero, 
                0x7000, 
                0x7007, 
                0x7038, 
                0x71C0, 
                0x7E00
            })
            Name (CDCT, Package (0x05)
            {
                Package (0x02)
                {
                    0xE4, 
                    0x0140
                }, 

                Package (0x02)
                {
                    0xDE, 
                    0x014D
                }, 

                Package (0x02)
                {
                    0xDE, 
                    0x014D
                }, 

                Package (0x02)
                {
                    Zero, 
                    Zero
                }, 

                Package (0x02)
                {
                    0xDE, 
                    0x014D
                }
            })
            Name (SUCC, One)
            Name (NVLD, 0x02)
            Name (CRIT, 0x04)
            Name (NCRT, 0x06)
            Method (GSCI, 0, Serialized)
            {
                Method (GBDA, 0, Serialized)
                {
                    If ((GESF == Zero))
                    {
                        PARM = 0x0679
                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == One))
                    {
                        PARM = 0x0240
                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x04))
                    {
                        PARM &= 0xEFFF0000
                        PARM &= (DerefOf (DBTB [IBTT]) << 0x10)
                        PARM |= IBTT /* \_SB_.PCI0.GFX0.PARM */
                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x05))
                    {
                        If (^^^^LID._LID ())
                        {
                            LIDS = One
                        }
                        Else
                        {
                            LIDS = Zero
                        }

                        PARM = IPSC /* \IPSC */
                        PARM |= (IPAT << 0x08)
                        PARM += 0x0100
                        PARM |= (LIDS << 0x10)
                        PARM += 0x00010000
                        PARM |= (IBIA << 0x14)
                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x06))
                    {
                        PARM = ITVF /* \ITVF */
                        PARM |= (ITVM << 0x04)
                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x07))
                    {
                        PARM = GIVD /* \_SB_.PCI0.GFX0.GIVD */
                        PARM ^= One
                        PARM |= (GMFN << One)
                        PARM |= 0x1800
                        PARM |= (IDMS << 0x11)
                        PARM |= (DerefOf (DerefOf (CDCT [HVCO]) [CDVL]) << 
                            0x15) /* \_SB_.PCI0.GFX0.PARM */
                        GESF = One
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x0A))
                    {
                        PARM = Zero
                        If (ISSC)
                        {
                            PARM |= 0x03
                        }

                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x0B))
                    {
                        PARM = KSV0 /* \KSV0 */
                        GESF = KSV1 /* \KSV1 */
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    GESF = Zero
                    Return (CRIT) /* \_SB_.PCI0.GFX0.CRIT */
                }

                Method (SBCB, 0, Serialized)
                {
                    If ((GESF == Zero))
                    {
                        PARM = Zero
                        PARM = 0x000F87FD
                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == One))
                    {
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x03))
                    {
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x04))
                    {
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x05))
                    {
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x06))
                    {
                        ITVF = (PARM & 0x0F)
                        ITVM = ((PARM & 0xF0) >> 0x04)
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x07))
                    {
                        If ((PARM == Zero))
                        {
                            Local0 = CLID /* \_SB_.PCI0.GFX0.CLID */
                            If ((0x80000000 & Local0))
                            {
                                CLID &= 0x0F
                                GLID (CLID)
                            }
                        }

                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x08))
                    {
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x09))
                    {
                        IBTT = (PARM & 0xFF)
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x0A))
                    {
                        IPSC = (PARM & 0xFF)
                        If (((PARM >> 0x08) & 0xFF))
                        {
                            IPAT = ((PARM >> 0x08) & 0xFF)
                            IPAT--
                        }

                        IBIA = ((PARM >> 0x14) & 0x07)
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x0B))
                    {
                        IF1E = ((PARM >> One) & One)
                        If ((PARM & 0x0001E000))
                        {
                            IDMS = ((PARM >> 0x0D) & 0x0F)
                        }
                        Else
                        {
                            IDMS = ((PARM >> 0x11) & 0x0F)
                        }

                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x10))
                    {
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x11))
                    {
                        PARM = (LIDS << 0x08)
                        PARM += 0x0100
                        GESF = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x12))
                    {
                        If ((PARM & One))
                        {
                            If (((PARM >> One) == One))
                            {
                                ISSC = One
                            }
                            Else
                            {
                                GESF = Zero
                                Return (CRIT) /* \_SB_.PCI0.GFX0.CRIT */
                            }
                        }
                        Else
                        {
                            ISSC = Zero
                        }

                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x13))
                    {
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    If ((GESF == 0x14))
                    {
                        PAVP = (PARM & 0x0F)
                        GESF = Zero
                        PARM = Zero
                        Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                    }

                    GESF = Zero
                    Return (SUCC) /* \_SB_.PCI0.GFX0.SUCC */
                }

                If ((GEFC == 0x04))
                {
                    GXFC = GBDA ()
                }

                If ((GEFC == 0x06))
                {
                    GXFC = SBCB ()
                }

                GEFC = Zero
                SCIS = One
                GSSE = Zero
                SCIE = Zero
                Return (Zero)
            }

            Method (PDRD, 0, NotSerialized)
            {
                If (!DRDY)
                {
                    Sleep (ASLP)
                }

                Return (!DRDY)
            }

            Method (PSTS, 0, NotSerialized)
            {
                If ((CSTS > 0x02))
                {
                    Sleep (ASLP)
                }

                Return ((CSTS == 0x03))
            }

            Method (GNOT, 2, NotSerialized)
            {
                If (PDRD ())
                {
                    Return (One)
                }

                CEVT = Arg0
                CSTS = 0x03
                If (((CHPD == Zero) && (Arg1 == Zero)))
                {
                    If (((OSYS > 0x07D0) && (OSYS < 0x07D6)))
                    {
                        Notify (PCI0, Arg1)
                    }
                    Else
                    {
                        Notify (GFX0, Arg1)
                    }
                }

                If (CondRefOf (HNOT))
                {
                    HNOT (Arg0)
                }
                Else
                {
                    Notify (GFX0, 0x80) // Status Change
                }

                Return (Zero)
            }

            Method (GHDS, 1, NotSerialized)
            {
                TIDX = Arg0
                Return (GNOT (One, Zero))
            }

            Method (GLID, 1, NotSerialized)
            {
                CLID = Arg0
                Return (GNOT (0x02, Zero))
            }

            Method (GDCK, 1, NotSerialized)
            {
                CDCK = Arg0
                Return (GNOT (0x04, Zero))
            }

            Method (PARD, 0, NotSerialized)
            {
                If (!ARDY)
                {
                    Sleep (ASLP)
                }

                Return (!ARDY)
            }

            Method (AINT, 2, NotSerialized)
            {
                If (!(TCHE & (One << Arg0)))
                {
                    Return (One)
                }

                If (PARD ())
                {
                    Return (One)
                }

                If ((Arg0 == 0x02))
                {
                    PFIT ^= 0x07
                    PFIT |= 0x80000000
                    ASLC = 0x04
                }
                ElseIf ((Arg0 == One))
                {
                    BCLP = Arg1
                    BCLP |= 0x80000000
                    ASLC = 0x0A
                }
                ElseIf ((Arg0 == 0x03))
                {
                    PFMB = Arg1
                    PFMB |= 0x80000100
                }
                ElseIf ((Arg0 == Zero))
                {
                    ALSI = Arg1
                    ASLC = One
                }
                Else
                {
                    Return (One)
                }

                ASLE = One
                Return (Zero)
            }

            Method (SCIP, 0, NotSerialized)
            {
                If ((OVER != Zero))
                {
                    Return (!GSMI)
                }

                Return (Zero)
            }
        }
    }

    Name (_S0, Package (0x04)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x04)  // _S3_: S3 System State
    {
        0x05, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S4, Package (0x04)  // _S4_: S4 System State
    {
        0x06, 
        Zero, 
        Zero, 
        Zero
    })
    Name (_S5, Package (0x04)  // _S5_: S5 System State
    {
        0x07, 
        Zero, 
        Zero, 
        Zero
    })
    Scope (_SB.PCI0.LPCB)
    {
        Device (EC)
        {
            Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_GPE, 0x16)  // _GPE: General Purpose Events
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (BFFR, ResourceTemplate ()
                {
                    IO (Decode16,
                        0x0062,             // Range Minimum
                        0x0062,             // Range Maximum
                        0x00,               // Alignment
                        0x01,               // Length
                        )
                    IO (Decode16,
                        0x0066,             // Range Minimum
                        0x0066,             // Range Maximum
                        0x00,               // Alignment
                        0x01,               // Length
                        )
                })
                Return (BFFR) /* \_SB_.PCI0.LPCB.EC__._CRS.BFFR */
            }

            OperationRegion (ERAM, EmbeddedControl, Zero, 0xFF)
            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                DSBY,   1, 
                ENGA,   1, 
                ENHY,   1, 
                HFNE,   1, 
                DSEM,   1, 
                EN3R,   1, 
                REBY,   1, 
                ENTM,   1, 
                ENBK,   1, 
                ENFP,   1, 
                    ,   1, 
                IDMI,   1, 
                WPSW,   1, 
                BYON,   1, 
                ENBT,   1, 
                NTKY,   1, 
                DKON,   1, 
                DSSK,   1, 
                MTES,   1, 
                USBO,   1, 
                DSMC,   1, 
                SNLC,   1, 
                NLSF,   1, 
                TNKB,   1, 
                DSHP,   1, 
                IGPK,   1, 
                CHGR,   1, 
                    ,   1, 
                CBAT,   1, 
                ADO0,   1, 
                ADO1,   1, 
                Offset (0x04), 
                    ,   1, 
                CLBA,   1, 
                LWBA,   1, 
                SUBE,   1, 
                PUBE,   1, 
                RSBE,   1, 
                DCBE,   1, 
                PFBE,   1, 
                HSPA,   1, 
                NHDD,   1, 
                DEAD,   1, 
                B440,   1, 
                B315,   1, 
                T315,   1, 
                R315,   1, 
                BYAM,   1, 
                HSUN,   8, 
                HSRP,   8, 
                    ,   1, 
                DELY,   1, 
                Offset (0x09), 
                Offset (0x0A), 
                Offset (0x0B), 
                TPSE,   2, 
                Offset (0x0C), 
                HLCL,   4, 
                    ,   2, 
                BLIK,   1, 
                TONF,   1, 
                UONE,   1, 
                    ,   1, 
                UONM,   2, 
                ECBK,   4, 
                HFNS,   2, 
                GSER,   1, 
                PSCS,   1, 
                PSDS,   1, 
                GSUD,   1, 
                GSID,   2, 
                MBCG,   1, 
                SBCG,   1, 
                MBRF,   1, 
                SBRF,   1, 
                HDSU,   1, 
                BYSU,   1, 
                    ,   1, 
                TMOD,   1, 
                HAM0,   8, 
                HAM1,   8, 
                HAM2,   8, 
                HAM3,   8, 
                HAM4,   8, 
                HAM5,   8, 
                HAM6,   8, 
                HAM7,   8, 
                HAM8,   8, 
                HAM9,   8, 
                HAMA,   8, 
                HAMB,   8, 
                HAMC,   8, 
                HAMD,   8, 
                HAME,   8, 
                HAMF,   8, 
                HT00,   1, 
                HT01,   1, 
                HT02,   1, 
                HT03,   1, 
                HT10,   1, 
                HT11,   1, 
                HT12,   1, 
                HT13,   1, 
                Offset (0x23), 
                EXCM,   8, 
                Offset (0x25), 
                Offset (0x26), 
                USP0,   1, 
                USP3,   1, 
                USP4,   1, 
                EHP0,   1, 
                EHP1,   1, 
                Offset (0x27), 
                Offset (0x28), 
                ID00,   1, 
                ID01,   1, 
                ID02,   1, 
                ID03,   1, 
                    ,   2, 
                SEBT,   1, 
                CMDS,   1, 
                Offset (0x2A), 
                HATR,   8, 
                HT0H,   8, 
                HT0L,   8, 
                HT1H,   8, 
                HT1L,   8, 
                HFSP,   8, 
                    ,   5, 
                SMUT,   1, 
                Offset (0x31), 
                FANS,   2, 
                HUWB,   1, 
                ENS4,   1, 
                DSEX,   1, 
                AYID,   1, 
                MMUT,   1, 
                ODDP,   1, 
                HWPM,   1, 
                HWLB,   1, 
                HWLO,   1, 
                HWDK,   1, 
                HWFN,   1, 
                HWBT,   1, 
                HWRI,   1, 
                HWBU,   1, 
                Offset (0x34), 
                    ,   7, 
                HPLO,   1, 
                Offset (0x36), 
                Offset (0x37), 
                Offset (0x38), 
                HB0S,   7, 
                MBTS,   1, 
                Offset (0x3A), 
                MUTE,   1, 
                I2CS,   1, 
                PWRF,   1, 
                WANO,   1, 
                DCBD,   1, 
                DCWL,   1, 
                DCWW,   1, 
                Offset (0x3B), 
                SPKM,   1, 
                KBLH,   1, 
                    ,   1, 
                BTDH,   1, 
                USBN,   1, 
                    ,   2, 
                S3FG,   1, 
                Offset (0x3D), 
                Offset (0x3E), 
                Offset (0x41), 
                    ,   7, 
                PFLG,   1, 
                Offset (0x46), 
                FNKY,   1, 
                    ,   1, 
                HPLD,   1, 
                PROF,   1, 
                ACPW,   1, 
                    ,   2, 
                CALR,   1, 
                HPBU,   1, 
                DKEV,   1, 
                BYNO,   1, 
                HDIB,   1, 
                Offset (0x48), 
                HPHI,   1, 
                GSTS,   1, 
                    ,   2, 
                EXGC,   1, 
                DOKI,   1, 
                HDDT,   1, 
                Offset (0x49), 
                    ,   1, 
                NUMK,   1, 
                Offset (0x4A), 
                Offset (0x4B), 
                Offset (0x4C), 
                ETHB,   8, 
                ETLB,   8, 
                    ,   1, 
                ACOV,   1, 
                RMCS,   1, 
                    ,   1, 
                T4E4,   1, 
                T4E5,   1, 
                Offset (0x4F), 
                Offset (0x50), 
                SMPR,   8, 
                SMST,   8, 
                SMAD,   8, 
                SMCM,   8, 
                SMD0,   100, 
                Offset (0x74), 
                BCNT,   8, 
                SMAA,   8, 
                BATD,   16, 
                TMP0,   8, 
                TMP1,   8, 
                TMP2,   8, 
                TMP3,   8, 
                TMP4,   8, 
                TMP5,   8, 
                TMP6,   8, 
                TMP7,   8, 
                Offset (0x81), 
                HIID,   8, 
                Offset (0x83), 
                HFNI,   8, 
                Offset (0x86), 
                Offset (0x87), 
                Offset (0x88), 
                SCRS,   1, 
                Offset (0x89), 
                HDEO,   8, 
                Offset (0x8B), 
                LOMD,   1, 
                CBDE,   1, 
                Offset (0x8C), 
                Offset (0x8D), 
                HDAA,   3, 
                HDAB,   3, 
                HDAC,   2, 
                Offset (0x8F), 
                Offset (0x90), 
                ERMC,   8, 
                Offset (0x92), 
                AMSB,   8, 
                ALSB,   8, 
                DMSB,   8, 
                DLSB,   8, 
                Offset (0xA0), 
                Offset (0xB0), 
                HDEN,   32, 
                DBTS,   8, 
                Offset (0xB8), 
                HDEM,   8, 
                HDES,   8, 
                Offset (0xC0), 
                Offset (0xC1), 
                MCUR,   16, 
                MBRM,   16, 
                MBVG,   16, 
                Offset (0xC8), 
                ATMX,   8, 
                AC65,   8, 
                Offset (0xCB), 
                BFUD,   1, 
                Offset (0xCC), 
                PWMH,   8, 
                PWML,   8, 
                SHSC,   8, 
                HSID,   8, 
                Offset (0xE0), 
                B1FC,   16, 
                Offset (0xE8), 
                Offset (0xE9), 
                Offset (0xEA), 
                Offset (0xEB), 
                Offset (0xEC), 
                Offset (0xED), 
                    ,   1, 
                    ,   1, 
                    ,   1, 
                    ,   1, 
                    ,   1, 
                    ,   1, 
                    ,   1, 
                Offset (0xEE), 
                MBTH,   4, 
                SBTH,   4, 
                Offset (0xF0), 
                Offset (0xF8), 
                    ,   4, 
                Offset (0xF9), 
                Offset (0xFA), 
                Offset (0xFC)
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0xA0), 
                SBRC,   16, 
                SBFC,   16, 
                SBAE,   16, 
                SBRS,   16, 
                SBAC,   16, 
                SBVO,   16, 
                SBAF,   16, 
                SBBS,   16
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0xA0), 
                    ,   15, 
                SBCM,   1, 
                SBMD,   16, 
                SBCC,   16
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0xA0), 
                SBDC,   16, 
                SBDV,   16, 
                SBOM,   16, 
                SBSI,   16, 
                SBDT,   16, 
                SBSN,   16
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0xA0), 
                SBCH,   32
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0xA0), 
                SBMN,   128
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0xA0), 
                SBDN,   128
            }

            Name (BATO, Zero)
            Name (BATN, Zero)
            Name (BATF, 0xC0)
            Method (_REG, 2, NotSerialized)  // _REG: Region Availability
            {
                If (((Arg0 == 0x03) && (Arg1 == One)))
                {
                    ECON = One
                    SXFG = 0xFF
                    LIDX = Zero
                    LIDW = One
                    ODDS = Zero
                    ACST = ACPW /* \_SB_.PCI0.LPCB.EC__.ACPW */
                    PWRS = ACST /* \ACST */
                    If (IGDS)
                    {
                        If (((OSYS > 0x07D0) && (OSYS < 0x07D6)))
                        {
                            ^^^GFX0.BCLP = DerefOf (PNLS [BRNS])
                            ^^^GFX0.BCLP |= 0x80000000
                            ^^^GFX0.ASLC = 0x0A
                        }
                    }

                    If ((AC65 == 0x41))
                    {
                        If (!MBTS)
                        {
                            LFMG = One
                            \_PR.CPU0._PPC = 0x0D
                            PNOT ()
                            \_PR.CPU1._PPC = 0x0D
                            PNOT ()
                        }
                    }
                }
            }

            Method (LED, 2, NotSerialized)
            {
                Local0 = (Arg0 | Arg1)
                If (ECON)
                {
                    HLCL = Local0
                }
                Else
                {
                    WBEC (0x0C, Local0)
                }
            }

            Name (BAON, Zero)
            Name (WBON, Zero)
            Method (BEEP, 1, NotSerialized)
            {
                If ((Arg0 == 0x0F))
                {
                    WBON = Zero
                }

                Local2 = WBON /* \_SB_.PCI0.LPCB.EC__.WBON */
                Local0 = Arg0
                Local1 = 0xFF
                If ((Arg0 == 0x11))
                {
                    Local0 = Zero
                    Local1 = Zero
                    WBON = Zero
                }

                If ((Arg0 == 0x10))
                {
                    Local0 = 0x03
                    Local1 = 0x08
                    WBON = One
                }

                If ((Arg0 == 0x03))
                {
                    WBON = Zero
                    If (Local2)
                    {
                        Local0 = 0x07
                        If (((SPS == 0x03) || (SPS == 0x04)))
                        {
                            Local2 = Zero
                            Local0 = 0xFF
                            Local1 = 0xFF
                        }
                    }
                }

                If ((Arg0 == 0x07))
                {
                    If (Local2)
                    {
                        Local2 = Zero
                        Local0 = 0xFF
                        Local1 = 0xFF
                    }
                }

                If (ECON)
                {
                    If ((Local2 && !WBON))
                    {
                        HSRP = Zero
                        HSUN = Zero
                        Sleep (0x64)
                    }

                    If ((Local1 != 0xFF))
                    {
                        HSRP = Local1
                    }

                    If ((Local0 != 0xFF))
                    {
                        HSUN = Local0
                    }
                }

                If ((Arg0 == 0x03))
                {
                    Sleep (0x012C)
                }

                If ((Arg0 == 0x07))
                {
                    Sleep (0x01F4)
                }
            }

            Method (BPOL, 1, NotSerialized)
            {
                WECB (0x03, 0xD6, Arg0)
                Local0 = RECB (0x03, 0xD0)
                WECB (0x03, 0xD0, Local0 |= One)
            }

            Method (FNST, 0, NotSerialized)
            {
                If (ECON)
                {
                    Local0 = HFNS /* \_SB_.PCI0.LPCB.EC__.HFNS */
                    Local1 = HFNE /* \_SB_.PCI0.LPCB.EC__.HFNE */
                }
                Else
                {
                    Local0 = (RBEC (0x0E) & 0x03)
                    Local1 = (RBEC (Zero) & 0x08)
                }

                If (Local1)
                {
                    If ((Local0 == Zero))
                    {
                        UCMS (0x11)
                    }

                    If ((Local0 == One))
                    {
                        UCMS (0x0F)
                    }

                    If ((Local0 == 0x02))
                    {
                        UCMS (0x10)
                    }
                }
            }

            Method (SELE, 0, NotSerialized)
            {
                BATN = BATD /* \_SB_.PCI0.LPCB.EC__.BATD */
                BATF = Zero
                If ((0xC0 & BATN))
                {
                    BATF |= One
                }

                If ((0x0300 & BATN))
                {
                    BATF |= 0x04
                }

                Local0 = (BATN & One)
                Local1 = (BATO & One)
                If (Local0)
                {
                    BATF |= 0x0100
                }
                Else
                {
                    BATF &= 0xFEFF
                }

                If (~(Local0 == Local1))
                {
                    BATF |= 0x40
                }

                Local0 = (BATN & 0xC0)
                Local1 = (BATO & 0xC0)
                If (~(Local0 == Local1))
                {
                    BATF |= 0x02
                }

                If ((One & BATF))
                {
                    If ((0x04 & BATF))
                    {
                        If ((BATN & 0x10))
                        {
                            BATF |= 0x10
                        }
                    }
                }
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0x54), 
                SMW0,   16
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0x54), 
                SMB0,   8
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0x54), 
                FLD0,   64
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0x54), 
                FLD1,   128
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0x54), 
                FLD2,   192
            }

            Field (ERAM, ByteAcc, NoLock, Preserve)
            {
                Offset (0x54), 
                FLD3,   256
            }

            Mutex (MUT0, 0x00)
            Method (SMRD, 4, NotSerialized)
            {
                If (!ECON)
                {
                    Return (0xFF)
                }

                If ((Arg0 != 0x07))
                {
                    If ((Arg0 != 0x09))
                    {
                        If ((Arg0 != 0x0B))
                        {
                            Return (0x19)
                        }
                    }
                }

                Acquire (MUT0, 0xFFFF)
                Local0 = 0x04
                While ((Local0 > One))
                {
                    SMST &= 0x40
                    SMCM = Arg2
                    SMAD = Arg1
                    SMPR = Arg0
                    Local3 = Zero
                    While (!Local1 = (SMST & 0xBF))
                    {
                        Sleep (0x02)
                        Local3++
                        If ((Local3 == 0x32))
                        {
                            SMST &= 0x40
                            SMCM = Arg2
                            SMAD = Arg1
                            SMPR = Arg0
                            Local3 = Zero
                        }
                    }

                    If ((Local1 == 0x80))
                    {
                        Local0 = Zero
                    }
                    Else
                    {
                        Local0--
                    }
                }

                If (Local0)
                {
                    Local0 = (Local1 & 0x1F)
                }
                Else
                {
                    If ((Arg0 == 0x07))
                    {
                        Arg3 = SMB0 /* \_SB_.PCI0.LPCB.EC__.SMB0 */
                    }

                    If ((Arg0 == 0x09))
                    {
                        Arg3 = SMW0 /* \_SB_.PCI0.LPCB.EC__.SMW0 */
                    }

                    If ((Arg0 == 0x0B))
                    {
                        Local3 = BCNT /* \_SB_.PCI0.LPCB.EC__.BCNT */
                        Local2 = (0x0100 >> 0x03)
                        If ((Local3 > Local2))
                        {
                            Local3 = Local2
                        }

                        If ((Local3 < 0x11))
                        {
                            Local2 = FLD1 /* \_SB_.PCI0.LPCB.EC__.FLD1 */
                        }
                        ElseIf ((Local3 < 0x19))
                        {
                            Local2 = FLD2 /* \_SB_.PCI0.LPCB.EC__.FLD2 */
                        }
                        Else
                        {
                            Local2 = FLD3 /* \_SB_.PCI0.LPCB.EC__.FLD3 */
                        }

                        Local3++
                        Local4 = Buffer (Local3){}
                        Local3--
                        Local5 = Zero
                        While ((Local3 > Local5))
                        {
                            GBFE (Local2, Local5, RefOf (Local6))
                            PBFE (Local4, Local5, Local6)
                            Local5++
                        }

                        PBFE (Local4, Local5, Zero)
                        Arg3 = Local4
                    }
                }

                Release (MUT0)
                Return (Local0)
            }

            Method (SMWR, 4, NotSerialized)
            {
                If (!ECON)
                {
                    Return (0xFF)
                }

                If ((Arg0 != 0x06))
                {
                    If ((Arg0 != 0x08))
                    {
                        If ((Arg0 != 0x0A))
                        {
                            Return (0x19)
                        }
                    }
                }

                Acquire (MUT0, 0xFFFF)
                Local0 = 0x04
                While ((Local0 > One))
                {
                    If ((Arg0 == 0x06))
                    {
                        SMB0 = Arg3
                    }

                    If ((Arg0 == 0x08))
                    {
                        SMW0 = Arg3
                    }

                    If ((Arg0 == 0x0A))
                    {
                        SMD0 = Arg3
                    }

                    SMST &= 0x40
                    SMCM = Arg2
                    SMAD = Arg1
                    SMPR = Arg0
                    Local3 = Zero
                    While (!Local1 = (SMST & 0xBF))
                    {
                        Sleep (0x02)
                        Local3++
                        If ((Local3 == 0x32))
                        {
                            SMST &= 0x40
                            SMCM = Arg2
                            SMAD = Arg1
                            SMPR = Arg0
                            Local3 = Zero
                        }
                    }

                    If ((Local1 == 0x80))
                    {
                        Local0 = Zero
                    }
                    Else
                    {
                        Local0--
                    }
                }

                If (Local0)
                {
                    Local0 = (Local1 & 0x1F)
                }

                Release (MUT0)
                Return (Local0)
            }

            Method (RECB, 2, NotSerialized)
            {
                ALSB = Arg1
                AMSB = Arg0
                Local7 = Zero
                While ((Local7 < 0xC8))
                {
                    If (((Local0 = (ERMC & 0x80)) == 0x80))
                    {
                        Local1 = Zero
                        Local7++
                    }
                    Else
                    {
                        ERMC = 0x81
                        Sleep (0x14)
                        Local6 = Zero
                        While ((Local6 < 0xC8))
                        {
                            If (((Local0 = (ERMC & 0x80)) == 0x80))
                            {
                                Local1 = Zero
                                Local6++
                            }
                            Else
                            {
                                Local1 = DMSB /* \_SB_.PCI0.LPCB.EC__.DMSB */
                                Local6 = 0xC8
                            }
                        }

                        Local7 = 0xC8
                    }
                }

                Return (Local1)
            }

            Method (WECB, 3, NotSerialized)
            {
                AMSB = Arg0
                ALSB = Arg1
                Local7 = Zero
                While ((Local7 < 0xC8))
                {
                    If (((Local0 = (ERMC & 0x80)) == 0x80))
                    {
                        Local1 = Zero
                        Local7++
                    }
                    Else
                    {
                        DMSB = Arg2
                        ERMC = 0x83
                        Sleep (0x14)
                        Local6 = Zero
                        While ((Local6 < 0xC8))
                        {
                            If (((Local0 = (ERMC & 0x80)) == 0x80))
                            {
                                Local1 = Zero
                                Local6++
                            }
                            Else
                            {
                                Local1 = One
                                Local6 = 0xC8
                            }
                        }

                        Local7 = 0xC8
                    }
                }

                Return (Local1)
            }

            Method (RECW, 2, NotSerialized)
            {
                ALSB = Arg1
                AMSB = Arg0
                Local0 = ERMC /* \_SB_.PCI0.LPCB.EC__.ERMC */
                Local7 = Zero
                While ((Local7 < 0xC8))
                {
                    If (((Local0 = (ERMC & 0x80)) == 0x80))
                    {
                        Local1 = Zero
                        Local7++
                    }
                    Else
                    {
                        ERMC = 0x82
                        Sleep (0x14)
                        Local6 = Zero
                        While ((Local6 < 0xC8))
                        {
                            If (((Local0 = (ERMC & 0x80)) == 0x80))
                            {
                                Local1 = Zero
                                Local6++
                            }
                            Else
                            {
                                Local1 = DMSB /* \_SB_.PCI0.LPCB.EC__.DMSB */
                                Local2 = DLSB /* \_SB_.PCI0.LPCB.EC__.DLSB */
                                Local6 = 0xC8
                            }
                        }

                        Local7 = 0xC8
                    }
                }

                Local4 = (0x0100 * Local2)
                Local4 += Local1
                Return (Local4)
            }

            Method (CHKS, 0, NotSerialized)
            {
                Local0 = 0x03E8
                While (SMPR)
                {
                    Sleep (One)
                    Local0--
                    If (!Local0)
                    {
                        Return (0x8080)
                    }
                }

                Local1 = (SMST & 0x80)
                If ((Local1 == 0x80))
                {
                    Return (Zero)
                }

                Return (0x8081)
            }

            Method (BFWL, 0, NotSerialized)
            {
                FW00 = SMD0 /* \_SB_.PCI0.LPCB.EC__.SMD0 */
                SMI (0x14, 0x02, Zero, Zero, Zero)
            }

            Method (BLCL, 0, NotSerialized)
            {
                Local0 = BRNS /* \BRNS */
                If (^^^GFX0.DRDY)
                {
                    If ((Zero == Local0))
                    {
                        Local1 = DerefOf (DerefOf (BRTB [0x02]) [0x03])
                        Local2 = DerefOf (DerefOf (BRTB [0x02]) [Zero])
                    }
                    Else
                    {
                        Local1 = DerefOf (DerefOf (BRTB [0x02]) [0x04])
                        Local2 = DerefOf (DerefOf (BRTB [0x02]) [One])
                    }

                    Local2 = (Local1 | (Local2 << 0x09))
                    ^^^GFX0.AINT (0x03, Local2)
                    Local1 = Zero
                    Local2 = DerefOf (DerefOf (BRTB [Local1]) [Local0])
                    ^^^GFX0.AINT (One, Local2)
                }
            }

            Method (_Q01, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = One
            }

            Method (_Q02, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x02
            }

            Method (_Q03, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x03
            }

            Method (_Q04, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x04
            }

            Method (_Q05, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x05
            }

            Method (_Q06, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x06
            }

            Method (_Q07, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x07
            }

            Method (_Q08, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x08
            }

            Method (_Q09, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x09
            }

            Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x0A
            }

            Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x0B
            }

            Method (_Q0C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x0C
            }

            Method (_Q0D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x0D
            }

            Method (_Q0E, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x0E
            }

            Method (_Q0F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x0F
            }

            Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x10
                If (^HKEY.MHKK (One))
                {
                    ^HKEY.MHKQ (0x1001)
                }
            }

            Method (_Q11, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x11
                If (^HKEY.MHKK (0x02))
                {
                    ^HKEY.MHKQ (0x1002)
                }
                Else
                {
                    Noop
                }
            }

            Method (_Q12, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x12
                ^HKEY.MHKQ (0x1003)
            }

            Method (_Q13, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x13
                If (^HKEY.DHKC)
                {
                    ^HKEY.MHKQ (0x1004)
                }
                Else
                {
                    Notify (SLPB, 0x80) // Status Change
                }
            }

            Method (_Q14, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x14
                If (^HKEY.MHKK (0x8000))
                {
                    ^HKEY.MHKQ (0x1010)
                }

                If ((OSYS >= 0x07D6))
                {
                    If (IGDS)
                    {
                        Notify (^^^GFX0.DD02, 0x86) // Device-Specific
                        Sleep (0x50)
                    }
                    Else
                    {
                        Notify (^^^PEG0.VGA.LCD, 0x86) // Device-Specific
                    }

                    UCMS (0x16)
                }
                ElseIf (IGDS)
                {
                    BRNS = UCMS (0x15)
                    Local0 = BRNS /* \BRNS */
                    If ((Local0 != 0x0F))
                    {
                        Local0++
                        BRNS = Local0
                    }

                    UCMS (0x16)
                    BLCL ()
                }
                Else
                {
                    UCMS (0x04)
                }
            }

            Method (_Q15, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x15
                If (^HKEY.MHKK (0x00010000))
                {
                    ^HKEY.MHKQ (0x1011)
                }

                If ((OSYS >= 0x07D6))
                {
                    If (IGDS)
                    {
                        Notify (^^^GFX0.DD02, 0x87) // Device-Specific
                        Sleep (0x50)
                    }
                    Else
                    {
                        Notify (^^^PEG0.VGA.LCD, 0x87) // Device-Specific
                    }

                    UCMS (0x16)
                }
                ElseIf (IGDS)
                {
                    If (VCDB)
                    {
                        VCDB = Zero
                        BRNS = UCMS (0x15)
                        UCMS (0x16)
                        BLCL ()
                    }
                    Else
                    {
                        BRNS = UCMS (0x15)
                        Local0 = BRNS /* \BRNS */
                        If (Local0)
                        {
                            Local0--
                            BRNS = Local0
                        }

                        UCMS (0x16)
                        BLCL ()
                    }
                }
                Else
                {
                    UCMS (0x05)
                }
            }

            Method (_Q16, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (^HKEY.MHKK (0x40))
                {
                    ^HKEY.MHKQ (0x1007)
                }
                ElseIf (IGDS)
                {
                    ^^^GFX0.GHDS (Zero)
                }
                ElseIf (((OSYS > 0x07D0) && (OSYS < 0x07D6)))
                {
                    ^^^PEG0.VGA.SWIH ()
                }
                ElseIf ((^^^PEG0.VGA.AVGA == One))
                {
                    ^^^PEG0.VGA.AFN0 ()
                }
            }

            Method (_Q17, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (^HKEY.MHKK (0x80))
                {
                    ^HKEY.MHKQ (0x1008)
                }
                Else
                {
                }
            }

            Method (_Q18, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (^HKEY.MHKK (0x0100))
                {
                    ^HKEY.MHKQ (0x1009)
                }

                Noop
            }

            Method (_Q19, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x19
                If (^HKEY.MHKK (0x00800000))
                {
                    ^HKEY.MHKQ (0x1018)
                }

                UCMS (0x03)
            }

            Method (_Q1A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (^HKEY.MHKK (0x0400))
                {
                    ^HKEY.MHKQ (0x100B)
                }
            }

            Method (_Q1B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                ^HKEY.MHKQ (0x100C)
            }

            Method (_Q1C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (^HKEY.MHKK (0x00200000))
                {
                    ^HKEY.MHKQ (0x1016)
                }

                UCMS (Zero)
            }

            Method (_Q1D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (^HKEY.MHKK (0x00100000))
                {
                    ^HKEY.MHKQ (0x1015)
                }

                UCMS (One)
            }

            Method (_Q1E, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x1E
                ADO0 = One
                ADO1 = One
            }

            Method (_Q1F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
            }

            Method (_Q22, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (MBTS)
                {
                    Notify (BAT1, 0x80) // Status Change
                    Notify (BAT1, Zero) // Bus Check
                }
            }

            Method (_Q24, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Notify (BAT1, 0x80) // Status Change
                If ((AC65 == 0x41))
                {
                    If (!MBTS)
                    {
                        LFMG = One
                        \_PR.CPU0._PPC = 0x0D
                        PNOT ()
                        \_PR.CPU1._PPC = 0x0D
                        PNOT ()
                    }
                    ElseIf ((LFMG == One))
                    {
                        LFMG = Zero
                        \_PR.CPU0._PPC = Zero
                        PNOT ()
                        \_PR.CPU1._PPC = Zero
                        PNOT ()
                    }
                }
            }

            Method (_Q26, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x26
                Sleep (0xC8)
                Notify (ACAD, 0x80) // Status Change
                Notify (BAT1, 0x80) // Status Change
                Notify (\_TZ.TZ00, 0x80) // Thermal Status Change
                PNOT ()
                If ((AC65 == 0x41))
                {
                    If (!MBTS)
                    {
                        LFMG = One
                        \_PR.CPU0._PPC = 0x0D
                        PNOT ()
                        \_PR.CPU1._PPC = 0x0D
                        PNOT ()
                    }
                    ElseIf ((LFMG == One))
                    {
                        LFMG = Zero
                        \_PR.CPU0._PPC = Zero
                        PNOT ()
                        \_PR.CPU1._PPC = Zero
                        PNOT ()
                    }
                }
            }

            Method (_Q27, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x27
                Sleep (0xC8)
                Notify (ACAD, 0x80) // Status Change
                PNOT ()
            }

            Method (_Q28, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x28
            }

            Method (_Q29, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x29
            }

            Method (_Q2A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (IGDS){}
                ElseIf (((OSYS > 0x07D0) && (OSYS < 0x07D6)))
                {
                    Sleep (0x64)
                    PHSR (0x9F)
                }

                ^HKEY.MHKQ (0x5002)
                Notify (LID, 0x80) // Status Change
            }

            Method (_Q2B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x2B
                If (!IGDS)
                {
                    If ((OSYS < 0x07D6))
                    {
                        Sleep (0x64)
                        PHSR (0x9E)
                    }
                    Else
                    {
                        UCMS (0x0D)
                    }
                }
                Else
                {
                    UCMS (0x0D)
                }

                ^HKEY.MHKQ (0x5001)
                Notify (LID, 0x80) // Status Change
            }

            Method (_Q37, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Sleep (0x01F4)
                ^^^^WMI1.CMD2 (0x2E, One, One)
                If (DOKI)
                {
                    ^HKEY.MHKQ (0x4010)
                }
                Else
                {
                    ^HKEY.MHKQ (0x4011)
                }
            }

            Method (_Q3F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Sleep (0x01F4)
                ^HKEY.MHKQ (0x6000)
            }

            Method (_Q40, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x40
                Notify (\_TZ.TZ00, 0x80) // Thermal Status Change
            }

            Method (_Q41, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                Sleep (0x01F4)
                ^HKEY.MHKQ (0x7000)
                If (!GSTS)
                {
                    GO70 = Zero
                    GO35 = Zero
                    GO71 = Zero
                }
                Else
                {
                    GO70 = DCWL /* \_SB_.PCI0.LPCB.EC__.DCWL */
                    GO35 = DCBD /* \_SB_.PCI0.LPCB.EC__.DCBD */
                    GO71 = DCWW /* \_SB_.PCI0.LPCB.EC__.DCWW */
                }
            }

            Method (_Q43, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x43
            }

            Method (_Q44, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x44
                If (WWNA)
                {
                    GO71 = DCWW /* \_SB_.PCI0.LPCB.EC__.DCWW */
                    WWNA = Zero
                }
                ElseIf (WANA)
                {
                    GO70 = DCWL /* \_SB_.PCI0.LPCB.EC__.DCWL */
                    WANA = Zero
                }
                ElseIf (BTHA)
                {
                    GO35 = DCBD /* \_SB_.PCI0.LPCB.EC__.DCBD */
                    BTHA = Zero
                }
            }

            Method (_Q45, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x45
                If ((ODDS == One))
                {
                    ^HKEY.MHKQ (0x3006)
                    ODDS = Zero
                    IRDY ()
                    Notify (^^^SAT0.PRT1, One) // Device Check
                }
            }

            Method (_Q4A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x4A
                Sleep (0xC8)
                Notify (BAT1, Zero) // Bus Check
                PNOT ()
                If ((AC65 == 0x41))
                {
                    If (!MBTS)
                    {
                        LFMG = One
                        \_PR.CPU0._PPC = 0x0D
                        PNOT ()
                        \_PR.CPU1._PPC = 0x0D
                        PNOT ()
                    }
                    ElseIf ((LFMG == One))
                    {
                        LFMG = Zero
                        \_PR.CPU0._PPC = Zero
                        PNOT ()
                        \_PR.CPU1._PPC = Zero
                        PNOT ()
                    }
                }
            }

            Method (_Q4B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x4B
                Notify (BAT1, 0x80) // Status Change
                PNOT ()
                If ((AC65 == 0x41))
                {
                    If (!MBTS)
                    {
                        LFMG = One
                        \_PR.CPU0._PPC = 0x0D
                        PNOT ()
                        \_PR.CPU1._PPC = 0x0D
                        PNOT ()
                    }
                    ElseIf ((LFMG == One))
                    {
                        LFMG = Zero
                        \_PR.CPU0._PPC = Zero
                        PNOT ()
                        \_PR.CPU1._PPC = Zero
                        PNOT ()
                    }
                }
            }

            Method (_Q4E, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x4E
                ^HKEY.MHKQ (0x6011)
            }

            Method (_Q4F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x4F
                ^HKEY.MHKQ (0x6012)
            }

            Method (_Q60, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x60
                If (^HKEY.MHKK (0x2000))
                {
                    ^HKEY.MHKQ (0x100E)
                }
            }

            Method (_Q61, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x61
            }

            Method (_Q62, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x62
            }

            Method (_Q63, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x63
                If (^HKEY.MHKK (0x00080000))
                {
                    ^HKEY.MHKQ (0x1014)
                }

                UCMS (0x0B)
            }

            Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x64
                If (^HKEY.MHKK (0x10))
                {
                    ^HKEY.MHKQ (0x1005)
                }
            }

            Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x65
                If (^HKEY.MHKK (0x20))
                {
                    ^HKEY.MHKQ (0x1006)
                }
            }

            Method (_Q66, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x66
                If (^HKEY.MHKK (0x0200))
                {
                    ^HKEY.MHKQ (0x100A)
                }

                UCMS (0x02)
            }

            Method (_Q67, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If (^HKEY.MHKK (0x00040000))
                {
                    ^HKEY.MHKQ (0x1013)
                }
            }

            Method (_Q68, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x68
            }

            Method (_Q69, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x69
            }

            Method (_Q6A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x6A
                ^HKEY.MHKQ (0x101B)
            }

            Method (_Q6B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x6B
            }

            Method (_Q6C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x6C
            }

            Method (_Q6D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x6D
            }

            Method (_Q6E, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x6E
            }

            Method (_Q6F, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x6F
            }

            Method (_Q70, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x70
                FNST ()
            }

            Method (_Q72, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x72
                FNST ()
            }

            Method (_Q73, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x73
                FNST ()
            }

            Method (_Q76, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x76
            }

            Method (_Q77, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0x77
            }

            Method (_QEA, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0xEA
                If ((T4E4 == Zero))
                {
                    T4E4 = One
                    T4E5 = Zero
                    THRO (0x91)
                    Sleep (0x1E)
                    THRO (0x95)
                }
                Else
                {
                    T4E5 = One
                    THRO (0x92)
                    Sleep (0x1E)
                    THRO (0x95)
                }
            }

            Method (_QEC, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0xEC
                T4E4 = One
                T4E5 = Zero
                THRO (0x91)
                Sleep (0x1E)
                THRO (0x95)
            }

            Method (_QEB, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                ACOV = One
                If ((THRO (0x93) == 0x12))
                {
                    RMCS = One
                }

                Sleep (0x1E)
                THRO (0x95)
                If ((AC65 == 0x41))
                {
                    If ((MBTS == Zero))
                    {
                        LFMG = One
                        \_PR.CPU0._PPC = 0x0D
                        PNOT ()
                        \_PR.CPU1._PPC = 0x0D
                        PNOT ()
                    }
                }
            }

            Method (_QED, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                P80H = 0xED
                ACOV = Zero
                RMCS = Zero
                T4E4 = Zero
                T4E5 = Zero
                THRO (0x94)
                Sleep (0x1E)
                THRO (0x95)
            }

            Method (_Q34, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
            {
                If ((((Local1 = (HB0S & 0x0F)) == Zero) && !ACPW))
                {
                    P80H = 0x34
                    ^HKEY.MHKQ (0x2313)
                }
            }

            Method (IRDY, 0, NotSerialized)
            {
                Local0 = 0x01F4
                Local1 = 0x3C
                Local2 = Zero
                While (Local1)
                {
                    Sleep (Local0)
                    Local3 = BCHK ()
                    If (!Local3)
                    {
                        Break
                    }

                    If ((Local3 == 0x02))
                    {
                        Local2 = One
                        Break
                    }

                    Local1--
                }

                Return (Local2)
            }

            Device (HKEY)
            {
                Name (_HID, EisaId ("IBM0068"))  // _HID: Hardware ID
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }

                Method (MHKV, 0, NotSerialized)
                {
                    Return (0x0100)
                }

                Name (DHKC, Zero)
                Name (DHKB, One)
                Mutex (XDHK, 0x07)
                Name (DHKH, Zero)
                Name (DHKW, Zero)
                Name (DHKS, Zero)
                Name (DHKD, Zero)
                Name (DHKN, 0x080C)
                Name (DHKT, Zero)
                Name (DHWW, Zero)
                Method (MHKA, 0, NotSerialized)
                {
                    Return (0x07FFFFFF)
                }

                Method (MHKN, 0, NotSerialized)
                {
                    Return (DHKN) /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKN */
                }

                Method (MHKK, 1, NotSerialized)
                {
                    If (DHKC)
                    {
                        Return ((DHKN & Arg0))
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (MHKM, 2, NotSerialized)
                {
                    Acquire (XDHK, 0xFFFF)
                    If ((Arg0 > 0x20))
                    {
                        Noop
                    }
                    Else
                    {
                        Local0 = (One << Arg0--)
                        If ((Local0 & 0x00FFFFFF))
                        {
                            If (Arg1)
                            {
                                DHKN |= Local0 /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKN */
                            }
                            Else
                            {
                                DHKN &= (Local0 ^ 0xFFFFFFFF)
                            }
                        }
                        Else
                        {
                            Noop
                        }
                    }

                    Release (XDHK)
                }

                Method (MHKS, 0, NotSerialized)
                {
                    Notify (SLPB, 0x80) // Status Change
                }

                Method (MHKC, 1, NotSerialized)
                {
                    DHKC = Arg0
                }

                Method (MHKP, 0, NotSerialized)
                {
                    Acquire (XDHK, 0xFFFF)
                    If (DHWW)
                    {
                        Local1 = DHWW /* \_SB_.PCI0.LPCB.EC__.HKEY.DHWW */
                        DHWW = Zero
                    }
                    ElseIf (DHKW)
                    {
                        Local1 = DHKW /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKW */
                        DHKW = Zero
                    }
                    ElseIf (DHKD)
                    {
                        Local1 = DHKD /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKD */
                        DHKD = Zero
                    }
                    ElseIf (DHKS)
                    {
                        Local1 = DHKS /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKS */
                        DHKS = Zero
                    }
                    ElseIf (DHKT)
                    {
                        Local1 = DHKT /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKT */
                        DHKT = Zero
                    }
                    Else
                    {
                        Local1 = DHKH /* \_SB_.PCI0.LPCB.EC__.HKEY.DHKH */
                        DHKH = Zero
                    }

                    Release (XDHK)
                    Return (Local1)
                }

                Method (MHKE, 1, NotSerialized)
                {
                    DHKB = Arg0
                    Acquire (XDHK, 0xFFFF)
                    DHKH = Zero
                    DHKW = Zero
                    DHKS = Zero
                    DHKD = Zero
                    DHKT = Zero
                    DHWW = Zero
                    Release (XDHK)
                }

                Method (MHKQ, 1, NotSerialized)
                {
                    If (DHKB)
                    {
                        If (DHKC)
                        {
                            Acquire (XDHK, 0xFFFF)
                            If ((Arg0 < 0x1000)){}
                            ElseIf ((Arg0 < 0x2000))
                            {
                                DHKH = Arg0
                            }
                            ElseIf ((Arg0 < 0x3000))
                            {
                                DHKW = Arg0
                            }
                            ElseIf ((Arg0 < 0x4000))
                            {
                                DHKS = Arg0
                            }
                            ElseIf ((Arg0 < 0x5000))
                            {
                                DHKD = Arg0
                            }
                            ElseIf ((Arg0 < 0x6000))
                            {
                                DHKH = Arg0
                            }
                            ElseIf ((Arg0 < 0x7000))
                            {
                                DHKT = Arg0
                            }
                            ElseIf ((Arg0 < 0x8000))
                            {
                                DHWW = Arg0
                            }
                            Else
                            {
                            }

                            Release (XDHK)
                            Notify (HKEY, 0x80) // Status Change
                        }
                        ElseIf ((Arg0 == 0x1004))
                        {
                            Notify (SLPB, 0x80) // Status Change
                        }
                    }
                }

                Method (MHKB, 1, NotSerialized)
                {
                }

                Method (MHKD, 0, NotSerialized)
                {
                }

                Method (MHQC, 1, NotSerialized)
                {
                    If (WNTF)
                    {
                        If ((Arg0 == Zero))
                        {
                            Return (CWAC) /* \CWAC */
                        }
                        ElseIf ((Arg0 == One))
                        {
                            Return (CWAP) /* \CWAP */
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            Return (CWAT) /* \CWAT */
                        }
                        Else
                        {
                            Noop
                        }
                    }
                    Else
                    {
                        Noop
                    }

                    Return (Zero)
                }

                Method (MHGC, 0, NotSerialized)
                {
                    If (WNTF)
                    {
                        Acquire (XDHK, 0xFFFF)
                        If (CKC4 (Zero))
                        {
                            Local0 = 0x03
                        }
                        Else
                        {
                            Local0 = 0x04
                        }

                        Release (XDHK)
                        Return (Local0)
                    }
                    Else
                    {
                        Noop
                    }

                    Return (Zero)
                }

                Method (MHSC, 1, NotSerialized)
                {
                    If ((CWAC && WNTF))
                    {
                        Acquire (XDHK, 0xFFFF)
                        If (OSC4)
                        {
                            If ((Arg0 == 0x03))
                            {
                                If (!CWAS)
                                {
                                    PNTF (0x81)
                                    CWAS = One
                                }
                            }
                            ElseIf ((Arg0 == 0x04))
                            {
                                If (CWAS)
                                {
                                    PNTF (0x81)
                                    CWAS = Zero
                                }
                            }
                            Else
                            {
                                Noop
                            }
                        }

                        Release (XDHK)
                    }
                    Else
                    {
                        Noop
                    }
                }

                Method (MHKG, 0, NotSerialized)
                {
                    Return (Zero)
                }

                Method (MHST, 0, NotSerialized)
                {
                }

                Method (MHTT, 0, NotSerialized)
                {
                }

                Method (MHBT, 0, NotSerialized)
                {
                }

                Method (MHFT, 1, NotSerialized)
                {
                }

                Method (MHCT, 1, NotSerialized)
                {
                }

                Method (MMTG, 0, NotSerialized)
                {
                    Local0 = Zero
                    Local0 |= One
                    If (!MCMU)
                    {
                        Local0 |= 0x00010000
                    }

                    Return (Local0)
                }

                Method (MMTS, 1, NotSerialized)
                {
                    If ((Arg0 == 0x02))
                    {
                        MMUT = One
                    }
                    Else
                    {
                        MMUT = Zero
                    }
                }

                Name (INDV, Zero)
                Method (MHQI, 0, NotSerialized)
                {
                    If ((IPMS & One))
                    {
                        INDV |= One
                    }

                    If ((IPMS & 0x02))
                    {
                        INDV |= 0x02
                    }

                    If ((IPMS & 0x04))
                    {
                        INDV |= 0x0100
                    }

                    If ((IPMS & 0x08))
                    {
                        INDV |= 0x0200
                    }

                    If ((IPMS & 0x10))
                    {
                        INDV |= 0x04
                    }

                    INDV |= 0x0303
                    Return (INDV) /* \_SB_.PCI0.LPCB.EC__.HKEY.INDV */
                }

                Method (MHGI, 1, NotSerialized)
                {
                    Name (RETB, Buffer (0x10){})
                    CreateByteField (RETB, Zero, MHGS)
                    Local0 = (One << Arg0)
                    If ((INDV & Local0))
                    {
                        If ((Arg0 == Zero))
                        {
                            CreateField (RETB, 0x08, 0x78, BRBU)
                            BRBU = IPMB /* \IPMB */
                            MHGS = 0x10
                        }
                        ElseIf ((Arg0 == One))
                        {
                            CreateField (RETB, 0x08, 0x18, RRBU)
                            RRBU = IPMR /* \IPMR */
                            MHGS = 0x04
                        }
                        ElseIf ((Arg0 == 0x08))
                        {
                            CreateField (RETB, 0x10, 0x18, ODBU)
                            CreateByteField (RETB, One, MHGZ)
                            ODBU = IPMO /* \IPMO */
                            MHGZ |= 0x04 /* \_SB_.PCI0.LPCB.EC__.HKEY.MHGI.MHGZ */
                            If ((ODDS == Zero))
                            {
                                MHGZ |= 0x03 /* \_SB_.PCI0.LPCB.EC__.HKEY.MHGI.MHGZ */
                            }

                            MHGS = 0x05
                        }
                        ElseIf ((Arg0 == 0x09))
                        {
                            CreateField (RETB, 0x10, 0x08, AUBU)
                            AUBU = IPMA /* \IPMA */
                            RETB [One] = One
                            MHGS = 0x03
                        }
                        ElseIf ((Arg0 == 0x02))
                        {
                            Local1 = VDYN (Zero, Zero)
                            RETB [0x02] = (Local1 & 0x0F)
                            Local1 >>= 0x04
                            RETB [One] = (Local1 & 0x0F)
                            MHGS = 0x03
                        }
                    }

                    Return (RETB) /* \_SB_.PCI0.LPCB.EC__.HKEY.MHGI.RETB */
                }

                Method (MHSI, 2, NotSerialized)
                {
                    Local0 = (One << Arg0)
                    If ((INDV & Local0))
                    {
                        If ((Arg0 == 0x08))
                        {
                            Local1 = ODDP /* \_SB_.PCI0.LPCB.EC__.ODDP */
                            If (!Local1)
                            {
                                ^^^^SAT0.PRT1._EJ0 (Zero)
                                IRDY ()
                                Notify (^^^^SAT0.PRT1, One) // Device Check
                                ODDS = Zero
                            }
                        }
                    }
                }

                Mutex (BFWM, 0x07)
                Method (MHCF, 1, NotSerialized)
                {
                    Local0 = BFWC (Arg0)
                    Return (Local0)
                }

                Method (MHPF, 1, NotSerialized)
                {
                    Name (RETB, Buffer (0x25){})
                    Acquire (BFWM, 0xFFFF)
                    If ((SizeOf (Arg0) <= 0x25))
                    {
                        BFWB = Arg0
                        If (BFWP ())
                        {
                            CHKS ()
                            BFWL ()
                        }

                        RETB = BFWB /* \BFWB */
                    }

                    Release (BFWM)
                    Return (RETB) /* \_SB_.PCI0.LPCB.EC__.HKEY.MHPF.RETB */
                }

                Method (MHIF, 1, NotSerialized)
                {
                    Name (RETB, Buffer (0x0A){})
                    Acquire (BFWM, 0xFFFF)
                    BFWG (Arg0)
                    RETB = BFWB /* \BFWB */
                    Release (BFWM)
                    Return (RETB) /* \_SB_.PCI0.LPCB.EC__.HKEY.MHIF.RETB */
                }

                Method (MHDM, 1, NotSerialized)
                {
                    BDMC (Arg0)
                }

                Method (CKC4, 1, NotSerialized)
                {
                    Local0 = Zero
                    If (One)
                    {
                        If (!C4AC)
                        {
                            Local0 |= One
                        }
                    }

                    If (!(CFGD & 0x80))
                    {
                        Local0 |= 0x02
                    }

                    If ((CWAC && CWAS))
                    {
                        Local0 |= 0x04
                    }

                    If ((CWUE && CWUS))
                    {
                        Local0 |= 0x08
                    }

                    Local0 &= ~Arg0
                    Return (Local0)
                }

                Method (MHQE, 0, NotSerialized)
                {
                    Return (One)
                }

                Method (MHGE, 0, NotSerialized)
                {
                    If ((One && C4AC))
                    {
                        Return (0x04)
                    }

                    C4AC = Zero
                    PNTF (0x81)
                    Return (0x03)
                }

                Method (MHSE, 1, NotSerialized)
                {
                    If (One)
                    {
                        Local0 = C4AC /* \C4AC */
                        If ((Arg0 == 0x03))
                        {
                            C4AC = Zero
                            If (One)
                            {
                                If (One)
                                {
                                    PNTF (0x81)
                                    PNOT ()
                                }
                            }
                        }
                        ElseIf ((Arg0 == 0x04))
                        {
                            C4AC = One
                            If (One)
                            {
                                If (One)
                                {
                                    PNTF (0x81)
                                    PNOT ()
                                }
                            }
                        }
                    }
                }

                Method (PWMC, 0, NotSerialized)
                {
                    Return (One)
                }

                Method (PWMG, 0, NotSerialized)
                {
                    Local0 = PWMH /* \_SB_.PCI0.LPCB.EC__.PWMH */
                    Local0 <<= 0x08
                    Local0 |= PWML /* \_SB_.PCI0.LPCB.EC__.PWML */
                    Return (Local0)
                }

                Method (UAWO, 1, NotSerialized)
                {
                    Return (UAWS (Arg0))
                }

                Method (MHAT, 1, NotSerialized)
                {
                    If ((WNTF && One))
                    {
                        Local0 = Arg0
                        Local1 = FTPS /* \FTPS */
                        If ((Arg0 & 0x00010000))
                        {
                            FTPS = One
                        }
                        Else
                        {
                            FTPS = Zero
                        }

                        If ((FTPS ^ Local1))
                        {
                            PNTF (0x80)
                        }

                        If ((Arg0 & 0x00040000))
                        {
                            SCRM = One
                            SCRS = One
                            HFSP = 0x07
                        }
                        Else
                        {
                            SCRM = Zero
                            SCRS = Zero
                            HFSP = 0x80
                        }

                        Return (One)
                    }

                    Return (Zero)
                }

                Method (MHGT, 1, NotSerialized)
                {
                    If ((WNTF && One))
                    {
                        Local0 = 0x01000000
                        Local0 = (Arg0 | 0x00F0FF00)
                        Local0 |= 0x08000000
                        If (SCRM)
                        {
                            Local0 |= 0x10000000
                        }
                        Else
                        {
                            Local0 &= 0xEFFFFFFF
                        }

                        If (FTPS)
                        {
                            Local0 |= 0x02000000
                        }
                        Else
                        {
                            Local0 &= 0xFDFFFFFF
                        }

                        Local0 |= 0x01000000
                        Return (Local0)
                    }

                    Return (Zero)
                }

                Name (WGFL, Zero)
                Method (WLSW, 0, NotSerialized)
                {
                    Return (GSTS) /* \_SB_.PCI0.LPCB.EC__.GSTS */
                }

                Method (GBDC, 0, NotSerialized)
                {
                    Local0 = Zero
                    If (BTMD)
                    {
                        Local0 = One
                        WGFL |= 0x10
                    }
                    Else
                    {
                        WGFL &= 0xFFFFFFEF
                    }

                    If (CBCI)
                    {
                        WGFL = 0x80
                        Return (Local0)
                    }

                    If (BPWS ())
                    {
                        Local0 |= 0x02
                    }
                    Else
                    {
                        Local0 &= 0xFFFFFFFD
                    }

                    Local0 |= 0x04
                    Return (Local0)
                }

                Method (SBDC, 1, NotSerialized)
                {
                    If ((Arg0 & 0x02))
                    {
                        BPWC (One)
                    }
                    Else
                    {
                        BPWC (Zero)
                    }

                    If ((Arg0 & 0x04))
                    {
                        WGFL |= 0x40
                    }
                    Else
                    {
                        WGFL &= 0xFFFFFFFFFFFFFFBF
                    }
                }

                Method (WLPS, 0, NotSerialized)
                {
                    If (ECON)
                    {
                        Local0 = DCWL /* \_SB_.PCI0.LPCB.EC__.DCWL */
                    }
                    Else
                    {
                        Local0 = ((RBEC (0x3A) & 0x20) >> 0x06)
                    }

                    Return (Local0)
                }

                Method (WLTG, 0, NotSerialized)
                {
                    If ((WGFL & 0x0100))
                    {
                        WLPC (!WLPS ())
                    }
                }

                Method (WLPC, 1, NotSerialized)
                {
                    WANA = One
                    If ((Arg0 && (GSTS && (WGSV (One) & 0x0400))))
                    {
                        If (ECON)
                        {
                            DCWL = One
                        }
                        Else
                        {
                            MBEC (0x3A, 0xFF, 0x20)
                        }

                        GO70 = One
                        WGFL |= 0x0200
                    }
                    Else
                    {
                        If (ECON)
                        {
                            DCWL = Zero
                        }
                        Else
                        {
                            MBEC (0x3A, 0xDF, Zero)
                        }

                        GO70 = Zero
                        WGFL &= 0xFFFFFDFF
                    }
                }

                Method (WPWS, 0, NotSerialized)
                {
                    If (ECON)
                    {
                        Local0 = DCWW /* \_SB_.PCI0.LPCB.EC__.DCWW */
                    }
                    Else
                    {
                        Local0 = ((RBEC (0x3A) & 0x40) >> 0x06)
                    }

                    Return (Local0)
                }

                Method (WTGL, 0, NotSerialized)
                {
                    If ((WGFL & One))
                    {
                        WPWC (!WPWS ())
                    }
                }

                Method (WPWC, 1, NotSerialized)
                {
                    WWNA = One
                    If ((Arg0 && (GSTS && (WGSV (One) & 0x04))))
                    {
                        If (ECON)
                        {
                            DCWW = One
                        }
                        Else
                        {
                            MBEC (0x3A, 0xFF, 0x40)
                        }

                        GO71 = One
                        WGFL |= 0x02
                    }
                    Else
                    {
                        If (ECON)
                        {
                            DCWW = Zero
                        }
                        Else
                        {
                            MBEC (0x3A, 0xBF, Zero)
                        }

                        GO71 = Zero
                        WGFL &= 0xFFFFFFFD
                    }

                    WALA = DCWW /* \_SB_.PCI0.LPCB.EC__.DCWW */
                }

                Method (BPWS, 0, NotSerialized)
                {
                    If (ECON)
                    {
                        Local0 = DCBD /* \_SB_.PCI0.LPCB.EC__.DCBD */
                    }
                    Else
                    {
                        Local0 = ((RBEC (0x3A) & 0x10) >> 0x04)
                    }

                    Return (Local0)
                }

                Method (BTGL, 0, NotSerialized)
                {
                    If ((WGFL & 0x10))
                    {
                        BPWC (!BPWS ())
                    }
                }

                Method (BPWC, 1, NotSerialized)
                {
                    BTHA = One
                    If ((Arg0 && ((WGFL & 0x10) && !(WGFL & 0x80
                        ))))
                    {
                        If (ECON)
                        {
                            DCBD = One
                            GO35 = DCBD /* \_SB_.PCI0.LPCB.EC__.DCBD */
                        }
                        Else
                        {
                            MBEC (0x3A, 0xFF, 0x10)
                        }

                        WGFL |= 0x20
                        BLTH (0x02)
                    }
                    Else
                    {
                        If (ECON)
                        {
                            DCBD = Zero
                            GO35 = DCBD /* \_SB_.PCI0.LPCB.EC__.DCBD */
                        }
                        Else
                        {
                            MBEC (0x3A, 0xEF, Zero)
                        }

                        WGFL &= Zero
                        BLTH (0x03)
                    }
                }

                Method (WGPS, 1, NotSerialized)
                {
                    If ((Arg0 >= 0x04))
                    {
                        BLTH (0x05)
                    }

                    If (!(WGFL & 0x04))
                    {
                        WPWC (Zero)
                    }

                    If (!(WGFL & 0x40))
                    {
                        BPWC (Zero)
                    }
                }

                Method (WGWK, 1, NotSerialized)
                {
                    If ((WGFL & 0x20))
                    {
                        BPWC (One)
                    }

                    If ((WGFL & 0x02))
                    {
                        WPWC (One)
                    }
                }

                Method (GUWB, 0, NotSerialized)
                {
                    Local0 = Zero
                    If ((WGFL & 0x0100))
                    {
                        Local0 |= One
                    }

                    If (UPWS ())
                    {
                        Local0 |= 0x02
                    }

                    Return (Local0)
                }

                Method (SUWB, 1, NotSerialized)
                {
                    If ((Arg0 & 0x02))
                    {
                        UPWC (One)
                    }
                    Else
                    {
                        UPWC (Zero)
                    }
                }

                Method (UPWS, 0, NotSerialized)
                {
                    If (ECON)
                    {
                        Local0 = HUWB /* \_SB_.PCI0.LPCB.EC__.HUWB */
                    }
                    Else
                    {
                        Local0 = ((RBEC (0x31) & 0x04) >> 0x02)
                    }

                    Return (Local0)
                }

                Method (UPWC, 1, NotSerialized)
                {
                    If ((Arg0 && (WGFL & 0x0100)))
                    {
                        If (ECON)
                        {
                            HUWB = One
                        }
                        Else
                        {
                            MBEC (0x31, 0xFF, 0x04)
                        }

                        WGFL |= 0x0200
                    }
                    Else
                    {
                        If (ECON)
                        {
                            HUWB = Zero
                        }
                        Else
                        {
                            MBEC (0x31, 0xFB, Zero)
                        }

                        WGFL &= 0xFFFFFFFFFFFFFDFF
                    }
                }

                Method (TVLG, 0, NotSerialized)
                {
                    Local0 = Zero
                    Return (Local0)
                }

                Method (TVLS, 1, NotSerialized)
                {
                    Local0 = Zero
                    Local0 = Arg0
                    Local0 &= 0x02
                    If (Local0)
                    {
                        Local0 = Arg0
                        Local0 &= One
                        If (Local0)
                        {
                            Local0 = Arg0
                            Local0 &= 0xFF00
                            Local0 >>= 0x08
                            If ((Local0 == Zero)){}
                            If ((Local0 == One)){}
                            If ((Local0 == 0x02)){}
                        }
                        Else
                        {
                        }
                    }
                    Else
                    {
                    }
                }

                Method (GLSI, 0, NotSerialized)
                {
                }

                Method (NUMG, 0, NotSerialized)
                {
                    Local0 = One
                    If (NUMK)
                    {
                        If (SNLC)
                        {
                            Local0 = 0x0101
                        }
                        Else
                        {
                            Local0 = 0x0103
                        }
                    }
                    ElseIf (SNLC)
                    {
                        Local0 = One
                    }
                    Else
                    {
                        Local0 = 0x03
                    }

                    Return (Local0)
                }

                Method (HKS3, 0, NotSerialized)
                {
                    If (GSTS)
                    {
                        If (WANP)
                        {
                            If (DCWW)
                            {
                                GO71 = One
                            }
                            Else
                            {
                                GO71 = Zero
                            }
                        }
                        Else
                        {
                            GO71 = Zero
                            DCWW = Zero
                        }

                        If (WLNP)
                        {
                            If (WOFF)
                            {
                                GO70 = Zero
                            }
                            ElseIf (DCWL)
                            {
                                GO70 = One
                            }
                            Else
                            {
                                GO70 = Zero
                            }
                        }
                        Else
                        {
                            GO70 = Zero
                            DCWL = Zero
                        }
                    }
                    Else
                    {
                        GO70 = Zero
                    }
                }
            }

            Method (DKID, 0, NotSerialized)
            {
                Local0 = GI02 /* \GI02 */
                Local1 = GI03 /* \GI03 */
                Local2 = GI04 /* \GI04 */
                Local0 |= (Local1 << One)
                Local0 |= (Local2 << 0x02)
                Return (Local0)
            }

            Method (GDKS, 0, NotSerialized)
            {
                Local0 = Zero
                If ((DOKI == One))
                {
                    Local0 |= One
                    Local1 = DKID ()
                    Local1 <<= 0x08
                    Local0 |= Local1
                }

                Return (Local0)
            }

            Method (WGDS, 0, NotSerialized)
            {
                Local0 = Zero
                If ((DOKI == One))
                {
                    Local0 |= One
                }

                Local1 = DKID ()
                Local1 <<= 0x08
                Local0 |= Local1
                Return (Local0)
            }
        }
    }

    Scope (_SB)
    {
        Device (ACAD)
        {
            Name (_HID, "ACPI0003" /* Power Source Device */)  // _HID: Hardware ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                If (ECON)
                {
                    ACST = ^^PCI0.LPCB.EC.ACPW /* \_SB_.PCI0.LPCB.EC__.ACPW */
                    Sleep (0x64)
                    UCMS (0x13)
                    PWRS = ^^PCI0.LPCB.EC.ACPW /* \_SB_.PCI0.LPCB.EC__.ACPW */
                }

                Return (PWRS) /* \PWRS */
            }
        }
    }

    Scope (_SB)
    {
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
                    Return (0xFFFFFFFF)
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
            Arg2 = TIDX /* \_SB_.GBFE.TIDX */
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
                    /* 0000 */  0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // 0.......
                    /* 0008 */  0x00                                             // .
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

        Method (WAEC, 0, NotSerialized)
        {
            Name (CUNT, 0x14)
            While ((^PCI0.LPCB.EC.HSID == Zero))
            {
                Sleep (0x05)
                CUNT--
                If ((CUNT == Zero))
                {
                    Break
                }
            }
        }

        Mutex (BATM, 0x07)
        Method (GBIF, 3, NotSerialized)
        {
            Acquire (BATM, 0xFFFF)
            If (Arg2)
            {
                ^PCI0.LPCB.EC.HIID = (Arg0 | One)
                WAEC ()
                Local7 = ^PCI0.LPCB.EC.SBCM /* \_SB_.PCI0.LPCB.EC__.SBCM */
                Arg1 [Zero] = (Local7 ^ One)
                ^PCI0.LPCB.EC.HIID = Arg0
                WAEC ()
                If (Local7)
                {
                    Arg1 [0x02] = (^PCI0.LPCB.EC.SBFC * 0x0A)
                }
                Else
                {
                    Arg1 [0x02] = ^PCI0.LPCB.EC.SBFC /* \_SB_.PCI0.LPCB.EC__.SBFC */
                }

                ^PCI0.LPCB.EC.HIID = (Arg0 | 0x02)
                WAEC ()
                If (Local7)
                {
                    Local0 = (^PCI0.LPCB.EC.SBDC * 0x0A)
                }
                Else
                {
                    Local0 = ^PCI0.LPCB.EC.SBDC /* \_SB_.PCI0.LPCB.EC__.SBDC */
                }

                Arg1 [One] = Local0
                Divide (Local0, 0x14, Local1, Arg1 [0x05])
                Divide (Local0, 0x64, Local1, Arg1 [0x06])
                Arg1 [0x04] = ^PCI0.LPCB.EC.SBDV /* \_SB_.PCI0.LPCB.EC__.SBDV */
                Local0 = ^PCI0.LPCB.EC.SBSN /* \_SB_.PCI0.LPCB.EC__.SBSN */
                Name (SERN, Buffer (0x06)
                {
                    "     "
                })
                Local2 = 0x04
                While (Local0)
                {
                    Divide (Local0, 0x0A, Local1, Local0)
                    SERN [Local2] = (Local1 + 0x30)
                    Local2--
                }

                Arg1 [0x0A] = SERN /* \_SB_.GBIF.SERN */
                ^PCI0.LPCB.EC.HIID = (Arg0 | 0x06)
                WAEC ()
                Arg1 [0x09] = ^PCI0.LPCB.EC.SBDN /* \_SB_.PCI0.LPCB.EC__.SBDN */
                ^PCI0.LPCB.EC.HIID = (Arg0 | 0x04)
                WAEC ()
                Name (BTYP, Buffer (0x05)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00                     // .....
                })
                BTYP = ^PCI0.LPCB.EC.SBCH /* \_SB_.PCI0.LPCB.EC__.SBCH */
                Arg1 [0x0B] = BTYP /* \_SB_.GBIF.BTYP */
                ^PCI0.LPCB.EC.HIID = (Arg0 | 0x05)
                WAEC ()
                Arg1 [0x0C] = ^PCI0.LPCB.EC.SBMN /* \_SB_.PCI0.LPCB.EC__.SBMN */
            }
            Else
            {
                Arg1 [One] = 0xFFFFFFFF
                Arg1 [0x05] = Zero
                Arg1 [0x06] = Zero
                Arg1 [0x02] = 0xFFFFFFFF
            }

            Release (BATM)
            Return (Arg1)
        }

        Method (GBST, 4, NotSerialized)
        {
            If (^PCI0.LPCB.EC.BFUD)
            {
                PHSR (0x83)
            }

            Acquire (BATM, 0xFFFF)
            If ((Arg1 & 0x20))
            {
                Local0 = 0x02
            }
            ElseIf ((Arg1 & 0x40))
            {
                Local0 = One
            }
            Else
            {
                Local0 = Zero
            }

            If ((Arg1 & 0x0F)){}
            Else
            {
                Local0 |= 0x04
            }

            If (((Arg1 & 0x0F) == 0x0F))
            {
                Local0 = 0x04
                Local1 = Zero
                Local2 = Zero
                Local3 = Zero
            }
            Else
            {
                ^PCI0.LPCB.EC.HIID = Arg0
                WAEC ()
                Local3 = ^PCI0.LPCB.EC.SBVO /* \_SB_.PCI0.LPCB.EC__.SBVO */
                If (Arg2)
                {
                    Local2 = (^PCI0.LPCB.EC.SBRC * 0x0A)
                }
                Else
                {
                    Local2 = ^PCI0.LPCB.EC.SBRC /* \_SB_.PCI0.LPCB.EC__.SBRC */
                }

                Local1 = ^PCI0.LPCB.EC.SBAC /* \_SB_.PCI0.LPCB.EC__.SBAC */
                If ((Local1 >= 0x8000))
                {
                    If ((Local0 & One))
                    {
                        Local1 = (0x00010000 - Local1)
                    }
                    Else
                    {
                        Local1 = Zero
                    }
                }
                ElseIf (!(Local0 & 0x02))
                {
                    Local1 = Zero
                }

                If (Arg2)
                {
                    Local1 *= Local3
                    Divide (Local1, 0x03E8, Local7, Local1)
                }
            }

            Arg3 [Zero] = Local0
            Arg3 [One] = Local1
            Arg3 [0x02] = Local2
            Arg3 [0x03] = Local3
            Release (BATM)
            Return (Arg3)
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A") /* Control Method Battery */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
            Name (B0ST, Zero)
            Name (BT0I, Package (0x0D)
            {
                Zero, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                One, 
                0x2A30, 
                Zero, 
                Zero, 
                One, 
                One, 
                "", 
                "", 
                "", 
                ""
            })
            Name (BT0P, Package (0x04){})
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (ECON)
                {
                    B0ST = ^^PCI0.LPCB.EC.MBTS /* \_SB_.PCI0.LPCB.EC__.MBTS */
                }
                ElseIf ((RBEC (0x38) & 0x80))
                {
                    B0ST = One
                }
                Else
                {
                    B0ST = Zero
                }

                If (B0ST)
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
                Local7 = Zero
                Local6 = 0x01F4
                While ((!Local7 && Local6))
                {
                    If (^^PCI0.LPCB.EC.MBTS)
                    {
                        If (((^^PCI0.LPCB.EC.HB0S & 0x0F) == 0x0F))
                        {
                            Sleep (0x14)
                            Local6--
                        }
                        Else
                        {
                            Local7 = One
                        }
                    }
                    Else
                    {
                        Local6 = Zero
                    }
                }

                Return (GBIF (Zero, BT0I, Local7))
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Local0 = (DerefOf (BT0I [Zero]) ^ One)
                Return (GBST (Zero, ^^PCI0.LPCB.EC.HB0S, Local0, BT0P))
            }

            Method (_BTP, 1, NotSerialized)  // _BTP: Battery Trip Point
            {
                ^^PCI0.LPCB.EC.HAM4 &= 0xEF
                If (Arg0)
                {
                    Local1 = Arg0
                    If (!DerefOf (BT0I [Zero]))
                    {
                        Divide (Local1, 0x0A, Local0, Local1)
                    }

                    ^^PCI0.LPCB.EC.HT0L = (Local1 & 0xFF)
                    ^^PCI0.LPCB.EC.HT0H = ((Local1 >> 0x08) & 0xFF)
                    ^^PCI0.LPCB.EC.HAM4 |= 0x10
                }
            }
        }
    }

    Scope (_SB)
    {
        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D") /* Lid Device */)  // _HID: Hardware ID
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x18, 
                0x03
            })
            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                If (ECON)
                {
                    Local0 = ^^PCI0.LPCB.EC.HPLD /* \_SB_.PCI0.LPCB.EC__.HPLD */
                    LIDW = ^^PCI0.LPCB.EC.HPLD /* \_SB_.PCI0.LPCB.EC__.HPLD */
                    If (((OSYS > 0x07D0) && (OSYS < 0x07D6)))
                    {
                        ^^PCI0.GFX0.GLID (Local0)
                    }
                    Else
                    {
                        ^^PCI0.GFX0.CLID = Local0
                    }

                    Return (Local0)
                }
                ElseIf ((RBEC (0x46) & 0x04))
                {
                    Return (One)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
                If (ECON)
                {
                    If (Arg0)
                    {
                        LIDX = One
                    }
                    Else
                    {
                    }
                }
                ElseIf (Arg0)
                {
                    MBEC (0x32, 0xFF, 0x04)
                }
                Else
                {
                    MBEC (0x32, 0xFB, Zero)
                }
            }
        }
    }

    Scope (_SB)
    {
        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (Package (0x02)
                {
                    0x18, 
                    0x03
                })
            }

            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
            }
        }

        Device (WMI1)
        {
            Name (_HID, "PNP0C14" /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (CMBF, Buffer (0x03)
            {
                 0x00, 0x00, 0x00                                 // ...
            })
            Name (BUF1, Buffer (0x40)
            {
                /* 0000 */  0x01, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0xFF, 0xFF,  // ........
                /* 0008 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0010 */  0xFF, 0xFF, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF,  // ........
                /* 0018 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0020 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0028 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0030 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0038 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF   // ........
            })
            Name (BUF2, Buffer (0x40)
            {
                /* 0000 */  0x02, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0008 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0010 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0018 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0020 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0028 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0030 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,  // ........
                /* 0038 */  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF   // ........
            })
            Name (INBF, Buffer (0x80)
            {
                /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0010 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0020 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0028 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0030 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0038 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0040 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0048 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0050 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0058 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0060 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0068 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0070 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0078 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
            })
            CreateByteField (CMBF, Zero, EVID)
            CreateByteField (CMBF, One, ACID)
            CreateByteField (CMBF, 0x02, DA01)
            CreateByteField (BUF1, One, EID1)
            CreateByteField (BUF1, 0x02, ERQ0)
            CreateByteField (BUF1, 0x03, BRIL)
            CreateByteField (BUF1, 0x04, SKEY)
            CreateByteField (BUF1, 0x08, BLUE)
            CreateByteField (BUF1, 0x09, WLAN)
            CreateByteField (BUF1, 0x0A, WL3G)
            CreateByteField (BUF1, 0x0B, WMAX)
            CreateByteField (BUF1, 0x0C, GLSW)
            CreateByteField (BUF1, 0x10, TPST)
            CreateByteField (BUF1, 0x11, SLMD)
            CreateByteField (BUF1, 0x12, SBR0)
            CreateByteField (BUF1, 0x13, SBR1)
            CreateByteField (BUF1, 0x14, SBR2)
            CreateByteField (BUF1, 0x15, SBBR)
            CreateByteField (BUF1, 0x16, SBLI)
            CreateByteField (BUF1, 0x17, TBMD)
            CreateByteField (BUF1, 0x18, RTAG)
            CreateByteField (BUF1, 0x19, DKST)
            CreateByteField (BUF1, 0x1A, DKID)
            CreateWordField (BUF1, 0x19, DKDA)
            CreateBitField (BUF1, 0x10, AP00)
            CreateBitField (BUF1, 0x11, AP01)
            CreateBitField (BUF1, 0x12, AP02)
            CreateBitField (BUF1, 0x13, AP03)
            CreateBitField (BUF1, 0x14, AP04)
            CreateBitField (BUF1, 0x15, AP05)
            CreateBitField (BUF1, 0x16, AP06)
            CreateBitField (BUF1, 0x17, AP07)
            CreateWordField (BUF1, 0x20, GSRX)
            CreateWordField (BUF1, 0x22, GSRY)
            CreateWordField (BUF1, 0x24, GSRZ)
            CreateByteField (BUF1, 0x20, PD00)
            CreateByteField (BUF1, 0x21, PD01)
            CreateByteField (BUF1, 0x22, PD02)
            CreateByteField (BUF1, 0x23, PD03)
            CreateByteField (BUF1, 0x24, PD04)
            CreateByteField (BUF1, 0x25, PD05)
            CreateByteField (BUF1, 0x26, PD06)
            CreateByteField (BUF1, 0x27, PD07)
            CreateByteField (BUF2, One, EID2)
            CreateByteField (BUF2, 0x08, BIV0)
            CreateByteField (BUF2, 0x09, BIV1)
            CreateByteField (BUF2, 0x0A, BIV2)
            CreateByteField (BUF2, 0x0B, BIV3)
            CreateByteField (BUF2, 0x0C, BIV4)
            CreateByteField (BUF2, 0x0D, BIV5)
            CreateByteField (BUF2, 0x0E, BIV6)
            CreateByteField (BUF2, 0x0F, BIV7)
            CreateByteField (BUF2, 0x10, WMIV)
            CreateByteField (BUF2, 0x18, BRMX)
            CreateByteField (BUF2, 0x20, BAT1)
            CreateByteField (BUF2, 0x21, BAT2)
            CreateByteField (BUF2, 0x22, ACDC)
            CreateByteField (BUF2, 0x23, CPUT)
            CreateByteField (BUF2, 0x24, VGAT)
            CreateByteField (BUF2, 0x25, CDT1)
            CreateByteField (BUF2, 0x26, CDT2)
            CreateByteField (BUF2, 0x27, FSP1)
            CreateByteField (BUF2, 0x28, FSP2)
            CreateByteField (BUF2, 0x2A, BOR0)
            CreateByteField (BUF2, 0x2B, BOR1)
            CreateByteField (BUF2, 0x2C, BOR2)
            CreateByteField (BUF2, 0x2D, BOR3)
            CreateByteField (BUF2, 0x2E, BOR4)
            CreateByteField (BUF2, 0x2F, BOR5)
            CreateByteField (INBF, Zero, BY00)
            CreateByteField (INBF, One, BY01)
            CreateByteField (INBF, 0x02, BY02)
            CreateByteField (INBF, 0x03, BY03)
            CreateByteField (INBF, 0x04, BY04)
            CreateByteField (INBF, 0x05, BY05)
            CreateByteField (INBF, 0x06, BY06)
            CreateByteField (INBF, 0x07, BY07)
            CreateByteField (INBF, 0x08, BY08)
            CreateByteField (INBF, 0x09, BY09)
            CreateByteField (INBF, 0x0A, BY10)
            CreateByteField (INBF, 0x0B, BY11)
            CreateByteField (INBF, 0x0C, BY12)
            CreateByteField (INBF, 0x0D, BY13)
            CreateByteField (INBF, 0x0E, BY14)
            CreateByteField (INBF, 0x0F, BY15)
            CreateByteField (INBF, 0x10, BY16)
            CreateByteField (INBF, 0x11, BY17)
            CreateByteField (INBF, 0x12, BY18)
            CreateByteField (INBF, 0x13, BY19)
            CreateByteField (INBF, 0x14, BY20)
            CreateByteField (INBF, 0x15, BY21)
            CreateByteField (INBF, 0x16, BY22)
            CreateByteField (INBF, 0x17, BY23)
            CreateByteField (INBF, 0x18, BY24)
            CreateByteField (INBF, 0x19, BY25)
            CreateByteField (INBF, 0x1A, BY26)
            CreateByteField (INBF, 0x1B, BY27)
            CreateByteField (INBF, 0x1C, BY28)
            CreateByteField (INBF, 0x1D, BY29)
            CreateByteField (INBF, 0x1E, BY30)
            CreateByteField (INBF, 0x1F, BY31)
            CreateWordField (INBF, 0x10, BGTX)
            CreateWordField (INBF, 0x12, BGTY)
            CreateWordField (INBF, 0x14, BGTZ)
            Name (GSTH, Buffer (0x06)
            {
                 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF               // ......
            })
            CreateWordField (GSTH, Zero, GSTX)
            CreateWordField (GSTH, 0x02, GSTY)
            CreateWordField (GSTH, 0x04, GSTZ)
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                BIV0 = 0x38
                BIV1 = 0x31
                BIV2 = 0x45
                BIV3 = 0x54
                BIV4 = 0x30
                BIV5 = 0x31
                BIV6 = 0x54
                BIV7 = 0x31
                WMIV = 0x12
            }

            Name (_WDG, Buffer (0x3C)
            {
                /* 0000 */  0x20, 0x0F, 0xBC, 0xAB, 0xA1, 0x8E, 0xD1, 0x11,  //  .......
                /* 0008 */  0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10, 0x00, 0x00,  // ....)...
                /* 0010 */  0x80, 0x00, 0x01, 0x08, 0x40, 0x0F, 0xBC, 0xAB,  // ....@...
                /* 0018 */  0xA1, 0x8E, 0xD1, 0x11, 0x00, 0xA0, 0xC9, 0x06,  // ........
                /* 0020 */  0x29, 0x10, 0x00, 0x00, 0x49, 0x4F, 0x01, 0x01,  // )...IO..
                /* 0028 */  0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11,  // !...f...
                /* 0030 */  0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10,  // ......).
                /* 0038 */  0x41, 0x45, 0x01, 0x00                           // AE..
            })
            Method (WQIO, 1, NotSerialized)
            {
                Debug = "======== WMI WQIO ========"
                CMD1 (One, 0x02)
                CMD1 (0x02, 0x02)
                WMIS (Zero)
                BOR0 = WLS0 /* \WLS0 */
                BOR1 = WLS1 /* \WLS1 */
                BOR2 = WLS2 /* \WLS2 */
                BOR3 = WLS3 /* \WLS3 */
                BOR4 = WLS4 /* \WLS4 */
                BOR5 = WLS5 /* \WLS5 */
                Concatenate (BUF2, BUF1, Local0)
                Return (Local0)
            }

            Mutex (MSIO, 0x00)
            Method (WSIO, 2, Serialized)
            {
                Debug = "======== WMI WSIO ========"
                Acquire (MSIO, 0xFFFF)
                CPSR (Arg1)
                Release (MSIO)
            }

            Method (CPSR, 1, NotSerialized)
            {
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler, x=0-9, A-Z
                INBF = Arg0
                _T_0 = BY00 /* \_SB_.WMI1.BY00 */
                If ((_T_0 == One))
                {
                    If ((BY01 != 0x10))
                    {
                        Return (Zero)
                    }
                }
                Else
                {
                    Return (Zero)
                }

                GSTX = BGTX /* \_SB_.WMI1.BGTX */
                GSTY = BGTY /* \_SB_.WMI1.BGTY */
                GSTZ = BGTZ /* \_SB_.WMI1.BGTZ */
                CMD0 (BY08, BY09, BY10, BY11, BY16)
            }

            Method (_WED, 1, NotSerialized)  // _Wxx: Wake Event, xx=0x00-0xFF
            {
                Return (UWED (EVID, ACID, DA01))
            }

            Method (CMD1, 2, NotSerialized)
            {
                CMD0 (Arg0, Arg1, Zero, Zero, Zero)
            }

            Method (CMD2, 3, NotSerialized)
            {
                CMD0 (Arg0, Arg1, Arg2, Zero, Zero)
            }

            Method (CMD3, 1, NotSerialized)
            {
                CMD0 (0x19, One, One, One, Arg0)
            }

            Mutex (MCD0, 0x00)
            Method (CMD0, 5, Serialized)
            {
                If ((ERQ0 && (Arg2 == One)))
                {
                    EVID = Arg0
                    ACID = Arg1
                    DA01 = Arg4
                    Notify (WMI1, 0x80) // Status Change
                }
                Else
                {
                    Acquire (MCD0, 0xFFFF)
                    UWED (Arg0, Arg1, Arg4)
                    Release (MCD0)
                }
            }

            Method (UWED, 3, NotSerialized)
            {
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler, x=0-9, A-Z
                _T_0 = Arg0
                If ((_T_0 == One))
                {
                    EID1 = Arg0
                    DKDA = ^^PCI0.LPCB.EC.WGDS ()
                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x02))
                {
                    EID2 = Arg0
                    Return (BUF2) /* \_SB_.WMI1.BUF2 */
                }
                ElseIf ((_T_0 == 0x08))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP00 = One
                    }
                    Else
                    {
                        AP00 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x09))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP01 = One
                    }
                    Else
                    {
                        AP01 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x0A))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP02 = One
                    }
                    Else
                    {
                        AP02 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x0B))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP03 = One
                    }
                    Else
                    {
                        AP03 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x0C))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP04 = One
                    }
                    Else
                    {
                        AP04 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x0D))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP05 = One
                    }
                    Else
                    {
                        AP05 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x0E))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP06 = One
                    }
                    Else
                    {
                        AP06 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x0F))
                {
                    EID1 = Arg0
                    If (Arg2)
                    {
                        AP07 = One
                    }
                    Else
                    {
                        AP07 = Zero
                    }

                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x2E))
                {
                    EID1 = Arg0
                    DKDA = ^^PCI0.LPCB.EC.WGDS ()
                    Return (BUF1) /* \_SB_.WMI1.BUF1 */
                }
                ElseIf ((_T_0 == 0x31))
                {
                    WLS0 = BY26 /* \_SB_.WMI1.BY26 */
                    WLS1 = BY27 /* \_SB_.WMI1.BY27 */
                    WLS2 = BY28 /* \_SB_.WMI1.BY28 */
                    WLS3 = BY29 /* \_SB_.WMI1.BY29 */
                    WLS4 = BY30 /* \_SB_.WMI1.BY30 */
                    WLS5 = BY31 /* \_SB_.WMI1.BY31 */
                    WMIS (One)
                }
                Else
                {
                }
            }

            Name (WQAE, Buffer (0x02CB)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
                /* 0008 */  0xBB, 0x02, 0x00, 0x00, 0x3C, 0x09, 0x00, 0x00,  // ....<...
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
                /* 0018 */  0x18, 0x5E, 0x84, 0x00, 0x01, 0x06, 0x18, 0x42,  // .^.....B
                /* 0020 */  0x10, 0x05, 0x10, 0x8A, 0x23, 0x81, 0x42, 0x04,  // ....#.B.
                /* 0028 */  0x8A, 0x40, 0xA4, 0x00, 0x30, 0x28, 0x0D, 0x20,  // .@..0(. 
                /* 0030 */  0x92, 0x03, 0x21, 0x17, 0x4C, 0x4C, 0x00, 0xB7,  // ..!.LL..
                /* 0038 */  0x04, 0x78, 0x15, 0x60, 0x53, 0x80, 0x49, 0x10,  // .x.`S.I.
                /* 0040 */  0xF5, 0xEF, 0x0F, 0x51, 0x12, 0x1C, 0x4A, 0x08,  // ...Q..J.
                /* 0048 */  0x84, 0x24, 0x0A, 0x30, 0x2F, 0x40, 0xB7, 0x00,  // .$.0/@..
                /* 0050 */  0xC3, 0x02, 0x6C, 0x0B, 0x30, 0x2D, 0xC0, 0x31,  // ..l.0-.1
                /* 0058 */  0x24, 0x95, 0x06, 0x4E, 0x09, 0x2C, 0x05, 0x42,  // $..N.,.B
                /* 0060 */  0x42, 0x05, 0x28, 0x17, 0xE0, 0x5B, 0x80, 0x76,  // B.(..[.v
                /* 0068 */  0x44, 0x49, 0x16, 0x60, 0x19, 0x46, 0x04, 0x1E,  // DI.`.F..
                /* 0070 */  0x05, 0x43, 0xE3, 0xD0, 0xD8, 0x61, 0x58, 0x26,  // .C...aX&
                /* 0078 */  0x98, 0x06, 0x71, 0x18, 0x65, 0x23, 0x8B, 0xC0,  // ..q.e#..
                /* 0080 */  0xB8, 0x9D, 0x0A, 0x90, 0x2B, 0x40, 0x98, 0x00,  // ....+@..
                /* 0088 */  0xF1, 0xA8, 0xC2, 0x68, 0x0E, 0x8A, 0x88, 0x86,  // ...h....
                /* 0090 */  0x46, 0x89, 0x19, 0x13, 0x81, 0xED, 0x1C, 0x5B,  // F......[
                /* 0098 */  0xA3, 0x38, 0x95, 0xC2, 0x05, 0x48, 0xC7, 0xD0,  // .8...H..
                /* 00A0 */  0x08, 0x8E, 0xEB, 0x58, 0xB8, 0x2D, 0x01, 0x06,  // ...X.-..
                /* 00A8 */  0x05, 0x38, 0x9C, 0x8C, 0x50, 0x0A, 0x02, 0xD5,  // .8..P...
                /* 00B0 */  0x68, 0x42, 0x84, 0x0B, 0x19, 0x26, 0x44, 0xCC,  // hB...&D.
                /* 00B8 */  0x18, 0xC6, 0x3E, 0x97, 0x48, 0x07, 0x50, 0xF3,  // ..>.H.P.
                /* 00C0 */  0xC8, 0x08, 0xD2, 0xB1, 0x05, 0x8A, 0x15, 0x22,  // ......."
                /* 00C8 */  0xC1, 0x11, 0x1D, 0x0A, 0x46, 0x06, 0x84, 0x3C,  // ....F..<
                /* 00D0 */  0x0B, 0xB0, 0x3E, 0x46, 0x42, 0x60, 0xF7, 0xB3,  // ..>FB`..
                /* 00D8 */  0x90, 0x42, 0x04, 0x4D, 0xE3, 0xAC, 0x6A, 0x14,  // .B.M..j.
                /* 00E0 */  0xA0, 0x0C, 0x43, 0x43, 0x29, 0x4E, 0x80, 0x45,  // ..CC)N.E
                /* 00E8 */  0x2C, 0x19, 0x43, 0x11, 0x44, 0x84, 0xB3, 0x8A,  // ,.C.D...
                /* 00F0 */  0x62, 0xB0, 0x08, 0xA1, 0xE2, 0x19, 0xF5, 0xFC,  // b.......
                /* 00F8 */  0x82, 0xD4, 0x06, 0x2B, 0x90, 0x68, 0xC1, 0x8C,  // ...+.h..
                /* 0100 */  0xC0, 0xEC, 0x0F, 0x82, 0xC4, 0x7F, 0x17, 0xE8,  // ........
                /* 0108 */  0x44, 0xE0, 0x48, 0xA3, 0x41, 0x9D, 0x02, 0x12,  // D.H.A...
                /* 0110 */  0x3C, 0x15, 0x78, 0x7A, 0x07, 0xE6, 0x51, 0x19,  // <.xz..Q.
                /* 0118 */  0xE4, 0x4C, 0xCF, 0xAC, 0xCE, 0xE3, 0x00, 0x19,  // .L......
                /* 0120 */  0x38, 0xC3, 0x4A, 0xD0, 0xC1, 0xF9, 0x00, 0x8A,  // 8.J.....
                /* 0128 */  0x6B, 0x40, 0xFD, 0xFF, 0x2F, 0x06, 0x8F, 0x05,  // k@../...
                /* 0130 */  0x6C, 0x94, 0xE1, 0x30, 0x43, 0xF4, 0x4C, 0xC3,  // l..0C.L.
                /* 0138 */  0x9D, 0xC0, 0x21, 0x32, 0x40, 0x8F, 0xE8, 0x89,  // ..!2@...
                /* 0140 */  0x00, 0x3B, 0xB5, 0x93, 0x39, 0xFD, 0x52, 0x05,  // .;..9.R.
                /* 0148 */  0x98, 0x9D, 0xBD, 0x26, 0x99, 0xE0, 0x78, 0x7C,  // ...&..x|
                /* 0150 */  0x0E, 0xF0, 0x7C, 0x4E, 0x38, 0x81, 0xE5, 0x0F,  // ..|N8...
                /* 0158 */  0x02, 0x35, 0x32, 0x43, 0x7B, 0xA4, 0xA7, 0xF5,  // .52C{...
                /* 0160 */  0x3A, 0xE0, 0x83, 0x80, 0x09, 0x2C, 0xF6, 0x30,  // :....,.0
                /* 0168 */  0x41, 0xC7, 0x03, 0x7E, 0xC5, 0x37, 0x03, 0x21,  // A..~.7.!
                /* 0170 */  0xBC, 0x33, 0x78, 0xBE, 0x86, 0xD5, 0xD9, 0x42,  // .3x....B
                /* 0178 */  0x46, 0x56, 0xE1, 0xF1, 0xD0, 0xA3, 0x84, 0x41,  // FV.....A
                /* 0180 */  0xCF, 0xE6, 0x78, 0x9E, 0x09, 0x0E, 0x36, 0xC6,  // ..x...6.
                /* 0188 */  0x2B, 0x83, 0x09, 0x1C, 0x18, 0x42, 0x16, 0x20,  // +....B. 
                /* 0190 */  0x24, 0x6A, 0xE0, 0xF4, 0x54, 0xC1, 0x4F, 0x0D,  // $j..T.O.
                /* 0198 */  0x2F, 0x17, 0x3E, 0x17, 0x3C, 0x29, 0xB0, 0xB1,  // /.>.<)..
                /* 01A0 */  0x9C, 0x92, 0xCF, 0x1D, 0x1E, 0x1A, 0x7C, 0x91,  // ......|.
                /* 01A8 */  0xA7, 0x09, 0xD0, 0x9C, 0x25, 0x30, 0xB3, 0xF2,  // ....%0..
                /* 01B0 */  0x59, 0x82, 0x0F, 0x86, 0x1F, 0x0D, 0xD8, 0xA0,  // Y.......
                /* 01B8 */  0xF8, 0x20, 0x3C, 0xD6, 0xC8, 0xC7, 0x6E, 0x81,  // . <...n.
                /* 01C0 */  0x10, 0x92, 0x35, 0x66, 0xE8, 0xF7, 0x09, 0x0F,  // ..5f....
                /* 01C8 */  0xC2, 0x47, 0x89, 0xC0, 0x0C, 0x16, 0x37, 0x66,  // .G....7f
                /* 01D0 */  0xFB, 0x15, 0x80, 0x10, 0xFA, 0x05, 0xE4, 0x24,  // .......$
                /* 01D8 */  0x9E, 0x3E, 0x22, 0x24, 0xF8, 0xFF, 0x3F, 0x70,  // .>"$..?p
                /* 01E0 */  0xB0, 0x49, 0xF1, 0x41, 0x61, 0x08, 0x3C, 0x48,  // .I.Aa.<H
                /* 01E8 */  0xFC, 0x00, 0xF8, 0x39, 0x22, 0x70, 0xEC, 0xB0,  // ...9"p..
                /* 01F0 */  0x07, 0x10, 0x3A, 0xBA, 0x87, 0xE3, 0x03, 0x49,  // ..:....I
                /* 01F8 */  0x84, 0xBA, 0x20, 0x74, 0x3A, 0x31, 0xC2, 0x01,  // .. t:1..
                /* 0200 */  0x44, 0xE9, 0xFD, 0x06, 0x40, 0x08, 0x3C, 0xCD,  // D...@.<.
                /* 0208 */  0x43, 0xC0, 0x8C, 0xD3, 0x43, 0xE0, 0x03, 0x68,  // C...C..h
                /* 0210 */  0x75, 0x76, 0x44, 0xE9, 0xA4, 0x90, 0xA3, 0xE2,  // uvD.....
                /* 0218 */  0x63, 0xC2, 0x0E, 0x80, 0x8B, 0x3C, 0xD4, 0x50,  // c....<.P
                /* 0220 */  0xD1, 0x8F, 0x02, 0xC9, 0x82, 0x41, 0x9D, 0x6B,  // .....A.k
                /* 0228 */  0x00, 0x57, 0x90, 0x8F, 0x0E, 0x60, 0xB9, 0x34,  // .W...`.4
                /* 0230 */  0xF0, 0x73, 0x43, 0xB8, 0x83, 0x08, 0x12, 0x32,  // .sC....2
                /* 0238 */  0x42, 0x98, 0x27, 0x9A, 0x78, 0x4F, 0x34, 0x9E,  // B.'.xO4.
                /* 0240 */  0x51, 0x9F, 0x07, 0x1A, 0x90, 0x0D, 0xC8, 0x07,  // Q.......
                /* 0248 */  0x1A, 0x18, 0xFF, 0xFF, 0x03, 0x0D, 0xB8, 0x22,  // ......."
                /* 0250 */  0xBE, 0x4D, 0x74, 0xF8, 0xF0, 0x81, 0x06, 0xE0,  // .Mt.....
                /* 0258 */  0x87, 0x98, 0x03, 0x0D, 0x1A, 0xDA, 0x77, 0x03,  // ......w.
                /* 0260 */  0xDF, 0x67, 0x70, 0xD1, 0x21, 0x74, 0xBA, 0xF0,  // .gp.!t..
                /* 0268 */  0x79, 0x06, 0x78, 0x00, 0xE2, 0xEF, 0x23, 0xE7,  // y.x...#.
                /* 0270 */  0xEC, 0xB9, 0x18, 0x90, 0xC9, 0x3B, 0x4D, 0x40,  // .....;M@
                /* 0278 */  0xFB, 0xFF, 0x9F, 0x26, 0xF0, 0x43, 0xF3, 0x18,  // ...&.C..
                /* 0280 */  0x4E, 0x3D, 0xD8, 0xD3, 0x96, 0xEF, 0x05, 0x3E,  // N=.....>
                /* 0288 */  0xD4, 0xC0, 0x0C, 0x70, 0xA8, 0x01, 0xDD, 0x88,  // ...p....
                /* 0290 */  0x70, 0x87, 0x1A, 0xB0, 0xC0, 0xBD, 0x69, 0xB0,  // p.....i.
                /* 0298 */  0x33, 0x0D, 0x30, 0x19, 0x01, 0x57, 0x68, 0xD3,  // 3.0..Wh.
                /* 02A0 */  0xA7, 0x46, 0xA3, 0x56, 0x0D, 0xCA, 0xD4, 0x28,  // .F.V...(
                /* 02A8 */  0xD3, 0xA0, 0x56, 0x9F, 0x4A, 0x8D, 0x19, 0x3B,  // ..V.J..;
                /* 02B0 */  0x13, 0x90, 0x37, 0x83, 0x86, 0xEA, 0x48, 0x20,  // ..7...H 
                /* 02B8 */  0x34, 0x18, 0x85, 0x40, 0x1C, 0x8A, 0x4E, 0x20,  // 4..@..N 
                /* 02C0 */  0x96, 0xE4, 0x01, 0x84, 0x09, 0x5C, 0x81, 0x40,  // .....\.@
                /* 02C8 */  0xFC, 0xFF, 0x07                                 // ...
            })
        }

        Device (WMI2)
        {
            Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_WDG, Buffer (0x3C)
            {
                /* 0000 */  0xF1, 0x24, 0xB4, 0xFC, 0x5A, 0x07, 0x0E, 0x4E,  // .$..Z..N
                /* 0008 */  0xBF, 0xC4, 0x62, 0xF3, 0xE7, 0x17, 0x71, 0xFA,  // ..b...q.
                /* 0010 */  0x41, 0x37, 0x01, 0x01, 0xE3, 0x5E, 0xBE, 0xE2,  // A7...^..
                /* 0018 */  0xDA, 0x42, 0xDB, 0x49, 0x83, 0x78, 0x1F, 0x52,  // .B.I.x.R
                /* 0020 */  0x47, 0x38, 0x82, 0x02, 0x41, 0x38, 0x01, 0x02,  // G8..A8..
                /* 0028 */  0x21, 0x12, 0x90, 0x05, 0x66, 0xD5, 0xD1, 0x11,  // !...f...
                /* 0030 */  0xB2, 0xF0, 0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10,  // ......).
                /* 0038 */  0x42, 0x42, 0x01, 0x00                           // BB..
            })
            Mutex (MWMI, 0x07)
            Name (PREL, Buffer (0x08)
            {
                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
            })
            Method (WQA7, 1, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                WMIS (0x0C)
                PREL [Zero] = LAG0 /* \LAG0 */
                PREL [One] = LAG1 /* \LAG1 */
                PREL [0x02] = LAG2 /* \LAG2 */
                PREL [0x03] = LAG3 /* \LAG3 */
                PREL [0x04] = LAG4 /* \LAG4 */
                PREL [0x05] = LAG5 /* \LAG5 */
                PREL [0x06] = LAG6 /* \LAG6 */
                PREL [0x07] = LAG7 /* \LAG7 */
                Release (MWMI)
                Return (PREL) /* \_SB_.WMI2.PREL */
            }

            Method (WMA8, 3, NotSerialized)
            {
                Acquire (MWMI, 0xFFFF)
                LAG0 = Arg2 [Zero]
                LAG1 = Arg2 [One]
                LAG2 = Arg2 [0x02]
                LAG3 = Arg2 [0x03]
                LAG4 = Arg2 [0x04]
                LAG5 = Arg2 [0x05]
                LAG6 = Arg2 [0x06]
                LAG7 = Arg2 [0x07]
                WMIS (0x0D)
                Release (MWMI)
                Return (Zero)
            }

            Name (WQBB, Buffer (0x038A)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
                /* 0008 */  0x7A, 0x03, 0x00, 0x00, 0xF0, 0x0B, 0x00, 0x00,  // z.......
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
                /* 0018 */  0x18, 0xC5, 0x85, 0x00, 0x01, 0x06, 0x18, 0x42,  // .......B
                /* 0020 */  0x10, 0x07, 0x10, 0x8A, 0x0D, 0x21, 0x02, 0x0B,  // .....!..
                /* 0028 */  0x83, 0x50, 0x50, 0x18, 0x14, 0xA0, 0x45, 0x41,  // .PP...EA
                /* 0030 */  0x88, 0x57, 0x04, 0x44, 0x0A, 0x84, 0x0C, 0x0B,  // .W.D....
                /* 0038 */  0x50, 0x2C, 0xC0, 0xB9, 0x00, 0xE9, 0x02, 0x94,  // P,......
                /* 0040 */  0xA3, 0xC8, 0x31, 0x88, 0x08, 0xDC, 0xBF, 0x3F,  // ..1....?
                /* 0048 */  0xC4, 0x40, 0x20, 0x52, 0x00, 0x21, 0xA1, 0x10,  // .@ R.!..
                /* 0050 */  0x12, 0x01, 0x4C, 0x85, 0xC0, 0x11, 0x82, 0x7E,  // ..L....~
                /* 0058 */  0x05, 0x20, 0x74, 0x28, 0x40, 0xA6, 0x00, 0x83,  // . t(@...
                /* 0060 */  0x02, 0x9C, 0x22, 0x88, 0x20, 0x4A, 0xCB, 0x02,  // ..". J..
                /* 0068 */  0x74, 0x0B, 0xF0, 0x2D, 0x40, 0x3B, 0x84, 0xD0,  // t..-@;..
                /* 0070 */  0x22, 0x57, 0x2A, 0xC0, 0x22, 0x94, 0x7C, 0x02,  // "W*.".|.
                /* 0078 */  0x4A, 0x22, 0x8A, 0x64, 0xE3, 0xC9, 0x36, 0x22,  // J".d..6"
                /* 0080 */  0x99, 0x87, 0x45, 0x0E, 0x02, 0x25, 0x66, 0x10,  // ..E..%f.
                /* 0088 */  0x28, 0x9D, 0xB8, 0xB2, 0x89, 0xAB, 0x41, 0x1C,  // (.....A.
                /* 0090 */  0x40, 0x94, 0xF3, 0x88, 0x92, 0xE0, 0xA8, 0x0E,  // @.......
                /* 0098 */  0x22, 0x42, 0xEC, 0x72, 0x05, 0x48, 0x1E, 0x80,  // "B.r.H..
                /* 00A0 */  0x34, 0x4F, 0x4C, 0xD6, 0xE7, 0xA0, 0x91, 0xB1,  // 4OL.....
                /* 00A8 */  0x11, 0xF0, 0x60, 0x12, 0x40, 0x58, 0x94, 0x75,  // ..`.@X.u
                /* 00B0 */  0x2A, 0x0A, 0x0C, 0xCA, 0x03, 0x88, 0xE4, 0x8C,  // *.......
                /* 00B8 */  0x15, 0x05, 0x6C, 0xAF, 0x13, 0x91, 0xC9, 0x81,  // ..l.....
                /* 00C0 */  0x52, 0x49, 0x70, 0xA8, 0x61, 0x7A, 0x6A, 0xCD,  // RIp.azj.
                /* 00C8 */  0x4F, 0x4C, 0x13, 0x39, 0xB5, 0xA6, 0x87, 0x2C,  // OL.9...,
                /* 00D0 */  0x48, 0x26, 0x6D, 0x28, 0xA8, 0xB1, 0x7B, 0x5A,  // H&m(..{Z
                /* 00D8 */  0x27, 0xE5, 0x99, 0x46, 0x3C, 0x28, 0xC3, 0x24,  // '..F<(.$
                /* 00E0 */  0xF0, 0x28, 0x18, 0x1A, 0x27, 0x28, 0xEB, 0x44,  // .(..'(.D
                /* 00E8 */  0x40, 0x07, 0xCA, 0x01, 0x4F, 0xC2, 0x73, 0x2C,  // @...O.s,
                /* 00F0 */  0x5E, 0x80, 0xF0, 0x11, 0x93, 0xB3, 0x40, 0x8C,  // ^.....@.
                /* 00F8 */  0x04, 0x3E, 0x13, 0x78, 0xE4, 0xC7, 0x8C, 0x1D,  // .>.x....
                /* 0100 */  0x51, 0xB8, 0x80, 0xE7, 0x73, 0x0C, 0x91, 0xE3,  // Q...s...
                /* 0108 */  0x1E, 0x6A, 0x8C, 0xA3, 0x88, 0x7C, 0x38, 0x0C,  // .j...|8.
                /* 0110 */  0xED, 0x74, 0xE3, 0x1C, 0xD8, 0xE9, 0x14, 0x04,  // .t......
                /* 0118 */  0x2E, 0x90, 0x60, 0x3D, 0xCF, 0x59, 0x20, 0xFF,  // ..`=.Y .
                /* 0120 */  0xFF, 0x18, 0x07, 0xC1, 0xF0, 0x8E, 0x01, 0x23,  // .......#
                /* 0128 */  0x03, 0x42, 0x1E, 0x05, 0x58, 0x1D, 0x96, 0x26,  // .B..X..&
                /* 0130 */  0x91, 0xC0, 0xEE, 0x05, 0x68, 0xBC, 0x04, 0x48,  // ....h..H
                /* 0138 */  0xE1, 0x20, 0xA5, 0x0C, 0x42, 0x30, 0x8D, 0x09,  // . ..B0..
                /* 0140 */  0xB0, 0x75, 0x68, 0x90, 0x37, 0x01, 0xD6, 0xAE,  // .uh.7...
                /* 0148 */  0x02, 0x42, 0x89, 0x74, 0x02, 0x71, 0x42, 0x44,  // .B.t.qBD
                /* 0150 */  0x89, 0x18, 0xD4, 0x40, 0x51, 0x6A, 0x43, 0x15,  // ...@QjC.
                /* 0158 */  0x4C, 0x67, 0xC3, 0x13, 0x66, 0xDC, 0x10, 0x31,  // Lg..f..1
                /* 0160 */  0x0C, 0x14, 0xB7, 0xFD, 0x41, 0x90, 0x61, 0xE3,  // ....A.a.
                /* 0168 */  0xC6, 0xEF, 0x41, 0x9D, 0xD6, 0xD9, 0x1D, 0xD3,  // ..A.....
                /* 0170 */  0xAB, 0x82, 0x09, 0x3C, 0xE9, 0x37, 0x84, 0xA7,  // ...<.7..
                /* 0178 */  0x83, 0xA3, 0x38, 0xDA, 0xA8, 0x31, 0x9A, 0x23,  // ..8..1.#
                /* 0180 */  0x65, 0xAB, 0x96, 0x06, 0x0E, 0x45, 0x82, 0x47,  // e....E.G
                /* 0188 */  0x9D, 0x17, 0x7C, 0x32, 0xF0, 0xD0, 0x0E, 0xDB,  // ..|2....
                /* 0190 */  0x83, 0x3D, 0x4B, 0x0F, 0xE1, 0x08, 0x9E, 0x19,  // .=K.....
                /* 0198 */  0x1E, 0x09, 0x3C, 0x06, 0x76, 0x57, 0xF0, 0x21,  // ..<.vW.!
                /* 01A0 */  0xC0, 0x67, 0x04, 0xBC, 0x6B, 0x40, 0x5D, 0x0E,  // .g..k@].
                /* 01A8 */  0x1E, 0x0D, 0xD8, 0xA4, 0xC3, 0x61, 0xC6, 0xEB,  // .....a..
                /* 01B0 */  0xB9, 0x7B, 0xEA, 0x3E, 0x63, 0xF0, 0xF3, 0x86,  // .{.>c...
                /* 01B8 */  0x07, 0x87, 0x1B, 0xE9, 0xC9, 0x1C, 0x59, 0xA9,  // ......Y.
                /* 01C0 */  0x02, 0xCC, 0x5E, 0x03, 0x74, 0x94, 0xF0, 0x81,  // ..^.t...
                /* 01C8 */  0x83, 0xDD, 0x05, 0x9E, 0x02, 0x4C, 0x60, 0xF9,  // .....L`.
                /* 01D0 */  0x83, 0x40, 0x8D, 0xCC, 0xD0, 0x1E, 0xEF, 0x7B,  // .@.....{
                /* 01D8 */  0x87, 0x21, 0x9F, 0x14, 0x0E, 0x8B, 0x89, 0x3D,  // .!.....=
                /* 01E0 */  0x78, 0xD0, 0xF1, 0x80, 0xFF, 0x3E, 0xF2, 0xA4,  // x....>..
                /* 01E8 */  0xE1, 0xE9, 0x7B, 0xBE, 0x26, 0x18, 0x18, 0x42,  // ..{.&..B
                /* 01F0 */  0x56, 0xC6, 0x83, 0x1A, 0x88, 0xA1, 0x5F, 0x15,  // V....._.
                /* 01F8 */  0x0E, 0xE3, 0x34, 0x7C, 0x02, 0xF1, 0x39, 0x20,  // ..4|..9 
                /* 0200 */  0x48, 0x8C, 0x63, 0xF2, 0xE0, 0xFC, 0xFF, 0x27,  // H.c....'
                /* 0208 */  0x70, 0xAC, 0x91, 0xD3, 0x73, 0x8A, 0xCF, 0x13,  // p...s...
                /* 0210 */  0xFC, 0x70, 0xE1, 0xF3, 0x04, 0x3B, 0x31, 0x9C,  // .p...;1.
                /* 0218 */  0xC6, 0x73, 0x80, 0x87, 0x73, 0x56, 0x3E, 0x4E,  // .s..sV>N
                /* 0220 */  0x00, 0x0B, 0x88, 0xD7, 0x09, 0x3E, 0x50, 0xF8,  // .....>P.
                /* 0228 */  0xB0, 0x87, 0xE6, 0x51, 0xBC, 0x44, 0xBC, 0x3D,  // ...Q.D.=
                /* 0230 */  0x98, 0x20, 0xDA, 0x43, 0x0C, 0x18, 0x67, 0x84,  // . .C..g.
                /* 0238 */  0x3B, 0x6F, 0xC0, 0x39, 0xC5, 0x00, 0x0F, 0xA8,  // ;o.9....
                /* 0240 */  0x43, 0xC0, 0x1C, 0x26, 0x3C, 0x04, 0x3E, 0x80,  // C..&<.>.
                /* 0248 */  0x67, 0x90, 0x73, 0xF4, 0x31, 0xE7, 0xCC, 0x70,  // g.s.1..p
                /* 0250 */  0xC7, 0x1D, 0xB0, 0x0D, 0x83, 0x47, 0xB6, 0x00,  // .....G..
                /* 0258 */  0xC2, 0xE2, 0x3C, 0x09, 0x14, 0xF0, 0x6D, 0x40,  // ..<...m@
                /* 0260 */  0x61, 0x7C, 0xB8, 0x01, 0xEF, 0xFF, 0xFF, 0x70,  // a|.....p
                /* 0268 */  0x03, 0x5C, 0xCF, 0x07, 0xB8, 0xE3, 0x03, 0xDC,  // .\......
                /* 0270 */  0x8B, 0x05, 0x3B, 0x3C, 0x3C, 0xDE, 0x00, 0x83,  // ..;<<...
                /* 0278 */  0x21, 0x3D, 0xD2, 0xBC, 0xD5, 0xC4, 0x78, 0xB5,  // !=....x.
                /* 0280 */  0x09, 0x11, 0xE1, 0xA1, 0xE6, 0xDD, 0xC6, 0x48,  // .......H
                /* 0288 */  0xF1, 0x1E, 0x6F, 0xD8, 0x35, 0xE6, 0x2C, 0x1E,  // ..o.5.,.
                /* 0290 */  0x40, 0xA2, 0x14, 0x87, 0xA6, 0x8B, 0x4D, 0x8C,  // @.....M.
                /* 0298 */  0x28, 0x6F, 0x36, 0x86, 0x7D, 0xD3, 0x31, 0x50,  // (o6.}.1P
                /* 02A0 */  0xA8, 0x48, 0x11, 0xC2, 0xBC, 0x58, 0x84, 0x78,  // .H...X.x
                /* 02A8 */  0xBC, 0x01, 0xB3, 0xA4, 0x97, 0x8A, 0x3E, 0x07,  // ......>.
                /* 02B0 */  0x3E, 0xDE, 0x00, 0x5E, 0xFE, 0xFF, 0xC7, 0x1B,  // >..^....
                /* 02B8 */  0xC0, 0xC3, 0x30, 0x7C, 0x4C, 0x01, 0xDB, 0xCD,  // ..0|L...
                /* 02C0 */  0x81, 0xDD, 0x53, 0xE0, 0x9F, 0x53, 0x00, 0x47,  // ..S..S.G
                /* 02C8 */  0x42, 0x1E, 0x01, 0x3A, 0x78, 0x58, 0x04, 0x88,  // B..:xX..
                /* 02D0 */  0x6C, 0x3C, 0x03, 0x7C, 0x26, 0xA2, 0x02, 0xA9,  // l<.|&...
                /* 02D8 */  0x34, 0x53, 0xB0, 0x8C, 0x53, 0xB0, 0x3A, 0x21,  // 4S..S.:!
                /* 02E0 */  0x72, 0x19, 0x14, 0x12, 0x01, 0xA1, 0x91, 0x19,  // r.......
                /* 02E8 */  0xCE, 0x87, 0x44, 0x83, 0x19, 0xC4, 0xE7, 0x03,  // ..D.....
                /* 02F0 */  0x9F, 0x29, 0x7C, 0x72, 0xE2, 0xFF, 0xFF, 0x93,  // .)|r....
                /* 02F8 */  0x13, 0x78, 0x0E, 0x26, 0x0F, 0x15, 0xB0, 0x10,  // .x.&....
                /* 0300 */  0x7D, 0x5A, 0xE0, 0x70, 0x3E, 0xB3, 0x70, 0x38,  // }Z.p>.p8
                /* 0308 */  0x1F, 0x49, 0xF8, 0x01, 0x92, 0x1F, 0x95, 0xC0,  // .I......
                /* 0310 */  0x25, 0xF0, 0xD0, 0x00, 0x0A, 0x20, 0xDF, 0x0F,  // %.... ..
                /* 0318 */  0x7C, 0x0E, 0x78, 0x46, 0x60, 0x73, 0x78, 0x24,  // |.xF`sx$
                /* 0320 */  0xF0, 0x81, 0x80, 0xC1, 0xF3, 0x68, 0xA3, 0xA2,  // .....h..
                /* 0328 */  0x47, 0x1B, 0x0F, 0x8F, 0x1F, 0x19, 0x3C, 0x9F,  // G.....<.
                /* 0330 */  0x07, 0x82, 0xA3, 0x7C, 0x24, 0xC0, 0x61, 0xBC,  // ...|$.a.
                /* 0338 */  0x5F, 0x78, 0x88, 0x3E, 0xE5, 0xC0, 0x9A, 0xC8,  // _x.>....
                /* 0340 */  0x51, 0x5B, 0xF4, 0x89, 0x40, 0xA0, 0xCF, 0x5C,  // Q[..@..\
                /* 0348 */  0x98, 0x53, 0x0E, 0x70, 0x52, 0x68, 0xD3, 0xA7,  // .S.pRh..
                /* 0350 */  0x46, 0xA3, 0x56, 0x0D, 0xCA, 0xD4, 0x28, 0xD3,  // F.V...(.
                /* 0358 */  0xA0, 0x56, 0x9F, 0x4A, 0x8D, 0x19, 0x33, 0x01,  // .V.J..3.
                /* 0360 */  0x25, 0x71, 0x07, 0x05, 0x2A, 0x69, 0x59, 0x1A,  // %q..*iY.
                /* 0368 */  0x97, 0x03, 0x81, 0xD0, 0x00, 0xA7, 0x4B, 0x81,  // ......K.
                /* 0370 */  0x38, 0xF4, 0x4B, 0x46, 0x80, 0x8E, 0xFB, 0x64,  // 8.KF...d
                /* 0378 */  0x12, 0x90, 0xC5, 0xAE, 0x4A, 0x20, 0x96, 0xA9,  // ....J ..
                /* 0380 */  0x02, 0xA2, 0x11, 0x10, 0x89, 0x06, 0x11, 0x90,  // ........
                /* 0388 */  0xFF, 0xFF                                       // ..
            })
        }

        Device (WMIQ)
        {
            Name (_HID, EisaId ("PNP0C14") /* Windows Management Instrumentation Device */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (BUF0, Buffer (0x20)
            {
                /* 0000 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0008 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0010 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  // ........
                /* 0018 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
            })
            CreateWordField (BUF0, Zero, EVSZ)
            CreateDWordField (BUF0, 0x02, DW00)
            CreateDWordField (BUF0, 0x06, DW01)
            CreateDWordField (BUF0, 0x0A, DW02)
            CreateDWordField (BUF0, 0x0E, DW03)
            Name (_WDG, Buffer (0x50)
            {
                /* 0000 */  0x45, 0x5B, 0xEB, 0x4D, 0x3D, 0x29, 0xF1, 0x4A,  // E[.M=).J
                /* 0008 */  0x9D, 0x89, 0xF2, 0x65, 0x7B, 0x33, 0x90, 0x74,  // ...e{3.t
                /* 0010 */  0x41, 0x30, 0x01, 0x01, 0xA1, 0xE8, 0x9F, 0x60,  // A0.....`
                /* 0018 */  0x42, 0xC9, 0x72, 0x41, 0xA4, 0x90, 0xA1, 0x5C,  // B.rA...\
                /* 0020 */  0xA9, 0x63, 0x23, 0xEC, 0x42, 0x30, 0x01, 0x01,  // .c#.B0..
                /* 0028 */  0x59, 0xC8, 0xB7, 0xF9, 0x2D, 0xA5, 0x49, 0x4A,  // Y...-.IJ
                /* 0030 */  0xB4, 0x14, 0xDC, 0xBE, 0x76, 0x05, 0xA8, 0xF6,  // ....v...
                /* 0038 */  0x41, 0x31, 0x01, 0x01, 0x21, 0x12, 0x90, 0x05,  // A1..!...
                /* 0040 */  0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0,  // f.......
                /* 0048 */  0xC9, 0x06, 0x29, 0x10, 0x41, 0x45, 0x01, 0x00   // ..).AE..
            })
            Mutex (MWMI, 0x07)
            Method (WQA0, 1, NotSerialized)
            {
                Return (BUF0) /* \_SB_.WMIQ.BUF0 */
            }

            Method (WSA0, 2, Serialized)
            {
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler, x=0-9, A-Z
                Acquire (MWMI, 0xFFFF)
                BUF0 = Arg1
                If (((EVSZ & 0xF0) == 0x30))
                {
                    \WMIQ (0x11, EVSZ, DW00, DW01)
                    DW00 = PAR1 /* \PAR1 */
                    DW01 = PAR2 /* \PAR2 */
                }
                ElseIf (((EVSZ & 0xF0) == 0x20))
                {
                    Local0 = ((DW02 << 0x10) | EVSZ) /* \_SB_.WMIQ.EVSZ */
                    \WMIQ (0x10, Local0, DW00, DW01)
                    DW03 = PAR0 /* \PAR0 */
                    DW00 = PAR1 /* \PAR1 */
                    DW01 = PAR2 /* \PAR2 */
                    DW02 = PAR3 /* \PAR3 */
                }
                Else
                {
                    Local0 = (EVSZ & 0xFF)
                    _T_0 = Local0
                    If ((_T_0 == Zero))
                    {
                        \WMIQ (0x02, EVSZ, DW01, Zero)
                        DW00 = PAR0 /* \PAR0 */
                    }
                    ElseIf ((_T_0 == One))
                    {
                        Local0 = ((DW02 << 0x10) | EVSZ) /* \_SB_.WMIQ.EVSZ */
                        \WMIQ (0x04, Local0, DW01, Zero)
                        DW00 = PAR0 /* \PAR0 */
                    }
                    ElseIf ((_T_0 == 0x02))
                    {
                        \WMIQ (0x06, EVSZ, DW01, Zero)
                        DW00 = PAR0 /* \PAR0 */
                    }
                    ElseIf ((_T_0 == 0x03))
                    {
                        \WMIQ (0x08, EVSZ, DW01, Zero)
                        DW00 = PAR0 /* \PAR0 */
                    }
                    ElseIf ((_T_0 == 0x04))
                    {
                        \WMIQ (0x0A, EVSZ, DW01, Zero)
                        DW00 = PAR0 /* \PAR0 */
                    }
                    ElseIf ((_T_0 == 0x05))
                    {
                        \WMIQ (0x0C, EVSZ, DW01, Zero)
                        DW00 = PAR0 /* \PAR0 */
                    }
                    ElseIf ((_T_0 == 0x06))
                    {
                        \WMIQ (0x0E, EVSZ, DW01, Zero)
                        DW00 = PAR0 /* \PAR0 */
                    }
                }

                Release (MWMI)
            }

            Method (WQB0, 1, NotSerialized)
            {
                Return (BUF0) /* \_SB_.WMIQ.BUF0 */
            }

            Method (WQA1, 1, NotSerialized)
            {
                Return (BUF0) /* \_SB_.WMIQ.BUF0 */
            }

            Method (WSA1, 2, Serialized)
            {
                Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler, x=0-9, A-Z
                Acquire (MWMI, 0xFFFF)
                BUF0 = Arg1
                If (((EVSZ & 0xF0) == 0x30))
                {
                    \WMIQ (0x11, EVSZ, DW00, DW01)
                }
                Else
                {
                    Local0 = (EVSZ & 0xFF)
                    _T_0 = Local0
                    If ((_T_0 == Zero))
                    {
                        \WMIQ (0x03, EVSZ, DW01, DW00)
                    }
                    ElseIf ((_T_0 == One))
                    {
                        Local0 = ((DW02 << 0x10) | EVSZ) /* \_SB_.WMIQ.EVSZ */
                        \WMIQ (0x05, Local0, DW01, DW00)
                    }
                    ElseIf ((_T_0 == 0x02))
                    {
                        \WMIQ (0x07, EVSZ, DW01, DW00)
                    }
                    ElseIf ((_T_0 == 0x03))
                    {
                        \WMIQ (0x09, EVSZ, DW01, DW00)
                    }
                    ElseIf ((_T_0 == 0x04))
                    {
                        \WMIQ (0x0B, EVSZ, DW01, DW00)
                    }
                    ElseIf ((_T_0 == 0x05))
                    {
                        \WMIQ (0x0D, EVSZ, DW01, DW00)
                    }
                    ElseIf ((_T_0 == 0x06))
                    {
                        \WMIQ (0x0F, EVSZ, DW01, DW00)
                    }
                }

                Release (MWMI)
            }

            Name (WQAE, Buffer (0x0360)
            {
                /* 0000 */  0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00,  // FOMB....
                /* 0008 */  0x50, 0x03, 0x00, 0x00, 0xC4, 0x0D, 0x00, 0x00,  // P.......
                /* 0010 */  0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54,  // DS...}.T
                /* 0018 */  0x28, 0xD4, 0x86, 0x00, 0x01, 0x06, 0x18, 0x42,  // (......B
                /* 0020 */  0x10, 0x07, 0x10, 0x92, 0x2F, 0x81, 0x42, 0x04,  // ..../.B.
                /* 0028 */  0x0A, 0x44, 0x24, 0xC1, 0x30, 0x28, 0x0F, 0x20,  // .D$.0(. 
                /* 0030 */  0x92, 0x03, 0x21, 0x17, 0x4C, 0x4C, 0x80, 0x08,  // ..!.LL..
                /* 0038 */  0x08, 0x79, 0x15, 0x60, 0x53, 0x80, 0x49, 0x10,  // .y.`S.I.
                /* 0040 */  0xF5, 0xEF, 0x0F, 0x51, 0x12, 0x1C, 0x4A, 0x08,  // ...Q..J.
                /* 0048 */  0x84, 0x24, 0x0B, 0x30, 0x2F, 0x40, 0xB7, 0x00,  // .$.0/@..
                /* 0050 */  0xC3, 0x02, 0x6C, 0x0B, 0x30, 0x2D, 0xC0, 0x31,  // ..l.0-.1
                /* 0058 */  0x24, 0x95, 0x06, 0x4E, 0x09, 0x2C, 0x05, 0x42,  // $..N.,.B
                /* 0060 */  0xC2, 0x05, 0x28, 0x17, 0xE0, 0x5B, 0x80, 0x76,  // ..(..[.v
                /* 0068 */  0x44, 0xE1, 0xB6, 0x0C, 0x23, 0x02, 0x8F, 0x82,  // D...#...
                /* 0070 */  0x09, 0x45, 0xA3, 0x04, 0x65, 0x0D, 0x8B, 0x12,  // .E..e...
                /* 0078 */  0x58, 0x0C, 0x20, 0x99, 0x84, 0x2D, 0x0A, 0x10,  // X. ..-..
                /* 0080 */  0x8F, 0x2F, 0xE8, 0x13, 0xE9, 0x1C, 0x43, 0x04,  // ./....C.
                /* 0088 */  0x1E, 0xA0, 0x07, 0x82, 0x1B, 0x91, 0x65, 0x8E,  // ......e.
                /* 0090 */  0x40, 0xE3, 0x39, 0xA2, 0xB2, 0x21, 0xE9, 0x34,  // @.9..!.4
                /* 0098 */  0x3A, 0x15, 0x20, 0x57, 0x80, 0x30, 0x78, 0xA1,  // :. W.0x.
                /* 00A0 */  0xC6, 0x68, 0x0E, 0x8A, 0x88, 0x85, 0x46, 0x0D,  // .h....F.
                /* 00A8 */  0xC4, 0x12, 0x61, 0x35, 0x8A, 0xD8, 0x07, 0x74,  // ..a5...t
                /* 00B0 */  0x26, 0x27, 0x52, 0x3A, 0x86, 0x46, 0x70, 0x26,  // &'R:.Fp&
                /* 00B8 */  0xC1, 0x3C, 0x84, 0x38, 0x21, 0x0A, 0x82, 0xD3,  // .<.8!...
                /* 00C0 */  0x20, 0x82, 0x84, 0x8C, 0x10, 0xA6, 0x66, 0x3C,  //  .....f<
                /* 00C8 */  0xA1, 0x06, 0x39, 0xB9, 0x3E, 0x31, 0x84, 0x12,  // ..9.>1..
                /* 00D0 */  0x3E, 0xDA, 0x31, 0x26, 0x30, 0xE4, 0x61, 0x60,  // >.1&0.a`
                /* 00D8 */  0x64, 0x40, 0xC8, 0xB3, 0x00, 0xEB, 0x43, 0x25,  // d@....C%
                /* 00E0 */  0x04, 0x76, 0x3F, 0x20, 0x0D, 0xE2, 0x08, 0x2B,  // .v? ...+
                /* 00E8 */  0x14, 0x60, 0x0D, 0x42, 0x30, 0x31, 0xDA, 0x12,  // .`.B01..
                /* 00F0 */  0xA0, 0x6C, 0x50, 0x72, 0x86, 0x25, 0x94, 0x40,  // .lPr.%.@
                /* 00F8 */  0x0D, 0x0A, 0xD0, 0x28, 0xC0, 0x18, 0x8A, 0x90,  // ...(....
                /* 0100 */  0x02, 0x15, 0x87, 0x21, 0x94, 0x40, 0x01, 0x6B,  // ...!.@.k
                /* 0108 */  0x03, 0x95, 0x37, 0x60, 0x61, 0x46, 0x08, 0x75,  // ..7`aF.u
                /* 0110 */  0x80, 0x61, 0xA2, 0xB6, 0x3F, 0x08, 0x12, 0x50,  // .a..?..P
                /* 0118 */  0x01, 0x44, 0x0B, 0x20, 0x8A, 0x34, 0x1A, 0xD4,  // .D. .4..
                /* 0120 */  0x61, 0x20, 0xC1, 0xC3, 0x81, 0xA7, 0x75, 0xE4,  // a ....u.
                /* 0128 */  0x9E, 0x9E, 0x41, 0x4E, 0xEF, 0xC0, 0xEA, 0x3C,  // ..AN...<
                /* 0130 */  0x15, 0x90, 0x41, 0xB3, 0xFF, 0x3F, 0xD6, 0x73,  // ..A..?.s
                /* 0138 */  0x00, 0x3B, 0x26, 0xE0, 0x5D, 0x03, 0xEA, 0x7E,  // .;&.]..~
                /* 0140 */  0xF0, 0x74, 0xC0, 0x66, 0x19, 0x0E, 0x33, 0x44,  // .t.f..3D
                /* 0148 */  0x8F, 0x14, 0x07, 0xE8, 0x21, 0x3D, 0x0D, 0x60,  // ....!=.`
                /* 0150 */  0x1D, 0x4E, 0x46, 0x47, 0x81, 0x52, 0x05, 0x98,  // .NFG.R..
                /* 0158 */  0x3D, 0x21, 0x68, 0xA2, 0x09, 0x8E, 0xC7, 0x67,  // =!h....g
                /* 0160 */  0x00, 0xCF, 0xE7, 0x84, 0x13, 0x58, 0xFE, 0x20,  // .....X. 
                /* 0168 */  0x50, 0x23, 0x33, 0xB4, 0x07, 0x7B, 0x5A, 0xAF,  // P#3..{Z.
                /* 0170 */  0x02, 0x3E, 0x2C, 0x1C, 0x16, 0x3B, 0x15, 0x78,  // .>,..;.x
                /* 0178 */  0x93, 0x1A, 0x0F, 0x10, 0x50, 0x7C, 0x2F, 0x10,  // ....P|/.
                /* 0180 */  0xC2, 0xFB, 0x82, 0xE7, 0x6B, 0x48, 0xBD, 0x1C,  // ....kH..
                /* 0188 */  0x64, 0x64, 0x15, 0x1E, 0x0F, 0xEA, 0x7A, 0xE0,  // dd....z.
                /* 0190 */  0x53, 0xC0, 0xB9, 0x1E, 0xD0, 0xE3, 0x82, 0x09,  // S.......
                /* 0198 */  0xC6, 0x86, 0xD0, 0x19, 0xC0, 0xA2, 0x8E, 0x13,  // ........
                /* 01A0 */  0xA8, 0xB3, 0x85, 0x8F, 0x13, 0xEC, 0xC6, 0xC0,  // ........
                /* 01A8 */  0xB1, 0xCF, 0xC8, 0xA7, 0x09, 0x8F, 0x0C, 0xEF,  // ........
                /* 01B0 */  0x7D, 0xAE, 0x64, 0x0E, 0x1E, 0x19, 0x9B, 0xD3,  // }.d.....
                /* 01B8 */  0x83, 0x04, 0x58, 0xAE, 0x15, 0xC1, 0xE2, 0xBC,  // ..X.....
                /* 01C0 */  0x42, 0xF0, 0x49, 0x07, 0x8C, 0x70, 0x28, 0x87,  // B.I..p(.
                /* 01C8 */  0x15, 0x26, 0x56, 0xC4, 0x18, 0x3D, 0x5E, 0x0F,  // .&V..=^.
                /* 01D0 */  0xA4, 0x15, 0x53, 0x04, 0x3E, 0x1C, 0x78, 0x5C,  // ..S.>.x\
                /* 01D8 */  0x7C, 0x1C, 0x1E, 0x6D, 0xE0, 0xA3, 0xF7, 0x98,  // |..m....
                /* 01E0 */  0x7C, 0xF8, 0xF0, 0xA8, 0xE1, 0xDE, 0x28, 0x3C,  // |.....(<
                /* 01E8 */  0x98, 0xA3, 0x78, 0x8C, 0x48, 0xF0, 0xFF, 0x2F,  // ..x.H../
                /* 01F0 */  0x10, 0x16, 0x3D, 0x6A, 0xFB, 0x15, 0x80, 0x10,  // ..=j....
                /* 01F8 */  0xFA, 0xF5, 0xE3, 0x24, 0x8E, 0xE5, 0x5C, 0xAC,  // ...$..\.
                /* 0200 */  0xF4, 0x34, 0x40, 0xB1, 0x5E, 0x4B, 0xD8, 0xC0,  // .4@.^K..
                /* 0208 */  0x0C, 0x63, 0x02, 0x8B, 0x1C, 0x27, 0x7A, 0x00,  // .c...'z.
                /* 0210 */  0x7C, 0x6A, 0xF1, 0xC3, 0x9E, 0xCB, 0x01, 0x1C,  // |j......
                /* 0218 */  0x4D, 0x94, 0x73, 0x38, 0x1C, 0x1F, 0x47, 0x22,  // M.s8..G"
                /* 0220 */  0xD4, 0x05, 0xA1, 0x41, 0x3C, 0x15, 0x78, 0x40,  // ...A<.x@
                /* 0228 */  0x51, 0xDE, 0x5F, 0xF8, 0x08, 0x30, 0x01, 0x0E,  // Q._..0..
                /* 0230 */  0x33, 0x28, 0xC9, 0xE7, 0x19, 0x80, 0x58, 0x47,  // 3(....XG
                /* 0238 */  0x98, 0x03, 0xF2, 0x25, 0xE6, 0x10, 0xFF, 0xFF,  // ...%....
                /* 0240 */  0x4F, 0x0C, 0xEF, 0x05, 0x8F, 0x32, 0xBE, 0x18,  // O....2..
                /* 0248 */  0x04, 0x3A, 0xAB, 0x17, 0x99, 0xE7, 0x19, 0x03,  // .:......
                /* 0250 */  0x3D, 0xC6, 0x44, 0x31, 0x5A, 0x98, 0x37, 0x19,  // =.D1Z.7.
                /* 0258 */  0xA3, 0x18, 0xEA, 0x75, 0x26, 0x64, 0x90, 0x40,  // ...u&d.@
                /* 0260 */  0xE1, 0x9F, 0x67, 0xE2, 0x85, 0x08, 0x1F, 0xE8,  // ..g.....
                /* 0268 */  0x79, 0x86, 0x45, 0x3C, 0xCF, 0x00, 0x34, 0x91,  // y.E<..4.
                /* 0270 */  0x72, 0x9E, 0x01, 0x45, 0xF0, 0xF3, 0x0C, 0xE8,  // r..E....
                /* 0278 */  0x47, 0x86, 0x3F, 0x48, 0xC0, 0xFF, 0xFF, 0x1F,  // G.?H....
                /* 0280 */  0x24, 0xF8, 0x49, 0x85, 0xDF, 0x67, 0xE0, 0xDC,  // $.I..g..
                /* 0288 */  0x24, 0xDE, 0x39, 0x3C, 0xA0, 0x17, 0x1A, 0xDC,  // $.9<....
                /* 0290 */  0x81, 0x06, 0x30, 0x80, 0xF5, 0x40, 0x03, 0x9C,  // ..0..@..
                /* 0298 */  0x04, 0x9E, 0x66, 0xA8, 0xF4, 0x77, 0x80, 0x24,  // ..f..w.$
                /* 02A0 */  0xC1, 0xA0, 0x34, 0x1C, 0x68, 0x80, 0xF6, 0x29,  // ..4.h..)
                /* 02A8 */  0x06, 0xF8, 0xFD, 0xFF, 0x4F, 0x31, 0xF0, 0xCF,  // ....O1..
                /* 02B0 */  0x58, 0xB8, 0x53, 0x0C, 0xEC, 0x3B, 0xCC, 0xF9,  // X.S..;..
                /* 02B8 */  0xBC, 0x62, 0xBC, 0xBE, 0x3C, 0x0B, 0x3C, 0x26,  // .b..<.<&
                /* 02C0 */  0x3C, 0xBB, 0xBC, 0xDC, 0xF9, 0x38, 0x10, 0xE4,  // <....8..
                /* 02C8 */  0xD5, 0xE5, 0x21, 0x8F, 0x9F, 0x61, 0x8C, 0xF2,  // ..!..a..
                /* 02D0 */  0xAC, 0xE7, 0x33, 0x4C, 0x88, 0x28, 0xC1, 0xA2,  // ..3L.(..
                /* 02D8 */  0xC6, 0x79, 0x2C, 0x88, 0xFC, 0x4E, 0x63, 0xD4,  // .y,..Nc.
                /* 02E0 */  0x88, 0xC1, 0x8F, 0x20, 0xCC, 0x53, 0x0C, 0x0B,  // ... .S..
                /* 02E8 */  0x76, 0x8A, 0x01, 0x68, 0x22, 0xE1, 0x14, 0x03,  // v..h"...
                /* 02F0 */  0x8A, 0xC0, 0xA7, 0x18, 0xA8, 0xFF, 0xFF, 0x43,  // .......C
                /* 02F8 */  0x1E, 0x38, 0x4F, 0x23, 0xF8, 0x83, 0x04, 0xBC,  // .8O#....
                /* 0300 */  0x81, 0x04, 0xE7, 0xB7, 0x18, 0x18, 0x27, 0x3C,  // ......'<
                /* 0308 */  0xE0, 0x22, 0xEF, 0x04, 0x03, 0x8A, 0x31, 0x61,  // ."....1a
                /* 0310 */  0x6E, 0x30, 0xB8, 0x03, 0x0C, 0x30, 0x52, 0x68,  // n0...0Rh
                /* 0318 */  0xD3, 0xA7, 0x46, 0xA3, 0x56, 0x0D, 0xCA, 0xD4,  // ..F.V...
                /* 0320 */  0x28, 0xD3, 0xA0, 0x56, 0x9F, 0x4A, 0x8D, 0x19,  // (..V.J..
                /* 0328 */  0x3B, 0x00, 0x78, 0x46, 0x8F, 0x01, 0x4C, 0xE2,  // ;.xF..L.
                /* 0330 */  0x83, 0x41, 0x83, 0xF5, 0xD9, 0xD4, 0x20, 0x8E,  // .A.... .
                /* 0338 */  0x4A, 0x21, 0x10, 0x87, 0x3C, 0xCA, 0x08, 0xD0,  // J!..<...
                /* 0340 */  0x01, 0x5F, 0x32, 0x02, 0xB2, 0xBC, 0xB7, 0x9E,  // ._2.....
                /* 0348 */  0x40, 0x2C, 0x75, 0x15, 0x02, 0xB1, 0x48, 0x13,  // @,u...H.
                /* 0350 */  0x80, 0x4C, 0xCA, 0xAB, 0x40, 0x40, 0x0E, 0x02,  // .L..@@..
                /* 0358 */  0x42, 0xC3, 0xAC, 0x43, 0x20, 0xFE, 0xFF, 0x03   // B..C ...
            })
        }
    }

    Scope (_SB.PCI0.PEG0)
    {
        Device (VGA)
        {
            Name (_ADR, Zero)  // _ADR: Address
            OperationRegion (VPCG, PCI_Config, Zero, 0x0100)
            Field (VPCG, DWordAcc, NoLock, Preserve)
            {
                Offset (0x54), 
                VPWR,   32
            }

            Name (AVGA, Zero)
            Name (SWIT, One)
            Name (CRT0, One)
            Name (LCD0, One)
            Name (DP00, One)
            Name (DP01, One)
            Name (DP02, One)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Name (_PSC, Zero)  // _PSC: Power State Current
            Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
            {
                _PSC = Zero
            }

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                _PSC = 0x03
            }

            Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
            {
                SWIT = (Arg0 & 0x03)
            }

            Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
            {
                Return (Package (0x05)
                {
                    0x0100, 
                    0x0110, 
                    0x0230, 
                    0x0210, 
                    0x0220
                })
            }

            Device (LCD)
            {
                Name (_ADR, 0x0110)  // _ADR: Address
                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If (LCD0)
                    {
                        Return (0x1F)
                    }
                    Else
                    {
                        Return (0x1D)
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (LCD0)
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                }

                Method (_BCL, 0, NotSerialized)  // _BCL: Brightness Control Levels
                {
                    AVGA = One
                    Return (IBCL) /* \_SB_.PCI0.IBCL */
                }

                Name (CC01, Zero)
                Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
                {
                    If (!CC01)
                    {
                        UCMS (0x06)
                        CC01 = One
                    }

                    IBCM (Arg0)
                }

                Method (_BQC, 0, NotSerialized)  // _BQC: Brightness Query Current
                {
                    Return (EBRL) /* \_SB_.PCI0.EBRL */
                }
            }

            Device (CRT)
            {
                Name (_ADR, 0x0100)  // _ADR: Address
                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If (CRT0)
                    {
                        Return (0x1F)
                    }
                    Else
                    {
                        Return (0x1D)
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (CRT0)
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                }
            }

            Device (DP0)
            {
                Name (_ADR, 0x0230)  // _ADR: Address
                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If (DP00)
                    {
                        Return (0x1F)
                    }
                    Else
                    {
                        Return (0x1D)
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (DP00)
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                }
            }

            Device (DP1)
            {
                Name (_ADR, 0x0210)  // _ADR: Address
                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If (DP01)
                    {
                        Return (0x1F)
                    }
                    Else
                    {
                        Return (0x1D)
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (DP01)
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                }
            }

            Device (DP2)
            {
                Name (_ADR, 0x0220)  // _ADR: Address
                Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                {
                    If (DP02)
                    {
                        Return (0x1F)
                    }
                    Else
                    {
                        Return (0x1D)
                    }
                }

                Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                {
                    If (DP02)
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                {
                }
            }

            Name (TGLP, Zero)
            Name (TGLT, Package (0x10)
            {
                Package (0x13)
                {
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x04, 
                    One, 
                    One, 
                    0x05, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x08, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x09, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    0x04, 
                    0x05, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    0x08, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x09, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x04, 
                    One, 
                    One, 
                    0x05, 
                    0x08, 
                    One, 
                    One, 
                    0x09, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x08, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x09, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x04, 
                    One, 
                    One, 
                    0x05, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x04, 
                    One, 
                    One, 
                    0x05, 
                    0x08, 
                    One, 
                    One, 
                    0x09, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    0x04, 
                    0x05, 
                    0x08, 
                    One, 
                    One, 
                    0x09, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    0x04, 
                    0x05, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    0x08, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x09, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }, 

                Package (0x13)
                {
                    One, 
                    0x02, 
                    0x03, 
                    0x04, 
                    0x05, 
                    0x08, 
                    One, 
                    One, 
                    0x09, 
                    0x10, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    One, 
                    0x11, 
                    One, 
                    One
                }
            })
            Method (SWIH, 0, NotSerialized)
            {
                PHSR (0x9C)
                Local0 = GCDE /* \GCDE */
                Local1 = DADD /* \DADD */
                If ((Local1 == One))
                {
                    TGLP = Zero
                }
                ElseIf ((Local1 == 0x03))
                {
                    TGLP = One
                }
                ElseIf ((Local1 == 0x05))
                {
                    TGLP = 0x02
                }
                ElseIf ((Local1 == 0x09))
                {
                    TGLP = 0x03
                }
                ElseIf ((Local1 == 0x11))
                {
                    TGLP = 0x04
                }
                ElseIf ((Local1 == 0x07))
                {
                    TGLP = 0x05
                }
                ElseIf ((Local1 == 0x0B))
                {
                    TGLP = 0x06
                }
                ElseIf ((Local1 == 0x13))
                {
                    TGLP = 0x07
                }
                ElseIf ((Local1 == 0x0D))
                {
                    TGLP = 0x08
                }
                ElseIf ((Local1 == 0x19))
                {
                    TGLP = 0x09
                }
                ElseIf ((Local1 == 0x15))
                {
                    TGLP = 0x0A
                }
                ElseIf ((Local1 == 0x1D))
                {
                    TGLP = 0x0B
                }
                ElseIf ((Local1 == 0x0F))
                {
                    TGLP = 0x0C
                }
                ElseIf ((Local1 == 0x17))
                {
                    TGLP = 0x0D
                }
                ElseIf ((Local1 == 0x1B))
                {
                    TGLP = 0x0E
                }
                ElseIf ((Local1 == 0x1F))
                {
                    TGLP = 0x0F
                }

                Local2 = DerefOf (DerefOf (TGLT [TGLP]) [Local0])
                LCD0 = ((Local2 & One) >> Zero)
                CRT0 = ((Local2 & 0x02) >> One)
                DP00 = ((Local2 & 0x04) >> 0x02)
                DP01 = ((Local2 & 0x08) >> 0x03)
                DP02 = ((Local2 & 0x10) >> 0x04)
                Notify (VGA, 0x80) // Status Change
            }

            Name (ATIB, Buffer (0x0100){})
            Name (AG02, Zero)
            Name (AG03, Zero)
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
                    ATIB = Arg1
                    CreateWordField (ATIB, Zero, AAA1)
                    CreateWordField (ATIB, 0x02, AAA2)
                    CreateWordField (ATIB, 0x04, AAA3)
                    AG02 = AAA2 /* \_SB_.PCI0.PEG0.VGA_.ATIF.AAA2 */
                    AG03 = AAA3 /* \_SB_.PCI0.PEG0.VGA_.ATIF.AAA3 */
                    Return (AF03 (AG02, AG03))
                }

                If ((Arg0 == 0x04))
                {
                    Return (AF04 ())
                }
            }

            Method (AF00, 0, NotSerialized)
            {
                P80H = 0xF0
                CreateWordField (ATIB, Zero, SSZE)
                CreateWordField (ATIB, 0x02, VERN)
                CreateDWordField (ATIB, 0x04, NMSK)
                CreateDWordField (ATIB, 0x08, SFUN)
                SSZE = 0x0C
                VERN = One
                NMSK = 0x11
                MSKN = NMSK /* \_SB_.PCI0.PEG0.VGA_.AF00.NMSK */
                SFUN = 0x0F
                Return (ATIB) /* \_SB_.PCI0.PEG0.VGA_.ATIB */
            }

            Name (NCOD, 0x81)
            Method (AF01, 0, NotSerialized)
            {
                P80H = 0xF1
                CreateWordField (ATIB, Zero, SSZE)
                CreateDWordField (ATIB, 0x02, VMSK)
                CreateDWordField (ATIB, 0x06, FLGS)
                VMSK = 0x0B
                SSZE = 0x0A
                VMSK = 0x03
                FLGS = One
                NCOD = 0x81
                Return (ATIB) /* \_SB_.PCI0.PEG0.VGA_.ATIB */
            }

            Name (PSBR, Buffer (0x04)
            {
                 0x00, 0x00, 0x00, 0x00                           // ....
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
            Name (SACT, Buffer (0x09)
            {
                /* 0000 */  0x01, 0x02, 0x03, 0x08, 0x09, 0x80, 0x81, 0x04,  // ........
                /* 0008 */  0x05                                             // .
            })
            Method (AF02, 0, NotSerialized)
            {
                P80H = 0xF2
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
                PSBI = PSBR /* \_SB_.PCI0.PEG0.VGA_.PSBR */
                If (PDSW)
                {
                    P80H = 0x82
                    PDSW = Zero
                }

                If (PEXM)
                {
                    EXPM = SEXM /* \_SB_.PCI0.PEG0.VGA_.SEXM */
                    SEXM = Zero
                    PEXM = Zero
                }

                If (PTHR)
                {
                    THRM = STHG /* \_SB_.PCI0.PEG0.VGA_.STHG */
                    THID = STHI /* \_SB_.PCI0.PEG0.VGA_.STHI */
                    STHG = Zero
                    STHI = Zero
                    PTHR = Zero
                }

                If (PFPS)
                {
                    FPWR = SFPG /* \_SB_.PCI0.PEG0.VGA_.SFPG */
                    FPWR = SFPI /* \_SB_.PCI0.PEG0.VGA_.SFPI */
                    SFPG = Zero
                    SFPI = Zero
                    PFPS = Zero
                }

                If (PSPS)
                {
                    SPWR = SSPS /* \_SB_.PCI0.PEG0.VGA_.SSPS */
                    PSPS = Zero
                }

                If (PXPS)
                {
                    P80H = 0xA2
                    PXPS = Zero
                }

                If (PBRT)
                {
                    P80H = 0xF7
                    PBRT = Zero
                }

                Return (ATIB) /* \_SB_.PCI0.PEG0.VGA_.ATIB */
            }

            Name (LG00, Zero)
            Name (LG01, Zero)
            Name (LG02, Zero)
            Name (LG03, Zero)
            Method (AF03, 2, NotSerialized)
            {
                P80H = 0xF3
                CreateWordField (ATIB, Zero, SSZE)
                CreateWordField (ATIB, 0x02, SSDP)
                CreateWordField (ATIB, 0x04, SCDP)
                SSDP = AG02 /* \_SB_.PCI0.PEG0.VGA_.AG02 */
                SCDP = AG03 /* \_SB_.PCI0.PEG0.VGA_.AG03 */
                Name (NXTD, 0x09)
                Name (CIDX, 0x09)
                LG01 = SSDP /* \_SB_.PCI0.PEG0.VGA_.AF03.SSDP */
                LG01 &= 0x028B
                LG02 = SCDP /* \_SB_.PCI0.PEG0.VGA_.AF03.SCDP */
                LG02 |= One
                P80H = LG02 /* \_SB_.PCI0.PEG0.VGA_.LG02 */
                LG00 = Zero
                While ((LG00 < SizeOf (SACT)))
                {
                    LG03 = DerefOf (SACT [LG00])
                    If ((LG03 == 0x04))
                    {
                        LG03 = 0x0200
                    }

                    If ((LG03 == 0x05))
                    {
                        LG03 = 0x0201
                    }

                    If ((LG03 == LG01))
                    {
                        CIDX = LG00 /* \_SB_.PCI0.PEG0.VGA_.LG00 */
                        LG00 = SizeOf (SACT)
                    }
                    Else
                    {
                        LG00++
                    }
                }

                LG00 = CIDX /* \_SB_.PCI0.PEG0.VGA_.AF03.CIDX */
                While ((LG00 < SizeOf (SACT)))
                {
                    LG00++
                    If ((LG00 == SizeOf (SACT)))
                    {
                        LG00 = Zero
                    }

                    LG03 = DerefOf (SACT [LG00])
                    If ((LG03 == 0x04))
                    {
                        LG03 = 0x0200
                    }

                    If ((LG03 == 0x05))
                    {
                        LG03 = 0x0201
                    }

                    If (((LG03 & LG02) == LG03))
                    {
                        NXTD = LG00 /* \_SB_.PCI0.PEG0.VGA_.LG00 */
                        LG00 = SizeOf (SACT)
                    }
                }

                If ((NXTD == SizeOf (SACT)))
                {
                    SSDP = Zero
                }
                Else
                {
                    LG00 = NXTD /* \_SB_.PCI0.PEG0.VGA_.AF03.NXTD */
                    LG03 = DerefOf (SACT [LG00])
                    SSDP &= 0xFFFFFFFFFFFFFD74
                    SSDP |= LG03 /* \_SB_.PCI0.PEG0.VGA_.LG03 */
                    If ((LG03 == 0x04))
                    {
                        SSDP &= 0xFFFB
                        SSDP |= 0x0200
                    }

                    If ((LG03 == 0x05))
                    {
                        SSDP &= 0xFFFA
                        SSDP |= 0x0201
                    }
                }

                SSZE = 0x04
                P80H = SSDP /* \_SB_.PCI0.PEG0.VGA_.AF03.SSDP */
                Return (ATIB) /* \_SB_.PCI0.PEG0.VGA_.ATIB */
            }

            Method (AF04, 0, NotSerialized)
            {
                P80H = 0xF4
                CreateWordField (ATIB, Zero, SSZE)
                CreateByteField (ATIB, 0x02, LIDS)
                SSZE = 0x03
                If (LIDW)
                {
                    LIDS = Zero
                }
                Else
                {
                    LIDS = One
                }

                Return (ATIB) /* \_SB_.PCI0.PEG0.VGA_.ATIB */
            }

            Method (AFN0, 0, Serialized)
            {
                If ((MSKN & One))
                {
                    CreateBitField (PSBR, Zero, PDSW)
                    PDSW = One
                    Notify (VGA, NCOD)
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
                    Notify (VGA, NCOD)
                }
            }

            Method (AFN4, 1, Serialized)
            {
                If ((MSKN & 0x10))
                {
                    Local0 = Arg0
                    Local1 = SSPS /* \_SB_.PCI0.PEG0.VGA_.SSPS */
                    SSPS = Local0
                    If ((Local0 == Local1)){}
                    Else
                    {
                        CreateBitField (PSBR, 0x04, PSPS)
                        PSPS = One
                        Notify (VGA, NCOD)
                    }
                }
            }

            Method (AFN5, 0, Serialized)
            {
                If ((MSKN & 0x20))
                {
                    CreateBitField (PSBR, 0x05, PDCC)
                    PDCC = One
                    Notify (VGA, NCOD)
                }
            }

            Method (AFN6, 0, Serialized)
            {
                If ((MSKN & 0x40))
                {
                    CreateBitField (PSBR, 0x06, PXPS)
                    PXPS = One
                    Notify (VGA, NCOD)
                }
            }

            Method (AFN7, 1, Serialized)
            {
                If ((MSKN & 0x80))
                {
                    CreateBitField (PSBR, 0x07, PBRT)
                    PBRT = One
                    CreateByteField (ATIB, 0x0C, BRTL)
                    BRTL = Arg0
                    Notify (VGA, NCOD)
                }
            }
        }
    }

    Scope (_SB.PCI0.RP06)
    {
        Device (BLAN)
        {
            Name (_ADR, Zero)  // _ADR: Address
            OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
            Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
            {
                Offset (0x10), 
                L0SE,   1, 
                    ,   4, 
                RETR,   1, 
                Offset (0x11), 
                Offset (0x12), 
                    ,   13, 
                LASX,   1, 
                Offset (0x1A), 
                ABPX,   1, 
                    ,   2, 
                PDCX,   1, 
                    ,   2, 
                PDSX,   1, 
                Offset (0x1B), 
                LSCX,   1, 
                Offset (0x20), 
                Offset (0x22), 
                PSPX,   1, 
                Offset (0x98), 
                    ,   30, 
                HPEX,   1, 
                PMEX,   1, 
                    ,   30, 
                HPSX,   1, 
                PMSX,   1
            }

            Device (PXSX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Method (HPME, 0, Serialized)
            {
                If (PMSX)
                {
                    Local0 = 0xC8
                    While (Local0)
                    {
                        PMSX = One
                        If (PMSX)
                        {
                            Local0--
                        }
                        Else
                        {
                            Local0 = Zero
                        }
                    }

                    Notify (PXSX, 0x02) // Device Wake
                }
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
                If (WOLN)
                {
                    ^^PMSX = One
                    LANO = Arg0
                }
                Else
                {
                    LANO = Zero
                }
            }

            Name (CSTA, Zero)
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (CSTA)
                {
                    Return (Zero)
                }
                Else
                {
                    Return (0x0F)
                }
            }

            Name (CABL, Zero)
        }
    }

    Name (SPS, Zero)
    Name (OSIF, Zero)
    Name (W98F, Zero)
    Name (WNTF, Zero)
    Name (WMEF, Zero)
    Name (WXPF, Zero)
    Name (WVIS, Zero)
    Name (WSPV, Zero)
    Name (LNUX, Zero)
    Name (H8DR, Zero)
    Name (MEMX, Zero)
    Name (FNID, Zero)
    Name (RRBF, Zero)
    Name (NBCF, Zero)
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (DGSY, 1, NotSerialized)
        {
            DB0F = DB0E /* \DB0E */
            DB0E = DB0D /* \DB0D */
            DB0D = DB0C /* \DB0C */
            DB0C = DB0B /* \DB0B */
            DB0B = DB0A /* \DB0A */
            DB0A = DB09 /* \DB09 */
            DB09 = DB08 /* \DB08 */
            DB08 = DB07 /* \DB07 */
            DB07 = DB06 /* \DB06 */
            DB06 = DB05 /* \DB05 */
            DB05 = DB04 /* \DB04 */
            DB04 = DB03 /* \DB03 */
            DB03 = DB02 /* \DB02 */
            DB02 = DB01 /* \DB01 */
            DB01 = DB00 /* \DB00 */
            DB00 = Arg0
        }
    }
}

