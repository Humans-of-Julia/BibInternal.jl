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

# List of possible fields (currently based on bibtex). Keep it sorted for readability
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

# For output formatting purpose
const maxfieldlength = maximum(map(s -> length(string(s)), fields))