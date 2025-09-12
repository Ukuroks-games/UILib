-- services

local UserInputService = game:GetService("UserInputService")

local skin = require(script.Parent.skin)

--[[
    Window class
]]
local window = {}

export type WindowStruct = {
	MainFrame: Frame,
}

export type Window = typeof(setmetatable(
	{} :: WindowStruct,
	{ __index = window }
))

function window.SetSkin(self: WindowStruct, WindowSkin: skin.WindowSkin)
	self.MainFrame.BackgroundColor3 = WindowSkin.WorkColor
end

function window.new(WindowSkin: skin.WindowSkin, mainFrame: Frame?): Window
	local self: WindowStruct = {
		MainFrame = mainFrame or Instance.new("Frame"),
	}

	window.SetSkin(self, WindowSkin)

	setmetatable(self, { __index = window })

	return self
end

return window
