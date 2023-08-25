`timescale 1ns / 1ps



module testbench(


    );
    
    
    
    // Crossgrid testbench starting here
    ///////////////////////////////////
    ///////////////////////////////////
    
    /*
    
    reg clk;
    reg reset;
    reg [5:0] a;
    reg [8:0] ctr;
    wire [5:0] c;
    
    crossgrid #(.number_ports(3),  .data_width(2)) cross(
        .data_in(a),
        .data_out(c),    
        .ctr(ctr),
        .clk(clk)
        
    
    );
    
    initial begin
    
    a = 6'b100100;
    ctr = 9'b001100010;
    
    end
    
    initial begin

    clk = 1'b0;
    forever #1 clk = ~clk;
    end

   */
   
   
   //ASYNC_FIFO testbench starting here
   ////////////////////////////////////
   ////////////////////////////////////
   
   /*
   
   reg clk_in;
   reg clk_out;
   reg reset;
   reg write_en;
   reg read_en;
   wire fifo_full;
   wire fifo_empty;
   reg [1:0] data_in;
   wire [1:0] data_out;
   wire [15:0] fifo_size;
   wire [15:0] fifo_nr_samples;
   
   
   
    async_fifo #( .FIFO_DATA_WIDTH(2), .FIFO_ADDR_WIDTH(4)) fifos(
   
        .clk_in(clk_in),
        .clk_out(clk_out),
        .reset(reset),
        .write_en(write_en),
        .read_en(read_en),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .data_in(data_in),
        .data_out(data_out),
        .fifo_size(fifo_size),
        .fifo_nr_samples(fifo_nr_samples)
   
   
   
   );
   
   
   initial begin
   
        reset = 1'b1;
        read_en = 1'b0;
        write_en = 1'b0;
        data_in = 2'b10;
   
        
        #10
        
        reset = 1'b0;
        write_en = 1'b1;
        
       
       #91
       write_en = 1'b0;
       read_en = 1'b1;
       
       #5
       
       read_en = 1'b0;
        
  end
   
   initial begin
   
       clk_in = 1'b0;
     
       forever #4 clk_in = ~clk_in;
           
   end
   
   initial begin
   
       #2
   
       clk_out = 1'b0;
     
       forever #4 clk_out = ~clk_out;
           
   end
      
   */
   
   //async_fifos testbench starting here
   /////////////////////////////////// 
   ///////////////////////////////////
 
   
   /*
   
   reg clk;
   reg [1:0] clk_in;
   reg [1:0] clk_out;
   reg [1:0] reset;
   reg [1:0] write_en;
   reg [1:0] read_en;
   wire [1:0] fifo_full;
   wire [1:0] fifo_empty;
   reg [3:0] data_in;
   wire [3:0] data_out;
   wire [31:0] fifo_size;
   wire [31:0] fifo_nr_samples;
   
   
   async_fifos_ #(.number_ports(2), .FIFO_DATA_WIDTH(2), .FIFO_ADDR_WIDTH(4)) fifos(
   
        .clk_in(clk_in),
        .clk_out(clk_out),
        .reset(reset),
        .write_en(write_en),
        .read_en(read_en),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty),
        .data_in(data_in),
        .data_out(data_out),
        .fifo_size(fifo_size),
        .fifo_nr_samples(fifo_nr_samples)
   
   
   
   );
   
   
   initial begin
   
    clk_in = 2'b00;
    
    #4
    
    clk_out = 2'b00;
    
   end
   
   initial begin
   
       
       reset = 2'b11;
       write_en = 2'b00;
       read_en = 2'b00;
       data_in = 4'b1110;
       
       #10
       
       reset = 2'b00;
       
       #131
       
       write_en = 2'b11;
       
       
       #25
       
       write_en = 2'b00;
       read_en = 2'b01;
       
       #50
       
       read_en = 2'b00;
       
       #99
       
       write_en = 2'b11;
       
       #8
       
       write_en = 2'b00;
       
       
       
   
   end
   
   always @(posedge clk)
   begin
   
        if(clk_in == 2'b00)
        begin
        
            clk_in <= 2'b11;
             
        end
        else      
        begin
            clk_in <= 2'b00;           
      
        end
        
        if(clk_out == 2'b00)
        begin
        
            clk_out <= 2'b11;
        
        end
        else
        begin
        
            clk_out <= 2'b00;
        
        end    
        
        
        
   
   end
   
   
   
   initial begin
   
       clk = 1'b0;
     
       forever #4 clk = ~clk;
       
   
   end 
   
   
   
   
   
   //auc testbench starting here
   /////////////////////////////////// 
   ///////////////////////////////////
   
   
   /*
   
   reg clk;
   reg [4:0] adress;
   wire[4:0] number;
    
    
   Auc aux(
   
        .clk(clk),
        .adress(adress),
        .number(number)
   
   ) ;
    
    
   initial begin
   
        adress = 5'b00001;
   
   end 
   
   initial begin
   
     clk <= 1'b0;
     
     forever #4 clk = ~clk;
   
   end
    
    */
    
    
    
    //arbitrer testbench starting here
   /////////////////////////////////// 
   ///////////////////////////////////
   
   /*
    
    reg clk;
    reg [5:0] request;
    reg [2:0] pointer;
    wire [2:0] chosen;
    
    arbitrer #(.number_ports(6)) arbitro(
    
        .clk(clk),
        .request(request),
        .pointer(pointer),
        .chosen(chosen)
    
    );
    
    
    
    initial begin
    
        pointer = 3'b000;
        
        request = 6'b011000;
        
        #5
        
        pointer = 3'b001;
        
        #8
        
        pointer = 3'b010;
    
    
        #8
        
        pointer = 3'b011;
        
        #8
        
        pointer = 3'b100;
    
    
        #8
        
        pointer = 3'b101;
    
    
    
    end
    
    
    initial begin
    
        clk = 1'b0;
        
        forever #4 clk = ~clk;
    
    end
    
    
    
    */
    
   //codificador testbench starting here
   /////////////////////////////////// 
   ///////////////////////////////////
    
   /*
    
    reg reset_found;
    reg [7:0] request;
    wire [2:0] chosen;
    
    
    
    codificador #(.number_ports(8)) coder(
    
        .reset_found(reset_found),
        .request(request),
        .chosen(chosen)
    
    );
    
    
    
    initial begin
    
        request = 8'b10011100;
        reset_found = 1'b0;


        #10
        
        reset_found = 1'b1;   
        
        
        #5
        reset_found = 1'b0;
        
        
        #10 
        request = 8'b10011000;
        reset_found = 1'b1;
        
         
    
    end
    
    
    */
   
   
    //crosscontrol testbench starting here
   /////////////////////////////////// 
   ///////////////////////////////////
   
   /*
   
   reg [5:0] destinations;
   wire [8:0] ctr;
   
   
   
   cross_control #(.number_ports(3)) cross(
   
       .destinations(destinations),
       .ctr(ctr)
   
   );
   
   
   initial begin
   
    destinations = 8'b010010;
   
   end
    
    
    */
    
    
    //islip testbench starting here
   /////////////////////////////////// 
   ///////////////////////////////////
    
 
       
   
    reg clk;
    reg reset;
    reg [15:0] request;
    wire [7:0] destinations;   
    
    
    
    islip #(.number_ports(4)) islip_mod(
    
        .clk(clk),
        .reset(reset),
        .request(request),
        .destinations(destinations)
    
    );
    
    
    
    initial begin
    
    
        reset = 1'b1;
        request = 16'b0000110101110111;
       
        
        #10
        
        reset = 0;
        
        #25
        
        request = 16'b0000000001100000;
    
    
    end
    
    
    initial begin
    
        clk = 1'b0;
        
        forever #4 clk = ~clk;
    
    end
    
    
    
    
    
     //abt_ptr testbench starting here
   /////////////////////////////////// 
   ///////////////////////////////////
    
   /* 
    
    reg reset;
    reg clk;
    reg increment;
    wire [2:0] pointer;
    
    
    abt_ptr #(.number_ports(7)) apontador(
    
        .reset(reset),
        .clk(clk),
        .increment(increment),
        .pointer(pointer)
    
    );
 
 
     initial begin
     
        reset = 1'b1;
     
     
        increment = 1'b1;
        
        #10
        
        reset = 1'b0; 
        
        #20
        
        increment = 1'b0;
         
        #20
        
        increment = 1'b1;
      
     end
 
    
     initial begin
    
        clk = 1'b0;
        
        forever #4 clk = ~clk;
    
    end
    
    */
    
endmodule

