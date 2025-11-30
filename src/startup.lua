local githubData = {
    UrlBase = "https://raw.githubusercontent.com/repos/%s/%s/refs/heads/main/%s",
    Owner = "Legomasterdaniel",
    Repository = "cc_commands"
}

local function CreateDirectory(path)
    fs.makeDir(path)
    print("Created Directory ".. path)
end
local function InsertFromRepository(path, githubFilePath)
    local request = http.get(string.format(
        githubData.UrlBase, githubData.Owner, githubData.Repository, filePath))
    local fileData = request.readAll()
    request.close()
    
    local file = fs.open(path, "w")
    file.write(fileData)
    file.close()
    print("Created File ".. path)
end

local function IsInstalled()
    if fs.exists("cc_commands") then return true end
    return false
end

local function CreateFiles()
    -- Make necessary directories.
    CreateDirectory("cc_commands")
    CreateDirectory("cc_commands/commands")

    -- Install the lua files from pastebin.
    InsertFromRepository("src/cc_commands/startup.lua")
    InsertFromRepository("src/cc_commands/commands/test.lua")
end

if IsInstalled() then
    os.run(shell.resolve("cc_commands/startup.lua")) -- Run normal command system
else
    CreateFiles() -- Set up command system
end