`timescale 1ns / 1ps



module arbitrer
        #(parameter number_ports = 4)
        
        (        
            input clk,
            input [number_ports - 1: 0] request,
            input [$clog2(number_ports) - 1 : 0] pointer,
            output reg [$clog2(number_ports) - 1: 0] chosen,
            output reg given
            
        
        );

           wire[number_ports - 1 : 0] aux;
           wire [$clog2(number_ports) - 1: 0] rotated_chosen;
           
           reg reset_found;
            
           always @(negedge clk)
           begin
           
              reset_found = 1'b1;  
           
           end
     
           
           always @(posedge clk)
           begin
           
                reset_found = 1'b0;
           
           end
            
            
          assign aux = (request>>pointer) | (request<<(number_ports - pointer)) ;
          
          codificador #(.number_ports(number_ports)) coder(
          
            .reset_found(reset_found),
            .request(aux),
            .rotated_chosen(rotated_chosen)
          
          );
          
          
          always @(*)
          begin
              if(rotated_chosen + pointer > (number_ports - 1))
              begin
                    assign chosen = rotated_chosen - (number_ports - pointer);
              end
              else
              begin
                    assign chosen = pointer + rotated_chosen;
              end
              
              if(request == 0)
              begin
              
                given = 1'b0;
              
              end
              else
              begin
              
                given = 1'b1;
              
              end
              
              
          end
          
       
endmodule
