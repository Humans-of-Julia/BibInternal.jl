module BibTeX # Based on https://en.wikipedia.org/wiki/BibTeX

import BibInternal.AbstractEntry

export Article, Book, Booklet, InBook, InCollection, InProceedings, Manual, MasterThesis, Misc, PhDThesis, Proceedings, TechReport, Unpublished
export make_bibtex_entry, BibtexName, string_to_bibtex_name

function make_bibtex_entry(
    type::String,
    id::String,
    fields::Dict{String,String}
    )
    if type == "article"
        return Article(id, fields)
    elseif type == "book"
        return Book(id, fields)
    elseif type == "booklet"
        return Booklet(id, fields)
    elseif type == "inbook"
        return InBook(id, fields)
    elseif type == "incollection"
        return InCollection(id, fields)
    elseif type == "inproceedings" || type == "conference"
        return InProceedings(id, fields)
    elseif type == "manual"
        return Manual(id, fields)
    elseif type == "masterthesis"
        return MasterThesis(id, fields)
    elseif type == "phdthesis"
        return PhDThesis(id, fields)
    elseif type == "proceedings"
        return Proceedings(id, fields)
    elseif type == "techreport"
        return TechReport(id, fields)
    elseif type == "unpublished"
        return Unpublished(id, fields)
    end
    # default
    return Misc(id, fields)
end

function get_delete(d::Dict{String,String}, key::String)
    ans = get(d, key, "")
    delete!(d, key)
    return ans
end

struct BibtexName  
    particle::String
    last::String
    junior::String
    first::String
    middle::String  
end

function strings_to_bibtexnames(str::String)
    aux = split(str, r"[\n\r ]and[\n\r ]")
    return map(x -> string_to_bibtex_name(String(x)), aux)
end

function string_to_bibtex_name(str::String)
    subnames = split(str, r"[\n\r ]*,[\n\r ]*")
    
    # subnames containers
    first = ""
    middle = ""
    particle = ""
    last = ""
    junior = ""

    # mark for string parsing
    mark_in = 1
    mark_out = 0

    # BibTeX form 1: First Second von Last
    if length(subnames) == 1
        aux = split(subnames[1], r"[\n\r ]+")
        mark_out = length(aux) - 1
        last = aux[end]
        if length(aux) > 1 && isuppercase(aux[1][1])
            first = aux[1]
            mark_in += 1
            for s in aux[2:end-1]
                mark_in += 1
                if islowercase(s[1])
                    break;
                end
                middle *= " $s"
            end
            for s in reverse(aux[mark_in:mark_out])
                if islowercase(s[1])
                    break;
                end
                mark_out -= 1
                last = "$s " * last
            end
            for s in aux[mark_in:mark_out]
                particle *= " $s"
            end
        end
    end
    # BibTeX form 2: von Last, First Second
    if length(subnames) == 2
        aux = split(subnames[1], r"[\n\r ]+") # von Last
        mark_out = length(aux) - 1
        last = string(aux[end])
        for s in reverse(aux[1:mark_out])
            if islowercase(s[1])
                break;
            end
            mark_out -= 1
            last = "$s " * last
        end
        for s in aux[1:mark_out]
            particle *= " $s"
        end
        aux = split(subnames[2], r"[\n\r ]+")
        first = aux[1]
        if length(aux) > 1
            for s in aux[2:end]
                middle *= " $s"
            end
        end
    end
    if length(subnames) == 3
        aux = split(subnames[1], r"[\n\r ]+") # von Last
        mark_out = length(aux) - 1
        last = aux[end]
        for s in reverse(aux[1:mark_out])
            if islowercase(s[1])
                break;
            end
            mark_out -= 1
            last = "$s " * last
        end
        for s in aux[1:mark_out]
            particle *= " $s"
        end
        junior = subnames[2]
        aux =split(subnames[3], r"[\n\r ]+")
        first = aux[1]
        if length(aux) > 1
            for s in aux[2:end]
                middle *= " $s"
            end
        end
    end
    return BibtexName(particle, last, junior, first, middle)
