# input:  perl name_of_this_file header_file schema_name table_name
use warnings 'all';
use feature qw(say);

my $path = $ARGV[0]; # file with headers
my $schema = $ARGV[1]; # schema in data warehouse
my $table = $ARGV[2]; # table in schema
open my $fh, "<", $path or die "Can't open $path: $!";

while (my $line = <$fh>){
    my $column = $line;
    chomp($column);
    # sql script
    print "
    select 
      '$column' problem, 
      * 
    from $schema.$table 
    where $column ...
      union";
}
print "\n;\n";
close $fh;

