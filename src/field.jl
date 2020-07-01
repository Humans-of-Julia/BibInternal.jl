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
const maxfieldlength = maximum(map(s -> length(string(s)), fields))

function space(field::Symbol)
    return maxfieldlength - length(string(field))
end