module BibTeX # Based on https://en.wikipedia.org/wiki/BibTeX

import BibInternal.AbstractEntry

export Article, Book, Booklet, InBook, InCollection, InProceedings, Manual, MasterThesis, Misc, PhDThesis, Proceedings, TechReport, Unpublished
export make_bibtex_entry

function make_bibtex_entry(
    type::AbstractString,
    id::AbstractString,
    fields::Dict{AbstractString,AbstractString}
    )
    if type == "article"
        return Article(id, fields)
    end
end

function get_delete(d::Dict{AbstractString,AbstractString}, key::AbstractString)
    ans = get(d, key, "")
    delete!(d, key)
    return ans
end

struct Article <: AbstractEntry
    # ID field
    id::AbstractString

    # Required fields
    author::AbstractString
    journal::AbstractString
    title::AbstractString
    volume::AbstractString
    year::AbstractString

    # Optional fields
    doi::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    number::AbstractString
    pages::AbstractString

    # Other fields
    other::Dict{AbstractString,AbstractString}

    function Article(
        id::AbstractString,
        author::AbstractString,
        journal::AbstractString,
        title::AbstractString,
        volume::AbstractString,
        year::AbstractString,
        doi::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        number::AbstractString,
        pages::AbstractString,
        other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, journal, title, volume, year, doi, key, month, note, number, pages, other)            
    end
