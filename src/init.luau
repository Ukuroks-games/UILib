local DropDownList = require(script.DropDownList)
local bar = require(script.bar)
local checkbox = require(script.checkbox)
local defaultSwitch = require(script.defaultSwitch)
local slider = require(script.slider)
local smoothBar = require(script.smoothBar)
local switch = require(script.switch)
local tabs = require(script.tabs)

--[=[
	@class UILib
]=]
local UILib = {}

--[=[
	@prop bar Bar
	@within UILib
]=]
UILib.bar = bar

--[=[
	@prop smoothBar SmoothBar
	@within UILib
]=]
UILib.smoothBar = smoothBar

--[=[
	@prop switch Switch
	@within UILib
]=]
UILib.switch = switch

--[=[
	@prop DropDownList DropDownList
	@within UILib
]=]
UILib.DropDownList = DropDownList

--[=[
	@prop checkbox Checkbox
	@within UILib
]=]
UILib.checkbox = checkbox

--[=[
	@prop defaultSwitch defaultSwitch
	@within UILib
]=]
UILib.defaultSwitch = defaultSwitch
	
--[=[
	@prop tabs Tabs
	@within UILib
]=]	
UILib.tabs = tabs

--[=[
	@prop slider Slider
	@within UILib
]=]
UILib.slider = slider

return UILib
