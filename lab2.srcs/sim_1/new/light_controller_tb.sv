`timescale 1ns/1ps

module tb_light_controller;

    reg clk;
    reg rst;
    reg button;

    wire [2:0] light_state_N1;
    wire [2:0] light_state_N10;
    wire [2:0] light_state_3seconds;

    light_controller #(.N(1)) dut_N1 (
        .clk(clk),
        .rst(rst),
        .button(button),
        .light_state(light_state_N1)
    );

    light_controller #(.N(10)) dut_N10 (
        .clk(clk),
        .rst(rst),
        .button(button),
        .light_state(light_state_N10)
    );

    light_controller #(.N(300000000)) dut_3seconds (
        .clk(clk),
        .rst(rst),
        .button(button),
        .light_state(light_state_3seconds)
    );

    always #5ns clk = ~clk;

    initial begin
        clk    = 0;
        rst    = 1;
        button = 0;

        repeat (2) @(posedge clk); rst = 0;

        button = 1;
        repeat(50) @(posedge clk);
        button = 0;

        repeat(10) @(posedge clk);
    end

endmodule