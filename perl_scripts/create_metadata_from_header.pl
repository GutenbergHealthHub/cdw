use warnings 'all';
use feature qw(say);

my $path = $ARGV[0]; # file with headers
my $source = $ARGV[1]; # source of reference
open my $fh, "<", $path or die "Can't open $path: $!";

while (my $line = <$fh>){
  if($line !~ /datum|anzahl|vorname|plz/){ # not date, quantitie or first name
    my $table_column = $line;
    chomp($table_column); # remove end of line (\n)
    # sql script to create a table into metadata schema
    print " 
      -- $table_column
      drop table if exists metadata_repository.$table_column;
      create table metadata_repository.$table_column(
        id serial primary key,
        sourceid varchar not null,
        $table_column varchar not null,
        description varchar,
        source varchar not null default '$source' references metadata_repository.sources(sourceid),
        inserted timestamp not null default now(),
        unique(sourceid, $table_column)
      );\n"
  }
}
close $fh;
