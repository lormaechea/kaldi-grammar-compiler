#!/usr/bin/perl

use utf8;
binmode STDOUT, ":utf8";
use Data::Dumper qw(Dumper);

sub grammarSplit {
    my ($fileInput) = @_;

    # Opening the file:
    open(FIC, "<:encoding(utf-8)", $fileInput) or die $!;

    # print "$fileInput\n";

    # Output files:
    # --> Main grammar:
    my $mainOutput = $fileInput;
    $mainOutput =~ s/(.+)(\.txt)/$1_main$2/g;

    # Creating the resulting main grammar file:
    open(MAIN_G, ">:encoding(utf-8)", $mainOutput);

    # --> Sub-grammar:
    my $subOutput = $fileInput;
    $subOutput =~ s/(.+)(\.txt)/$1_sub$2/g;

    # Creating the resulting main grammar file:
    open(SUB_G, ">:encoding(utf-8)", $subOutput);

    print "\n_________________________________________________________________\n";
    print "\nWE PROCEED TO THE GRAMMAR SPLIT...\n";

    # We initialize the backup variable:
    my $lineCop = "";

    while( my $line = <FIC> )
    {
        # chomp $line;
        
        # We erase the commented lines:
        $line =~ s/^#.+$//d;

        # We put the whole text in a single line:
        $line =~ s/\n/@/g;

        # And create a copy for the resulting string:
        $lineCop = $lineCop . $line;
    }

    close(FIC);

    # print "$lineCop\n";

    my ($finalPhrase,$finalUtterance, $finalTrLex) = ('','','');

    while ( $lineCop =~ /(.+)/g )
    {
        $tmp = $1;

        while ( $tmp =~ /(PhraseId.+?EndPhrase)/g )
        {
            $finalPhrase = $1;
            $finalPhrase =~ s/Source/Phrase/g;
            $finalPhrase =~ s/@/\n/g;
            # print "$finalPhrase\n\n";
            print SUB_G "$finalPhrase\n\n";
        }

        while ( $tmp =~ /(Utterance.+?EndUtterance)/g )
        {
            $finalUtterance = $1;
            $finalUtterance =~ s/@/\n/g;
            # print "$finalUtterance\n\n";
            print MAIN_G "$finalUtterance\n\n";
        }

        while ( $tmp =~ /(TrLex.+?@)/g )
        {
            $finalTrLex = $1;
            $finalTrLex =~ s/@/\n/g;
            # print "$finalTrLex";
            print SUB_G "$finalTrLex\n";
        }
    }

    print "---> OK. The file \"$mainOutput\" was created.\n";
    print "---> OK. The file \"$subOutput\" was created.\n";
    print "_________________________________________________________________\n\n";
    
    close(MAIN_G);
    close(SUB_G);

    return ($mainOutput, $subOutput);
}