end
function Article(
    id::AbstractString,
    author::AbstractString,
    journal::AbstractString,
    title::AbstractString,
    volume::AbstractString,
    year::AbstractString;
    doi::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    number::AbstractString="",
    pages::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    Article(id, author, journal, title, volume, year, doi, key, month, note, number, pages, other)
end
function Article(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    author::AbstractString # shared with editor
    editor::AbstractString # shared with author
    publisher::AbstractString
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    edition::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    number::AbstractString # shared with volume
    series::AbstractString
    url::AbstractString
    volume::AbstractString # shared with number

    # Other
    other::Dict{AbstractString,AbstractString}

    function Book(
        id::AbstractString,
        author::AbstractString, # shared with editor
        editor::AbstractString, # shared with author
        publisher::AbstractString,
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        edition::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        number::AbstractString, # shared with volume
        series::AbstractString,
        url::AbstractString,
        volume::AbstractString, # shared with number
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, editor, publisher, title, year, address, edition, key, month, note, number, series, url, volume, other)
    end
end

function Book(
    id::AbstractString,
    author::AbstractString, # shared with editor
    editor::AbstractString, # shared with author
    publisher::AbstractString,
    title::AbstractString,
    year::AbstractString;
    address::AbstractString="",
    edition::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    number::AbstractString="", # shared with volume
    series::AbstractString="",
    url::AbstractString="",
    volume::AbstractString="", # shared with number
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    Book(id, author, editor, publisher, title, year, address, edition, key, month, note, number, series, url, volume, other)
end

function Book(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    title::AbstractString

    # Optional
    address::AbstractString
    author::AbstractString
    howpublished::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    year::AbstractString

    # Other
    other::Dict{AbstractString,AbstractString}

    function Booklet(
        id::AbstractString,
        title::AbstractString,
        address::AbstractString,
        author::AbstractString,
        howpublished::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        year::AbstractString,
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
        if title == ""
            push!(errors, "title")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        return new(title, address, author, howpublished, key, month, note, year, other)
    end

end

function Booklet(
    id::AbstractString,
    title::AbstractString;
    address::AbstractString="",
    author::AbstractString="",
    howpublished::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    year::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
)
    Booklet(id, title, address, author, howpublished, key, month, note, year, other)
end

function Booklet(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    author::AbstractString # shared with editor
    chapter::AbstractString # shared with pages
    editor::AbstractString # shared with author
    pages::AbstractString # shared with chapter
    publisher::AbstractString
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    edition::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    number::AbstractString # shared with volume
    series::AbstractString
    type::AbstractString
    volume::AbstractString
    
    # Other
    other::Dict{AbstractString,AbstractString}

    function InBook(
        id::AbstractString,
        author::AbstractString, # shared with editor
        chapter::AbstractString, # shared with pages
        editor::AbstractString, # shared with author
        pages::AbstractString, # shared with chapter
        publisher::AbstractString,
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        edition::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        number::AbstractString, # shared with volume
        series::AbstractString,
        type::AbstractString,
        volume::AbstractString, # shared with number
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, chapter, editor, pages, publisher, title, year, address, edition, key, month, note, number, series, type, volume, other)
    end
end

function InBook(
    id::AbstractString,
    author::AbstractString, # shared with editor
    chapter::AbstractString, # shared with pages
    editor::AbstractString, # shared with author
    pages::AbstractString, # shared with chapter
    publisher::AbstractString,
    title::AbstractString,
    year::AbstractString;
    address::AbstractString="",
    edition::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    number::AbstractString="", # shared with volume
    series::AbstractString="",
    type::AbstractString="",
    volume::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    InBook(id, author, chapter, editor, pages, publisher, title, year, address, edition, key, month, note, number, series, type, volume, other)
end

function InBook(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    author::AbstractString
    booktitle::AbstractString
    publisher::AbstractString
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    chapter::AbstractString
    edition::AbstractString
    editor::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    number::AbstractString # shared with volume
    pages::AbstractString
    series::AbstractString
    type::AbstractString
    volume::AbstractString # shared with volume

    # Other
    other::Dict{AbstractString,AbstractString}

    function InCollection(
        id::AbstractString,
        author::AbstractString,
        booktitle::AbstractString,
        publisher::AbstractString,
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        chapter::AbstractString,
        edition::AbstractString,
        editor::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        number::AbstractString, # shared with volume
        pages::AbstractString,
        series::AbstractString,
        type::AbstractString,
        volume::AbstractString, # shared with volume
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, booktitle, publisher, title, year, address, chapter, edition, editor, key, month, note, number, pages, series, type, volume, other)
    end
end

function InCollection(
    id::AbstractString,
    author::AbstractString,
    booktitle::AbstractString,
    publisher::AbstractString,
    title::AbstractString,
    year::AbstractString;
    address::AbstractString="",
    chapter::AbstractString="",
    edition::AbstractString="",
    editor::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    number::AbstractString="", # shared with volume
    pages::AbstractString="",
    series::AbstractString="",
    type::AbstractString="",
    volume::AbstractString="", # shared with volume
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    InCollection(id, author, booktitle, publisher, title, year, address, chapter, edition, editor, key, month, note, number, pages, series, type, volume, other)
end

function InCollection(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    author::AbstractString
    booktitle::AbstractString
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    editor::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    number::AbstractString # shared with volume
    organization::AbstractString
    pages::AbstractString
    publisher::AbstractString
    series::AbstractString
    volume::AbstractString # shared with volume

    # Other
    other::Dict{AbstractString,AbstractString}

    function InProceedings(
        id::AbstractString,
        author::AbstractString,
        booktitle::AbstractString,
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        editor::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        number::AbstractString,
        organization::AbstractString,
        pages::AbstractString,
        publisher::AbstractString,
        series::AbstractString,
        volume::AbstractString,
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, booktitle, title, year, address, editor, key, month, note, number, organization, pages, publisher, series, volume, other)
    end
end

function InProceedings(
    id::AbstractString,
    author::AbstractString,
    booktitle::AbstractString,
    title::AbstractString,
    year::AbstractString;
    address::AbstractString="",
    editor::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    number::AbstractString="",
    organization::AbstractString="",
    pages::AbstractString="",
    publisher::AbstractString="",
    series::AbstractString="",
    volume::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    InProceedings(id, author, booktitle, title, year, address, editor, key, month, note, number, organization, pages, publisher, series, volume, other)
end

function InProceedings(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    title::AbstractString

    # Optional
    address::AbstractString
    author::AbstractString
    edition::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    organization::AbstractString
    year::AbstractString

    # Other
    other::Dict{AbstractString,AbstractString}

    function Manual(
        id::AbstractString,
        title::AbstractString,
        address::AbstractString,
        author::AbstractString,
        edition::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        organization::AbstractString,
        year::AbstractString,
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
        if title == ""
            push!(errors, "title")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        return new(id, title, address, author, edition, key, month, note, organization, year, other)
    end
end

function Manual(
    id::AbstractString,
    title::AbstractString;
    address::AbstractString="",
    author::AbstractString="",
    edition::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    organization::AbstractString="",
    year::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
)
    Manual(id, title, address, author, edition, key, month, note, organization, year, other)
end

function Manual(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    author::AbstractString
    school::AbstractString
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    type::AbstractString

    # Other
    other::Dict{AbstractString,AbstractString}

    function MasterThesis(
        id::AbstractString,
        author::AbstractString,
        school::AbstractString,
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        type::AbstractString,
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, school, title,  year, address, key, month, note, type, other)
    end
end

function MasterThesis(
    id::AbstractString,
    author::AbstractString,
    school::AbstractString,
    title::AbstractString,
    year::AbstractString;
    address::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    type::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    MasterThesis(id, author, school, title,  year, address, key, month, note, type, other)
end

function MasterThesis(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Optional
    author::AbstractString
    howpublished::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    title::AbstractString
    year::AbstractString

    # Other
    other::Dict{AbstractString,AbstractString}
end

function Misc(
    id::AbstractString;
    author::AbstractString="",
    howpublished::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    title::AbstractString="",
    year::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    Misc(id, author, howpublished, key, month, note, title, year, other)
end

function Misc(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    author::AbstractString
    school::AbstractString
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    type::AbstractString

    # Other
    other::Dict{AbstractString,AbstractString}

    function PhDThesis(
        id::AbstractString,
        author::AbstractString,
        school::AbstractString,
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        type::AbstractString,
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, school, title,  year, address, key, month, note, type, other)        
    end
end

function PhDThesis(
    id::AbstractString,
    author::AbstractString,
    school::AbstractString,
    title::AbstractString,
    year::AbstractString;
    address::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    type::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    PhDThesis(id, author, school, title,  year, address, key, month, note, type, other)
end

function PhDThesis(id::AbstractString, d::Dict{AbstractString,AbstractString})
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
    id::AbstractString

    # Required
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    editor::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    number::AbstractString # shared with volume
    organization::AbstractString
    publisher::AbstractString
    series::AbstractString
    volume::AbstractString # shared with number

    # Other
    other::Dict{AbstractString,AbstractString}

    function Proceedings(    
        id::AbstractString,    
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        editor::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        number::AbstractString, # shared with volume
        organization::AbstractString,
        publisher::AbstractString,
        series::AbstractString,
        volume::AbstractString, # shared with number
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
        if title == ""
            push!(errors, "title")
        end
        if year == ""
            push!(errors, "year")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        return new(id, title, year, address, editor, key, month, note, number, organization, publisher, series, volume, other)
    end
end

function Proceedings(
    id::AbstractString,
        title::AbstractString,
        year::AbstractString;
        address::AbstractString="",
        editor::AbstractString="",
        key::AbstractString="",
        month::AbstractString="",
        note::AbstractString="",
        number::AbstractString="", # shared with volume
        organization::AbstractString="",
        publisher::AbstractString="",
        series::AbstractString="",
        volume::AbstractString="", # shared with number
        other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
        )
    Proceedings(id, title, year, address, editor, key, month, note, number, organization, publisher, series, volume, other)
end

function Proceedings(id::AbstractString, d::Dict{AbstractString,AbstractString})
    title = get_delete(d, "title")
    year = get_delete(d, "title")
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
    id::AbstractString

    # Required
    author::AbstractString
    institution::AbstractString
    title::AbstractString
    year::AbstractString

    # Optional
    address::AbstractString
    key::AbstractString
    month::AbstractString
    note::AbstractString
    number::AbstractString
    type::AbstractString

    # Other
    other::Dict{AbstractString,AbstractString}

    function TechReport(
        id::AbstractString,
        author::AbstractString,
        institution::AbstractString,
        title::AbstractString,
        year::AbstractString,
        address::AbstractString,
        key::AbstractString,
        month::AbstractString,
        note::AbstractString,
        number::AbstractString,
        type::AbstractString,
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
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
        return new(id, author, institution, title, year, address, key, month, note, number, type, other)
    end
end

function TechReport(
    id::AbstractString,
    author::AbstractString,
    institution::AbstractString,
    title::AbstractString,
    year::AbstractString;
    address::AbstractString="",
    key::AbstractString="",
    month::AbstractString="",
    note::AbstractString="",
    number::AbstractString="",
    type::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    TechReport(id, author, institution, title, year, address, key, month, note, number, type, other)
end

function TechReport(id::AbstractString, d::Dict{AbstractString,AbstractString})
    author = get_delete(d, "author")
    institution = get_delete(d, "institution")
    title = get_delete(d, "title")
    year = get_delete(d, "title")
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
    id::AbstractString

    # Required
    author::AbstractString
    note::AbstractString
    title::AbstractString

    # Optional
    key::AbstractString
    month::AbstractString
    year::AbstractString

    # Other
    other::Dict{AbstractString,AbstractString}

    function Unpublished(    
        id::AbstractString,    
        author::AbstractString,
        note::AbstractString,
        title::AbstractString,
        key::AbstractString,
        month::AbstractString,
        year::AbstractString,
        other::Dict{AbstractString,AbstractString}
        )
        errors = Vector{AbstractString}()
        if author == ""
            push!(errors, "author")
        end
        if note == ""
            push!(errors, "note")
        end
        if title == ""
            push!(errors, "title")
        end
        if length(errors) > 0
            error("Missing the " * foldl(((x, y) -> x * ", " * y), errors) * " field(s).")
        end
        return new(id, author, note, title, key, month, year, other)
    end
end

function Unpublished(
    id::AbstractString,
    author::AbstractString,
    note::AbstractString,
    title::AbstractString;
    key::AbstractString="",
    month::AbstractString="",
    year::AbstractString="",
    other::Dict{AbstractString,AbstractString}=Dict{AbstractString,AbstractString}()
    )
    Unpublished(id, author, note, title, key, month, year, other)
end

function Unpublished(id::AbstractString, d::Dict{AbstractString,AbstractString})
    author = get_delete(d, "author")
    note = get_delete(d, "note")
    title = get_delete(d, "title")
    key = get_delete(d, "key")
    month = get_delete(d, "month")
    year = get_delete(d, "year")
    Unpublished(id, author, note, title, key, month, year, d)
end

end # Module BibTeX