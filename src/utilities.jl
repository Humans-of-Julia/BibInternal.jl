"""
    space(field::Symbol)
Return the amount of spaces needed to export entries, for instance to BibTeX format.
"""
function space(field::Symbol)
    return maxfieldlength - length(string(field))
end

"""
    get_delete!(fields::Fields, key::String)
Get a the value of a field and delete it afterward.
"""
function get_delete!(fields::Fields, key::String)
    ans = get(fields, key, "")
    delete!(fields, key)
    return ans
end

"""
    arxive_url(fields::Fields)
Make an arxiv url from an eprint entry. Work with both old and current arxiv BibTeX format.
"""
function arxive_url(fields::Fields)
    str = "https://arxiv.org/abs/"
    if get(fields, "archivePrefix", "") == ""
        aux = split(fields["eprint"], ":")
        str *= aux[2]
    else
        str *= fields["eprint"]
    end
    return str
end