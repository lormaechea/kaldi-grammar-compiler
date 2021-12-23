#!/usr/bin/perl


# We import the necessary modules:
require "./perlModules/normalization.pl";

use utf8;
binmode STDOUT, ":utf8";
use Data::Dumper qw(Dumper);
# use warnings;

sub mainGramNormalizer {
    my ($fileInput) = @_;

    # Output file:
    my $fileOutput = $fileInput;
    $fileOutput =~ s/(.+)(\.txt)/$1_norm$2/g;

    # We read the file:
    {
        local $/=undef;
        open(FIC, "<:encoding(utf-8)", $fileInput) or die $!;
        $fileInput = <FIC>;
    }

    # Creating the normalized file:
    open(OUT, ">:encoding(utf-8)", $fileOutput);

    # print "$fileInput\n";

    my ($exSource,$resultingSource) = ('','');

    print "\n_________________________________________________________________\n";
    print "\nWE PROCEED TO THE MAIN GRAMMAR NORMALIZATION...\n";

    # We proceed to the text normalization:
    while ($fileInput =~ /([^\n]+\n)/g) 
    {
        my $line = $1;
        $line =~ s/\r$//g;
        chomp $line; # Maybe redondant, but just in case.

        # print "$line\n";

        if ( $line =~ /^Source (.+)$/g )
        {
            $exSource = $1;

            # print "\nORIGINAL  : $exSource\n";

            $exSource = &normalization($exSource);

            # We then create the resulting source phrase:
            $resultingSource = "#0 $exSource\n";

            # We erase the ending spaces:
            $resultingSource =~ s/ $//g;

            # We squeeze spaces:
            $resultingSource =~ s/ +/ /g;

            # Last changes:
            $resultingSource =~ s/(\$\w+?)(\$\w+?)/$1 $2/g;
            $resultingSource =~ s/(\$\w+)-(\w+)/$1_\U$2/g;

            # print "$resultingSource";
            print OUT "$resultingSource";
        }
    }

    print "---> OK. The file \"$fileOutput\" was normalized.\n";
    print "_________________________________________________________________\n\n";
     
    close(OUT);

    return $fileOutput;
}

