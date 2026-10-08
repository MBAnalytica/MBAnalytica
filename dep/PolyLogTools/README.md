# PolyLogTools

Polylogtools is a Mathematica package for calculations involving multiple
polylogarithms.

## Installation
Clone the repository using
```
git clone https://gitlab.com/pltteam/plt.git
```
This will create a new directory `plt` in the current working directory.
Alternatively, if git is not available, it is possible to download a release
tarball from the project gitlab page https://gitlab.com/pltteam/plt.


Afterwards, Mathematica needs to be told about the directory where PolyLogTools
was installed. For this, we need to define the variable `$PolyLogPath` in the
current Mathematica session before loading the package:
```
$PolyLogPath = SetDirectory["path/to/polylogtools"];
<<PolyLogTools`;
```

Alternatively, if one does not want to execute this command in every fresh kernel
session, it is possible to modify the configuration file Mathematica preloads when
starting a new kernel.
Under MacOS the file can be found in (if the file does not exist, just create it)
```
~/Library/Mathematica/Kernel/init.m
```
On Unix/Linux systems the file should be at
```
~/.Mathematica/Autoload/init.m
```

Add the following lines to the appropriate init.m file:
```
$PolyLogPath = "path/to/polylogtools";
If[Not[MemberQ[$Path, $PolyLogPath]],$Path = Append[$Path,$PolyLogPath]];
```
Now it is possible to load PolyLogTools by executing `<<PolyLogTools.m` in a new kernel.
