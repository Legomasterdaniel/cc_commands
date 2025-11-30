local json = textutils or require("json")

local githubRepository = "https://api.github.com/repos/Legomasterdaniel/cc_commands/contents"



local function CreateDirectory(path)
    fs.makeDir(path)
    print("Created Directory ".. path)
end
local function CreateFile(path, fileData)
    local file = fs.open(path, "w")
    file.write(fileData)
    file.close()
    print("Created File ".. path)
end

local function RecursiveTreeExploration(tree)
    if tree.type == "say" or tree.type == "dir" then
        local request = http.get(tree.url)
        local branches = request.readAll()
        branches = json.unserialiseJSON(branches)
        request.close()
        for _, branch in pairs(branches) do
            RecursiveTreeExploration(branch)
        end
    elseif tree.type = "file" then
        local request = http.get(tree.download_url)
        local fileData = request.readAll()
        request.close()

        CreateFile(string.sub(tree.path, 4), fileData)
    end
end
local function CloneRepository()
    local request = http.get(string.format(
        githubData.UrlBase, githubData.Owner, githubData.Repository, githubFilePath))
    local data = request.readAll()
    data = json.unserialiseJSON(data)
    request.close()

    for _, branch in pairs(data) do
        if branch.name ~= "src" then continue end
        RecursiveTreeExploration(branch)
    end
end

local function IsInstalled()
    if fs.exists("/cc_commands") then return true end
    return false
end

local function CreateFiles()
    -- Make necessary directories.
    CreateDirectory("/cc_commands")
    CreateDirectory("/cc_commands/commands")

    -- Install the lua files from pastebin.
    InsertFromRepository("/cc_commands/startup.lua", "src/cc_commands/startup.lua")
    InsertFromRepository("/cc_commands/commands/test.lua", "src/cc_commands/commands/test.lua")

    print("\nDone installing!\n\n")

    os.run({}, "/cc_commands/startup.lua")
end

if IsInstalled() then
    os.run({}, "/cc_commands/startup.lua") -- Run command system
else
    CloneRepository() -- Set up command system
    os.run({}, "/cc_commands/startup.lua") -- Run command system
end