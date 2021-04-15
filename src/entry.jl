"""
    struct Name
        particle::String
        last::String
        junior::String
        first::String
        middle::String
    end
Store a name with no ambiguities. For additional parts to define a name, please fill an issue or make a pull request.
"""
# Name type
struct Name
    particle::String
    last::String
    junior::String
    first::String
    middle::String
end
Names = Vector{Name}

"""
    Name(str::String)
Decompose without ambiguities a name as `particle` (optional) `last`, `junior` (optional), `first` `middle` (optional) based on BibTeX possible input. As for BibTeX, the decomposition of a name in the form of `first` `last` is also possible, but ambiguities can occur.
"""
function Name(str::String)
    subnames = map(strip, split(str, r"[\n\r\t ]*,[\n\r\t ]*"; keepempty=false))

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
    return Name(particle, last, junior, first, middle)
end

"""
    names(str::String)
Decompose into parts a list of names in BibTeX compatible format. That is names sparated by `and`.
"""
function names(str::String)
    aux = split(str, r"[\n\r ]and[\n\r ]")
    return map(x -> Name(String(x)), aux)
end

"""
    struct Access
        doi::String
        howpublished::String
        url::String
    end
Store the online access of an entry as a String. Handles the fields `doi` and `url` and the `arXiV` entries. For additional fields or entries, please fill an issue or make a pull request.
"""
struct Access
    doi::String
    howpublished::String
    url::String
end

"""
    Access(fields::Fields)
Construct the online access information based on the entry fields.
"""
function Access(fields::Fields)
    doi = get_delete!(fields, "doi")
    howpublished = get_delete!(fields, "howpublished")
    url = fields["_type"] == "eprint" ? arxive_url(fields) : get_delete!(fields, "url")
    Access(doi, howpublished, url)
end

"""
    struct Date
        day::String
        month::String
        year::String
    end
Store the date information as `day`, `month`, and `year`.
"""
struct Date
    day::String
    month::String
    year::String
end

"""
    Date(fields::Fields)
Construct the date information based on the entry fields.
"""
function Date(fields::Fields)
    day = get_delete!(fields, "day")
    month = get_delete!(fields, "month")
    year = get_delete!(fields, "year")
    Date(day, month, year)
end

"""
    struct Eprint
        archive_prefix::String
        eprint::String
        primary_class::String
    end
Store the information related to arXiv eprint format.
"""
struct Eprint
    archive_prefix::String
    eprint::String
    primary_class::String
end

"""
    Eprint(fields::Fields)
Construct the eprint arXiv information based on the entry fields. Handle old and current arXiv format.
"""
function Eprint(fields::Fields)
    archive_prefix = get_delete!(fields, "archivePrefix")
    eprint = get_delete!(fields, "eprint")
    primary_class = get_delete!(fields, "primaryClass")
    Eprint(archive_prefix, eprint, primary_class)
end

"""
    struct In
        address::String
        chapter::String
        edition::String
        institution::String
        journal::String
        number::String
        organization::String
        pages::String
        publisher::String
        school::String
        series::String
        volume::String
    end
Store all the information related to how an entry was published.
"""
struct In
    address::String
    chapter::String
    edition::String
    institution::String
    journal::String
    number::String
    organization::String
    pages::String
    publisher::String
    school::String
    series::String
    volume::String
end

"""
    In(fields::Fields)
Construct the information of how an entry was published based on its fields
"""
function In(fields::Fields)
    address = get_delete!(fields, "address")
    chapter = get_delete!(fields, "chapter")
    edition = get_delete!(fields, "edition")
    institution = get_delete!(fields, "institution")
    journal = get_delete!(fields, "journal")
    number = get_delete!(fields, "number")
    organization = get_delete!(fields, "organization")
    pages = get_delete!(fields, "pages")
    publisher = get_delete!(fields, "publisher")
    school = get_delete!(fields, "school")
    series = get_delete!(fields, "series")
    volume = get_delete!(fields, "volume")
    In(address, chapter, edition, institution, journal, number, organization, pages, publisher, school, series, volume)
end

"""
    struct Entry <: AbstractEntry
        access::Access
        authors::Names
        booktitle::String
        date::Date
        editors::Names
        eprint::Eprint
        id::String
        in::In
        fields::Dict{String,String}
        title::String
        type::String
    end
Generic Entry type. If some construction rules are required, it should be done beforehand. Check `bibtex.jl` as the example of rules implementation for BibTeX format.
"""
struct Entry <: AbstractEntry
    access::Access
    authors::Names
    booktitle::String
    date::Date
    editors::Names
    eprint::Eprint
    id::String
    in::In
    fields::Dict{String,String}
    title::String
    type::String
end

"""
    Entry(id::String, fields::Fields)
Construct an entry with a unique id and a list of `Fields`.
"""
function Entry(id::String, fields::Fields)
    # foreach((name, field) -> fields[name] = erase_spaces(field), fields)
    access = Access(fields)
    authors = names(get_delete!(fields, "author"))
    booktitle = get_delete!(fields, "booktitle")
    date = Date(fields)
    editors = names(get_delete!(fields, "editor"))
    eprint = Eprint(fields)
    in_ = In(fields)
    title = get_delete!(fields, "title")
    type = get_delete!(fields, "_type")
    return Entry(access, authors, booktitle, date, editors, eprint, id, in_, fields, title, type)
end
