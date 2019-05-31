use v6.c;
unit module HTML::Lazy:ver<0.0.1>;
use HTML::Escape;

=begin pod

=head1 NAME

HTML::Lazy - Declarative HTML generation

=head1 SYNOPSIS

=begin code :lang<perl6>

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

=end code

And the result:

=begin output 

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

=end output

=head1 DESCRIPTION

HTML::Lazy is a declarative HTML document generation module.
It provides declarative functions for creating lazy HTML generation closures.
The lazy generation can be overridden through an eager renderer and generation can be performed in parrallel with a hyper-renderer.

=head2 Tags and adding your own

For a list of html tags which can be exported, see the export list below. If you need one I've missed, you can generate your own tag function like this:

=begin code :lang<perl6>
my &head = tag-factory 'head';
=end code

You now have a routine for generating head tags.

=head2 Prior Art

This is certainly not the first Perl 6 HTML generator and will hardly be the lasst.
A number of other modules provide differnt solutions which you should consider:

=item L<XHTML::Writer | https://github.com/gfldex/perl6-xhtml-writer>
=item L<Typesafe::XHTML::Writer | https://github.com/gfldex/perl6-typesafe-xhtml-writer>
=item L<HTML::Tag | https://github.com/adaptiveoptics/HTML-Tag>

=head1 AUTHOR

Sam Gillespie <samgwise@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Sam Gillespie.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=head1 Export groups

=begin table

Symbol                   | Export groups
========================================
&render                  | :DEFAULT, :ALL
&pre-render              | :DEFAULT, :ALL
&hyper-render            | :DEFAULT, :ALL
&text                    | :DEFAULT, :ALL
&text-raw                | :DEFAULT, :ALL
&node                    | :DEFAULT, :ALL
&tag-factory             | :DEFAULT, :ALL
&with-attributes         | :DEFAULT, :ALL
&html-en                 | :DEFAULT, :ALL
&include-file            | :DEFAULT, :ALL
&head                    | :tags, :ALL 
&title                   | :tags, :ALL 
&meta                    | :tags, :ALL 
&body                    | :tags, :ALL 
&div                     | :tags, :ALL 
&footer                  | :tags, :ALL 
&header                  | :tags, :ALL 
&br                      | :tags, :ALL 
&col                     | :tags, :ALL 
&colgroup                | :tags, :ALL 
&ul                      | :tags, :ALL 
&ol                      | :tags, :ALL 
&li                      | :tags, :ALL 
&code                    | :tags, :ALL 
&samp                    | :tags, :ALL 
&pre                     | :tags, :ALL 
&table                   | :tags, :ALL 
&thead                   | :tags, :ALL 
&tbody                   | :tags, :ALL 
&tfoot                   | :tags, :ALL 
&tr                      | :tags, :ALL 
&th                      | :tags, :ALL 
&td                      | :tags, :ALL 
&caption                 | :tags, :ALL 
&figure                  | :tags, :ALL 
&figurecaption           | :tags, :ALL 
&a                       | :tags, :ALL 
&img                     | :tags, :ALL 
&audio                   | :tags, :ALL 
&video                   | :tags, :ALL 
&canvas                  | :tags, :ALL 
&link                    | :tags, :ALL 
&script                  | :tags, :ALL 
&style                   | :tags, :ALL 
&asource                 | :tags, :ALL 
&svg                     | :tags, :ALL 
&noscript                | :tags, :ALL 
&iframe                  | :tags, :ALL 
&template                | :tags, :ALL 
&form                    | :tags, :ALL 
&input                   | :tags, :ALL 
&label                   | :tags, :ALL 
&optgroup                | :tags, :ALL 
&option                  | :tags, :ALL 
&select                  | :tags, :ALL 
&textarea                | :tags, :ALL 
&button                  | :tags, :ALL 
&span                    | :tags, :ALL 
&p                       | :tags, :ALL 
&i                       | :tags, :ALL 
&b                       | :tags, :ALL 
&q                       | :tags, :ALL 
&blockquote              | :tags, :ALL 
&em                      | :tags, :ALL 
&sub                     | :tags, :ALL 
&sup                     | :tags, :ALL 
&h1                      | :tags, :ALL 
&h2                      | :tags, :ALL 
&h3                      | :tags, :ALL 
&h4                      | :tags, :ALL 
&h5                      | :tags, :ALL 
&h6                      | :tags, :ALL 

