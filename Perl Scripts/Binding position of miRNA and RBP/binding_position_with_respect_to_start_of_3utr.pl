#!/usr/local/bin/perl

#Module 1: New line remove 

open(DATA1, "<miRNA_RBP_3utr_target_sequence.txt");
open(DATA2, ">miRNA_RBP_3utr_target_sequence_nr.txt");
while($a=<DATA1>)
   {
  if($a=~/>/)
     {
    print DATA2 "\n".$a;
     }
  else
     {
    $b=chomp($a);
    print DATA2 $a;
     }
  }
close(DATA1);
close(DATA2);



#Module 2: Align target/binding sequence 

open(DATA1,"<miRNA_RBP_binding_seuence.csv");
open(DATA3,">miRNA_RBP_binding_loaction.csv");

while($sukhen=<DATA1>)
{
$i=0;
@a=split(',',$sukhen);
chomp $a[1];
print DATA3 $a[0].",".$a[1];

$s=$a[1];
#print $s;
$ln=length $s;
$mi=$ln/2;
$m=int($mi);
$t=">".$a[0]." ";
#print $t;
$ch="";
open(DATA2,"<miRNA_RBP_3utr_target_sequence_nr.txt");
while($sukhen2=<DATA2>) 
  {
  if($ch=~/$t/)
    {
    print $ch."\n";
    $utrln=length $sukhen2;

    $i=index($sukhen2,$s);
    $j=$i+1;
    $end=$j+$ln;
    $mid=$j+$m;
    print DATA3 ",".$j.",".$mid.",".$end.",".$utrln;
    }
  $ch=$sukhen2;
   }
close(DATA2);

 print DATA3 "\n"; 
}
close(DATA1);
close(DATA3);


#Module 3: binding location with respect to starting neucleotide of the 3'UTR

open(DATA1,"<miRNA_RBP_binding_loaction.csv");
open(DATA2,">miRNA_RBP_binding_position_not_find.csv");
open(DATA3,">miRNA_RBP_binding_position_gene_not_matched.csv");
open(DATA4,">miRNA_RBP_binding_location_for_distance_calculation.csv");
while($sukhen=<DATA1>)
  {
@a=split(',',$sukhen);
chomp($a[2]);
#print $a[2];
if($a[2]==0)
  {
  print DATA2 $sukhen;
  }
elsif($a[2] eq "")
  {
  print DATA3 $sukhen;
  }

else
  {
  print DATA4 $sukhen;
  }


}

close(DATA1);
close(DATA2);
close(DATA3);
close(DATA4);
