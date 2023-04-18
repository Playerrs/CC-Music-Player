---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by josue.
--- DateTime: 12/04/2023 20:46
---
local args = {...}

if not fs.exists("Client/Cache") then
    term.clear()
    term.setCursorPos(1,1)
    print("What's your name?")
    local t = fs.open("Client/Cache", "w")
    t.writeLine(read())
    t.writeLine(os.getComputerID())
    math.randomseed(os.clock()*10000000)
    t.writeLine(math.random(1050, 65200))
    t.close()
end

--- Imports

os.loadAPI("Dependencies/touchpoint")
local modemAPI = require("../Dependencies/ModemAPI")

--- Classes

local Chat = require("../Classes/Chat")
local Message = require("../Classes/Message")
local Device = require("../Classes/Device")

--- Load

local f = fs.open("Client/Cache", "r")
local userName = f.readLine()
local computerID = tonumber(f.readLine())
local modemPort = tonumber(f.readLine())
f.close()

local thisDevice = Device:new(userName, computerID, modemPort)
local screen = touchpoint.new()
local modem = modemAPI.startModem(modemPort)

--- Functions
local function enterInAChat()
    term.clear()
    term.setCursorPos(1,1)
    print("Digite o id do chat para entrar")
    local r = read()
    modem.transmit(20358+5, thisDevice.modemPort, {"enter_chat", {id = r, device = thisDevice}})

    local channel, receivedMessage, rChannel = modemAPI.receive()

end



local chatTest = Chat:new({ thisDevice }, 1, {})

while true do
    term.clear()
    term.setCursorPos(1,1)
    --local r = read()
    --local messageTest = Message:new(r, thisDevice)
    --chatTest:addMessage(messageTest)
    --modem.transmit(20358, 20358+5, chatTest)
    enterInAChat()
    sleep(2)

end