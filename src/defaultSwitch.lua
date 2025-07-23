
-- Services

local ReplicatedStorage = game:GetService("ReplicatedStorage")


-- Libs

local Packages = ReplicatedStorage.Packages

local stdlib = require(Packages.stdlib)

local mutex = stdlib.mutex

--[[
	Interface & base functions for switch or checkbox or something like
]]
local defaultSwitch = {}

export type DefaultSwitch = {
	State: BoolValue,
	Button: GuiButton,
	
	EnableAnimation: ((self: DefaultSwitch) -> Tween?)?,

	DisableAnimation: ((self: DefaultSwitch) -> Tween?)?,

	SetState: (self: DefaultSwitch, newState: boolean) -> nil,

	AnimationMutex: mutex.Mutex,

	connections: { RBXScriptConnection }
}

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

function defaultSwitch.new(button: GuiButton, state: boolean?, enableAnimation: ((self: DefaultSwitch) -> Tween?)?, disableAnimation: ((self: DefaultSwitch) -> Tween?)?): DefaultSwitch
	local self = {
		Button = button,
		State = Instance.new("BoolValue"),
		EnableAnimation = enableAnimation,
		DisableAnimation = disableAnimation,
		AnimationMutex = mutex.new(),
		connections = {},

		SetState = defaultSwitch.SetState
	}

	self.State.Value = state or false

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
					tween = self.EnableAnimation()
				else
					tween = self.DisableAnimation()
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
