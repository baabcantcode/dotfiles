--- borrowing from startup.nvim 
local functions = {}

local quotes = require("startup.quotes")

---Returns a random programming quote
---@return table: Lines of text for the quote
function functions.quote()
    math.randomseed(os.clock())
    local index = math.random() * #quotes
    return quotes[math.floor(index) + 1]
end

---Returns the current date and time
---@return table: Table with a string for the date and one for the time
function functions.date_time()
    local clock = " " .. os.date("%H:%M")
    local date = " " .. os.date("%d-%m-%y")
    return { clock, date }
end

return functions
