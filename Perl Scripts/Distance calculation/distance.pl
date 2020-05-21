#!/usr/bin/perl
open(DATA1, "<m6A_modification_location_for_distance_calculation.csv");#m6A
open(DATA2, ">distance_between_m6A_and_miR_or_RBP_binding_site.csv");
while($sukhen=<DATA1>)
  {
@a=split(',',$sukhen);

open(DATA3, "<miRNA_RBP_binding_location_for_distance_calculation.csv");#miR or RBP binding position
 while($sukhen2=<DATA3>)
    {
  @b=split(',',$sukhen2);
   
     if($a[0] eq $b[0])
        {
         
         if($a[3]>$b[3])
          {
           chomp($b[4]);
           $d1=$a[3]-$b[3];#mid-mid
           
           }
         else
            {
           chomp($a[4]);
           $d1=$b[3]-$a[3];#mid-mid
           
            }

      print DATA2 $a[0].",".$d1.",".$b[5];
      
        } 
    }
 
close(DATA3);

  }

close(DATA1);
close(DATA2);
