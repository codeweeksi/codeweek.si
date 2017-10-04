# codeweek.si  - local Codeweek EU website

This website is based on [Codeweek.eu codebase](https://github.com/codeeu/codeeu.github.io) 
It is created with [jekyll](http://jekyllrb.com/)

## Important - before editing
*Never* work directly on `master`, it gets deleted. Always switch to the `source` branch first (or make a new branch out of it) and then add your changes to this branch.

## Building
Site is automatically built by [Travis](https://travis-ci.org/codeweeksi/codeweek.si). Building is triggered by pushing commits to the the `source` branch. 

Travis runs gulp and all the jekyll commands to generate static content. This content is copied to the `master`branch and pushed back to github as master branch.

## Adding sub-pages
All sub-pages are located in `_pages folder. If you want to add a new subpage, simply create a directory in the `_pages`, add an `index.md` or `index.html` file and add the jekyll headers into this file like this:

```
---
layout: subpage_plain
title: Digitalno opismenjevanje mladih
permalink: /opismenjevanje/
--- 
```
### Subpage template
All sub-pages need a template with proper navigation. You can find the templates (or create a new one) in `_layouts` folder. Sub-pages have two available templates at the moment. If you intend to write your subpage in markdown, use `supage_plain`.

### Subpage permalink - important
*Don't forget* to add a permalink for your page. Permalink is the permanent link that others can use when linking to this page. It doesn't have to be the same as the name of the sub-folder. Don't include spaces in it, use `-` as a delimiter :)

Permalink should have a `/` as a prefix and suffix like this: `/my-fancy-permalink/`

Also, don't forget to include a link to your subpage somewhere in the main (index) page, so people can actually reach it and find it.