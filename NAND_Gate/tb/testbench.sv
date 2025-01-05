module testbench;
    reg a, b;
    wire out;

    nandgate dut(
        .a(a),
        .b(b),
        .out(out)
    );
    initial begin
        $display("a  b | NAND ");
        $display("-------------");
        for (int i = 0; i < 4; i++) begin
            {a, b} = i;             
            #1;

            $display("%b  %b |  %b  ", a, b, out);
        end
        $finish();
    end



endmodule

