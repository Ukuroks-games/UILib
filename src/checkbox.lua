local TweenService = game:GetService("TweenService")

local defaultSwitch = require(script.Parent.defaultSwitch)

local checkbox = {}

export type Checkbox = {
	checked: ImageLabel
} & defaultSwitch.DefaultSwitch

function checkbox.EnableAnimation(self: Checkbox): Tween?
	return TweenService:Create(
		self.checked, TweenInfo.new(0), {Visible = true})
end

function checkbox.DisableAnimation(self: Checkbox): Tween? 
	return TweenService:Create(
		self.checked, TweenInfo.new(0), {Visible = false})
end

function checkbox.new(Background: ImageButton, checkedImageID: string, state: boolean?): Checkbox
	local self = defaultSwitch.new(
		Background,
		state,
		checkbox.EnableAnimation :: defaultSwitch.Func,
		checkbox.DisableAnimation :: defaultSwitch.Func
	)

	self.checked = Instance.new("ImageLabel")
	self.checked.Parent = self.Button
	self.checked.Size = UDim2.fromScale(1,1)
	self.checked.Image = checkedImageID


	return self
end

return checkbox
