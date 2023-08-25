`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2023 16:44:06
// Design Name: 
// Module Name: Auc
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


module Auc(

    input clk,
    input [4: 0] adress,
    output [4: 0] number


    );
   
   
 /*  reg [4:0] aux;
   
   always @(posedge clk)
   begin
    
      
        aux = {adress[2:0], adress[4:3]};
  end
  
  assign number = aux;
 
 */
 
 assign number = {adress[2:0], adress[4:3]};
 
    
endmodule
