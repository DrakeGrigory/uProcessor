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