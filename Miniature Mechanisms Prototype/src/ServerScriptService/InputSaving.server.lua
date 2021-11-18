local DSS = game:GetService("DataStoreService")
local InputManager = DSS:GetDataStore("MMInputManager")
local RS = game:GetService("ReplicatedStorage")
local UKRemote = RS:WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("UpdateKeys")
local InputModule = require(RS.Modules.InputModule)

game.Players.PlayerAdded:Connect(function(plr)	
	local Folder = Instance.new("Folder",game:GetService("ServerStorage"):WaitForChild("InputStorage"))
	Folder.Name = plr.Name
	local Inputs = InputManager:GetAsync("I_"..tostring(plr.UserId))
	
	local Forward = Instance.new("StringValue",Folder)
	Forward.Name = "Forward"
	
	local Backward = Instance.new("StringValue",Folder)
	Backward.Name = "Backward"
	
	local Left = Instance.new("StringValue",Folder)
	Left.Name = "Left"
	
	local Right = Instance.new("StringValue",Folder)
	Right.Name = "Right"
	
	local Nitro = Instance.new("StringValue",Folder)
	Nitro.Name = "Nitro"
	
	local Shoot = Instance.new("StringValue",Folder)
	Shoot.Name = "Shoot"
	
	local Swap = Instance.new("StringValue",Folder)
	Swap.Name = "Swap"
	
	if Inputs then
		print("Key settings successfully loaded.")
		Forward.Value = Inputs.Forward
		Backward.Value = Inputs.Backward
		Left.Value = Inputs.Left
		Right.Value = Inputs.Right
		Nitro.Value = Inputs.Nitro
		Shoot.Value = Inputs.Shoot
		Swap.Value = Inputs.Swap
		
		InputModule.GetKeys(Forward.Value,Backward.Value,Left.Value,Right.Value,Nitro.Value,Shoot.Value,Swap.Value)
		
		print(Inputs)
	else
		Forward.Value = "W"
		Backward.Value = "S"
		Left.Value = "A"
		Right.Value = "D"
		Nitro.Value = "LeftShift"
		Shoot.Value = "Space"
		Swap.Value = "Q"
		
		InputManager:SetAsync("I_"..tostring(plr.UserId),
			{
				["Forward"] = Forward.Value,
				["Backward"] = Backward.Value,
				["Left"] = Left.Value,
				["Right"] = Right.Value,
				["Nitro"] = Nitro.Value,
				["Shoot"] = Shoot.Value,
				["Swap"] = Swap.Value
			})
	end
end)

--[[
1 = Forward
2 = Backward
3 = Left
4 = Right
5 = Nitro
6 = Shoot
7 = Swap
]]--

local function UpdateKB(plr,keys)
	local PlrInputs = game:GetService("ServerStorage"):WaitForChild("InputStorage"):WaitForChild(plr.Name)
	local Id = "I_"..tostring(plr.UserId)
	local success , err pcall(function()
		InputManager:UpdateAsync(Id,
			{
				["Forward"] = keys[1],
				["Backward"] = keys[2],
				["Left"] = keys[3],
				["Right"] = keys[4],
				["Nitro"] = keys[5],
				["Shoot"] = keys[6],
				["Swap"] = keys[7]
			})
	end)
end

UKRemote.OnServerEvent:connect(UpdateKB)