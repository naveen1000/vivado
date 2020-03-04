`timescale 1ns / 1ps 
module core (
  input clk,
  output LED0,
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  output LED6,
  output LED7);
    // Registers
    reg [0:7] regArray [0:7]; // General Purpose
    reg [0:7] pc = 0; // Program counter
    reg [0:15] ir; // Instruction register

    // Memory
    reg [0:16] memory [0:256];

    reg [0:4] opcode;
    reg [0:2] regSel1;
    reg [0:2] regSel2;
    reg [0:2] regSel3;
    reg [0:7] immediate;

    reg [0:16] tmp;

    integer i;

    initial begin
        // Set the registers values to 0
        for (i = 0; i < 8; i = i + 1)
            regArray[i] <= 0;
        
       // $readmemb("program.bin", memory); // Load program
        memory[0]=16'b01000_001_00000011;//ldi r0 0
        memory[1]=16'b01000_010_00000010;//INC R0
        memory[2]=16'b00000_000_0001_0010;//JMP 1
        /*memory[3]=16'b01110_000_00000010;
        memory[4]=16'b01000_000_10000000;
        memory[5]=16'b10010_000_0001_0000;
        memory[6]=16'b01110_000_00000101;
        memory[7]=16'b01111_000_0000_0001;*/
        //memory[9]=16'b;
    end

    always @(posedge clk) begin
        ir = memory[pc];
        //$display("ir=%b",ir);
        opcode = ir[0:4];
        regSel1 = ir[5:7];
        regSel2 = ir[9:11];
        regSel3 = ir[13:15];
        immediate = ir[8:15];

        pc = pc + 1;
        
        case (opcode)
            5'b00000: // ADD
                begin
                regArray[regSel1] = regArray[regSel2] + regArray[regSel3];
                //$display("added");
                end
            5'b00001: // SUB
                regArray[regSel1] = regArray[regSel2] - regArray[regSel3];
            5'b00010: // AND
                regArray[regSel1] = regArray[regSel2] & regArray[regSel3];
            5'b00011: // OR
                regArray[regSel1] = regArray[regSel2] | regArray[regSel3];
            5'b00100: // XOR
                regArray[regSel1] = regArray[regSel2] ^ regArray[regSel3];
            5'b00101: // INV
                regArray[regSel1] = ~ regArray[regSel1];
            5'b00110: // SHL
                regArray[regSel1] = regArray[regSel1] << regArray[regSel2];
             5'b00111: // MOV
                regArray[regSel1] =  regArray[regSel2];
            5'b01000: // LDI
                begin
                regArray[regSel1] = immediate;
                //$display("loaded");
                end
            5'b01010: // INC
                begin
                regArray[regSel1] = regArray[regSel1] + 8'h01;
                //$display("INC");
                end
            5'b01011: // DEC
                regArray[regSel1] = regArray[regSel1] - 8'b00000001;
            5'b01110: // JNZ
                pc = (regArray[regSel1] == 0) ? pc : immediate;
            5'b01111: // JMP
                 pc = immediate;
            5'b10000: // LDM
                regArray[regSel1] = memory[immediate];
            5'b10001: // STM
                 memory[immediate] = regArray[regSel1];
            5'b10010: // SHR
                regArray[regSel1] = regArray[regSel1] >> regArray[regSel2];
        endcase
    end
    assign {LED0,LED1,LED2,LED3,LED4,LED5,LED6,LED7} = regArray[0][0:7];

endmodule