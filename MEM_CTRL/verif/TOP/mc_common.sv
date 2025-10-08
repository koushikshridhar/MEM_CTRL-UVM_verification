//MC address defines used for TB
`define CSR_ADDR 		'h0
`define POC_ADDR 		'h4
`define BA_MASK_ADDR 'h8
`define CSC0_ADDR 	'h10
`define TMS0_ADDR 	'h14
`define CSC1_ADDR 	'h18
`define TMS1_ADDR 	'h1c
`define CSC2_ADDR 	'h20
`define TMS2_ADDR 	'h24
`define CSC3_ADDR 	'h28
`define TMS3_ADDR 	'h2c
`define CSC4_ADDR 	'h30
`define TMS4_ADDR 	'h34
`define CSC5_ADDR 	'h38
`define TMS5_ADDR 	'h3c
`define CSC6_ADDR 	'h40
`define TMS6_ADDR 	'h44
`define CSC7_ADDR 	'h48
`define TMS7_ADDR 	'h4c

//Register Mask Value
`define CSR_MASK 		32'hFF00_0706
`define POC_MASK 		32'hFFFF_FFFF
`define BA_MASK_MASK 32'h0000_00FF
`define CSCn_MASK 	32'h00FF_0FFF
`define TMSn_MASK 	32'hFFFF_FFFF

//CS : Memory Start Addr and End Addr
`define CS0_START_ADDR	32'h0020_0000    
`define CS0_END_ADDR    32'h003F_FFFF
`define CS1_START_ADDR	32'h0040_0000
`define CS1_END_ADDR		32'h005F_FFFF
`define CS2_START_ADDR	32'h0080_0000
`define CS2_END_ADDR		32'h009F_FFFF
`define CS3_START_ADDR	32'h0100_0000
`define CS3_END_ADDR		32'h011F_FFFF
`define CS4_START_ADDR	32'h0200_0000
`define CS4_END_ADDR		32'h021F_FFFF
`define CS5_START_ADDR	32'h0400_0000
`define CS5_END_ADDR		32'h041F_FFFF
`define CS6_START_ADDR	32'h0800_0000
`define CS6_END_ADDR		32'h081F_FFFF
`define CS7_START_ADDR	32'h1000_0000
`define CS7_END_ADDR		32'h101F_FFFF


