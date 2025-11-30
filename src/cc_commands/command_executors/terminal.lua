sleep(1)
while true do
    term.clear()
    term.setCursorPos(1, 1)
    write("Options:\n - help | Lists out all available commands.")
    write("Input a command: ")
    local input = read()
    
    if fs.exists("cc_commands/commands/"..input) then
        pcall(function()
            os.run({}, "cc_commands/commands/"..input)
        end)
    end
    print("\nPress any key to continue..")
    while true do
        local event = os.pullEvent()
        if event == "key" then break end
    end
end