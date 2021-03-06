module vga(clk,rst_n,vga_r,vga_g,vga_b,hsync_r,vsync_r);
input clk,rst_n;
output vga_r,vga_g,vga_b,vsync_r,hsync_r;
reg [11:0] x_cnt;
reg [9:0] y_cnt;
reg hsync_r;
reg vsync_r;

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) x_cnt <= 0;
	else if(x_cnt == 12'd1039) x_cnt <= 0;
	else x_cnt <= x_cnt + 1'b1;
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) y_cnt <= 0;
	else if(y_cnt == 10'd687) y_cnt <= 0;
	else if(x_cnt == 12'd1039) y_cnt <= y_cnt + 1'b1;
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) hsync_r <= 1;
	else if(x_cnt == 0) hsync_r <= 0;
	else if(x_cnt == 12'd120) hsync_r <= 1;
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) vsync_r <= 1;
	else if(y_cnt == 0) vsync_r <= 0;
	else if(y_cnt == 10'd6) vsync_r <= 1;
end

reg vga_r,vga_g,vga_b;

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		vga_r <= 0;
		vga_g <= 0;
		vga_b <= 0;
	end else begin
		if(y_cnt < 10'd31) begin vga_r <= 0; vga_g <= 0; vga_b <= 0; end
		else if(y_cnt <= 10'd121) begin vga_r <= 1; vga_g <= 0; vga_b <= 0; end
		else if(y_cnt <= 10'd211) begin vga_r <= 1; vga_g <= 1; vga_b <= 0; end
		else if(y_cnt <= 10'd301) begin vga_r <= 0; vga_g <= 1; vga_b <= 1; end
		else if(y_cnt <= 10'd391) begin vga_r <= 0; vga_g <= 1; vga_b <= 0; end
		else if(y_cnt <= 10'd481) begin vga_r <= 1; vga_g <= 0; vga_b <= 1; end
		else if(y_cnt <= 10'd571) begin vga_r <= 0; vga_g <= 0; vga_b <= 1; end
		else if(y_cnt <= 10'd631) begin vga_r <= 1; vga_g <= 1; vga_b <= 1; end
		else begin vga_r <= 0; vga_g <= 0; vga_b <= 0; end
	end
end

endmodule