end

struct Article <: AbstractEntry
    # ID field
    id::String

    # Required fields
    author::Vector{BibtexName}
    journal::String
    title::String
    volume::String
    year::String

    # Optional fields
    doi::String
    key::String
    month::String
    note::String
    number::String
    pages::String

    # Other fields
    fields::Dict{String,String}

    function Article(
        id::String,
        author::String,
        journal::String,
        title::String,
        volume::String,
        year::String,
        doi::String,
        key::String,
        month::String,
        note::String,
        number::String,
        pages::String,
        fields::Dict{String,String}=Dict{String,String}()
        )
        errors = Vector{String}()
        if author == ""
            push!(errors, "author")
        end
        if journal == ""
            push!(errors, "journal")
        end
        if title == ""
            push!(errors, "title")
        end
        if volume == ""
            push!(errors, "volume")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        return new(id, authors, journal, title, volume, year, doi, key, month, note, number, pages, fields)            
    end
end
function Article(
    id::String,
    author::Vector{BibtexName},
    journal::String,
    title::String,
    volume::String,
    year::String;
    doi::String="",
    key::String="",
    month::String="",
    note::String="",
    number::String="",
    pages::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    Article(id, author, journal, title, volume, year, doi, key, month, note, number, pages, fields)
end
function Article(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    journal = get_delete(d, "journal")
    title = get_delete(d, "title")
    volume = get_delete(d, "volume")
    year = get_delete(d, "year")
    doi = get_delete(d, "doi")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    number = get_delete(d, "number")
    pages = get_delete(d, "pages")

    Article(id, author, journal, title, volume, year, doi, key, month, note, number, pages, d)
end


struct Book <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName} # shared with editor
    editor::Vector{BibtexName} # shared with author
    publisher::String
    title::String
    year::String

    # Optional
    address::String
    edition::String
    key::String
    month::String
    note::String
    number::String # shared with volume
    series::String
    url::String
    volume::String # shared with number

    # Other fields
    fields::Dict{String,String}

    function Book(
        id::String,
        author::String, # shared with editor
        editor::String, # shared with author
        publisher::String,
        title::String,
        year::String,
        address::String,
        edition::String,
        key::String,
        month::String,
        note::String,
        number::String, # shared with volume
        series::String,
        url::String,
        volume::String, # shared with number
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == editor == ""
            push!(errors, "author/editor")
        end
        if publisher == ""
            push!(errors, "publisher")
        end
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        editors = strings_to_bibtexnames(editor)
        return new(id, authors, editors, publisher, title, year, address, edition, key, month, note, number, series, url, volume, fields)
    end
end

function Book(
    id::String,
    author::Vector{BibtexName}, # shared with editor
    editor::Vector{BibtexName}, # shared with author
    publisher::String,
    title::String,
    year::String;
    address::String="",
    edition::String="",
    key::String="",
    month::String="",
    note::String="",
    number::String="", # shared with volume
    series::String="",
    url::String="",
    volume::String="", # shared with number
    fields::Dict{String,String}=Dict{String,String}()
    )
    Book(id, author, editor, publisher, title, year, address, edition, key, month, note, number, series, url, volume, fields)
end

function Book(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    editor = get_delete(d, "editor")
    publisher = get_delete(d, "publisher")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    edition = get_delete(d, "edition")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    number = get_delete(d, "number")
    series = get_delete(d, "series")
    url = get_delete(d, "url")
    volume = get_delete(d, "volume")

    Book(id, author, editor, publisher, title, year, address, edition, key, month, note, number, series, url, volume, d)
end

struct Booklet <: AbstractEntry
    # ID field
    id::String

    # Required
    title::String

    # Optional
    address::String
    author::Vector{BibtexName}
    howpublished::String
    key::String
    month::String
    note::String
    year::String

    # Other fields
    fields::Dict{String,String}

    function Booklet(
        id::String,
        title::String,
        address::String,
        author::String,
        howpublished::String,
        key::String,
        month::String,
        note::String,
        year::String,
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if title == ""
            push!(errors, "title")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        return new(id, title, address, authors, howpublished, key, month, note, year, fields)
    end

end

function Booklet(
    id::String,
    title::String;
    address::String="",
    author::Vector{BibtexName}=[],
    howpublished::String="",
    key::String="",
    month::String="",
    note::String="",
    year::String="",
    fields::Dict{String,String}=Dict{String,String}()
)
    Booklet(id, title, address, author, howpublished, key, month, note, year, fields)
end

function Booklet(id::String, d::Dict{String,String})
    title = get_delete(d, "title")
    address = get_delete(d, "address")
    author = get_delete(d, "author")
    howpublished = get_delete(d, "howpublished")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    year = get_delete(d, "year")
    Booklet(id, title, address, author, howpublished, key, month, note, year, d)
end

struct InBook <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName} # shared with editor
    chapter::String # shared with pages
    editor::Vector{BibtexName} # shared with author
    pages::String # shared with chapter
    publisher::String
    title::String
    year::String

    # Optional
    address::String
    edition::String
    key::String
    month::String
    note::String
    number::String # shared with volume
    series::String
    type::String
    volume::String
    
    # Other fields
    fields::Dict{String,String}

    function InBook(
        id::String,
        author::String, # shared with editor
        chapter::String, # shared with pages
        editor::String, # shared with author
        pages::String, # shared with chapter
        publisher::String,
        title::String,
        year::String,
        address::String,
        edition::String,
        key::String,
        month::String,
        note::String,
        number::String, # shared with volume
        series::String,
        type::String,
        volume::String, # shared with number
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == editor == ""
            push!(errors, "author/editor")
        end
        if chapter == pages == ""
            push!(errors, "chapter/pages")
        end
        if publisher == ""
            push!(errors, "publisher")
        end
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        editors = strings_to_bibtexnames(editor)
        return new(id, authors, chapter, editors, pages, publisher, title, year, address, edition, key, month, note, number, series, type, volume, fields)
    end
end

function InBook(
    id::String,
    author::Vector{BibtexName}, # shared with editor
    chapter::String, # shared with pages
    editor::Vector{BibtexName}, # shared with author
    pages::String, # shared with chapter
    publisher::String,
    title::String,
    year::String;
    address::String="",
    edition::String="",
    key::String="",
    month::String="",
    note::String="",
    number::String="", # shared with volume
    series::String="",
    type::String="",
    volume::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    InBook(id, author, chapter, editor, pages, publisher, title, year, address, edition, key, month, note, number, series, type, volume, fields)
end

function InBook(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    chapter = get_delete(d, "chapter")
    editor = get_delete(d, "editor")
    pages = get_delete(d, "pages")
    publisher = get_delete(d, "publisher")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    edition = get_delete(d, "edition")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    number = get_delete(d, "number")
    series = get_delete(d, "series")
    type = get_delete(d, "type")
    volume = get_delete(d, " volume")
    InBook(id, author, chapter, editor, pages, publisher, title, year, address, edition, key, month, note, number, series, type, volume, d)
end

struct InCollection <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName}
    booktitle::String
    publisher::String
    title::String
    year::String

    # Optional
    address::String
    chapter::String
    edition::String
    editor::Vector{BibtexName}
    key::String
    month::String
    note::String
    number::String # shared with volume
    pages::String
    series::String
    type::String
    volume::String # shared with volume

    # Other fields
    fields::Dict{String,String}

    function InCollection(
        id::String,
        author::String,
        booktitle::String,
        publisher::String,
        title::String,
        year::String,
        address::String,
        chapter::String,
        edition::String,
        editor::String,
        key::String,
        month::String,
        note::String,
        number::String, # shared with volume
        pages::String,
        series::String,
        type::String,
        volume::String, # shared with volume
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == ""
            push!(errors, "author")
        end
        if booktitle == ""
            push!(errors, "booktitle")
        end
        if publisher == ""
            push!(errors, "publisher")
        end
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        editors = strings_to_bibtexnames(editor)
        return new(id, authors, booktitle, publisher, title, year, address, chapter, edition, editors, key, month, note, number, pages, series, type, volume, fields)
    end
end

function InCollection(
    id::String,
    author::Vector{BibtexName},
    booktitle::String,
    publisher::String,
    title::String,
    year::String;
    address::String="",
    chapter::String="",
    edition::String="",
    editor::Vector{BibtexName}=[],
    key::String="",
    month::String="",
    note::String="",
    number::String="", # shared with volume
    pages::String="",
    series::String="",
    type::String="",
    volume::String="", # shared with volume
    fields::Dict{String,String}=Dict{String,String}()
    )
    InCollection(id, author, booktitle, publisher, title, year, address, chapter, edition, editor, key, month, note, number, pages, series, type, volume, fields)
end

function InCollection(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    booktitle = get_delete(d, "booktitle")
    publisher = get_delete(d, "publisher")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    chapter = get_delete(d, "chapter")
    edition = get_delete(d, "edition")
    editor = get_delete(d, "editor")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    number = get_delete(d, "number")
    pages = get_delete(d, "pages")
    series = get_delete(d, "series")
    type = get_delete(d, "type")
    volume = get_delete(d, " volume")
    InCollection(id, author, booktitle, publisher, title, year, address, chapter, edition, editor, key, month, note, number, pages, series, type, volume, d)
end

struct InProceedings <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName}
    booktitle::String
    title::String
    year::String

    # Optional
    address::String
    editor::Vector{BibtexName}
    key::String
    month::String
    note::String
    number::String # shared with volume
    organization::String
    pages::String
    publisher::String
    series::String
    volume::String # shared with volume

    # Other fields
    fields::Dict{String,String}

    function InProceedings(
        id::String,
        author::String,
        booktitle::String,
        title::String,
        year::String,
        address::String,
        editor::String,
        key::String,
        month::String,
        note::String,
        number::String,
        organization::String,
        pages::String,
        publisher::String,
        series::String,
        volume::String,
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == ""
            push!(errors, "author")
        end
        if booktitle == ""
            push!(errors, "booktitle")
        end
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        editors = strings_to_bibtexnames(editor)
        return new(id, authors, booktitle, title, year, address, editors, key, month, note, number, organization, pages, publisher, series, volume, fields)
    end
end

function InProceedings(
    id::String,
    author::Vector{BibtexName},
    booktitle::String,
    title::String,
    year::String;
    address::String="",
    editor::Vector{BibtexName}=[],
    key::String="",
    month::String="",
    note::String="",
    number::String="",
    organization::String="",
    pages::String="",
    publisher::String="",
    series::String="",
    volume::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    InProceedings(id, author, booktitle, title, year, address, editor, key, month, note, number, organization, pages, publisher, series, volume, fields)
end

function InProceedings(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    booktitle = get_delete(d, "booktitle")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    editor = get_delete(d, "editor")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    number = get_delete(d, "number")
    organization = get_delete(d, "organization")
    pages = get_delete(d, "pages")
    publisher = get_delete(d, "publisher")
    series = get_delete(d, "series")
    volume = get_delete(d, " volume")
    InProceedings(id, author, booktitle, title, year, address, editor, key, month, note, number, organization, pages, publisher, series, volume, d)
end

struct Manual <: AbstractEntry
    # ID field
    id::String

    # Required
    title::String

    # Optional
    address::String
    author::Vector{BibtexName}
    edition::String
    key::String
    month::String
    note::String
    organization::String
    year::String

    # Other fields
    fields::Dict{String,String}

    function Manual(
        id::String,
        title::String,
        address::String,
        author::String,
        edition::String,
        key::String,
        month::String,
        note::String,
        organization::String,
        year::String,
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if title == ""
            push!(errors, "title")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        return new(id, title, address, authors, edition, key, month, note, organization, year, fields)
    end
end

function Manual(
    id::String,
    title::String;
    address::String="",
    author::Vector{BibtexName}=[],
    edition::String="",
    key::String="",
    month::String="",
    note::String="",
    organization::String="",
    year::String="",
    fields::Dict{String,String}=Dict{String,String}()
)
    Manual(id, title, address, author, edition, key, month, note, organization, year, fields)
end

function Manual(id::String, d::Dict{String,String})
    title = get_delete(d, "title")
    address = get_delete(d, "address")
    author = get_delete(d, "author")
    edition = get_delete(d, "edition")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    organization = get_delete(d, "organization")
    year = get_delete(d, "year")
    Manual(id, title, address, author, edition, key, month, note, organization, year, d)
end

struct MasterThesis <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName}
    school::String
    title::String
    year::String

    # Optional
    address::String
    key::String
    month::String
    note::String
    type::String

    # Other fields
    fields::Dict{String,String}

    function MasterThesis(
        id::String,
        author::String,
        school::String,
        title::String,
        year::String,
        address::String,
        key::String,
        month::String,
        note::String,
        type::String,
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == ""
            push!(errors, "author")
        end
        if school == ""
            push!(errors, "school")
        end
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        return new(id, authors, school, title,  year, address, key, month, note, type, fields)
    end
end

function MasterThesis(
    id::String,
    author::Vector{BibtexName},
    school::String,
    title::String,
    year::String;
    address::String="",
    key::String="",
    month::String="",
    note::String="",
    type::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    MasterThesis(id, author, school, title,  year, address, key, month, note, type, fields)
end

function MasterThesis(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    school = get_delete(d, "school")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    type = get_delete(d, "type")
    MasterThesis(id, author, school, title,  year, address, key, month, note, type, d)
end

struct Misc <: AbstractEntry
    # ID field
    id::String

    # Optional
    author::Vector{BibtexName}
    howpublished::String
    key::String
    month::String
    note::String
    title::String
    year::String

    # Other fields
    fields::Dict{String,String}

    function Misc(
        id::String,
        author::String,
        howpublished::String,
        key::String,
        month::String,
        note::String,
        title::String,
        year::String,
        fields::Dict{String,String}
        )
        authors = strings_to_bibtexnames(author)
        new(id, authors, howpublished, key, month, note, title, year, fields)
    end
end

function Misc(
    id::String;
    author::Vector{BibtexName}=[],
    howpublished::String="",
    key::String="",
    month::String="",
    note::String="",
    title::String="",
    year::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    Misc(id, author, howpublished, key, month, note, title, year, fields)
end

function Misc(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    howpublished = get_delete(d, "howpublished")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    Misc(id, author, howpublished, key, month, note, title, year, d)
end

struct PhDThesis <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName}
    school::String
    title::String
    year::String

    # Optional
    address::String
    key::String
    month::String
    note::String
    type::String

    # Other fields
    fields::Dict{String,String}

    function PhDThesis(
        id::String,
        author::String,
        school::String,
        title::String,
        year::String,
        address::String,
        key::String,
        month::String,
        note::String,
        type::String,
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == ""
            push!(errors, "author")
        end
        if school == ""
            push!(errors, "school")
        end
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end        
        authors = strings_to_bibtexnames(author)
        return new(id, authors, school, title,  year, address, key, month, note, type, fields)        
    end
end

function PhDThesis(
    id::String,
    author::Vector{BibtexName},
    school::String,
    title::String,
    year::String;
    address::String="",
    key::String="",
    month::String="",
    note::String="",
    type::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    PhDThesis(id, author, school, title,  year, address, key, month, note, type, fields)
end

function PhDThesis(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    school = get_delete(d, "school")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    type = get_delete(d, "type")
    PhDThesis(id, author, school, title,  year, address, key, month, note, type, d)
end

struct Proceedings <: AbstractEntry
    # ID field
    id::String

    # Required
    title::String
    year::String

    # Optional
    address::String
    editor::Vector{BibtexName}
    key::String
    month::String
    note::String
    number::String # shared with volume
    organization::String
    publisher::String
    series::String
    volume::String # shared with number

    # Other fields
    fields::Dict{String,String}

    function Proceedings(    
        id::String,    
        title::String,
        year::String,
        address::String,
        editor::String,
        key::String,
        month::String,
        note::String,
        number::String, # shared with volume
        organization::String,
        publisher::String,
        series::String,
        volume::String, # shared with number
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        editors = strings_to_bibtexnames(editor)
        return new(id, title, year, address, editors, key, month, note, number, organization, publisher, series, volume, fields)
    end
end

function Proceedings(
    id::String,
    title::String,
    year::String;
    address::String="",
    editor::Vector{BibtexName}=[],
    key::String="",
    month::String="",
    note::String="",
    number::String="", # shared with volume
    organization::String="",
    publisher::String="",
    series::String="",
    volume::String="", # shared with number
    fields::Dict{String,String}=Dict{String,String}()
    )
    Proceedings(id, title, year, address, editor, key, month, note, number, organization, publisher, series, volume, fields)
end

function Proceedings(id::String, d::Dict{String,String})
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    editor = get_delete(d, "editor")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    number = get_delete(d, "number")
    organization = get_delete(d, "organization")
    publisher = get_delete(d, "publisher")
    series = get_delete(d, "series")
    volume = get_delete(d, "volume")
    Proceedings(id, title, year, address, editor, key, month, note, number, organization, publisher, series, volume, d)
end

struct TechReport <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName}
    institution::String
    title::String
    year::String

    # Optional
    address::String
    key::String
    month::String
    note::String
    number::String
    type::String

    # Other fields
    fields::Dict{String,String}

    function TechReport(
        id::String,
        author::String,
        institution::String,
        title::String,
        year::String,
        address::String,
        key::String,
        month::String,
        note::String,
        number::String,
        type::String,
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == ""
            push!(errors, "author")
        end
        if institution == ""
            push!(errors, "institution")
        end
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        return new(id, authors, institution, title, year, address, key, month, note, number, type, fields)
    end
end

function TechReport(
    id::String,
    author::Vector{BibtexName},
    institution::String,
    title::String,
    year::String;
    address::String="",
    key::String="",
    month::String="",
    note::String="",
    number::String="",
    type::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    TechReport(id, author, institution, title, year, address, key, month, note, number, type, fields)
end

function TechReport(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    institution = get_delete(d, "institution")
    title = get_delete(d, "title")
    year = get_delete(d, "year")
    address = get_delete(d, "address")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    note = get_delete(d, "note")
    number = get_delete(d, "number")
    type = get_delete(d, "type")
    TechReport(id, author, institution, title, year, address, key, month, note, number, type, d)
end

struct Unpublished <: AbstractEntry
    # ID field
    id::String

    # Required
    author::Vector{BibtexName}
    note::String # TODO; is it required?
    title::String

    # Optional
    key::String
    month::String
    year::String

    # Other fields
    fields::Dict{String,String}

    function Unpublished(    
        id::String,    
        author::String,
        note::String,
        title::String,
        key::String,
        month::String,
        year::String,
        fields::Dict{String,String}
        )
        errors = Vector{String}()
        if author == []
            push!(errors, "author")
        end
        # if note == ""
        #     push!(errors, "note")
        # end
        if title == ""
            push!(errors, "title")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        authors = strings_to_bibtexnames(author)
        return new(id, authors, note, title, key, month, year, fields)
    end
end

function Unpublished(
    id::String,
    author::Vector{BibtexName},
    note::String,
    title::String;
    key::String="",
    month::String="",
    year::String="",
    fields::Dict{String,String}=Dict{String,String}()
    )
    Unpublished(id, author, note, title, key, month, year, fields)
end

function Unpublished(id::String, d::Dict{String,String})
    author = get_delete(d, "author")
    note = get_delete(d, "note")
    title = get_delete(d, "title")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    year = get_delete(d, "year")
    Unpublished(id, author, note, title, key, month, year, d)
end

end # Module BibTeX