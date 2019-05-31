#! /usr/bin/env perl6
use v6.c;

unit sub MAIN(Str $src = 'lib/HTML/Lazy.pm6');

die "Source input '$src' does not exists" unless $src.IO.f;

say "=begin table\n";
my $header = sprintf("%-24s | %-12s", 'Symbol', 'Export groups');
say $header;
say '=' x $header.chars;

for $src.IO.lines {
    when '' { next }
    when m/^ \s* 'our' \s+ ['&'|'sub'] \s* ([\w|'-']+) \s* .+? \s+ 'export(' \s* (':' \w+) \s* ')' / {
        say sprintf("%-24s | %-12s", "&$0", "$1, :ALL")
    }
    default { next; say "Rejected: $_" }
}

say "\n=end table"