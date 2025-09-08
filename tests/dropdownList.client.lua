local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


local DropdownList = require(ReplicatedStorage.Packages.UILib.DropDownList)


local gui = Players.LocalPlayer.PlayerGui:WaitForChild("StarterScreen")

local OpenButton = Instance.new("TextButton")
OpenButton.Parent = gui
OpenButton.Text = "Open dropdown list"

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "Close"

local List = DropdownList.new(
	OpenButton, 
	{
		Instance.new("TextLabel"),
		Instance.new("TextLabel"),
		Instance.new("TextLabel"),
		CloseButton
	},
	UDim.new(0.5, 0)
)

CloseButton.MouseButton1Click:Connect(function()
	List:Close()
end)


