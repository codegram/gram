#gram

Gram is an internal administration tool for Codegram.

It is composed of independent components. For now the only available component is Blog. To install and setup Gram, just do the following:

    $ echo "token: MY_CODEGRAM_TOKEN" > ~/.gramrc
    $ gem install gram

##Blog component

To publish a blogpost, type this:

    $ gram blog my_blogpost.markdown

The `my_blogpost.markdown` file should be a regular markdown file with some headers in it, like this:

    ---
    title: My blog post title
    tagline: Stranger than fiction
    ---

    # My awesome header
    ## More markdown goodness, etc.

## Copyright

Copyright (c) 2011 Codegram. See LICENSE for details.
