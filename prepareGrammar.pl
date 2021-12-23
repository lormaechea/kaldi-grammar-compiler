#!/usr/bin/perl
#!/usr/bash

<<DOC;
-------------------------------------------------------------------------------
DESCRIPTION :    This scripts prepares the grammar data for the subsequent
                 FST conversion.
EXECUTION   :    perl prepareGrammar.pl <INPUT_FILE>
-------------------------------------------------------------------------------
DOC

# We import the necessary modules:
require "./perlModules/gramSplitter.pl";
require "./perlModules/mainGramNormalizer.pl";
require "./perlModules/subGramNormalizer.pl";

use utf8;
binmode STDOUT, ":utf8";
use Data::Dumper qw(Dumper);
use Term::ANSIColor qw(:constants);
# use warnings;

# Input file:
my $fileInput = $ARGV[0];

# We verify the execution:
if ( @ARGV != 1 ) {
    print RED BOLD, "\n\t*** WRONG USAGE: perl $0 @ARGV\n";
     print "\t--> PLEASE TYPE: perl $0 <INPUT_FILE>\n\n", RESET;
      exit 1; # We stop the program execution.
}

my ($mainGrammar,$subGrammar,$normMainGrammar,$normSubGrammar) = ('','','','');

print YELLOW BOLD, "\n\t***********************************\n";
print "\t******* GRAMMAR PREPARATION *******\n";
print "\t***********************************\n", RESET;

# We divise the main grammar and sub grammar:
($mainGrammar, $subGrammar) = &grammarSplit($fileInput);

# We proceed to the main grammar normalization:
$normMainGrammar = &mainGramNormalizer($mainGrammar);

# And the sub grammar normalization:
$normSubGrammar = &subGramNormalizer($subGrammar);

# As a supplementary step, we create the newWords.txt file for our grammar:
system("cat \"$normMainGrammar\" \"$normSubGrammar\" > ./wordsGenerator/totalGram.txt");
# And we finally create newWords.txt:
system("bash ./wordsGenerator/addOOV.sh ./wordsGenerator/totalGram.txt");

print GREEN BOLD, "\tTHE RESULTING FILES WERE SUCCESSFULLY CREATED:\n";
print "\t\t--> \"$normMainGrammar\"\n";
print "\t\t--> \"$normSubGrammar\"\n";
print "\t\t--> \"newWords.txt\"\n\n", RESET;
