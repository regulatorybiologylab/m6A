#!/usr/local/bin/perl

#Module 1: New line remove 

open(DATA1, "<mRNA_3utr_target_sequence.txt");
open(DATA2, ">mRNA_3utr_target_sequence_nr.txt");
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

open(DATA1,"<m6A_modification_seuence.csv");
open(DATA3,">m6A_modification_loaction.csv");

while($sukhen=<DATA1>)
{
$i=0;
@a=split(',',$sukhen);
chomp $a[1];
print DATA3 $a[0].",".$a[1];

$s=$a[1];

$ln=length $s;

#central A position


$flag=0;
$i=0;

$mi=$ln/2;
$m=int($mi);

while($flag==0)
 {
@m6a= split(//,$s);
 
  if($m6a[$m+$i] eq "A")
      {

      $m=$m+$i;
      $flag=1;
      
      }
   elsif($m6a[$m-$i] eq "A")
      {
     $m=$m-$i;
      $flag=1;
    
      }
  else
     {
    $i++;
     }
   
  }



$t=">".$a[0]." ";

$ch="";
open(DATA2,"<mRNA_3utr_target_sequence_nr.txt");
while($sukhen2=<DATA2>) 
  {
  if($ch=~/$t/)
    {
  
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

open(DATA1,"<m6A_modification_loaction.csv");
open(DATA2,">m6A_modification_position_not_find.csv");
open(DATA3,">m6A_modification_position_gene_not_matched.csv");
open(DATA4,">m6A_modification_location_for_distance_calculation.csv");
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
