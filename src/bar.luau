--[=[
	@class Bar
	@client
]=]
local Bar = {}

export type BarStruct = {
	Background: GuiObject,
	BarFill: GuiObject,
	Fill: NumberValue,
}

export type Bar = typeof(setmetatable({} :: BarStruct, { __index = Bar }))

function Bar.Destroy(self: Bar)
	self.Fill:Destroy()
	self.BarFill:Destroy()
end

--[=[
	@param self Bar

	@method UpdateFill
	@within Bar
]=]
function Bar.UpdateFill(self: Bar)
	self.BarFill.Size = UDim2.new(1, 0, self.Fill.Value, 0)
end

--[=[
	Constructor
]=]
function Bar.new(
	background: GuiObject,
	Fill: number | NumberValue,
	BarFill: GuiObject?
): Bar
	local function InitFill(): NumberValue
		local r

		if typeof(Fill) == "NumberValue" then
			r = Fill
		else 
			r = Instance.new("NumberValue")
			r.Value = Fill
		end

		return r
	end

	local self: BarStruct = {
		Background = background,
		Fill = InitFill(),
		BarFill = BarFill or Instance.new("Frame"),
	}

	self.BarFill.Parent = self.Background
	self.BarFill.Position = UDim2.new()
	

	setmetatable(self, { __index = Bar })

	self:UpdateFill()

	self.Fill.Changed:Connect(function(_: number) 
		self:UpdateFill()
	end)

	return self
end

return Bar
