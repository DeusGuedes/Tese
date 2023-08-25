`timescale 1ns / 1ps



module slip
    
    #(parameter number_ports = 4)
        
        
    (
        
        input clk,
        input reset,
        input [(number_ports * number_ports) - 1: 0 ] request,
        output [(($clog2(number_ports)) * number_ports) - 1: 0] destinations
            
    
    );
    
    reg[(number_ports * number_ports) - 1 : 0] aux_sending; 
    reg[(number_ports * number_ports) - 1 : 0] request_sending;
    wire[(($clog2(number_ports)) * number_ports) - 1: 0] chosen_sending;
    
    reg[(number_ports * number_ports) - 1 : 0] aux_receiving;    
    reg[(number_ports * number_ports) - 1 : 0] request_receiving;
    wire[(($clog2(number_ports)) * number_ports) - 1: 0] chosen_receiving;
    
    reg[1:0] state;
    reg[1:0] next_state;
    
    reg increment_sending;
    reg increment_receiving;
    
    localparam[1:0] request_state = 2'b00;
    localparam[1:0] grant_state = 2'b01;
    localparam[1:0] accept_state = 2'b10;
    localparam[1:0] reset_state = 2'b11;
    
    genvar i;
    genvar j;
    
    integer x;
    integer y;
    
    
    always @(posedge clk)
    begin
    
        if(reset == 1'b1)
        begin
        
            state = reset_state;
            next_state = reset_state;
        
        end
        else
        begin
        
            state = next_state;
            
        end  
    end
      
    
    always @(state)
    begin
    
        case (state)
        
        
            reset_state: begin
            
                increment_sending = 1'b0;
                increment_receiving = 1'b0;
            
                next_state = request_state;
             
            end
            
            
            request_state: begin
                
                request_sending = request;
                          
                increment_sending = 1'b0;
                increment_receiving = 1'b0;
                
                next_state = grant_state;
                
            end
                
                
            grant_state:  begin
                
                request_receiving = aux_receiving;
                            
                increment_sending = 1'b0;
                increment_receiving = 1'b1;
                            
                next_state = accept_state;
            
            end
                
                
            accept_state: begin
                    
                
                request_sending = aux_sending;
                
                increment_sending = 1'b1;
                increment_receiving = 1'b0;
                
                next_state = request_state;
                
            end
            
        endcase        
    
    end
    
    generate
    
        for(i = 0; i < number_ports; i = i + 1)
        begin
        
            arbitrer #(.number_ports(number_ports)) sending_arbitrer(
            
                .clk(clk),
                .reset(reset),
                .increment(increment_sending),
                .request(request_sending[i * number_ports +: number_ports]),
                .chosen(chosen_sending[i * $clog2(number_ports) +: $clog2(number_ports)])
            
            
            );
        
        
        end
    
    endgenerate
    
    generate
        
        for(j = 0; j < number_ports; j = j + 1)
        begin
        
            arbitrer #(.number_ports(number_ports)) receiving_arbitrer(
            
                .clk(clk),
                .reset(reset),
                .increment(increment_receiving),
                .request(request_receiving[j * number_ports +: number_ports]),
                .chosen(chosen_receiving[j * $clog2(number_ports) +: $clog2(number_ports)])
            
            
            );
        
        end
    
    endgenerate
    
    
    always @(posedge clk)
    begin
    
        for(x = 0; x < number_ports; x = x + 1)
        begin
        
            for(y = 0; y < number_ports; y = y + 1)
            begin
            
                if(chosen_receiving[x*($clog2(number_ports))  +: $clog2(number_ports)] == y)
                begin
                
                    aux_sending[y * number_ports + x] = 1'b1;
           
                end
                else
                begin
                
                    aux_sending[y * number_ports + x] = 1'b0;
           
                
                end
            
            end
        
        end
     
    end
    
    
    always@(posedge clk)
    begin
    
         for(x = 0; x < number_ports; x = x + 1)
        begin
        
            for(y = 0; y < number_ports; y = y + 1)
            begin
            
                if(request[x * number_ports + y ] == 1'b1)
                begin
                    aux_receiving[y * number_ports + x] = 1'b1;
                end
                else
                begin
                    aux_receiving[y * number_ports + x] = 1'b0;
                end
            
            end
        
        end
    
    
    end
    
    
    assign destinations = chosen_sending;
    
endmodule