=end table

=head1 Subroutines

=end pod

#
# Exportables
#

our sub render(&tag --> Str) is export(:DEFAULT) {
    #= Calls a no argument Callable to produce the defined content.
    #= This routine is here to show programmer intention and catch any errors encountered when building the HTML Str.
    #= All errors are returned in the form of a failure so it is important to check the truthiness of the result to determine if the HTML was generated succesfully.
    CATCH { return fail "render action encountered the following error: { .gist }" }
    try tag
}

our sub pre-render(&tag --> Callable) is export(:DEFAULT) {
    #= Executes a render and stores the result so it may be rendered later.
    #= Use this function to eagerly evaluate a document or sub document and store the resulting Str for use in other documents.
    #= Please note that any errors encountered during a pre-render will not be encountered until the result of the pre-rendered output is used, since the Failure object will be caputred in the result.
    my $content = render &tag;
    -> {
        $content
    }
}

our sub hyper-render(*@children --> Callable) is export(:DEFAULT) {
    #= Children of a hyper-render function will be rendered in parrallel when called.
    #= The results will be reassembled without change to order.
    -> {
        my @promises = do for @children -> $child {
            start { render $child }
        }

        join("\n", @promises.map( -> $promise { await $promise } ))
    }
}

our sub text(Str $text --> Callable) is export(:DEFAULT) {
    #= Create a closure to emit the text provided.
    #= Text is escaped for HTML, use `text-raw` for including text which should not be sanitised.
    #= The escaping uses escape-html from `HTML::Escape` (https://modules.perl6.org/dist/HTML::Escape:cpan:MOZNION).
    -> {
        escape-html $text
    }
}

our sub text-raw(Str $text --> Callable) is export(:DEFAULT) {
    #= Create a closure to emit the text provided.
    #= The text is returned with no escaping.
    #= This function is appropriate for inserting HTML from other sources, scripts or CSS.
    #= If you are looking to add text content to a page you should look at the `text` function as it will sanitize the input, so as to avoid any accidental or malicious inclusion of HTML or script content.
    -> { $text }
}

our sub node(Str:D $tag, Associative $attributes, *@children --> Callable) is export(:DEFAULT) {
    #= Generalised html element generator.
    #= This function provides the core rules for generating html tags.
    #= All tag generators are built upon this function.
    #= To create specialised versions of this function use the `tag-factory` and then further specialised with the C<with-attributes> function.
    -> {
        '<'
        ~ $tag
        ~ ($attributes.so
            ?? ' ' ~ $attributes.kv
                    .map( -> $attr, $val { $attr ~ '="' ~ as-list($val).join(' ') ~'"'} )
                    .join(' ')
            !! ''
        )
        ~ '>'
        ~ (
        ~ (@children.so ?? "\n" ~ @children.map( { .() } ).join("\n").indent(4) ~ "\n" !! '')
        )
        ~ '</'
        ~ $tag
        ~ '>'
        # " # fix syntax highlighting...
    }
}

our sub tag-factory(Str:D $tag --> Callable) is export(:DEFAULT) {
    #= Make functions to create specific tags.
    #= Returns a Callable with the signiture (Associative $attributes, *@children --> Callable).
    #= The closure created by this routine wraps up an instance of the `node` routine.
    -> Associative $attributes, *@children {
        node $tag, $attributes, |@children
    }
}

our sub with-attributes(&tag, Associative $attributes --> Callable) is export(:DEFAULT) {
    #= Create a tag with preset attributes.
    #= Allows for further specialisation of tag closures from the C<tag-factory> routine.
    #= The closure returned from this routine has the following signiture (*@children --> Callable).
    -> *@children {
        tag $attributes, |@children
    }
}

our sub html-en(Associative :$attributes = {:lang<en>, :dir<ltr>}, *@children --> Callable) is export(:DEFAULT) {
    #= Create a HTML tag with DOCTYPE defenition.
    #= Use this function as the top of your document.
    #= The default arguments to attributes are set for English, `{:lang<en>, :dir<ltr>}`, but a new Map or hash can be used to tailor this routine to your needs.
    -> {
        "<!DOCTYPE html>\n"
        ~ render node 'html', $attributes, |@children
    }
}

