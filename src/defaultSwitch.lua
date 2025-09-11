-- Libs

local stdlib = require(script.Parent.Parent.stdlib)

local mutex = stdlib.mutex

--[[
	Interface & base functions for switch or checkbox or something like
]]
local defaultSwitch = {}

export type Func = (self: DefaultSwitch) -> Tween?

export type DefaultSwitchStruct = {
	State: BoolValue,
	Button: GuiButton,

	AnimationMutex: stdlib.Mutex,

	EnableAnimation: Func,
	DisableAnimation: Func,

	connections: { RBXScriptConnection },
}

export type DefaultSwitch = typeof(setmetatable(
	{} :: DefaultSwitchStruct,
	{ __index = defaultSwitch }
))

--[[
	Destroy default switch 
]]
function defaultSwitch.Destroy(self: DefaultSwitch)
	self.State:Destroy()
	self.AnimationMutex:Destroy()

	for _, v in pairs(self.connections) do
		if v then
			v:Disconnect()
			v = nil
		end
	end
end

function defaultSwitch.SetState(self: DefaultSwitch, newState: boolean)
	self.State.Value = newState
end

function defaultSwitch.new(
	button: GuiButton,
	state: boolean?,
	enableAnimation: Func?,
	disableAnimation: Func?
): DefaultSwitch
	local self: DefaultSwitchStruct = {
		Button = button,
		State = Instance.new("BoolValue"),
		AnimationMutex = mutex.new(),
		connections = {},

		EnableAnimation = enableAnimation,
		DisableAnimation = disableAnimation,

		SetState = defaultSwitch.SetState,
	}

	self.State.Value = state or false

	setmetatable(self, { __index = defaultSwitch })

	table.insert(
		self.connections,
		self.Button.MouseButton1Click:Connect(function()
			self.State.Value = not self.State.Value
		end)
	)

	table.insert(
		self.connections,
		self.State.Changed:Connect(function(newValue: boolean)
			self.AnimationMutex:wait()
			self.AnimationMutex:lock()

			if self.DisableAnimation and self.EnableAnimation then
				local tween: Tween? = nil

				if newValue then
					tween = self:EnableAnimation()
				else
					tween = self:DisableAnimation()
				end

				if tween then
					tween:Play()

					tween.Completed:Wait()
				end
			end

			self.AnimationMutex:unlock()
		end)
	)

	return self
end

return defaultSwitch
