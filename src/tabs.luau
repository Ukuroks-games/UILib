--[[
	Класс вкладок
]]
local tabs = {}

export type Tabs<Index> = {
	Tabs: {
		[Index]: {
			Button: GuiButton,
			Tab: Frame
		}
	},

	CurrentOpened: Index,

	OpenedChanged: RBXScriptSignal,

	OpenedChangedEvent: BindableEvent,

	Connections: { RBXScriptConnection },

	OpenTab: (self: Tabs<Index>, open: Index) -> boolean?,

	Destroy: (self: Tabs<Index>) -> nil
}

tabs.ButtonType = {
	Image = "Image",
	Text = "Text"
}

function tabs.Destroy<Index>(self: Tabs<Index>, destroyAll: boolean?)

	if destroyAll then
		for _, v in pairs(self.Tabs) do
			v.Button:Destroy()
			v.Tab:Destroy()
		end
	end

	for _, v in pairs(self.Connections) do
		if v then
			v:Disconnect()
		end
	end

	self.OpenedChangedEvent:Destroy()

	table.clear(self)

end

function tabs.OpenTab<Index>(self: Tabs<Index>, open: Index): boolean?
	if self.Tabs[open] then
		self.OpenedChangedEvent:Fire(open)
		return true
	else
		return nil
	end
end

function tabs.new<Index>(tabsFrames: { [Index]: Frame }, ButtonsType: string, DefaultOpened: Index): Tabs<Index>

	local OpenedChangedEvent = Instance.new("BindableEvent")

	local self: Tabs<Index> = {
		Tabs = {},
		Connections = {},
		CurrentOpened = DefaultOpened,
		OpenedChanged = OpenedChangedEvent.Event,
		OpenedChangedEvent = OpenedChangedEvent,

		OpenTab = tabs.OpenTab,
		Destroy = tabs.Destroy
	}

	for i, v in pairs(tabsFrames) do
		
		v.Visible = false

		local newTab = {
			Button = Instance.new(ButtonsType .. "Button"),
			Tab = v
		}

		table.insert(
			self.Connections, 
			newTab.Button.MouseButton1Click:Connect(
				function()
					self.OpenedChangedEvent:Fire(i)
				end
			)
		)

		self.Tabs[i] = newTab
	end

	local function SetCurrentTab(open: Index) 
		self.Tabs[self.CurrentOpened].Tab.Visible = false
		self.Tabs[open].Tab.Visible = true
		self.CurrentOpened = open
	end

	table.insert(
		self.Connections, 
		self.OpenedChanged:Connect(SetCurrentTab)
	)

	SetCurrentTab(DefaultOpened)

	return self
end

return tabs
