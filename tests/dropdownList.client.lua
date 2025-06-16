local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local DropdownList = require(ReplicatedStorage.shared.DropDownList)


local gui = StarterGui.ScreenGui

local OpenButton = Instance.new("TextButton")
OpenButton.Parent = gui
OpenButton.Text = "Open dropdown list"

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "Close"

local List = DropDownList.new(
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


