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

##Gem component

To bootstrap a new gem, type this:

    $ gram gem create my_gem

By default, the new gem will be using Minitest/Spec & Mocha. If you prefer RSpec:

    $ gram gem create my_gem --rspec

And if you want to create a Rails extension or anything requiring ActiveRecord,
just use the `--rails` option:

    $ gram gem create my_gem --rails

This will add the required dependencies and enable the test suite to use
ActiveRecord with in-memory sqlite :)

## Copyright

Copyright (c) 2011 Codegram. See LICENSE for details.
