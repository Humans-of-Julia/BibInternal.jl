"""
    space(field::Symbol)
Return the amount of spaces needed to export entries, for instance to BibTeX format.
"""
space(field) = maxfieldlength - length(string(field))

"""
    get_delete!(fields::Fields, key::String)
Get the value of a field and delete it afterward.
"""
function get_delete!(fields, key)
    ans = get(fields, key, "")
    delete!(fields, key)
    return ans
end

"""
    arxive_url(fields::Fields)
Make an arxiv url from an eprint entry. Work with both old and current arxiv BibTeX format.
"""
function arxive_url(fields)
    str = "https://arxiv.org/abs/"
    if get(fields, "archiveprefix", "") == ""
        aux = split(fields["eprint"], ":")
        str *= aux[2]
    else
        str *= fields["eprint"]
    end
    return str
end

"""
    erase_spaces(str::String)
Erase extra spaces, i.e. `r"[\n\r ]+"`, from `str` and return a new string.
"""
erase_spaces(str) = replace(str, r"[\n\r ]+" => " ")
