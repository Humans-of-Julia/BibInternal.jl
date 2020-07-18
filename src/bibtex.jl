Required = Union{String, Tuple{String, String}}

const rules = Dict{String, Vector{Required}}([
    "article"       => ["author", "journal", "title", "volume", "year"]
    "book"          => [("author", "editor"), "publisher", "title", "year"]
    "booklet"       => ["title"]
    "eprint"        => ["author", "eprint", "title", "year"]
    "inbook"        => [("author", "editor"), ("chapter", "pages"), "publisher", "title", "year"]
    "incollection"  => ["author", "booktitle", "publisher", "title", "year"]
    "inproceedings" => ["author", "booktitle", "title", "year"]
    "manual"        => ["title"]
    "masterthesis"  => ["author", "school", "title", "year"]
    "misc"          => []
    "phdthesis"     => ["author", "school", "title", "year"]
    "proceedings"   => ["title", "year"]
    "techreport"    => ["author", "institution", "title", "year"]
    "unpublished"   => ["author", "note", "title"]
])

function check_entry(
    fields::Fields
    )
    errors = Vector{String}()
    for t_field in rules[get(fields, "type", "misc")]
        at_least_one = false
        if typeof(t_field) == Tuple{String,String}
            for field in t_field
                if get(fields, field, "") != ""
                    at_least_one = true
                    break
                end
            end
            if !at_least_one 
                push!(errors, "{" * foldl((x,y)->"$x≡$y", t_field; init = "")[2:end] * "}")
            end
        else
            if get(fields, t_field, "") == ""
                push!(errors, t_field)
            end
        end
    end
    return errors
end

function make_bibtex_entry(
    id::String,
    fields::Fields
    )
    if "eprint" ∈ keys(fields)
        fields["type"] = "eprint"
    end
    errors = check_entry(fields)
    if length(errors) > 0
        error("Entry $id is missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
    end
    return Entry(id,fields)
end