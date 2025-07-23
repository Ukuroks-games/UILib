local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local stdlib = require(ReplicatedStorage.Packages.stdlib)
local defaultSwitch = require(script.Parent.defaultSwitch)

--[[
	This is default switch, you can make something like that using defaultSwitch
]]
local switch = {}

--[[
	Тот самый свитч переключатель
]]
export type Switch = {
	--[[
		Та самая тёмная область по которой перемещается шарик
	]]
	bar: Frame,

	--[[
		шарик который перемещается по bar
	]]
	ball: Frame,

	ballRadius: Frame,
	barRadius: UICorner,
	background: UICorner
} & defaultSwitch.DefaultSwitch

function switch.CalcSizes(self: Switch)

	self.barRadius.CornerRadius = UDim.new(0, math.floor(self.ball.AbsoluteSize.X / 2))


end

function switch.EnableAnimation(self: Switch)

	return TweenService:Create(
		self.ball,
		TweenInfo.new(
			0.2
		),
		{
			Position = UDim2.new(
				1, 
				-(self.ball.AbsoluteSize.X / 2),
				self.ball.Position.Y.Scale,
				self.ball.Position.Y.Offset
			)
		}
	)
end

function switch.DisableAnimation(self: Switch)

	return TweenService:Create(
		self.ball,
		TweenInfo.new(
			0.2
		),
		{
			Position = UDim2.new(
				0, 
				(self.ball.AbsoluteSize.X / 2),
				self.ball.Position.Y.Scale,
				self.ball.Position.Y.Offset
			)
		}
	)

end

function switch.Destroy(self: Switch)

	self.bar:Destroy()
	self.ball:Destroy()

	defaultSwitch:Destroy(self)
end

function switch.new(background: Frame, state: boolean?): Switch

	local self = defaultSwitch.new(
		Instance.new("TextButton"),
		state,
		switch.EnableAnimation,
		switch.DisableAnimation
	)

	stdlib.utility.merge(self, {
		bar = Instance.new("Frame"),
		ball = Instance.new("Frame"),
		ballRadius = Instance.new("UICorner"),
		barRadius = Instance.new("UICorner"),
		background = background
	})

	self.bar.Parent = background
	self.bar.Size = UDim2.fromScale(1, 0.86)

	self.ball.Parent = bar
	self.ball.Size = UDim2.fromScale(0.5, 1)

	self.Button.Parent = background
	self.Button.Text = ""
	self.Button.Size = UDim2.fromScale(1,1)

	self.ballRadius.Parent = ball
	self.ballRadius.Corner = UDim.new(1, 0)

	self.barRadius.Parent = bar
	

	return self
end

return switch
