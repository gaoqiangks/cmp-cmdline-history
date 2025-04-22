local source = {}

function source.new()
    return setmetatable({}, { __index = source })
end

function source:get_keyword_pattern()
    return '.*'
end

function source:complete(request, callback)
    local hist_type = request.option.history_type or vim.fn.getcmdtype()
    local seen_items = {}
    local items = {}
    local index = 1
    for i = 1, vim.fn.histnr(hist_type) do
        local item = vim.fn.histget(hist_type, -i)
        if #item > 0 and not seen_items[item] then
            seen_items[item] = true
            items[#items + 1] = { label = item, dup = 0, histnr = index }
            index = index + 1
        end
    end
    log("items = " .. vim.inspect(items))
    callback({ items = items })
end

return source
