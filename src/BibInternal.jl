module BibInternal

# Abstract types to handle bibliographies items
abstract type AbstractRule end
abstract type AbstractRulesSet end

# EmptyRules set
struct EmptyRules <: AbstractRulesSet end

# Includes
include("field.jl")
include("entry.jl")
include("rule.jl") # includes sub rules files

end # module
