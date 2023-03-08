/*
 * Generated by Digital. Don't modify this file!
 * Any changes will be lost if this file is regenerated.
 */

module DIG_Counter_Nbit
#(
    parameter Bits = 2
)
(
    output [(Bits-1):0] out,
    output ovf,
    input C,
    input en,
    input clr
);
    reg [(Bits-1):0] count;

    always @ (posedge C) begin
        if (clr)
          count <= 'h0;
        else if (en)
          count <= count + 1'b1;
    end

    assign out = count;
    assign ovf = en? &count : 1'b0;

    initial begin
        count = 'h0;
    end
endmodule

module DIG_D_FF_Nbit
#(
    parameter Bits = 2,
    parameter Default = 0
)
(
   input [(Bits-1):0] D,
   input C,
   output [(Bits-1):0] Q,
   output [(Bits-1):0] \~Q
);
    reg [(Bits-1):0] state;

    assign Q = state;
    assign \~Q = ~state;

    always @ (posedge C) begin
        state <= D;
    end

    initial begin
        state = Default;
    end
endmodule

module DIG_JK_FF
#(
    parameter Default = 1'b0
)
(
   input J,
   input C,
   input K,
   output Q,
   output \~Q
);
    reg state;

    assign Q = state;
    assign \~Q = ~state;

    always @ (posedge C) begin
        if (~J & K)
            state <= 1'b0;
         else if (J & ~K)
            state <= 1'b1;
         else if (J & K)
            state <= ~state;
    end

    initial begin
        state = Default;
    end
endmodule


module CompUnsigned #(
    parameter Bits = 1
)
(
    input [(Bits -1):0] a,
    input [(Bits -1):0] b,
    output \> ,
    output \= ,
    output \<
);
    assign \> = a > b;
    assign \= = a == b;
    assign \< = a < b;
endmodule


module CPLD_SYNC (
  input nC25not8,
  input C25not8,
  output ACT, // Active Area
  output \~HS , // Horizontal Sync
  output \~VS , // Vertical Sync
  output IRQ_S // IRQ Output

);
  wire s0;
  wire [6:0] s1;
  wire s2;
  wire [9:0] s3;
  wire s4;
  wire s5;
  wire s6;
  wire s7;
  wire s8;
  wire s9;
  wire s10;
  wire s11;
  // X
  DIG_Counter_Nbit #(
    .Bits(7)
  )
  DIG_Counter_Nbit_i0 (
    .en( 1'b1 ),
    .C( nC25not8 ),
    .clr( s0 ),
    .out( s1 )
  );
  // Y
  DIG_Counter_Nbit #(
    .Bits(10)
  )
  DIG_Counter_Nbit_i1 (
    .en( s0 ),
    .C( nC25not8 ),
    .clr( s2 ),
    .out( s3 )
  );
  assign IRQ_S = (s4 & s5);
  // HSYNC
  DIG_JK_FF #(
    .Default(0)
  )
  DIG_JK_FF_i2 (
    .J( s6 ),
    .C( C25not8 ),
    .K( s7 ),
    .\~Q ( \~HS  )
  );
  // VSYNC
  DIG_JK_FF #(
    .Default(0)
  )
  DIG_JK_FF_i3 (
    .J( s8 ),
    .C( C25not8 ),
    .K( s9 ),
    .\~Q ( \~VS  )
  );
  CompUnsigned #(
    .Bits(7)
  )
  CompUnsigned_i4 (
    .a( s1 ),
    .b( 7'b1001111 ),
    .\> ( s10 ),
    .\= ( s4 )
  );
  CompUnsigned #(
    .Bits(10)
  )
  CompUnsigned_i5 (
    .a( s3 ),
    .b( 10'b110001111 ),
    .\> ( s11 ),
    .\= ( s5 )
  );
  assign ACT = ~ (s11 | s10);
  assign s0 = (s1[0] & s1[1] & ~ s1[2] & ~ s1[3] & ~ s1[4] & s1[5] & s1[6]);
  assign s8 = (s3[0] & ~ s3[1] & ~ s3[2] & ~ s3[3] & ~ s3[4] & ~ s3[5] & s3[6] & s3[7] & s3[8] & ~ s3[9]);
  assign s7 = (s1[0] & ~ s1[1] & s1[2] & s1[3] & s1[4] & ~ s1[5] & s1[6]);
  assign s6 = (s1[0] & ~ s1[1] & ~ s1[2] & ~ s1[3] & s1[4] & ~ s1[5] & s1[6]);
  assign s9 = (s3[0] & s3[1] & ~ s3[2] & ~ s3[3] & ~ s3[4] & ~ s3[5] & s3[6] & s3[7] & s3[8] & ~ s3[9]);
  assign s2 = (~ s3[0] & ~ s3[1] & s3[2] & s3[3] & ~ s3[4] & ~ s3[5] & ~ s3[6] & ~ s3[7] & ~ s3[8] & s3[9] & s0);
endmodule

module DIG_Register_BUS #(
    parameter Bits = 1
)
(
    input C,
    input en,
    input [(Bits - 1):0]D,
    output [(Bits - 1):0]Q
);

    reg [(Bits - 1):0] state = 'h0;

    assign Q = state;

    always @ (posedge C) begin
        if (en)
            state <= D;
   end
