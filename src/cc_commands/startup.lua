local function StartCommandExecutor(path)
    coroutine.resume(coroutine.create(function()
        os.run({}, path)
    end))
end
local function StartCommandExecutors()
    print("Starting Command Executors..\n")
    local foundExecutors = fs.find("cc_commands/command_executors/*.lua")
    for _, executorPath in pairs(foundExecutors) do
        if not executorPath == "cc_commands/command_executors/terminal.lua" then
            StartCommandExecutor(executorPath)
        end
        print("Started ".. executorPath .."\n")
    end
    for _, executorPath in pairs(foundExecutors) do
        if executorPath == "cc_commands/command_executors/terminal.lua" then
            os.run({}, executorPath)
        end
        print("Started ".. executorPath .. "\n")
    end
    print("Started Command Executors!\n")
    
end
StartCommandExecutors()