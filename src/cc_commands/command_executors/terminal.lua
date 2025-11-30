local function split(str, seperator)
    local t = {}
    seperator = seperator or " "
    for part in string.gmatch(str, "([^"..seperator.."]+)") do
        table.insert(t, part)
    end
    return t
end

while true do
    term.clear()
    term.setCursorPos(1, 1)
    write("Options:\n - help | Lists out all available commands.\n\n")
    write("Input a command: ")
    local input = read()
    
    if fs.exists("cc_commands/commands/"..split(input, " ")[1]) then
        local success, error = pcall(function()
            local command = require("cc_commands/commands/"..split(input, " ")[1]..".lua")
            if not command then
                write("ERROR: Could not find command ".. split(input, " ")[1] .."!")
                return
            end
            local text = table.concat(split(input, " "), " ", 2)
            command.run()
        end)
        if not success then
            write("ERROR: ".. error)
        end
    else
        write("ERROR: Could not find command ".. split(input, " ")[1] .."!")
    end
    write("\nPress any key to continue..")
    while true do
        local event = os.pullEvent()
        if event == "key" then break end
    end
end