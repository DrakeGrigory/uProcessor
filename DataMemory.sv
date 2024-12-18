module DataMemory  #(parameter DataWidth = 8, parameter DataLen = 256)(
    input [DataWidth-1:0] Accu,
    input WriteEnable,
    input [DataWidth-1:0] Addr,
    input nReset,
    input clk,
    output reg [DataWidth-1:0] DataOut
);

reg [DataWidth-1:0] DataMem [DataLen-1:0];

integer i=0;
always @(clk) 
begin
    if(nReset==0) begin             //RESET

        for(i=0; i<DataLen; i=i+1) begin
            DataMem[i] = {8'bxxxx_1001};
        end

    end else begin                  //Normal Operations
              
        if(WriteEnable==1) begin    // Write

            DataMem[Addr] = Accu;
            DataOut = 8'b0;
        end else begin              // Read

            DataOut = DataMem[Addr];

        end

    end
end
endmodule