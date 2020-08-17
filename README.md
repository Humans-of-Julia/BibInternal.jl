[![Build Status](https://travis-ci.com/Azzaare/BibInternal.jl.svg?branch=master)](https://travis-ci.com/Azzaare/BibInternal.jl)
[![codecov](https://codecov.io/gh/Azzaare/BibInternal.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Azzaare/BibInternal.jl)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://Azzaare.github.io/BibInternal.jl/stable)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# BibInternal.jl

This package provides an internal format to translate from/to other bibliographic format.

All entries depend of an abstract supertype `AbstractEntry`.
One generic entry `GenericEntry` is available to make entries without any specific rules.

Currently, only one set of entries following the BibTeX rules is available. *Required* and *optional* BibTeX fields are checked by the constructor.

Pull Requests to add more entries (or update the BibTeX rules) are welcome.

## Packages using BibInternal.jl
- [BibParser.jl](https://github.com/Azzaare/BibParser.jl) : A package to parse bibliography files
  - BibParser.BibTEX: an Automa.jl based BibTeX parser
- [Bibliography.jl](https://github.com/Azzaare/Bibliography.jl) : A wrapper package to translate from/to different bibliographic formats (currently BibTeX and some web export)