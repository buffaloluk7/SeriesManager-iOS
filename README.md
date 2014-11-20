SeriesManager-iOS
=================

Cloning repository
------------------
First you have to generate a ssh key pair if you don't already have one. Follow this tutorial:
https://help.github.com/articles/generating-ssh-keys/

Next clone the repository includes all submodules:
```
git clone --recursive https://github.com/buffaloluk7/SeriesManager-iOS SeriesManager
```
Make sure to build the correct scheme in Xcode: Product -> Scheme -> SeriesManager

General
-------
iOS App written in Swift which access the thetvdb.com API to retrieve tv shows.
