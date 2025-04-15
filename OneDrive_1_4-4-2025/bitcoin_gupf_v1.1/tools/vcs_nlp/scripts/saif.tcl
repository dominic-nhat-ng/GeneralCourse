saif -region bitcoin -depth 0 bitcoin_top.dut
saif -start bitcoin
run 1ns
saif -stop bitcoin
saif -report bitcoin.saif -tres 1e-12 -region bitcoin
quit
