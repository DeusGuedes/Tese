`timescale 1ns / 1ps



module async_fifos_
    
    #(parameter number_ports = 1, parameter FIFO_DATA_WIDTH = 18, parameter FIFO_ADDR_WIDTH = 4, parameter REG_CLK_IN = 0)
    
    (
     input [number_ports - 1: 0] clk_in,
     input [number_ports - 1: 0] clk_out,
     input [number_ports - 1: 0] reset,
     input [number_ports - 1: 0] write_en,
     input [(FIFO_DATA_WIDTH * number_ports) - 1 :0] data_in,
     input [number_ports - 1: 0] read_en,
     output [(FIFO_DATA_WIDTH * number_ports) - 1:0] data_out,
     output [number_ports - 1: 0] fifo_full,
     output [number_ports - 1: 0] fifo_empty,
     output [(16 * number_ports) - 1:0]  fifo_size,             //Tenho que confirmar isto mais tarde
     output [(16 * number_ports) - 1:0]  fifo_nr_samples        //Same here, tenho que confirmar isto mais tarde
    
    );
    
    
    genvar i;
    
 
    generate
    
        for(i = 0; i < number_ports; i = i+1)
        begin
        
            async_fifo #(.FIFO_DATA_WIDTH(FIFO_DATA_WIDTH), .FIFO_ADDR_WIDTH(FIFO_ADDR_WIDTH), .REG_CLK_IN(REG_CLK_IN)) 
            fifo (
                 .clk_in(clk_in[i]),
                 .clk_out(clk_out[i]),
                 .reset(reset[i]),
                 .write_en(write_en[i]),
                 .data_in(data_in[(FIFO_DATA_WIDTH * i) + FIFO_DATA_WIDTH - 1: FIFO_DATA_WIDTH * i]),
                 .read_en(read_en[i]),
                 .data_out(data_out[(FIFO_DATA_WIDTH * i) + FIFO_DATA_WIDTH - 1: FIFO_DATA_WIDTH * i]),
                 .fifo_full(fifo_full[i]),
                 .fifo_empty(fifo_empty[i]),
                 .fifo_size(fifo_size[(i*16) + 15 : i*16]),
                 .fifo_nr_samples(fifo_nr_samples[(i*16) + 15 : i*16])                        
             ); 
        
        
        end
        
        
        
    endgenerate
    
endmodule
