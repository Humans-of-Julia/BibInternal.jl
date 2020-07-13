# BibInternal.jl

This package provides an internal format to translate from/to other bibliographic formating.

All entries depend of an abstract supertype `AbstractEntry`.
One generic entry `GenericEntry` is available to make entries without any specific rules.

Currently, only one set of entries following the BibTeX rules is available. *Required* and *optional* BibTeX fields are checked by the constructor.

Pull Requests to add more entries (or update the BibTeX rules) are welcome.

## Packages using BibInternal.jl
- [BibParser.jl](https://github.com/Azzaare/BibParser.jl) : A package to parse bibliography files
  - BibParser.BibTEX: an Automa.jl based BibTeX parser
- [Bibliography.jl](https://github.com/Azzaare/Bibliography.jl) : A wrapper package to translate from/to different bibliographic formats (currently BibTeX and some web export)