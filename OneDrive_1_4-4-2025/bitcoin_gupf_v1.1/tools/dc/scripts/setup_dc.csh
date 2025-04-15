#! /bin/csh

if (! -e results_bit_slice) then
  mkdir results_bit_slice
endif

if (! -e results_bit_top) then
  mkdir results_bit_top
endif

if (! -e results_bit_coin) then
  mkdir results_bit_coin
endif

if (! -e logs) then
  mkdir logs
endif

if (! -e reports) then
  mkdir reports
endif

if (! -e reports_bit_slice_quick) then
  mkdir reports_bit_slice_quick
endif
