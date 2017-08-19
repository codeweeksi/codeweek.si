# codeweek.si local Codeweek EU website

This website is based on [Codeweek.eu codebase](https://github.com/codeeu/codeeu.github.io) 
It is created with [jekyll](http://jekyllrb.com/)

## Important
*Never* work directly on `master`, it gets deleted! Always add your changes to `source` branch.
Travis builds the site from`source` branch, runs gulp and jekyll build and then copies compiled content to `master` branch.