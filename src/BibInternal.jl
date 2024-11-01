module BibInternal

"""
Abstract entry supertype.
"""
abstract type AbstractEntry end

# Imports
import TestItems: @testitem

# Includes
include("constant.jl")
include("utilities.jl")
include("bibtex.jl")
include("entry.jl")

end # module
