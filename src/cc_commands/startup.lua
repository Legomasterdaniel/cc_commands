local function StartCommandExecutor(path)
    coroutine.create(function()
        os.run({}, path)
    end)()
end
local function StartCommandExecutors()
    print("Starting Command Executors..")
    local foundExecutors = fs.find("cc_commands/command_executors/*.lua")
    for _, executorPath in pairs(foundExecutors) do
        StartCommandExecutor(executorPath)
        print("Started ".. executorPath)
    end
    print("Started Command Executors!")
end