
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE1_Uart_test(
		     //////////// CLOCK //////////
		     input 	  CLOCK_50,
		     input 	  CLOCK2_50,
		     input 	  CLOCK3_50,
		     input 	  CLOCK4_50,

		     //////////// SEG7 //////////
		     output [6:0] HEX0,
		     output [6:0] HEX1,
		     output [6:0] HEX2,
		     output [6:0] HEX3,
		     output [6:0] HEX4,
		     output [6:0] HEX5,

		     //////////// KEY //////////
		     input [3:0]  KEY,

		     //////////// LED //////////
		     output [9:0] LEDR,

		     //////////// SW //////////
		     input [9:0]  SW,

		     //////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
		     inout [35:0] GPIO
		     );

   
   wire 			  ready;
   wire 			  valid;
   wire[7:0] 			  data;
   
   assign valid = 1'b1;
   assign data  = 8'h30;

   UartTx sender(.clk(CLOCK_50),
		 .reset(~KEY[0]),
		 .io_txd(GPIO[0]),
		 .io_enq_ready(ready),
		 .io_enq_valid(valid),
		 .io_enq_bits(data));

endmodule
