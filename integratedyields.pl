#!/usr/bin/perl -w
# use strict;

open (IN, "$ARGV[0]");
open (OUT, ">", "$ARGV[0].dat");

$getit = 0;


LINE:
while (<IN>) {
   $line = $_;
   chomp ($line);

   if ($line =~ /INTEGRATED\sYIELDS/) {
      $getit = 1;
      next LINE;
   }

   elsif (($line =~ /ENERGY\sRANGE/) and ($getit == 1)) {

      if ($line =~ /SCATTERING\sANGLE\sRANGE/) {
         $line =~ s/.+SCATTERING\sANGLE\sRANGE\s+//;
         $value1 = $line;
         $value1 =~ s/\-.+//;
         $value2 = $line;
         $value2 =~ s/.+\-\-\-\s//;
         $value2 =~ s/\s.+//;

         $value3 = ($value1 + $value2)/2;
 
         next LINE;
      } 

      else {
         $line =~ s/.+THETA\s+//;
         $value3 = $line;
         $value3 =~ s/\s.+//;

         next LINE;
      }
         
   }
   
   elsif (($line =~ /^(\s+2\s+)/) and ($getit == 1)) {
      $line =~ s/\s+/\t/g;
      @line_list = split (/\t/, $line);

      $value4 = $line_list[5];

      print OUT $value3."\t".$value4."\n";

      $getit = 0;
      next LINE;
   }

   else {
      next LINE;
   }
}
