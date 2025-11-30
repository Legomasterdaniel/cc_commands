local function split(string, seperator)
    local table = {}
    seperator = seperator or " "
    for part in string.gmatch(str, "([^"..seperator.."]+)")
        table.insert(table, part)
    end
    return table
end

while true do
    term.clear()
    term.setCursorPos(1, 1)
    write("Options:\n - help | Lists out all available commands.\n\n")
    write("Input a command: ")
    local input = read()
    
    if fs.exists("cc_commands/commands/"..split(input, " ")[1]) then
        pcall(function()
            local command = require("cc_commands/commands/"..split(input, " ")[1])
            local text = table.concat(split(input, " "), " ", 2)
            command.run()
        end)
    end
    print("\nPress any key to continue..")
    while true do
        local event = os.pullEvent()
        if event == "key" then break end
    end
end