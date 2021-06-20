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
function Name(str)
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
                islowercase(s[1]) && break
                middle *= " $s"
            end
            for s in reverse(aux[mark_in:mark_out])
                islowercase(s[1]) && break
                mark_out -= 1
                last = "$s " * last
            end
            foreach(s -> particle *= " $s", aux[mark_in:mark_out])
        end
    end

    # BibTeX form 2: von Last, First Second
    if length(subnames) == 2
        aux = split(subnames[1], r"[\n\r ]+") # von Last
        mark_out = length(aux) - 1
        last = string(aux[end])
        for s in reverse(aux[1:mark_out])
            islowercase(s[1]) && break
            mark_out -= 1
            last = "$s " * last
        end
        foreach(s -> particle *= " $s", aux[1:mark_out])
        aux = split(subnames[2], r"[\n\r ]+")
        first = aux[1]
        length(aux) > 1 && foreach(s -> middle *= " $s", aux[2:end])
    end
    if length(subnames) == 3
        aux = split(subnames[1], r"[\n\r ]+") # von Last
        mark_out = length(aux) - 1
        last = aux[end]
        for s in reverse(aux[1:mark_out])
            islowercase(s[1]) && break
            mark_out -= 1
            last = "$s " * last
        end
        foreach(s -> particle *= " $s", aux[1:mark_out])
        junior = subnames[2]
        aux =split(subnames[3], r"[\n\r ]+")
        first = aux[1]
        length(aux) > 1 && foreach(s -> middle *= " $s", aux[2:end])
    end

    return Name(particle, last, junior, first, middle)
end

"""
    names(str::String)
Decompose into parts a list of names in BibTeX compatible format. That is names sparated by `and`.
"""
function names(str)
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
function Access(fields)
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
function Date(fields)
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
function Eprint(fields)
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
function In(fields)
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
function Entry(id, fields)
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

"""
    Base.isless(a::BibInternal.Date,b::BibInternal.Date)::Bool

Function to check for `a < b` on `BibInternal.Date` data types.

This function will throw an `ArgumentError` if the `year` can not parsed into
`Int`. If it is not possible to parse `month` or `day` to `Int` those entries
will be silently ignored for comparison.
This function will not check if the date fields are given in a correct format
all fields are parsed into and compared as `Int` (no checking if date format
is correct or valid!).
!!! danger "Note:"
    The silent ignoring of not parseable `month` or `day` fields will lead to
    misbehaviour if using comparators like `==` or `!==`!
"""
function Base.isless(a::BibInternal.Date,b::BibInternal.Date)
    numbers = "0123456789" # TODO: use a regexp

    empty_year = isempty(a.year) || isempty(b.year)
    year_format = !issubset(a.year,numbers) || !issubset(b.year,numbers)
    not_valid_year = empty_year || year_format
    not_valid_year && throw(ArgumentError("Unsupported year format!"))

    a_y = parse(Int,a.year)
    b_y = parse(Int,b.year)

    empty_month = isempty(a.month) || isempty(b.month)
    month_format = !issubset(a.month,numbers) || !issubset(b.month,numbers)
    not_valid_month = empty_month || month_format

    if !not_valid_month
        a_m = parse(Int,a.month)
        b_m = parse(Int,b.month)
    end

    empty_day = isempty(a.day) || isempty(b.day)
    day_format = !issubset(a.day,numbers) || !issubset(b.day,numbers)
    not_valid_day = empty_day || day_format

    if !not_valid_day
        a_d = parse(Int,a.day)
        b_d = parse(Int,b.day)
    end

    if a_y == b_y
        if not_valid_month
            return false
        else
            return a_m == b_m ? !not_valid_day && a_d < b_d : a_m < b_m
        end
    end

    return a_y < b_y
end

"""
    Base.isless(a::BibInternal.Name,b::BibInternal.Name)::Bool

Function to check for `a < b` on `BibInternal.Name` data types.

This function will check the fields `last`, `first` and `middle` in this order
of priority. The other fields are ignored for now.
The field comparsion is done by string comparsion no advanced alphabetizing
rules are used for now.
!!! danger "Note:"
    The silent ignoring of the other fields might lead to misbehaviour if using
    comparators like `==` or `!==`!
"""
function Base.isless(a::BibInternal.Name,b::BibInternal.Name)
    if a.last == b.last
        if a.first == b.first
            return a.middle == b.middle ? false : a.middle < b.middle
        else
            return a.first < b.first
        end
    end

    return a.last < b.last
end