endmodule

module Mux_8x1
(
    input [2:0] sel,
    input in_0,
    input in_1,
    input in_2,
    input in_3,
    input in_4,
    input in_5,
    input in_6,
    input in_7,
    output reg out
);
    always @ (*) begin
        case (sel)
            3'h0: out = in_0;
            3'h1: out = in_1;
            3'h2: out = in_2;
            3'h3: out = in_3;
            3'h4: out = in_4;
            3'h5: out = in_5;
            3'h6: out = in_6;
            3'h7: out = in_7;
            default:
                out = 'h0;
        endcase
    end
endmodule

module DIG_D_FF_1bit
#(
    parameter Default = 0
)
(
   input D,
   input C,
   output Q,
   output \~Q
);
    reg state;

    assign Q = state;
    assign \~Q = ~state;

    always @ (posedge C) begin
        state <= D;
    end

    initial begin
        state = Default;
    end
endmodule


module \CPLD-MAIN  (
  input C25,
  input CPU_nCLK, // CPU Clock Input
  input CPU_RnW, // CPU Read/Write Input
  input [10:0] CPU_A, // CPU Address Input
                      // bits 13-23
  input [7:0] DATA_I, // VRAM Data input
  input DUMMY, // Only needed for my own board,
               // the updated PCB doesn't need this input anymore
  output nIRQ_O, // Interrupt Output
  output [2:0] R_O, // Red Output
  output [2:0] G_O, // Green Output
  output [2:0] B_O, // Blue Output
  output HS_O, // Horizontal Sync Output
  output VS_O, // Vertical Sync Output
  output [12:0] ADDR_O, // Video Address output
  output VRAM_nOE, // VRAM Read
  output CPU_nCS0, // CPU Side VRAM Chip Select 0
  output CPU_nCS1, // CPU Side VRAM Chip Select 1
  output CPU_nCS2, // CPU Side VRAM Chip Select 2
  output CPU_nCS3, // CPU Side VRAM Chip Select 3
  output CPU_nOE, // CPU Side VRAM Read
  output CPU_nWE, // CPU Side VRAM Write
  output VRAM_nCS0, // VRAM Chip Select 0
  output VRAM_nCS1, // VRAM Chip Select 1
  output VRAM_nCS2, // VRAM Chip Select 2
  output VRAM_nCS3, // VRAM Chip Select 3
  output CPU_nWSE // CPU Side Wait State Enable

);
  wire \~C25/8 ;
  wire C25not8;
  wire ACT;
  wire IRQ;
  wire s0;
  wire s1;
  wire s2;
  wire [14:0] s3;
  wire s4;
  wire s5;
  wire s6;
  wire s7;
  wire [2:0] s8;
  wire [2:0] DIV;
  wire [7:0] s9;
  wire s10;
  wire s11;
  wire s12;
  wire s13;
  wire s14;
  wire s15;
  wire s16;
  wire s17;
  wire s18;
  wire s19;
  wire s20;
  wire [7:0] s21;
  wire s22;
  // DIV
  DIG_Counter_Nbit #(
    .Bits(3)
  )
  DIG_Counter_Nbit_i0 (
    .en( 1'b1 ),
    .C( C25 ),
    .clr( 1'b0 ),
    .out( s8 )
  );
  assign CPU_nOE = (~ CPU_RnW | CPU_nCLK);
  assign CPU_nWE = (CPU_nCLK | CPU_RnW);
  assign s19 = (CPU_A[2] & CPU_A[3] & CPU_A[4] & CPU_A[5] & CPU_A[6] & CPU_A[7] & CPU_A[8] & CPU_A[9] & CPU_A[10]);
  assign s6 = CPU_A[0];
  assign s7 = CPU_A[1];
  assign CPU_nWSE = ~ s19;
  assign CPU_nCS3 = ~ (s6 & s7 & s19);
  assign CPU_nCS2 = ~ (~ s6 & s7 & s19);
  assign CPU_nCS1 = ~ (s6 & ~ s7 & s19);
  assign CPU_nCS0 = ~ (~ s6 & ~ s7 & s19);
  // DELAY
  DIG_D_FF_Nbit #(
    .Bits(3),
    .Default(0)
  )
  DIG_D_FF_Nbit_i1 (
    .D( s8 ),
    .C( C25 ),
    .Q( DIV )
  );
  assign s22 = ~ s8[2];
  assign C25not8 = DIV[2];
  assign \~C25/8  = ~ C25not8;
  CPLD_SYNC CPLD_SYNC_i2 (
    .nC25not8( \~C25/8  ),
    .C25not8( C25not8 ),
    .ACT( ACT ),
    .\~HS ( HS_O ),
    .\~VS ( VS_O ),
    .IRQ_S( IRQ )
  );
  // CNT
  DIG_Counter_Nbit #(
    .Bits(15)
  )
  DIG_Counter_Nbit_i3 (
    .en( ACT ),
    .C( C25not8 ),
    .clr( IRQ ),
    .out( s3 )
  );
  assign VRAM_nOE = ~ ACT;
  // D0
  DIG_Register_BUS #(
    .Bits(8)
  )
  DIG_Register_BUS_i4 (
    .D( DATA_I ),
    .C( s22 ),
    .en( ACT ),
    .Q( s21 )
  );
  // D1
  DIG_Register_BUS #(
    .Bits(8)
  )
  DIG_Register_BUS_i5 (
    .D( s21 ),
    .C( \~C25/8  ),
    .en( ACT ),
    .Q( s9 )
  );
  assign ADDR_O = s3[12:0];
  assign s4 = s3[13];
  assign s5 = s3[14];
  assign VRAM_nCS3 = ~ (s4 & s5);
  assign VRAM_nCS2 = ~ (~ s4 & s5);
  assign VRAM_nCS1 = ~ (s4 & ~ s5);
  assign VRAM_nCS0 = ~ (~ s4 & ~ s5);
  assign s10 = s9[0];
  assign s11 = s9[1];
  assign s12 = s9[2];
  assign s13 = s9[3];
  assign s14 = s9[4];
  assign s15 = s9[5];
  assign s16 = s9[6];
  assign s17 = s9[7];
  Mux_8x1 Mux_8x1_i6 (
    .sel( DIV ),
    .in_0( s17 ),
    .in_1( s16 ),
    .in_2( s15 ),
    .in_3( s14 ),
    .in_4( s13 ),
    .in_5( s12 ),
    .in_6( s11 ),
    .in_7( s10 ),
    .out( s20 )
  );
  assign s18 = (ACT & s20);
  assign R_O[0] = s18;
  assign R_O[1] = s18;
  assign R_O[2] = s18;
  assign G_O[0] = s18;
  assign G_O[1] = s18;
  assign G_O[2] = s18;
  assign B_O[0] = s18;
  assign B_O[1] = s18;
  assign B_O[2] = s18;
  DIG_JK_FF #(
    .Default(0)
  )
  DIG_JK_FF_i7 (
    .J( IRQ ),
    .C( C25 ),
    .K( s0 ),
    .Q( s1 )
  );
  DIG_D_FF_1bit #(
    .Default(0)
  )
  DIG_D_FF_1bit_i8 (
    .D( s1 ),
    .C( CPU_nCLK ),
    .Q( s2 )
  );
  DIG_D_FF_1bit #(
    .Default(0)
  )
  DIG_D_FF_1bit_i9 (
    .D( s2 ),
    .C( CPU_nCLK ),
    .Q( s0 )
  );
  assign nIRQ_O = ~ (s2 | s0);
endmodule
