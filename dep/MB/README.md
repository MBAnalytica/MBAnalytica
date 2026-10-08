# MB Tools #

This project is a collection of tools devoted to the evaluation of Mellin-Barnes integrals.

### What is this repository for? ###

* The project has been started by Michael Czakon
* The original project was hosted at [hepforge](https://mbtools.hepforge.org/)
* The current project is hosted by [bitbucket](https://bitbucket.org/feynmanIntegrals/mb/src/master/)
* MB toolbox is currently updated by Andrei V. Belitsky, Aleaxander V. Smirnov and Vladimir A. Smirnov

### How do I set it up? ###
* The Mathematica portion of the codes requires Mathematica v.9 or later
* For simple tests to be independent on Cernlib and CUBA, one can use MBintegrate with the option MaxNIntegrateDim -> your_dim.
* In this case MB.m will use NIntegrate function from Mathematica. All typical options for NIntegrate can be passed to MBintegrate in this case.
* For faster integrations a user will need the gfortran compiler and some libraries (shipped with this package)
* The gfortran compiler at Ubuntu can be installed with sudo apt-get install gfortran
* Call make to get things working

### The following codes are provided ###
* MB.m : version 1.4 of MB (last updated June 28, 2022) by Michal Czakon, the main collection of routines for the resolution of singularities and the numerical evaluation of Mellin-Barnes integrals; for details see hep-ph/0511200; the current version is documented in the Manual; the distribution contains two example notebooks, MBexamples1.nb and MBexamples2.nb; updated in "MB tools relaoded" by Andrei V. Belitsky, Aleaxander V. Smirnov and Vladimir A. Smirnov to produce rational (as opposed to integer) shifts
* MBasymptotics.m : a routine which expands Mellin-Barnes integrals in a small parameter by Michal Czakon; example usage is illustrated in MBasymptotics.nb;
* MBresolve.m : a tool by Alexander V. Smirnov and Vladimir A. Smirnov realizing another strategy of resolving singularities of Mellin-Barnes integrals. This code should be loaded together with MB.m since it uses some of its routines. For details see arXiv:0901.0386. Updated in "MB tools relaoded" by Andrei V. Belitsky, Aleaxander V. Smirnov and Vladimir A. Smirnov to produce rational (as opposed to the decimal form of) shifts
* MBcreate.m : a tool by Andrei V. Belitsky, Aleaxander V. Smirnov and Vladimir A. Smirnov to convert Feynman parametric integrals (with and without delta-function constraints) to a concise Mellin-Barnes representation; for details see "MB tools reloaded"; detailed example is given in example.nb
* AMBRE.m : a tool by Janusz Gluza, Krzysztof Kajda and Tord Riemann for constructing Mellin-Barnes representations. It works both for planar multiloop scalar and one-loop tensor Feynman integrals. This is version 1.2, for previous versions and detailed description of the package with examples see the home page . The program is described in arXiv:0704.2423 and Computer Physics Communications 177 (2007) 879.
* barnesroutines.m : a tool by David A. Kosower for automatic application of the first and second Barnes lemmas on lists of multiple Mellin-Barnes integrals; an example notebook is included; a very long list by Vladimir A. Smirnov (2004) of corollories of the two lemmas is provided in barnes.txt
* libgamma: small library provided by Michael Czakon based on a part of cernlib for fortran evaluation of Gamma and PolyGamma
* Cuba: integration library by Thomas Hahn
