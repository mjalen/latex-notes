# Notes

This repo is an experiment I am trying. The idea is that `main` will hold my template branch. Then, each branch I create will be a different assignment or notes I am working on. The goal is to be able to have _everything_ I write in one repo while also being able to traverse between different assignments using branches.

Is this a good idea? I doubt it. But, you don't learn unless you live life on the edge right?

One flaw I can think off the top of my head is that if I wanted to collect all my hw/notes into a simple directory, that could be annoying. The idea is to simply have each hw/note in its own branch which seems to oppose this. 

The main perk I am chasing with this approach is to avoid templating while making document navigation simpler. Instead of finding where on my system a document is, I can simply `git checkout` and auto-complete to my directory. Up until now, my notes/hw have been located on Google Drive, which is evil and incredibly annoying to use. Git is a much better alternative (in my opinion), with features that better suit my needs.

This approach also allows me to utilize `nix` without having to constantly change it/copy-paste for each different document. I plan to essentially 'set-and-forget' with my declarative build system.
