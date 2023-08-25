`timescale 1ns / 1ps


module crossbar
    
    #(parameter data_width = 1)
    (
        input wire clk,
        input wire ctr,
        input wire [data_width - 1: 0] data_in_a,
        input wire [data_width - 1: 0] data_in_b,
        output reg [data_width - 1: 0] data_out_c,
        output reg [data_width - 1: 0] data_out_d
        
    );
    
    always @(*)
    begin
    
        if(ctr == 1'b0)
        begin
    
            data_out_c = data_in_a;
            data_out_d = data_in_b;
        end
        else
        begin
            data_out_c = data_in_b;
            data_out_d = data_in_a;

        end
    end
        
endmodule