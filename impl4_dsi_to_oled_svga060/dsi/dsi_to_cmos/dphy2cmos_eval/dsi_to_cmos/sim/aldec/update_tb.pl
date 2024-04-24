use Aldec::ActiveHDL;

print $ARGV[0];

open(FILE, "<dphy_2_cmos_tb.v") || die "File not found";
my @lines = <FILE>;
close(FILE);

my @newlines;
foreach(@lines) {
   $_ =~ s/dphy_2_cmos_ip_wrapper/$ARGV[0]/g;
   push(@newlines,$_);
}

open(FILE, ">dphy_2_cmos_tb.v") || die "File not found";
print FILE @newlines;
close(FILE);
