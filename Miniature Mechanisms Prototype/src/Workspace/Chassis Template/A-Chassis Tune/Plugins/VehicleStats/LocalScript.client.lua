local Health = script.Parent.Parent.Values.Health
local HealthBar  = script.Parent.HealthBar

local Nitro = script.Parent.Parent.Values.Nitro
local NitroBar = script.Parent.NitroBar

Health.Changed:Connect(function()
	HealthBar.Bar:TweenSize(UDim2.new((Health.Value/100)*0.86,0,0.75,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.2)	
end)

Nitro.Changed:Connect(function()
	NitroBar.Bar:TweenSize(UDim2.new((Nitro.Value/100)*0.86,0,0.75,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.2)	
end)

