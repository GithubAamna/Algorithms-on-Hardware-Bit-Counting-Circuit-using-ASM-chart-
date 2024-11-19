 module part_1(KEY,SW,LEDR,HEX0);
 input [3:0] KEY;
 input [9:0]SW;
 output [9:0] LEDR;
 output [6:0] HEX0;
 
 
 wire load_signal, increment_signal, counter_enable;
 wire [7:0] shifted_A;
 wire [3:0] sum_of_ones;
 wire done_signal;
 
 shift_register #(.N(8)) S1(.clk(KEY[0]),.areset_n(KEY[1]),.load_en(load_signal),.load_input(SW[7:0]),.shift_en(increment_signal),.serial_in(1'b0),.Q(shifted_A));
 
 assign counter_enable = ((shifted_A[0] == 1) & (shifted_A != 0))? 1 : 0;
 
 counter c1(.clk(KEY[0]),.areset_n(KEY[1]),.counter_en(counter_enable),.result(sum_of_ones));
 
 assign done_signal = (shifted_A == 0);
 
 hex_to_sev_seg h1 (.in(sum_of_ones),.display(HEX0));
 
 FSM F1(.clk(KEY[0]),.areset_n(KEY[1]),.s(SW[9]),.done_signal(done_signal),.load_signal(load_signal),.increment_signal(increment_signal),.done(LEDR[9]));
 
 endmodule 
 
 
 module FSM(clk,areset_n,s,done_signal,load_signal,increment_signal,done);
 //writing FSM
 input clk;
 input areset_n;
 input s;
 input done_signal;
 output reg load_signal;
 output reg increment_signal;
 output reg done;
 
 parameter A=2'b00, B= 2'b01, C= 2'b10;
 reg [1:0] p_state, n_state;
 
 always @ (done_signal,s,p_state)begin
	case(p_state)
	A:
		if (s == 1)
			n_state = B;
		else
			n_state = A;
			
	B:
		if (done_signal == 1)
			n_state = C;
		else 
			n_state = B;
	C: 
		if (s == 1 )
			n_state = C;
		else
			n_state = A;
	default: n_state <= A;
	endcase
 
 end
 
 always @ (posedge clk, negedge areset_n)begin
	if (!areset_n)
		p_state <= A;
	else
		p_state <= n_state; 
 
 end
 
 
 
 always @ (*)begin
 
	load_signal <=0;
	increment_signal <=0;
	done <=0;
	
	case (p_state)
	A:
		begin
		load_signal <= 1'b1;
		//sum_of_ones = 1'b0;
		end
	B:
		begin
		increment_signal <= 1'b1;
		end
	C:
		begin
		done<= 1'b1;
		end 
	endcase
 end
 
  
 
 
 endmodule
 
 
 module shift_register
 #(parameter N= 8)
 (input clk,
  input areset_n,
  input load_en,
  input [N-1:0] load_input,
  input shift_en,
  input serial_in,
  output reg [N-1:0]Q);
  
  always @ (posedge clk,negedge areset_n)begin
   if (!areset_n)
		Q <= 0;
		
	else if (load_en)
		Q <= load_input;
		
	else if (shift_en)
		begin
		Q <= (Q >> 1'b1);
		Q[N-1] <= serial_in;  
		end
  end
  
  endmodule
  
  module counter(clk,areset_n,counter_en,result);
  input clk;
  input areset_n;
  input counter_en;
  output reg [3:0] result;
  
  always @ (posedge clk, negedge areset_n)begin
  if (!areset_n)
		result <= 0;
	else if (counter_en)
		result <= result + 1'b1;
    
  end
  endmodule
  
  module hex_to_sev_seg (in,display);
	input [3:0]in;
	output reg[6:0]display;
	
always @ (*)begin
	case(in)
	4'b0000:
		display=7'b1000000;
	4'b0001:
		display=7'b1111001;
	4'b0010:
		display=7'b0100100;
	4'b0011:
		display=7'b0110000;
	4'b0100:
		display=7'b0011001;
	4'b0101:
		display=7'b0010010;
	4'b0110:
		display=7'b0000010;
	4'b0111:
		display=7'b1111000;
	4'b1000:
		display=7'b0000000;
	4'b1001:
		display=7'b0011000;
	4'b1010:
		display=7'b0001000;
	4'b1011:
		display=7'b0000011;
	4'b1100:
		display=7'b1000110;
	4'b1101:
		display=7'b0100001;
	4'b1110:
		display=7'b0000110;
	4'b1111:
		display=7'b0001110;
	
	default: display=7'bxxxxxxx;
	endcase
end
endmodule

  
 
