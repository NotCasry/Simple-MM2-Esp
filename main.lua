--# UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MM2", "Midnight")

local Visuals_Tab = Window:NewTab("Visuals")
local ESP_Section = Visuals_Tab:NewSection("ESP")
--# Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
--# Player
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
--# Global Variables
_G.EspEnabled = false
--# Variables
local MurderWeapon = "Knife"
local SherrifWeapon = "Gun"

local innocent_c3 = Color3.fromRGB(0, 255, 0)
local murderer_c3 = Color3.fromRGB(255, 0, 0)
local sherrif_c3 = Color3.fromRGB(0, 0, 255)

local Lobby = workspace:WaitForChild("Lobby")
--# Functions
function create_box(parent)
    local Box = Instance.new("Part")
    Box.Name = "BoxHead"
    Box.Size = Vector3.new(1.2, 1.25, 1.2)
    Box.Parent = parent
    Box.Material = Enum.Material.SmoothPlastic
    Box.Color = Color3.fromRGB(0, 255, 0)
    Box.Anchored = true
    Box.CanCollide = false
    Box.CanQuery = false
    Box.CanTouch = false
    Box.Transparency = 0.5
    Box.Reflectance = 0.5

    local highlight = Instance.new("Highlight")
    highlight.Name = "HL"
    highlight.Adornee = Box
    highlight.Parent = Box
    highlight.OutlineColor = innocent_c3
end

--# Main Script

-- Setting Character all the time, so it doesn't equal to nil
spawn(function() -- Spawn function allowing other things below it to run!
    while task.wait() do -- While do Loop
        Character = Player.Character or Player.CharacterAdded:Wait() -- Setting the Character
    end
end)

--# Esp Handler
spawn(function()
    while task.wait() do
        for _, p in pairs(Players:GetChildren()) do
            if workspace:FindFirstChild(p.Name) ~= nil and _G.EspEnabled == true and p.Name ~= Player.Name then
                local char = workspace:FindFirstChild(p.Name)
    
                if not char:FindFirstChild("BoxHead") then
                    
                    create_box(char)
    
                elseif char:FindFirstChild("BoxHead") then
    
                    spawn(function()
                        if char:FindFirstChild("Head") then
                            char:FindFirstChild("BoxHead").CFrame = char.Head.CFrame
                        end
                    end)
    
                    if workspace[p.Name]:FindFirstChild("Knife") then
                        char:FindFirstChild("BoxHead"):FindFirstChild("HL").OutlineColor = murderer_c3
                    elseif p.Backpack:FindFirstChild("Knife") then
                        char:FindFirstChild("BoxHead"):FindFirstChild("HL").OutlineColor = murderer_c3
                    elseif p.Backpack:FindFirstChild("Gun") then
                        char:FindFirstChild("BoxHead"):FindFirstChild("HL").OutlineColor = sherrif_c3
                    elseif workspace[p.Name]:FindFirstChild("Gun") then
                        char:FindFirstChild("BoxHead"):FindFirstChild("HL").OutlineColor = sherrif_c3
                    elseif not p.Backpack:FindFirstChild("Knife") and not workspace[p.Name]:FindFirstChild("Knife") then
                        char:FindFirstChild("BoxHead"):FindFirstChild("HL").OutlineColor = innocent_c3
                    elseif not p.Backpack:FindFirstChild("Gun") and not workspace[p.Name]:FindFirstChild("Gun") then
                        char:FindFirstChild("BoxHead"):FindFirstChild("HL").OutlineColor = innocent_c3
                    end
    
                end
    
            elseif workspace:FindFirstChild(p.Name) ~= nil and _G.EspEnabled == false and p.Name ~= Player.Name then
                local char = workspace:FindFirstChild(p.Name)
    
                if char:FindFirstChild("BoxHead") then
                    char:FindFirstChild("BoxHead"):Destroy()
                end
            end
        end
    end
end)

ESP_Section:NewToggle("Esp", "", function(state)
    if state then
        print("Toggle On")
        _G.EspEnabled = true
    else
        _G.EspEnabled = false
        print("Toggle Off")
    end
end)
