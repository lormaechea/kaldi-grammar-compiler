#!/usr/bin/perl


# We import the necessary modules:
require "./perlModules/normalization.pl";

use utf8;
binmode STDOUT, ":utf8";
use Data::Dumper qw(Dumper);
# use warnings;

sub subGramNormalizer {
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

    my ($idTrLex,$exTrLex, $resultingTrLex) = ('','','');
    my ($idPhrase,$exPhrase, $resultingPhrase) = ('','','');

    print "\n_________________________________________________________________\n";
    print "\nWE PROCEED TO THE SUB GRAMMAR NORMALIZATION...\n";

    # We proceed to the text normalization:
    while ($fileInput =~ /([^\n]+\n)/g) 
    {
        my $line = $1;
        $line =~ s/\r$//g;
        chomp $line; # Maybe redondant, but just in case.

        # print "$line\n";

        if ( $line =~ /^TrLex \$\$(\w+?) source=\"(.+?)\"/g )
        {
            $idTrLex = "#" . uc($1);
            $idTrLex =~ s/-/_/g;
            # print "\n$idTrLex\n";

            $exTrLex = $2;
            # print "\nORIGINAL : $exTrLex\n";

            $exTrLex = &normalization($exTrLex);

            # We create the resulting phrase:
            $resultingTrLex = "$idTrLex $exTrLex $idTrLex\n";

            # We erase the ending spaces:
            $resultingTrLex =~ s/ $//g;

            # We squeeze spaces:
            $resultingTrLex =~ s/ +/ /g;

            # Last changes:
            $resultingTrLex =~ s/(\$\w+?)(\$\w+?)/$1 $2/g;
            $resultingTrLex =~ s/(\$\w+)-(\w+)/$1_\U$2/g;

            # print "$resultingTrLex";
            print OUT "$resultingTrLex";
        }

        elsif ( $line =~ /^PhraseId (.*)/g )
        {
            $idPhrase = "#" . uc($1);
            $idPhrase =~ s/\$//g;
            $idPhrase =~ s/-/_/g;
            # print "\n$idPhrase\n";
        }

        elsif ( $line =~ /^Phrase (.*)/g )
        {
            $exPhrase = $1;

            # print "\nORIGINAL : $exPhrase\n";

            $exPhrase = &normalization($exPhrase);
            
            # We create the resulting phrase:
            $resultingPhrase = "$idPhrase $exPhrase $idPhrase\n";

            # We erase the ending spaces:
            $resultingPhrase =~ s/ $//g;

            # We squeeze spaces:
            $resultingPhrase =~ s/ +/ /g;

            # Last changes:
            $resultingPhrase =~ s/(\$\w+?)(\$\w+?)/$1 $2/g;
            $resultingPhrase =~ s/(\$\w+)-(\w+)/$1_\U$2/g;

            # print "$resultingPhrase";
            print OUT "$resultingPhrase";
        }
    }

    print "---> OK. The file \"$fileOutput\" was normalized.\n";
    print "_________________________________________________________________\n\n\n";
     
    close(OUT);

    return $fileOutput;
}
