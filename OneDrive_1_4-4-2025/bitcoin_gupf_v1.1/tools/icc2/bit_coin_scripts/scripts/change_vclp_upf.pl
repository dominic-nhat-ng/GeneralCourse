#! /usr/bin/perl

use strict;
use warnings;

while (<>) {
  chomp;
  if (/create_power_domain TOP$/) {
    printf "create_power_domain TOP -include_scope\n";
  } else {
    printf "$_\n";
  }
}
