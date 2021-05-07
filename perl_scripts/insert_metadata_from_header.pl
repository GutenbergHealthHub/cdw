use warnings 'all';
use feature qw(say);
my $path = $ARGV[0]; # file with headers
open my $fh, "<", $path or die "Can't open $path: $!";

while (my $line = <$fh>){

  if($line !~ /datum|anzahl|vorname|plz/){ # not for date, quantities, first name or zip code
    my $table_column = $line;
    chomp($table_column); # remove end of line (\n)
    # sql script to insert 
    print "
    -- insert into $table_column
    insert into metadata_repository.$table_column(sourceid, $table_column)
      values\n";
    for (my $i = 0; $i < 3; $i++){
      print "        ('',''),\n";
    }
    print"        ('','')\n;\n";
  }
}
close $fh;

