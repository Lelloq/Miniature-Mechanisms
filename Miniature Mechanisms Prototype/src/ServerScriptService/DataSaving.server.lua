local DSS = game:GetService("DataStoreService")
local DataManager = DSS:GetDataStore("MMDataManager")
local RS = game:GetService("ReplicatedStorage")
local UDRemote = RS:WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("UpdateData")

game.Players.PlayerAdded:Connect(function()
	
end)