`timescale 1ns / 1ps



module codificador
    #(parameter number_ports = 2)
    (

        
        input reset_found,
        input [number_ports - 1: 0] request,
        output [$clog2(number_ports) - 1: 0] rotated_chosen

    );
    
    
    
    reg found;
    reg [$clog2(number_ports) - 1: 0] aux_chosen;
    
    integer i;
    
    always @(posedge reset_found)
    begin
    
        found = 1'b0;
    
    end
    
    
    
    always @(*)begin
    
        for(i = 0; i < number_ports; i = i + 1)
        begin
        
        
            if(request[i] == 1'b1)
            begin
            
                if(found == 1'b0)
                begin
                
                    found = 1'b1;
                    aux_chosen = i;
                
                end
            
            
            end
        
        end
        
    end
    
    
    assign rotated_chosen = aux_chosen;
    
    
endmodule
