Various Scad models created by Team McHugh

Some of these OpenScad require you to install the BOSL2 library - the zip file is included in this repo.  (Todo: Look to see, and learn about, package management solutions in OpenSCAD.)  This is something that I found here: https://github.com/BelfrySCAD/BOSL2/ and which is referenced in the code via

```
include <BOSL2/std.scad>
```

This needs to be installed into your configured library path which you can find via Help -> Library Info and look for "User Library Path".  It might be set to something like:

```
User Library Path: C:/Users/mchug/OneDrive/Documents/OpenSCAD/libraries
```

You can easily open up the library directory using File -> Show Library Directory.  Extract the zip into that directory and ensure it is named "BOSL2" at the top level.  Also ensure that it is not nested with another directory. 
