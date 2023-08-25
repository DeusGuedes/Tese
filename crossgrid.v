`timescale 1ns / 1ps

module crossgrid
    
    #(parameter number_ports = 2, parameter data_width = 1)

    (
        input wire [(number_ports ** 2) - 1 : 0] ctr,
        input wire clk,
        input wire [(number_ports * data_width) - 1 : 0] data_in,
        output wire [(number_ports * data_width) - 1 : 0] data_out
         
    );
    
    wire [number_ports * (number_ports + 1) * data_width : 0] aux_horizontal;
    wire [number_ports * (number_ports + 1) * data_width : 0] aux_vertical;
       
    genvar x;
    genvar y;
    genvar z;
    
    for (x = 0; x < number_ports; x = x + 1)
    begin
    
        assign aux_horizontal[x * (number_ports + 1) * data_width + data_width - 1: x * (number_ports + 1) * data_width]
         = data_in[x* data_width + data_width - 1: x * data_width];
    
    end
    
    for( y = 0; y < number_ports * data_width; y = y + 1)
    begin
    
        assign aux_vertical[y] = 1'b1;
    
    end
    
    for(z = 0; z < number_ports; z = z + 1)
    begin
        
        assign data_out[z * data_width + data_width - 1: z * data_width] = aux_vertical[number_ports * data_width * number_ports + z * data_width + data_width - 1
                                                                                     : number_ports * data_width * number_ports + z * data_width];   
    end
    
    genvar i;
    genvar j;
    
    generate
        for(i = 0; i < number_ports ; i = i + 1)
        begin
            for(j = 0; j < number_ports; j = j + 1)
            begin
            
                crossbar #(.data_width(data_width)) crossunit(
                    
                    .clk(clk),
                    .ctr(ctr[i * number_ports + j]),
                    .data_in_a(aux_horizontal[i * (number_ports + 1) * data_width + j* data_width
                                + data_width - 1: i * (number_ports + 1) * data_width
                                 + j* data_width]),
                    .data_in_b(aux_vertical[i * number_ports * data_width + j* data_width
                                + data_width - 1: i * number_ports * data_width
                                 + j* data_width]),
                    .data_out_c(aux_horizontal[i * (number_ports + 1) * data_width + (j + 1)* data_width
                                + data_width - 1: i * (number_ports + 1) * data_width
                                 + (j+1)* data_width]),
                    .data_out_d(aux_vertical[(i+1) * number_ports * data_width + j* data_width
                                + data_width - 1: (i+1) * number_ports * data_width
                                 + j* data_width])
                
                );
                           
            end            
        end
     endgenerate
          
endmodule