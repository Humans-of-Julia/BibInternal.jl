module BibInternal

# Abstract Entry type
abstract type AbstractEntry end

# Generic Entry type (any fields is accepted without check nor rules)
struct GenericEntry <: AbstractEntry
    fields::Dict{String,String}
end

# Includes
include("constant.jl")
include("utilities.jl")
include("bibtex.jl")

end # module
