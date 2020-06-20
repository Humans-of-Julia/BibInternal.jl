# Type of rules
struct RequiredRule <: AbstractRule end
struct OptionalRule <: AbstractRule end
struct IgnoredRule <: AbstractRule end
struct ForbiddenRule <: AbstractRule end
abstract type AlternativelyRequiredRule <: AbstractRule end
struct InclusivelyRequiredRule <: AlternativelyRequiredRule
    alternative::Vector{Symbol}
end
struct ExclusivelyRequiredRule <: AlternativelyRequiredRule
    alternative::Vector{Symbol}
end

# Dictionnary type to store rules of a set : Tuple of Entry/Field
const EntryFieldRules = Dict{Tuple{Symbol,Symbol},AbstractRule}

# Import set of rules from other files
include("bibtexrules.jl")

# Store rules in a Dictionnary
rules_sets = Dict{AbstractRulesSet,EntryFieldRules}(
    EmptyRules()        =>  EntryFieldRules(),
    BibtexRules()       =>  generate_bibtex_rules()
)
