local TweenService = game:GetService("TweenService")

--[[
	Класс выпадающего списка
]]
local dropDownList = {}

dropDownList.State = {
	Opened = true,
	Close = false
}

export type DropDownList<Index> = {
	OpenButton: GuiButton,

	Buttons: { [Index]: Frame },

	ListBackground: Frame,

	OpenSize: UDim,

	OpenAnimationTime: number,

	State: boolean,

	-- functions

	--[[
		Открыть список
	]]
	Open: (self: DropDownList<Index>) -> Tween,

	--[[
		Закрыть список
	]]
	Close: (self: DropDownList<Index>) -> Tween,
}

function dropDownList.Destroy<Index>(self: DropDownList<Index>)
	

	table.clear(self)
end

function dropDownList.Open<Index>(self: DropDownList<Index>): Tween
	local t = TweenService:Create(
		self.ListBackground,
		TweenInfo.new(self.OpenAnimationTime),
		{
			["Size"] = UDim2.new(self.ListBackground.Size.X, self.OpenSize)
		}
	)

	self.State = dropDownList.State.Opened

	t:Play()

	return t
end

function dropDownList.Close<Index>(self: DropDownList<Index>): Tween
	local t = TweenService:Create(
		self.ListBackground,
		TweenInfo.new(self.OpenAnimationTime),
		{
			["Size"] = UDim2.new(self.ListBackground.Size.X, UDim.new(0, 0))
		}
	)

	self.State = dropDownList.State.Close

	t:Play()

	return t
end

--[[

]]
function dropDownList.new<Index>(OpenButton: GuiButton, points: { [Index]: Frame }, OpenSize: UDim, OpenAnimationTime: number, ListBackground: Frame?): DropDownList<Index>

    local self: DropDownList<Index> = {
		OpenButton = OpenButton,
		Buttons = {},
		OpenSize = OpenSize,
		OpenAnimationTime = OpenAnimationTime,
		ListBackground = ListBackground or Instance.new("Frame"),
		State = nil,

		Open = dropDownList.Open,
		Close = dropDownList.Close
    }

	self.OpenAnimationTime = 0
	self:Open():Destroy()
	self.OpenAnimationTime = OpenAnimationTime	-- restore OpenAnimationTime

	Instance.new("UIListLayout").Parent = self.ListBackground

	for i, v in pairs(points) do
		
		v.Parent = self.ListBackground

		self.Buttons[i] = v
	end


	self.OpenButton.MouseButton1Click:Connect(function(...: any)
		if self.State == true then
			self:Close()
		else
			self:Open()
		end
	end)

	return self
end

return dropDownList
