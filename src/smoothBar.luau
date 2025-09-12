local TweenService = game:GetService("TweenService")

local bar = require(script.Parent.bar)

--[=[
	Inherit from [Bar](./Bar)

	@class SmoothBar
	@client
]=]
local SmoothBar = setmetatable({}, {__index = bar})

export type SmoothBar = typeof(setmetatable({} :: {Speed: number} & bar.BarStruct, {__index = SmoothBar}))

--[=[
	@param self SmoothBar

	@method UpdateFill
	@within SmoothBar
]=]
function SmoothBar.UpdateFill(self: SmoothBar)
	local t = TweenService:Create(self.BarFill, TweenInfo.new(self.Speed), {Size = UDim2.new(1, 0, self.Fill.Value, 0)})
	t:Play()
end

--[=[
	Constructor

	@param b Bar
	@param speed number? -- by default is 0.
	@return SmoothBar
]=]
function SmoothBar.new(b: bar.Bar, speed: number?): SmoothBar
	local self = b
	self.Speed = speed or 0.2

	setmetatable(self, {__index = SmoothBar})

	return self
end

return SmoothBar
