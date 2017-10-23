
function table_read_only(tab)
    local temp= {}
    local mt = {
    __index = function(t,k) 

        if type(tab[k]) == "table" then
            tab[k] = table_read_only(tab[k])
        end 
        return tab[k]
     end,
    __newindex = function(t, k, v)

        error(string.format( "attempt to update type '%s' is read-only !", k))
    end
    }
 setmetatable(temp, mt) 
 return temp
end
-- setfenv(table_read_only , _G)