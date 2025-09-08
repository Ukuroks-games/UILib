local TweenService = game:GetService("TweenService")

local bar = require(script.Parent.bar)

local SmoothBar = setmetatable({}, {__index = bar})

export type SmoothBar = typeof(setmetatable({} :: {Speed: number} & bar.BarStruct, {__index = SmoothBar}))

function SmoothBar.UpdateFill(self: SmoothBar)
	local t = TweenService:Create(self.BarFill, TweenInfo.new(self.Speed), {Size = UDim2.new(1, 0, self.Fill.Value, 0)})
	t:Play()
end

function SmoothBar.new(bar: bar.Bar, speed: number?): SmoothBar
	local self = bar
	self.Speed = speed or 0.2

	setmetatable(self, {__index = SmoothBar})

	return self
end

return SmoothBar
