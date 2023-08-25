`timescale 1ns / 1ps



module cross_control

    #(parameter number_ports = 2)

    (

        input [(($clog2(number_ports)) * number_ports) - 1: 0] destinations,
        output reg [(number_ports ** 2) - 1: 0]   ctr 

    );


    integer i;
    integer j;
    integer x;
    
    
    always @(*)
    begin
    
        for(i = 0; i < number_ports; i = i + 1)
        begin
        
        
            for(j = 0; j < number_ports; j = j + 1)
            begin
                      
                if(j < destinations[i* ($clog2(number_ports)) +: ($clog2(number_ports))])
                begin
                    ctr[i * number_ports + j ] = 1'b0;
                end
                else
                begin
                    ctr[i * number_ports + j ] = 1'b1;
                end    
                 
            
            end
        
        end
    end


endmodule
