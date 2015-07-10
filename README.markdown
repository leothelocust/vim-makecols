makecols
========

Makecols.vim is intended to easily convert lists into column based
layouts.

The easiest way to explain is with examples.

Say you have a list of things (in this case numbers)

    1
    2
    3
    4
    5
    6
    7
    8
    9
    10

and you’d like it to look neater

    1       2
    3       4
    5       6
    7       8
    9       10

[That’s pretty neat](https://www.youtube.com/watch?v=Hm3JodBR-vs&feature=youtu.be&t=25s)


Usage
-----
Here’s how you do it.

Start with a list like above.
    
    1
    2
    3
    4
    5
    6
    7
    8
    9
    10

Then visual select the rows you’d like to make neat.

Then type ```mc``` and viola! The data has automagically been reconstructed
into a satisfactory arrangement.


    1   2
    3   4
    5   6
    7   8
    9   10

You are now free of the worry caused by inadequate single column list layouts. Carry on.

Installation
------------

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/leothelocust/vim-makecols.git

Once help tags have been generated, you can view the manual with
`:help makecols`.

Contributing
------------

Just pull, make some changes, and create a merge request.

License
-------

Copyright (c) Levi Olson. Distribution under the same terms as Vim itself.
See `:help license`.
