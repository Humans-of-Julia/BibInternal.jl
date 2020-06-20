# List of possible entries (currently based on bibtex). Keep it sorted for readability
const entries = [
    :article,
    :book,
    :booklet,
    :inbook,
    :incollection,
    :inproceedings,
    :manual,
    :masterthesis,
    :misc,
    :phdthesis,
    :proceedings,
    :techreport,
    :unpublished,
]

# List of possible entries (currently based on bibtex). Keep it sorted for readability
const entrylist = [:article, :book, :booklet, :inbook, :incollection, :inproceedings,
    :manual, :masterthesis, :misc, :phdthesis, :proceedings, :techreport, :unpublished]

# Dictionnary type to handle the fields of an entry
const EntryFields = Dict{Symbol,AbstractString}

# Exception related to entry management
struct EntryException <: Exception end

# Entry type
struct Entry
    kind::Symbol
    key::AbstractString
    fields::EntryFields
end

# TODO: check types
# External constructor
function Entry(
    kind::AbstractString,
    key::AbstractString,
    fieldList::Vector{Tuple{String,String}},
    rule::AbstractRulesSet=EmptyRules()
    )
    fields = EntryFields()
    for elt in fieldList
        fields[Symbol(elt[1])] = elt[2]
    end
    return Entry(Symbol(kind), key, fields)
end
