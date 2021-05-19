_G = _G or {}

function _G.Set(list)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = l
    end
    return set
end

function _G.SetBool(list)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = true
    end
    return set
end