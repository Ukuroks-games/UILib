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
	Close: (self: DropDownList<Index>) -> Tween?,

	Connections: { RBXScriptConnection }
}

function dropDownList.Destroy<Index>(self: DropDownList<Index>)
	
	for _, v in pairs(self.Connections) do
		if v then
			v:Disconnect()
		end
	end

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

function dropDownList.Close<Index>(self: DropDownList<Index>): Tween?
	if self.State ~= dropDownList.State.Close then
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
	else
		return nil
	end
end

--[[
	Constructor

	OpenButton - button that open/close list

	points - list of content of list

	OpenSize - how long list down

	ListBackground - background opened list. If you want you can add image to background of list using it. 
]]
function dropDownList.new<Index>(OpenButton: GuiButton, points: { [Index]: GuiObject }, OpenSize: UDim, OpenAnimationTime: number?, ListBackground: Frame?): DropDownList<Index>

    local self: DropDownList<Index> = {
		OpenButton = OpenButton,
		Buttons = {},
		OpenSize = OpenSize,
		OpenAnimationTime = OpenAnimationTime or 0.2,
		ListBackground = ListBackground or Instance.new("Frame"),
		State = dropDownList.State.Close,
		Connections = {},

		Open = dropDownList.Open,
		Close = dropDownList.Close
    }

	Instance.new("UIListLayout").Parent = self.ListBackground

	for i, v in pairs(points) do
		
		v.Parent = self.ListBackground

		self.Buttons[i] = v
	end


	table.insert(
		self.Connections,
		self.OpenButton.MouseButton1Click:Connect(function(...: any)
			if self.State == true then
				self:Close()
			else
				self:Open()
			end
		end)
	)

	return self
end

return dropDownList
