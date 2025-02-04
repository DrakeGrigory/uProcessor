/* WHAT IS THIS? 
// This module is an Data Memory
// It stores DATA_LEN of Registers of DATA_WIDTH width that hold values just like Accumulator.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
*/


module DataMemory  #(parameter DATA_WIDTH = 8, parameter DATA_LEN = 256)(
    input [DATA_WIDTH-1:0] Accu,
    input WriteEnable,
    input [DATA_WIDTH-1:0] Addr,
    input nReset,
    input clk,
    output reg [DATA_WIDTH-1:0] DataOut
);

reg [DATA_WIDTH-1:0] DataMem [DATA_LEN-1:0];

integer i=0;
always @(clk) 
begin
    if(nReset==0) begin             //RESET

        for(i=0; i<DATA_LEN; i=i+1) begin
            DataMem[i] = i;
        end

    end else begin                  //Normal Operations
              
        if(WriteEnable==1) begin    // Write

            DataMem[Addr] = Accu;

        end else begin              // Read
            DataMem[Addr] = DataMem[Addr];


        end

    end
end

always @(*) begin //I wonder what synthesis will discover.
                
    if(WriteEnable==1)
        DataOut = 8'b0;
    else
        DataOut = DataMem[Addr];
end
endmodule