our sub include-file(Str:D $file --> Callable) is export(:DEFAULT) {
    #= Include content from a file.
    #= Use this function to include external files such as scripts and CSS in your templates.
    #= Content is included without any sanitisation of the input.
    -> { $file.IO.slurp }
}

#
# Utils
#

# maps Any to Positional or Positional to Positional.
# Internal utility for simplifying attribute generation.
our sub as-list($v --> List) {
    return List if !$v.so;
    return $v if $v ~~ Positional;
    List($v)
}

#
# Tags
#

# Header tags
our &head is export( :tags ) = tag-factory 'head';
our &title is export( :tags ) = tag-factory 'title';
our &meta is export( :tags ) = tag-factory 'meta';

# Document ections
our &body is export( :tags) = tag-factory 'body';
our &div is export( :tags) = tag-factory 'div';
our &footer is export( :tags) = tag-factory 'foorter';
our &header is export( :tags) = tag-factory 'header';

# Formatting
our &br is export( :tags) = tag-factory 'br';
our &col is export( :tags) = tag-factory 'col';
our &colgroup is export( :tags) = tag-factory 'colgroup';
our &ul is export( :tags) = tag-factory 'ul';
our &ol is export( :tags) = tag-factory 'ol';
our &li is export( :tags) = tag-factory 'li';
our &code is export( :tags) = tag-factory 'code';
our &samp is export( :tags) = tag-factory 'samp';
our &pre is export( :tags) = tag-factory 'pre';
our &table is export( :tags) = tag-factory 'table';
our &thead is export( :tags) = tag-factory 'thead';
our &tbody is export( :tags) = tag-factory 'tbody';
our &tfoot is export( :tags) = tag-factory 'tfoot';
our &tr is export( :tags) = tag-factory 'tr';
our &th is export( :tags) = tag-factory 'th';
our &td is export( :tags) = tag-factory 'td';
our &caption is export( :tags) = tag-factory 'caption';
our &figure is export( :tags) = tag-factory 'figure';
our &figurecaption is export( :tags) = tag-factory 'figurecaption';

# Content
our &a is export( :tags) = tag-factory 'a';
our &img is export( :tags) = tag-factory 'img';
our &audio is export( :tags) = tag-factory 'audio';
our &video is export( :tags) = tag-factory 'video';
our &canvas is export( :tags) = tag-factory 'canvas';
our &link is export( :tags) = tag-factory 'link';
our &script is export( :tags) = tag-factory 'script';
our &style is export( :tags) = tag-factory 'style';
our &asource is export( :tags) = tag-factory 'source';
our &svg is export( :tags) = tag-factory 'svg';
our &noscript is export( :tags) = tag-factory 'noscript';
our &iframe is export( :tags) = tag-factory 'iframe';
our &template is export( :tags) = tag-factory 'template';

# input
our &form is export( :tags) = tag-factory 'form';
our &input is export( :tags) = tag-factory 'input';
our &label is export( :tags) = tag-factory 'label';
our &optgroup is export( :tags) = tag-factory 'optgroup';
our &option is export( :tags) = tag-factory 'option';
our &select is export( :tags) = tag-factory 'select';
our &textarea is export( :tags) = tag-factory 'textarea';
our &button is export( :tags) = tag-factory 'button';

# Text
our &span is export( :tags) = tag-factory 'span';
our &p is export( :tags) = tag-factory 'p';
our &i is export( :tags) = tag-factory 'i';
our &b is export( :tags) = tag-factory 'b';
our &q is export( :tags) = tag-factory 'q';
our &blockquote is export( :tags) = tag-factory 'blockquote';
our &em is export( :tags) = tag-factory 'em';
our &sub is export( :tags) = tag-factory 'sub';
our &sup is export( :tags) = tag-factory 'sup';
our &h1 is export( :tags) = tag-factory 'h1';
our &h2 is export( :tags) = tag-factory 'h2';
our &h3 is export( :tags) = tag-factory 'h3';
our &h4 is export( :tags) = tag-factory 'h4';
our &h5 is export( :tags) = tag-factory 'h5';
our &h6 is export( :tags) = tag-factory 'h6';
