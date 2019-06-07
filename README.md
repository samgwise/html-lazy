[![Build Status](https://travis-ci.org/samgwise/html-lazy.svg?branch=master)](https://travis-ci.org/samgwise/html-lazy)

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
        p({ :class<example> },
            text('Hello world!')
        )
    );

# Execute the generator and show the new HTML
put render($document)
```

And the result:

    <!DOCTYPE html>
    <html lang="en" dir="ltr">
        <head>
            <title>
                HTML::Lazy
            </title>
        </head>
        <body>
            <p class="example">
                Hello world!
            </p>
        </body>
    </html>

DESCRIPTION
===========

HTML::Lazy is a declarative HTML document generation module. It provides declarative functions for creating lazy HTML generation closures. The lazy generation can be overridden through an eager renderer and generation can be performed in parrallel with a hyper-renderer.

Tags and adding your own
------------------------

For a list of html tags which can be exported, see the export list below. If you need one I've missed, you can generate your own tag function like this:

```perl6
my &head = tag-factory 'head';
```

You now have a routine for generating head tags.

Prior Art
---------

This is certainly not the first Perl 6 HTML generator and will hardly be the lasst. A number of other modules provide differnt solutions which you should consider:

  * [XHTML::Writer](https://github.com/gfldex/perl6-xhtml-writer)

  * [Typesafe::XHTML::Writer](https://github.com/gfldex/perl6-typesafe-xhtml-writer)

  * [HTML::Tag](https://github.com/adaptiveoptics/HTML-Tag)

AUTHOR
======

Sam Gillespie <samgwise@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2019 Sam Gillespie.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

Export groups
=============

<table class="pod-table">
<thead><tr>
<th>Symbol</th> <th>Export groups</th>
</tr></thead>
<tbody>
<tr> <td>&amp;render</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;pre-render</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;hyper-render</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;text</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;text-raw</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;node</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;tag-factory</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;with-attributes</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;html-en</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;include-file</td> <td>:DEFAULT, :ALL</td> </tr> <tr> <td>&amp;head</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;title</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;meta</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;body</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;div</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;footer</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;header</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;br</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;col</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;colgroup</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;ul</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;ol</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;li</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;code</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;samp</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;pre</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;table</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;thead</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;tbody</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;tfoot</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;tr</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;th</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;td</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;caption</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;figure</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;figurecaption</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;a</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;img</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;audio</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;video</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;canvas</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;link</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;script</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;style</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;asource</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;svg</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;noscript</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;iframe</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;template</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;form</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;input</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;label</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;optgroup</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;option</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;select</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;textarea</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;button</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;span</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;p</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;i</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;b</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;q</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;blockquote</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;em</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;sub</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;sup</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;h1</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;h2</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;h3</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;h4</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;h5</td> <td>:tags, :ALL</td> </tr> <tr> <td>&amp;h6</td> <td>:tags, :ALL</td> </tr>
</tbody>
</table>

Subroutines
===========

### sub render

```perl6
sub render(
    &tag
) returns Str
```

Calls a no argument Callable to produce the defined content. This routine is here to show programmer intention and catch any errors encountered when building the HTML Str. All errors are returned in the form of a failure so it is important to check the truthiness of the result to determine if the HTML was generated succesfully.

### sub pre-render

```perl6
sub pre-render(
    &tag
) returns Callable
```

Executes a render and stores the result so it may be rendered later. Use this function to eagerly evaluate a document or sub document and store the resulting Str for use in other documents. Please note that any errors encountered during a pre-render will not be encountered until the result of the pre-rendered output is used, since the Failure object will be caputred in the result.

### sub hyper-render

```perl6
sub hyper-render(
    :$batch,
    :$degree,
    *@children
) returns Callable
```

Children of a hyper-render function will be rendered in parrallel when called. The results will be reassembled without change to order. The same semantics and default values apply for `:$batch` and `:$degree` as in `Any.hyper`.

### sub text

```perl6
sub text(
    Str $text
) returns Callable
```

Create a closure to emit the text provided. Text is escaped for HTML, use `text-raw` for including text which should not be sanitised. The escaping uses escape-html from `HTML::Escape` (https://modules.perl6.org/dist/HTML::Escape:cpan:MOZNION).

### sub text-raw

```perl6
sub text-raw(
    Str $text
) returns Callable
```

Create a closure to emit the text provided. The text is returned with no escaping. This function is appropriate for inserting HTML from other sources, scripts or CSS. If you are looking to add text content to a page you should look at the `text` function as it will sanitize the input, so as to avoid any accidental or malicious inclusion of HTML or script content.

### sub node

```perl6
sub node(
    Str:D $tag,
    Associative $attributes,
    *@children
) returns Callable
```

Generalised html element generator. This function provides the core rules for generating html tags. All tag generators are built upon this function. To create specialised versions of this function use the `tag-factory` and then further specialised with the C<with-attributes> function.

### sub tag-factory

```perl6
sub tag-factory(
    Str:D $tag
) returns Callable
```

Make functions to create specific tags. Returns a Callable with the signiture (Associative $attributes, *@children --> Callable). The closure created by this routine wraps up an instance of the `node` routine.

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

Create a HTML tag with DOCTYPE defenition. Use this function as the top of your document. The default arguments to attributes are set for English, `{:lang<en>, :dir<ltr>}`, but a new Map or hash can be used to tailor this routine to your needs.

### sub include-file

```perl6
sub include-file(
    Str:D $file
) returns Callable
```

Include content from a file. Use this function to include external files such as scripts and CSS in your templates. Content is included without any sanitisation of the input.

