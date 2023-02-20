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
const BIBTEX_ENTRIES = [
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

const BIBLATEX_ENRTIES = [
    :article,
    :book,
    :bookinbook,
    :booklet,
    :collection,
    :inbook,
    :incollection,
    :inproceedings,
    :inreference,
    :manual,
    :misc,
    :mvbook,
    :mvcollection,
    :mvproceedings,
    :mvreference,
    :online,
    :patent,
    :periodical,
    :proceedings,
    :reference,
    :report,
    :set,
    :suppbook,
    :suppcollection,
    :suppperiodical,
    :thesis,
    :unpublished,
    :xdata,
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
const BIBTEX_FIELDS = [
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
    :year,
]

const BIBLATEX_FIELDS = [
    :authors,
    :afterword,
    :annotator,
    :bookauthor,
    :booktitle,
    :commentator,
    :editor,
    :editora,
    :editorb,
    :editorc,
    :eventtitle,
    :forward,
    :holder,
    :indextitle,
    :institution,
    :introduction,
    :issuetitle,
    :journaltitle,
    :maintitle,
    :organization,
    :publisher,
    :reprinttitle,
    :series,
    :title,
    :translator,
]

const FIELDS = union!(BIBTEX_FIELDS, BIBLATEX_FIELDS)

"""
    const maxfieldlength
For output formatting purpose, for instance, export to BibTeX format.
"""
const MAX_FIELD_LENGTH = maximum(map(s -> length(string(s)), FIELDS))
