[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://Humans-of-Julia.github.io/BibInternal.jl/dev)
[![Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://Humans-of-Julia.github.io/BibInternal.jl/stable)
[![Build Status](https://github.com/Humans-of-Julia/BibInternal.jl/workflows/CI/badge.svg)](https://github.com/Humans-of-Julia/BibInternal.jl/actions)
[![codecov](https://codecov.io/gh/Humans-of-Julia/BibInternal.jl/branch/master/graph/badge.svg?token=zkneHUR45j)](https://codecov.io/gh/Humans-of-Julia/BibInternal.jl)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Discord chat](https://img.shields.io/discord/762167454973296644.svg?logo=discord&colorB=7289DA&style=flat-square)](https://discord.gg/7KC28q98nP)

# BibInternal.jl

This package provides an internal format to translate from/to other bibliographic format.

All entries depend on an abstract super type `AbstractEntry`.
One generic entry `GenericEntry` is available to make entries without any specific rules.

Currently, only one set of entries following the BibTeX rules is available. *Required* and *optional* BibTeX fields are checked by the constructor.

Pull Requests to add more entries (or update the BibTeX rules) are welcome.

Discussions are welcome either on this GitHub repository or on the `#modern-academics` channel of [Humans of Julia](https://humansofjulia.org/) (to join the Discord server, please click the `chat` badge above).

## Packages using BibInternal.jl
- [BibParser.jl](https://github.com/Humans-of-Julia/BibParser.jl) : A package to parse bibliography files
  - BibParser.BibTEX: an Automa.jl based BibTeX parser
- [Bibliography.jl](https://github.com/Humans-of-Julia/Bibliography.jl) : A wrapper package to translate from/to different bibliographic formats such as BibTeX, [StaticWebPages.jl](https://github.com/Humans-of-Julia/StaticWebPages.jl), and [DocumenterCitations.jl](https://github.com/ali-ramadhan/DocumenterCitations.jl).
