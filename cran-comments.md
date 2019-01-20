## Test environments
* local OS X install, R 3.5.2
* ubuntu 14.04 (on travis-ci), R 3.5.2
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

===============

This is an API pacakge to a free resource for
cybersecurity data <opendata.rapid7.com>.
The functions need an API key to work and the
datasets themselvs are gigabytes to terabytes.
Therefore the tests skip on CRAN but the 
example blocks are wrapped in try{} so there is 
at least some attempt to exercise the code 
in a CRAN context. I'll glady remove the try{}
blocks and use \dontrun{}s but I've gotten 
mixed results depending on the reviewer with
\dontrun{} in and out so any deterministic 
approach to successfully getting API packages
requiring API keys on CRAN without causing
extra work for the CRAN team will gladly 
be followed.