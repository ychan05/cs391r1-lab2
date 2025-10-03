`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2025 02:41:39 PM
// Design Name: 
// Module Name: light_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module light_controller #(parameter N) (
    input wire clk,
    input wire rst,
    input wire button,
    output wire [2:0] light_state
    );
    
   reg [2:0] light_state_reg;
   reg button_prev;
   reg [31:0] counter;
   
    assign light_state = light_state_reg;
    
   always @ (posedge clk) begin
        if (rst) begin 
            button_prev <= 1'b0;
            light_state_reg <= 3'b0;
            counter <= 0;
        end else begin
            if (!button) begin
                light_state_reg <= 3'b0;
                counter <= 0;
            end else if (button > button_prev) begin
                light_state_reg <= 1;
                counter <= 0;
            end 
            
            else if (button == button_prev) begin
                if (counter == N - 1) begin 
                    counter <= 0;
                    if (light_state_reg == 3'b111)  
                        light_state_reg <= 3'b001; // wrap to 1
                    else 
                        light_state_reg <= light_state_reg + 3'b001;
              end else begin
                counter <= counter + 1;
              end 
           end 
           
           button_prev <= button;
       end
            
   end
        
endmodule
