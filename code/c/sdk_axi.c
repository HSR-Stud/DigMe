#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_types.h" // basic types for Xilinx software IP
#include "xil_io.h"    // interface for the general IO component
#include "AXILite.h"   // board support package library for user component
int main()
{
  static u32 ArrayIn[4] = {0,0,0,0};
  static u32 ArrayOut[4] = {0x10101010, 0x20202020, 0x30303030, 0x40404040};
  init_platform();
  // write data to the AXILite component registers (xil_io.h)
  Xil_Out32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 0, ArrayOut[0]);
  Xil_Out32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 4, ArrayOut[1]);
  Xil_Out32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 8, ArrayOut[2]);
  Xil_Out32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 12, ArrayOut[3]);
  // read data from the AXILite component registers (xil_io.h)
  ArrayIn[0] = Xil_In32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 0);
  ArrayIn[1] = Xil_In32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 4);
  ArrayIn[2] = Xil_In32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 8);
  ArrayIn[3] = Xil_In32(XPAR_AXILITE_0_S00_AXI_BASEADDR + 12);
  // write data to the AXILite component registers (AXILite.h)
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 0, ArrayOut[0]);
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 4, ArrayOut[1]);
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 8, ArrayOut[2]);
  AXILITE_mWriteReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 12, ArrayOut[3]);
  // read data to the AXILite component registers (AXILite.h)
  ArrayIn[0] = AXILITE_mReadReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 0);
  ArrayIn[1] = AXILITE_mReadReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 4);
  ArrayIn[2] = AXILITE_mReadReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 8);
  ArrayIn[3] = AXILITE_mReadReg(XPAR_AXILITE_0_S00_AXI_BASEADDR, 12);
  cleanup_platform();
  return 0 ;
}
