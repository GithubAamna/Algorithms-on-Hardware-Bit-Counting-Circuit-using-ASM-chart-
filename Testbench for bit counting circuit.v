module part_1_tb;
 reg [3:0] KEY;
 reg [9:0]SW;
 wire [9:0] LEDR;
 wire [6:0] HEX0;
 
 wire areset_n;
 wire clk;
 wire s;
 wire [7:0] in;
 
 assign LEDR[8:0]= 9'b0;
 assign s = SW[9];
 assign in = SW[7:0];
 assign areset_n = KEY[1];
 assign clk = KEY[0];
 
 
part_1 DUT(.KEY(KEY),.SW(SW),.LEDR(LEDR),.HEX0(HEX0));

initial
begin
	KEY[0] =0;
	forever begin
	KEY[0] = ~KEY[0] ;#5;
	end
end

initial
begin
	#1000;
	$finish();
end

initial
begin
SW[7:0] = 8'b10101010; 
KEY[1] = 0;#5;
KEY[1] = 1;#5;
SW[9] = 1; #50;

end
endmodule