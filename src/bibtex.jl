const Required = Union{String,Tuple{String,String}}

"""
    const rules = Dict([
        "article"       => ["author", "journal", "title", "year"]
        "book"          => [("author", "editor"), "publisher", "title", "year"]
        "booklet"       => ["title"]
        "eprint"        => ["author", "eprint", "title", "year"]
        "inbook"        => [("author", "editor"), ("chapter", "pages"), "publisher", "title", "year"]
        "incollection"  => ["author", "booktitle", "publisher", "title", "year"]
        "inproceedings" => ["author", "booktitle", "title", "year"]
        "manual"        => ["title"]
        "mastersthesis" => ["author", "school", "title", "year"]
        "misc"          => []
        "phdthesis"     => ["author", "school", "title", "year"]
        "proceedings"   => ["title", "year"]
        "techreport"    => ["author", "institution", "title", "year"]
        "unpublished"   => ["author", "note", "title"]
    ])
List of BibTeX rules bases on the entry type. A field value as a singleton represents a required field. A pair of values represents mutually exclusive required fields.
"""
const rules = Dict{String,Vector{Required}}(
    [
        "article" => ["author", "journal", "title", "year"]
        "book" => [("author", "editor"), "publisher", "title", "year"]
        "booklet" => ["title"]
        "eprint" => ["author", "eprint", "title", "year"]
        "inbook" =>
            [("author", "editor"), ("chapter", "pages"), "publisher", "title", "year"]
        "incollection" => ["author", "booktitle", "publisher", "title", "year"]
        "inproceedings" => ["author", "booktitle", "title", "year"]
        "manual" => ["title"]
        "mastersthesis" => ["author", "school", "title", "year"]
        "misc" => []
        "phdthesis" => ["author", "school", "title", "year"]
        "proceedings" => ["title", "year"]
        "techreport" => ["author", "institution", "title", "year"]
        "unpublished" => ["author", "note", "title"]
    ],
)

"""
    check_entry(fields::Fields)
Check the validity of the fields of a BibTeX entry.
"""
function check_entry(fields)
    errors = Vector{String}()

    for t_field in rules[get(fields, "_type", "misc")]
        at_least_one = false
        if typeof(t_field) == Tuple{String,String}
            for field in t_field
                if get(fields, field, "") != ""
                    at_least_one = true
                    break
                end
            end
            if !at_least_one
                push!(errors, "{" * foldl((x, y) -> "$x≡$y", t_field; init="")[2:end] * "}")
            end
        else
            get(fields, t_field, "") == "" && push!(errors, t_field)
        end
    end

    return errors
end

"""
    make_bibtex_entry(id::String, fields::Fields)
Make an entry if the entry follows the BibTeX guidelines. Throw an error otherwise.
"""
function make_bibtex_entry(id, fields)
    # @info id fields
    "eprint" ∈ keys(fields) && (fields["_type"] = "eprint")
    fields = Dict(lowercase(k) => v for (k, v) in fields) # lowercase tag names
    errors = check_entry(fields)
    if length(errors) > 0
        error(
            "Entry $id is missing the " *
            foldl(((x, y) -> x * ", " * y), errors) *
            " field(s).",
        )
    end
    return Entry(id, fields)
end
