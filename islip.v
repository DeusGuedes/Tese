`timescale 1ns / 1ps


module islip

        #(parameter number_ports = 4)

        (

        input clk,
        input reset,
        input [(number_ports * number_ports) - 1: 0 ] request,
        output [(($clog2(number_ports)) * number_ports) - 1: 0] destinations
    
    );
    
    
    localparam[1:0] request_state = 2'b00;
    localparam[1:0] grant_state = 2'b01;
    localparam[1:0] accept_state = 2'b10;
    localparam[1:0] reset_state = 2'b11;
    
    reg[1:0] state;
    reg[1:0] next_state;
    
    reg [number_ports - 1: 0] increment_sending;
    reg [number_ports - 1: 0] increment_receiving;
    
    wire [number_ports -1: 0] given_sending;
    wire [number_ports -1: 0] given_receiving;
    
    wire [(($clog2(number_ports)) * number_ports) - 1: 0] sending_pointer;
    wire [(($clog2(number_ports)) * number_ports) - 1: 0] receiving_pointer;
    
    reg [(($clog2(number_ports)) * number_ports) - 1: 0] grant_signal;
    reg [number_ports - 1: 0] grant_given;
    reg grant_enable;
    
    wire [(($clog2(number_ports)) * number_ports) - 1: 0] accept_signal;
    wire [number_ports - 1: 0] accept_given;
       
    reg increment_enable;
    
    reg[(number_ports * number_ports) - 1 : 0] aux_sending; 
    reg[(number_ports * number_ports) - 1 : 0] request_sending;
    wire[(($clog2(number_ports)) * number_ports) - 1: 0] chosen_sending;
    
    reg[(number_ports * number_ports) - 1 : 0] aux_receiving;
    reg[(number_ports * number_ports) - 1 : 0] request_receiving;
    wire[(($clog2(number_ports)) * number_ports) - 1: 0] chosen_receiving;
    
    
    genvar i;
    genvar j;
    genvar ii;
    genvar jj;
    
      
    integer x;
    integer y;
    integer z;
    
    
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
                     
                grant_enable = 1'b0;
                increment_enable = 1'b0;
                     
                next_state = request_state;
             
            end
                       
            request_state: begin
                
                request_sending = request;
                grant_enable = 1'b0;
                increment_enable = 1'b0;
                                          
                next_state = grant_state;
                
            end
 
                               
            grant_state:  begin
                
                request_receiving = aux_receiving;
                grant_enable = 1'b1; 
                increment_enable = 1'b0;
                                          
                next_state = accept_state;
            
            end
                
                
            accept_state: begin
                    
                request_sending = aux_sending;
                grant_enable = 1'b0;
                increment_enable = 1'b1;
                        
                next_state = request_state;
                
            end
            
        endcase     
         
    end
    
    
    generate
    
        for(i = 0; i < number_ports; i = i + 1)
        begin
        
            arbitrer #(.number_ports(number_ports)) sending_arbitrer(
            
                .clk(clk),
                .request(request_sending[i * number_ports +: number_ports]),
                .chosen(chosen_sending[i * $clog2(number_ports) +: $clog2(number_ports)]),
                .pointer(sending_pointer[i * $clog2(number_ports) +: $clog2(number_ports)]),
                .given(given_sending[i])
            
            
            );
        
        
        end
    
    endgenerate
    
    generate
        
        for(j = 0; j < number_ports; j = j + 1)
        begin
        
            arbitrer #(.number_ports(number_ports)) receiving_arbitrer(
            
                .clk(clk),
                .request(request_receiving[j * number_ports +: number_ports]),
                .chosen(chosen_receiving[j * $clog2(number_ports) +: $clog2(number_ports)]),
                .pointer(receiving_pointer[j * $clog2(number_ports) +: $clog2(number_ports)]),
                .given(given_receiving[j])
            
            );
        
        end
    
    endgenerate
    
    
    
    generate
    
        for(ii = 0; ii < number_ports; ii = ii + 1)
        begin
        
            abt_ptr #(.number_ports(number_ports)) sending_arbitrer_pointer(
            
                .clk(clk),
                .reset(reset),
                .increment(increment_sending[ii]),
                .chosen(accept_signal[ii * ($clog2(number_ports)) +: $clog2(number_ports)]),
                .pointer(sending_pointer[ii * ($clog2(number_ports)) +: $clog2(number_ports)])
            
            );
        
        end
        
    endgenerate
    
    
    generate
    
        for(jj = 0; jj < number_ports; jj = jj + 1)
        begin
        
            abt_ptr #(.number_ports(number_ports)) receiving_arbitrer_pointer(
            
                .clk(clk),
                .reset(reset),
                .increment(increment_receiving[jj]),
                .chosen(grant_signal[jj * ($clog2(number_ports)) +: $clog2(number_ports)]),
                .pointer(receiving_pointer[jj * ($clog2(number_ports)) +: $clog2(number_ports)])
            
            );
        
        end
        
    endgenerate
        
        
    always @(posedge clk)
    begin
    
        if(grant_enable == 1'b1)
        begin
        
            grant_signal = chosen_receiving;
            grant_given = given_receiving;
            
        end
    
    end  
    
    assign accept_signal = chosen_sending;
    assign accept_given = given_sending;
    
    
    always @(*)
    begin
    
        for(x = 0; x < number_ports; x = x + 1)
        begin
        
            increment_sending[x] = given_sending[x] & increment_enable;
        
            if(given_receiving[x] == 1'b1)
            begin
            
                y = chosen_receiving[x*($clog2(number_ports))  +: $clog2(number_ports)];
                
                z = chosen_sending[y*($clog2(number_ports))  +: $clog2(number_ports)];
                
                if(z == x)
                begin
                
                    increment_receiving[x] = increment_enable;
                
                end
                else
                begin
                
                    increment_receiving[x] = 1'b0;
                
                end
            
            end
        
        end
    
    end
       
    
    always @(posedge clk)
    begin
    
        for(x = 0; x < number_ports; x = x + 1)
        begin
        
            for(y = 0; y < number_ports; y = y + 1)
            begin
            
                if(chosen_receiving[x*($clog2(number_ports))  +: $clog2(number_ports)] == y)
                begin
                     
                    if(given_receiving[x] == 1'b1)
                    begin
                        aux_sending[y * number_ports + x] = 1'b1;
                    end
                    else
                    begin
                        
                        aux_sending[y * number_ports + x] = 1'b0;
                    end
                        
                    
           
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
