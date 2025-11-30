local json = textutils or require("json")

local githubRepository = "https://api.github.com/repos/Legomasterdaniel/cc_commands/contents"



local function CreateDirectory(path)
    fs.makeDir(path)
    print("Created Directory ".. path .."\n")
end
local function CreateFile(path, fileData)
    local file = fs.open(path, "w")
    file.write(fileData)
    file.close()
    print("Created File ".. path .."\n")
end

local function RecursiveTreeExploration(tree)
    if tree.type == "say" or tree.type == "dir" then
        local request = http.get(tree.url)
        local branches = request.readAll()
        branches = json.unserialiseJSON(branches)
        request.close()
        CreateDirectory(string.sub(tree.path, 4))
        for _, branch in pairs(branches) do
            RecursiveTreeExploration(branch)
        end
    elseif tree.type == "file" then
        local request = http.get(tree.download_url)
        local fileData = request.readAll()
        request.close()
        if tree.path == "src/startup.lua" then goto continue end
        CreateFile(string.sub(tree.path, 4), fileData)
        ::continue::
    end
end
local function CloneRepository()
    local request = http.get(githubRepository)
    local data = request.readAll()
    data = json.unserialiseJSON(data)
    request.close()

    for _, branch in pairs(data) do
        if branch.name ~= "src" then goto continue end
        RecursiveTreeExploration(branch)
        ::continue::
    end
end

local function IsInstalled()
    if fs.exists("/cc_commands") then return true end
    return false
end

if IsInstalled() then
    os.run({}, "/cc_commands/startup.lua") -- Run command system
else
    CloneRepository() -- Set up command system
    os.run({}, "/cc_commands/startup.lua") -- Run command system
end