NAME
====

HTML::Lazy - Declarative HTML generation

SYNOPSIS
========

```perl6
use HTML::Lazy (:ALL);

my $document = html-en
    head( Map,
        title(Map, text('HTML::Lazy'))
    ),
    body( Map,
        text('Hello world!')
    );

# Execute the generator
put render($document)
```

DESCRIPTION
===========

HTML::Lazy is a declarative HTML document generation module. It provides declarative functions for creating lazy HTML generation closures. The lazy generation can be overridden through an eager renderer and generation can be performed in parrallel with a hyper-renderer.

AUTHOR
======

= Sam Gillespie <samgwise@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2019 = Sam Gillespie

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

### sub as-list

```perl6
sub as-list(
    $v
) returns List
```

maps Any to Positional or Positional to Positional. Internal utility for simplifying attribute generation.

### sub render

```perl6
sub render(
    &tag
) returns Str
```

calls a no argument Callable to produce the defined content. This routine is here to show programmer intention but is equivilent to the many ways to execute CALL-ME on a Callable.

### sub pre-render

```perl6
sub pre-render(
    &tag
) returns Callable
```

Executes a render and stores the result so it may be rendered later. Use this function to eagerly evaluate a document or sub document and store the resulting Str for use in other documents.

### sub hyper-render

```perl6
sub hyper-render(
    *@children
) returns Callable
```

Children of a hyper-render function will be rendered in parrallel when called. The results will be reassembled without change to order.

### sub text

```perl6
sub text(
    Str $text
) returns Callable
```

Create a closure to emit the text provided. Text is escaped for HTML, use text-raw for including text which should not be sanitised. The escaping uses escape-html from L<HTML::Escape | https://modules.perl6.org/dist/HTML::Escape:cpan:MOZNION>.

### sub text-raw

```perl6
sub text-raw(
    Str $text
) returns Callable
```

Create a closure to emit the text provided. The text is returned with no escaping. This function is appropriate for inserting HTML from other sources, scripts or CSS. If you are looking to add text content to a page you should look at the C<text> function as it will sanitize the input, so as to avoid any accidental or malicious inclusion of HTML or script content.

### sub node

```perl6
sub node(
    Str:D $tag,
    Associative $attributes,
    *@children
) returns Callable
```

Generalised html element generator. This function provides the core rules for generating html tags. All tag generators are built upon this function. To create specialised versions of this function use the C<tag-factory> and then further specialised with the C<with-attributes> function.

### sub tag-factory

```perl6
sub tag-factory(
    Str:D $tag
) returns Callable
```

Make functions to create specific tags. Returns a Callable with the signiture (Associative $attributes, *@children --> Callable). The closure created by this routine wraps up an instance of the C<node>.

### sub with-attributes

```perl6
sub with-attributes(
    &tag,
    Associative $attributes
) returns Callable
```

Create a tag with preset attributes. Allows for further specialisation of tag closures from the C<tag-factory> routine. The closure returned from this routine has the following signiture (*@children --> Callable).

### sub html-en

```perl6
sub html-en(
    Associative :$attributes = { ... },
    *@children
) returns Callable
```

Create a HTML tag with DOCTYPE defenition. Use this function as the top of your document. The default arguments to attributes are set for English, C<{:lang<en>, :dir<ltr>}>, but a new Map or hash can be used to tailor this routine to your needs.

### sub include-file

```perl6
sub include-file(
    Str:D $file
) returns Callable
```

Include content from a file. Use this function to include external files such as scripts and CSS in your templates. Content is included without any sanitisation of the input.

