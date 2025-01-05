module testbench;
    reg [1:0] a, b;      
    reg cin;             
    wire cout;            
    wire [1:0] sum;       

    Full_Adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .cout(cout),
        .sum(sum)
    );

    reg [3:0] result; 

    initial begin
        $display("-------------------------------------------------------------");
        $display("|  a  |  b  | cin | Expected |  Actual  |    Result         |");
        $display("-------------------------------------------------------------");

        for (int i = 0; i < 20; i++) begin
            a = $urandom_range(0, 3);  
            b = $urandom_range(0, 3);  
            cin = $urandom_range(0, 1);

            result = a + b + cin;

            #1;

            if (result == {cout, sum}) begin
                $display("|  %2d  |  %2d  |  %1d  |   %3d    |  %3d     |  >> PASSED <<  |", 
                         a, b, cin, result, {cout, sum});
            end else begin
                $display("|  %2d  |  %2d  |  %1d  |   %3d    |  %3d     |  >> FAILED <<  |", 
                         a, b, cin, result, {cout, sum});
            end
        end

        $display("-------------------------------------------------------------");
        $finish; 
    end
endmodule

