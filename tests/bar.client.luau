local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local bar = require(ReplicatedStorage.Packages.UILib.bar)
local smoothBar = require(ReplicatedStorage.Packages.UILib.smoothBar)


local background = Players.LocalPlayer.PlayerGui:WaitForChild("StarterScreen"):WaitForChild("BarBackground")


local function GetRand(): number
	return math.random(0, 100) / 100
end

local b = smoothBar.new(bar.new(background, GetRand()), 0.9)

b.BarFill.BackgroundColor3 = Color3.new()

while wait(1) do
	b.Fill.Value = GetRand()
end
