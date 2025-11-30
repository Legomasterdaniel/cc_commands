local githubData = {
    UrlBase = "https://raw.githubusercontent.com/repos/%s/%s/refs/heads/main/%s",
    Owner = "Legomasterdaniel",
    Repository = "cc_commands"
}

local function CreateDirectory(path)
    fs.makeDir(path)
end
local function InsertFromRepository(path, githubFilePath)
    local request = http.get(string.format(
        githubData.UrlBase, githubData.Owner, githubData.Repository, filePath))
    local fileData = request.readAll()
    request.close()
    
    local file = fs.open(path, "w")
    file.write(fileData)
    file.close()
end

local function IsInstalled()
    if fs.exists("rom/cc_commands") then return true end
    return false
end

local function CreateFiles()
    if IsInstalled() then return end -- if already set up, stop process.

    -- Make necessary directories.
    CreateDirectory("rom/cc_commands")
    CreateDirectory("rom/cc_commands/commands")

    -- Install the lua files from pastebin.
    pastebin get 
end

if IsInstalled() then
    os.run(shell.resolve("rom/cc_commands/startup.lua")) -- Run normal command
else

end