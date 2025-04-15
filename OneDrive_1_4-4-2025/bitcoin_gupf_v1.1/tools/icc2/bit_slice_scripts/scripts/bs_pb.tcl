################################################################################
# Blockages
################################################################################

remove_placement_blockages -all

set blkg [ create_placement_blockage -name auto_generate_blockage0 -type soft \
    -purpose system -boundary { {1.6720 8.9300} {3.3440 63.5360} } ]
set_attribute -objects $blkg -name is_derived -value true
set blkg [ create_placement_blockage -name auto_generate_blockage1 -type soft \
    -purpose system -boundary { {146.9450 59.9910} {198.2080 65.2080} } ]
set_attribute -objects $blkg -name is_derived -value true
set blkg [ create_placement_blockage -name auto_generate_blockage2 -type soft \
    -purpose system -boundary { {1.6720 63.5360} {46.1580 65.2080} } ]
set_attribute -objects $blkg -name is_derived -value true
set blkg [ create_placement_blockage -name auto_generate_blockage3 -type soft \
    -purpose system -boundary { {54.1190 1.6720} {96.9330 3.3440} } ]
set_attribute -objects $blkg -name is_derived -value true
create_placement_blockage -name left_block -type hard -boundary { {45.1440 \
    3.3440} {45.1440 60.1920} {48.4880 60.1920} {48.4880 3.3440} }
create_placement_blockage -name right_block -type hard -boundary { {101.3840 \
    5.0160} {101.3840 61.8640} {106.1310 61.8640} {106.1310 5.0160} }
create_placement_blockage -name pb_0 -type hard -boundary { {47.8550 56.8480} \
    {91.9350 61.8340} }
create_placement_blockage -name pb_1 -type hard -boundary { {45.1440 3.0000} \
    {94.0000 6.6880} }
create_placement_blockage -name pb_2 -type hard -boundary { {105.2340 58.5200} \
    {150.3280 61.8640} }
create_placement_blockage -name pb_3 -type hard -boundary { {146.9450 1.6720} \
    {155.9520 62.5995} }
create_placement_blockage -name pb_4 -type hard -boundary { {101.3840 3.3440} \
    {146.9450 8.3600} }
create_placement_blockage -name pb_5 -type hard -boundary { {195.6240 1.6720} \
    {198.2080 59.9910} }
create_placement_blockage -name pb_6 -type hard -boundary { {1.6720 1.6720} \
    {3.8000 60.1920} }
