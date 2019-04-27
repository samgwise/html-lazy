#! /usr/bin/env perl6
use v6.c;

use HTML::Lazy (:ALL);

my $document = html-en
    head( Map,
        title(Map, text('HTML::Lazy'))
    ),
    body( Map,
        p({ :class<example> },
            text('Hello world!')
        )
    );

# Execute the generator
put render($document)