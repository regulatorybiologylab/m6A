# Module 1: downloading and processing of the data from UCSC browser
use LWP::Simple;
open(DATA1,"<position_of_the_site.csv");
open(DATA3,">data_seq_plus.txt");
while($sukhen=<DATA1>)
{
open(MYFILE, ">data_plus.txt");
@a=split('\t',$sukhen);
$p=$a[0];
$q=$a[1];
$r=$a[2];

chomp $p;

chomp $q;
chomp $r;
#print $p;
$url="https://genome.ucsc.edu/cgi-bin/hgc?hgsid=707510695_CcYbQhcc6n4XTpjNBjoNAi8azSzA&g=htcGetDna2&table=&i=mixed&o=33031596&l=33031596&r=33041570&getDnaPos=".$p."%3A".$q."-".$r."&db=hg19&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=N&boolshad.hgSeq.revComp=0&submit=get+DNA";


$content = get $url;
print MYFILE $content;

close(MYFILE);

open(DATA2,"<data_plus.txt");
$flag=0;
$test="";
$end="</PRE>";
while($sukhen2=<DATA2>)
  {
   if($test=~/<PRE>/)
      {
      $flag=1;
       }
    elsif($sukhen2=~/$end/)
       {
      $flag=0;
       }
     else
       {
       }

  if($flag==1)
       {
    #print $sukhen2;
    print DATA3 $sukhen2;
       }
$test=$sukhen2;
}
close(DATA2);



}

close(DATA1);
close(DATA3);


# Module 2: processing of the downloaded data from UCSC browser(Removing new lines)

open(DATA1, "<data_seq_plus.txt");
open(DATA2, ">data_seq_plus_nr.txt");
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

# Module 3: Final processing of the downloaded data from UCSC browser for alignment

open(DATA2, ">sequences_of_plus_strand.csv");
open(DATA4, "<position_of_the_site.csv");
$c="";
while($sukhen=<DATA4>)
{
@a=split('\t',$sukhen);
chomp($a[0]);
chomp($a[1]);
chomp($a[2]);
$com=$a[0].":".$a[1]."-".$a[2];
print DATA2 $a[4];
open(DATA1, "<data_seq_plus_nr.txt");
 while($sukhen2=<DATA1>)
  {

	if($c=~/$com/)
	   {
        chomp($sukhen2);
	print DATA2 "\t".$sukhen2;
	  }
      $c=$sukhen2;
  }
close(DATA1);
print DATA2 "\n";
}
close(DATA4);
close(DATA2);





