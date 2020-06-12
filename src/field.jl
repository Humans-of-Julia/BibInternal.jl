# List of possible fields (currently based on bibtex). Keep it sorted for readability
const fields = [
    :address,
    :annote,
    :author,
    :booktitle,
    :chapter,
    :crossref,
    :edition,
    :editor,
    :howpublished,
    :institution,
    :journal,
    :key,
    :month,
    :note,
    :number,
    :organization,
    :pages,
    :publisher,
    :school,
    :series,
    :title,
    :type,
    :volume,
    :year
]

# For output formatting purpose
const maxfieldlength = maximum(map(s->length(string(s)), fields))

function space(field::Symbol)
    return maxfieldlength - length(string(field))
end

# Exceptions to convey errors in fields presence rules and formating
struct FieldNameException <: Exception
    name::AbstractString
end
struct FieldContentException <: Exception
    content::AbstractString
    function FieldContentException(args...)
        new(content)
    end
end

# TODO: Fill the check_field function for each field using regexp and LaTeX to text convertor
function check_field(
    field::Symbol,
    entrykind::Symbol,
    string::AbstractString
    )
    if true
        return string
    end
    throw(FieldContentException(string))
end