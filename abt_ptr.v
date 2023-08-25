`timescale 1ns / 1ps



module abt_ptr

    #(parameter number_ports = 2)

    (

    input clk,
    input reset,
    input increment,
    input [$clog2(number_ports) - 1 : 0] chosen,
    output [$clog2(number_ports) - 1 : 0] pointer

    );
    
    
    reg [$clog2(number_ports) - 1 : 0] ptr;
    
    
    
    always @(posedge clk)
    begin
    
        
        if(reset == 1'b1)
        begin
        
            ptr = {128{1'b0}};
        
        end
    
        if(increment == 1'b1)
        begin
        
            if(chosen == pointer)
            begin
        
                if(ptr == number_ports - 1)
                begin
                
                     ptr = {128{1'b0}};
                
                end
                else
                begin
                
                    ptr = ptr + 1;
                
                end
            end
        
        end
    
    end
    
    
    assign pointer = ptr;
   
    
    
endmodule
