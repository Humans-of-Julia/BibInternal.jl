[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://Humans-of-Julia.github.io/BibInternal.jl/dev)
[![Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://Humans-of-Julia.github.io/BibInternal.jl/stable)
[![Build Status](https://github.com/Humans-of-Julia/BibInternal.jl/workflows/CI/badge.svg)](https://github.com/Humans-of-Julia/BibInternal.jl/actions)
[![codecov](https://codecov.io/gh/Humans-of-Julia/BibInternal.jl/branch/master/graph/badge.svg?token=zkneHUR45j)](https://codecov.io/gh/Humans-of-Julia/BibInternal.jl)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# BibInternal.jl

This package provides an internal format to translate from/to other bibliographic format.

All entries depend of an abstract supertype `AbstractEntry`.
One generic entry `GenericEntry` is available to make entries without any specific rules.

Currently, only one set of entries following the BibTeX rules is available. *Required* and *optional* BibTeX fields are checked by the constructor.

Pull Requests to add more entries (or update the BibTeX rules) are welcome.

## Packages using BibInternal.jl
- [BibParser.jl](https://github.com/Humans-of-Julia/BibParser.jl) : A package to parse bibliography files
  - BibParser.BibTEX: an Automa.jl based BibTeX parser
- [Bibliography.jl](https://github.com/Humans-of-Julia/Bibliography.jl) : A wrapper package to translate from/to different bibliographic formats (currently BibTeX and some web export)