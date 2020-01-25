#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_types.h" // basic types for Xilinx software IP
#include "AXILite.h"   // board support package library for user component
#include "xdmaps.h"    // board support package library for PS DMA control
int main()
{
  static u32 ArrayIn[4] = {0,0,0,0};
  static u32 ArrayOut[4] = {0x10101010, 0x20202020, 0x30303030, 0x40404040};
  XDmaPs_Config *DmaCfg
  XDmaPs_Cmd DmaCmd;
  XDmaPs DmaInst;
  init_platform();
  // initialize PS DMA control registers
  memset(&DmaCmd, 0, sizeof(XDmaPs_Cmd));
  DmaCmd.ChanCtrl.SrcBurstSize = 4;
  DmaCmd.ChanCtrl.SrcBurstLen = 4;
  DmaCmd.ChanCtrl.SrcInc = 1;
  DmaCmd.ChanCtrl.DstBurstSize = 4;
  DmaCmd.ChanCtrl.DstBurstLen = 4;
  DmaCmd.ChanCtrl.DstInc = 1;
  DmaCmd.BD.SrcAddr = (u32) XPAR_AXILITE_0_S00_AXI_BASEADDR; // source address
  DmaCmd.BD.DstAddr = (u32) &ArrayIn[0]; // destination address
  DmaCmd.BD.Length = 4 * sizeof(int);
  DmaCfg = XDmaPs_LookupConfig(XPAR_XDMAPS_1_DEVICE_ID);
  XDmaPs_CfgInitialize(&DmaInst, DmaCfg, DmaCfg->BaseAddress);
  // write data to the AXILite component registers
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 0, ArrayOut[0]);
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 4, ArrayOut[1]);
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 8, ArrayOut[2]);
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 12, ArrayOut[3]);
  // start data transfer with PS DMA
  XDmaPs_Start(&DmaInst, 0, &DmaCmd, 0);
  whiley(DmaInst.IsReady == 0); // wait on transfer complete
  cleanup_platform();
  return 0 ;
}
