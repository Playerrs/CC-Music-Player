---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by josue.
--- DateTime: 14/04/2023 08:51
---

--local chatHandler = require("../Dependencies/chatHandler")

local chat = {members = {{userName = "Admin",
                          computerID = -1,
                          modemPort = 0}},
              messages = {}
}

function chat:new(members, id, messages)
    local instance = {
        members = members,
        id = id,
        messages = messages

    }
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


return chat