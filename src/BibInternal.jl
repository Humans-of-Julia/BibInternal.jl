module BibInternal

# Abstract types to handle bibliographies items
abstract type AbstractRule end
abstract type AbstractRulesSet end

# EmptyRules set
struct EmptyRules <: AbstractRulesSet end

# Abstract Entry type
abstract type AbstractEntry end

# Includes
include("field.jl")
include("entry.jl")
include("bibtex.jl")

end # module
