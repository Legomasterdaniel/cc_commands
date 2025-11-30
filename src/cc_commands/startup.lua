local function StartCommandExecutor(path)
    coroutine.resume(coroutine.create(function()
        os.run({}, path)
    end))
end
local function StartCommandExecutors()
    write("Starting Command Executors..")
    local foundExecutors = fs.find("cc_commands/command_executors/*.lua")
    for _, executorPath in pairs(foundExecutors) do
        if not executorPath == "cc_commands/command_executors/terminal.lua" then
            StartCommandExecutor(executorPath)
        end
        write("Started ".. executorPath .."")
    end
    for _, executorPath in pairs(foundExecutors) do
        if executorPath == "cc_commands/command_executors/terminal.lua" then
            os.run({}, executorPath)
        end
        write("Started ".. executorPath .. "")
    end
    write("Started Command Executors!")
    
end
StartCommandExecutors()