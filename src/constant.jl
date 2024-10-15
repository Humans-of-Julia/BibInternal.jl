"""
`Fields = Dict{String, String}`. Stores the fields `name => value` of an entry.
"""
const Fields = Dict{String,String}

"""
    const entries = [
        :article,
        :book,
        :booklet,
        :inbook,
        :incollection,
        :inproceedings,
        :manual,
        :mastersthesis,
        :misc,
        :phdthesis,
        :proceedings,
        :techreport,
        :unpublished,
    ]
List of possible entries (currently based on bibtex). Keep it sorted for readability.
"""
const entries = [
    :article,
    :book,
    :booklet,
    :inbook,
    :incollection,
    :inproceedings,
    :manual,
    :mastersthesis,
    :misc,
    :phdthesis,
    :proceedings,
    :techreport,
    :unpublished,
]

"""
    const fields = [
        :address,
        :annote,
        :archivePrefix,
        :author,
        :booktitle,
        :chapter,
        :crossref,
        :edition,
        :editor,
        :eprint,
        :howpublished,
        :institution,
        :isbn,
        :issn,
        :journal,
        :key,
        :month,
        :note,
        :number,
        :organization,
        :pages,
        :primaryClass,
        :publisher,
        :school,
        :series,
        :title,
        :type,
        :volume,
        :year
    ]
List of possible fields (currently based on bibtex). Keep it sorted for readability
"""
const fields = [
    :address,
    :annote,
    :archivePrefix,
    :author,
    :booktitle,
    :chapter,
    :crossref,
    :edition,
    :editor,
    :eprint,
    :howpublished,
    :institution,
    :isbn,
    :issn,
    :journal,
    :key,
    :month,
    :note,
    :number,
    :organization,
    :pages,
    :primaryClass,
    :publisher,
    :school,
    :series,
    :title,
    :type,
    :volume,
    :year,
]

"""
    const maxfieldlength
For output formatting purpose, for instance, export to BibTeX format.
"""
const maxfieldlength = maximum(map(s -> length(string(s)), fields))
