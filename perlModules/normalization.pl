#!/usr/bin/perl

use utf8;
binmode STDOUT, ":utf8";
use Data::Dumper qw(Dumper);


sub normalization {
   my ($text) = @_;

   # We delete the unnecessary spaces:
   $text =~ s/ +\|/\|/g;
   $text =~ s/\| +/\|/g;
   $text =~ s/\( +/\(/g;
   $text =~ s/ +\)/\)/g;

   # We transform the variables into the correct format: 
   $text =~ s/\$?\$(\w+)/\$\U$1/g;
   
   # We normalize the optional cases, not bracketed:
   $text =~ s/\?(\w+)/\(<eps>\|$1\)/g;

   # We fix the potential apostrophe issues:
   $text =~ s/\)(\'\w+)( |$)/$1\)/g;

   # # We normalize the optional variables, not bracketed:
   $text =~ s/\?\$(\w+)/\(<eps>\|\$$1\)/g;

   # We normalize the optional cases, bracketed:
   $text =~ s/\?\((.+?)\)/\(<eps>\|$1\)/g;
   $text =~ s/\?\((.+?)\)/\(<eps>\|$1\)/g; # Ad hoc recursion.

   # We solve the potential problem of having 2 connected ((:
   $text =~ s/\) ?\)/\) <eps>\) /g;
   # $text =~ s/\) \)/\) <eps>\) /g;
   $text =~ s/\) ?\)/\) <eps>\) /g; # Ad hoc recursion.

   # We check for the apostrophe problems:
   $text =~ s/\)(\'\w+\b)/$1\)/g;

   # We erase the ending spaces:
   $text =~ s/ $//g;

   # And separate parenthesis from words:
   $text =~ s/(\w)\(/$1 \(/g;
   $text =~ s/\)(\w)/\) $1/g;

   # And squeeze spaces:
   $text =~ s/ +/ /g;

   # And separate )(:
   $text =~ s/\)\(/\) \(/g;

   # And separate )$:
   $text =~ s/\)\$/\) \$/g;

   # And recheck pipes:
   $text =~ s/ \|/\|/g;
   $text =~ s/\| /\|/g;
   
   # print "$text\n";

   # On renvoie la liste des nombres premiers
   return $text;
}
