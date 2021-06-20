module BibInternal

"""
Abstract entry supertype.
"""
abstract type AbstractEntry end

# Includes
include("constant.jl")
include("utilities.jl")
include("bibtex.jl")
include("entry.jl")

end # module
