function space(field::Symbol)
    return maxfieldlength - length(string(field))
end

function get_delete!(fields::Fields, key::String)
    ans = get(fields, key, "")
    delete!(fields, key)
    return ans
end

# makes arxiv url from eprint entry
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