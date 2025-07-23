local progressBar = {}

export type ProgressBarStruct = {
	Background: Frame,
	Capacity: Frame,
}

export type ProgressBar = ProgressBarStruct & typeof(progressBar)

--[[
	newValue is number in range 0 - 1
]]
function progressBar.SetFilled(self: ProgressBar, newValue: number)
	self.Capacity.Size.X.Scale = newValue
end

function progressBar.new(Parent: GuiObject): ProgressBar
	local self: ProgressBarStruct = {
		Background  = Instance.new("Frame"),
		Capacity = Instance.new("Frame"),
	}

	self.Capacity.Parent = self.Background
	self.Capacity.Size = UDim2.fromScale(0, 1)

	self.Background.Parent = Parent

	setmetatable(self, {__index = progressBar})

	return self
end

return progressBar
