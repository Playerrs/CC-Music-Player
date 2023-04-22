---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by josue.
--- DateTime: 14/04/2023 08:51
---

--local chatHandler = require("../Dependencies/chatHandler")
local json = require("../Dependencies/Json")

local chat = {members = {{userName = "Admin",
                          computerID = -1,
                          modemPort = 0}},
              messages = {},
              name = "New Chat"
}

function chat:new(name, id, members, messages)
    local instance = {
        name = "",
        id = 0,
        members = {},
        messages = {}

    }

    if name then
        instance.name = name
    end
    if id then
        instance.id = id
    end
    if members then
        instance.members = members
    end
    if messages then
        instance.messages = messages
    end

    setmetatable(instance, {__index = self})

    return instance
end

function chat:addMember(DeviceObj)
    print(DeviceObj.userName, DeviceObj.computerID, DeviceObj.modemPort)
    table.insert(self.members, DeviceObj)
end

function chat:addMessage(MessageObj)
    print(MessageObj.content, MessageObj.device:getUser())
    table.insert(self.messages, MessageObj)
end

function chat.saveJSON(chatName, chatNum, _dataDir)
    local _f
    local data = {}
    chatNum = chatNum * 3
    if fs.exists(_dataDir.."servers.json") then
        _f = fs.open(_dataDir.."servers.json", "r")
        data = json.decode(_f.readAll())
        data[chatName] = chatNum
        _f.close()
    else
        data[chatName] = chatNum
    end

    _f = fs.open(_dataDir.."servers.json", "w")
    _f.write(json.encode(data))
    _f.close()
    return true
end

function chat.loadJSON(_dataDir)
    local data = {}
    if fs.exists(_dataDir.."servers.json") then
        local _f = fs.open(_dataDir.."servers.json", "r")
        data = json.decode(_f.readAll())
        _f.close()
        for k,v in pairs(data) do
            data[k] = tonumber(v)/3
        end
    else
        return false
    end

    return data
end

return chat