local PS = game:GetService("PhysicsService")
local SS = game:GetService("ServerStorage")

local VCol = game:GetService("ReplicatedStorage").Remotes.Functions.VehicleHit
local MaxHealth = 1000

local HealTimeInterval = 0.25

local Vehicle = script.Parent.Parent.Parent
local VehicleMaxSpeed = Vehicle.DriveSeat.MaxSpeed
local CurrentSpeed = VehicleMaxSpeed

local NitroRemote = game:GetService("ReplicatedStorage").Remotes.Events.Nitro
local NitroNumber = 100
local NitroPart = script.Parent.Parent.Parent.Misc.NitroPart
local NitroF = Instance.new("BodyForce",NitroPart)
NitroF.Force = Vector3.new(0,0,0)
local Back = Vector3.new(0,0,1) * 3500

local Debris = game:GetService("Debris")

local ShootRemote = game:GetService("ReplicatedStorage").Remotes.Events.Shoot

local Impact = game:GetService("ReplicatedStorage").Objects.Impact

-- [[Debounces]]
local Destroying = false

-- [[Global Variables]]
local CurrentHealth, CurrentAmmo, CurrentNitro

--[[Sound Handling]]
local SoundHandler = require(script.SoundHandler)

--[[Vehicle Respawn Handling]]
function DestroyVehicle(Vehicle)
	if Destroying then return end

	local Explosion = Instance.new("Explosion")
	
	Destroying = true
	
	Explosion.BlastRadius = 7
	Explosion.BlastPressure = 0
	Explosion.DestroyJointRadiusPercent = 0

	Explosion.ExplosionType = Enum.ExplosionType.NoCraters

	Explosion.Position = Vehicle.DriveSeat.Position

	Explosion.Parent = Vehicle.DriveSeat

	Debris:AddItem(Explosion,1)	

end

--[[Vehicle Health Handling]]

function DamageDealt(Damage,HitVehicle)
	if HitVehicle.DriveSeat.Occupant == nil then return end
	local HitOccupant = game.Players:GetPlayerFromCharacter(HitVehicle.DriveSeat.Occupant.Parent)
	
	--if HitOccupant = 
	
	CurrentHealth -= Damage	
	
	--local VColImpact = VCol:InvokeClient(Occupant, CurrentHealth)

	if CurrentHealth <= 0 then
		DestroyVehicle(Vehicle)
		return
	end

end

function HealOverTime()
	while wait(0.25) do
		if CurrentHealth < MaxHealth then
			CurrentHealth = CurrentHealth + 10
			if CurrentHealth > MaxHealth then
				CurrentHealth = MaxHealth
			end
		end
	end
end

--[[Nitro and Weapon Handling]]

local Misc = script.Parent.Parent.Parent.Misc
local Barrels = {Misc.BarrelOne,Misc.BarrelTwo}

function Nitro(plr,num)	
	if Vehicle.DriveSeat.Occupant == nil then return end
	local Occupant = game.Players:GetPlayerFromCharacter(Vehicle.DriveSeat.Occupant.Parent)
	if Occupant ~= plr then return end
	
	if NitroNumber > 0 and num == 1 then	
		NitroF.Force = NitroF.Parent.CFrame:vectorToWorldSpace(Back)
		NitroNumber = NitroNumber - 1
	else
		NitroF.Force = Vector3.new(0,0,0)
	end
end

function Shoot(plr,TeamName)
	if Vehicle.DriveSeat.Occupant == nil then return end
	local Occupant = game.Players:GetPlayerFromCharacter(Vehicle.DriveSeat.Occupant.Parent)
	if Occupant ~= plr then return end

	for i,Barrel in pairs(Barrels) do
		local BarrelPos = Barrel.Position
		local BarrelDir = Barrel.CFrame:vectorToWorldSpace(Vector3.new(0,0,-100))

		local rP = RaycastParams.new()
		rP.FilterDescendantsInstances = {Barrel,Vehicle}
		rP.FilterType = Enum.RaycastFilterType.Blacklist
		local rR = workspace:Raycast(BarrelPos,BarrelDir,rP)
		
		SoundHandler:FireSound(Vehicle,"Machine Gun")
		
		if rR then
			local hit = rR.Instance
			local ImpactC = Impact:Clone()
			ImpactC.Parent = workspace
			ImpactC.Position = Vector3.new(rR.Position.X-0.1,rR.Position.Y-0.1,rR.Position.Z-0.1)
			ImpactC.Sparkles.Color = Color3.new(hit.Color)
			Debris:AddItem(ImpactC,0.2)
			
			SoundHandler:Impact(hit)

			local ImpactModel = hit:FindFirstAncestorOfClass("Model")
			if ImpactModel ~= nil then
				if ImpactModel.Name == "Body" or ImpactModel == "Wheels" then
					DamageDealt(30, ImpactModel.Parent)
				end
			end
		end
	end
end

Vehicle.DriveSeat:GetPropertyChangedSignal("Occupant"):Connect(function()
	if Vehicle.DriveSeat.Occupant ~= nil then
		local createPlrStatus = Instance.new("Folder")
		createPlrStatus.Parent = SS.VehicleStatus
		
		local Player = game.Players:GetPlayerFromCharacter(Vehicle.DriveSeat.Occupant.Parent)
		
		createPlrStatus.Name = Player.UserId
		
		CurrentHealth = Instance.new("IntValue", createPlrStatus)
		CurrentHealth.Name = "CurrentHealth"
		CurrentHealth.Value = MaxHealth
		
		CurrentAmmo = Instance.new("IntValue", createPlrStatus)	
		CurrentAmmo.Name = "CurrentAmmo"
		CurrentHealth.Value = 0
		
		CurrentNitro = Instance.new("IntValue",createPlrStatus)
		CurrentNitro.Name = "CurrentNitro"
		CurrentNitro.Value = NitroNumber
	else
		
	end
end)

NitroRemote.OnServerEvent:Connect(Nitro)
ShootRemote.OnServerEvent:Connect(Shoot)
HealOverTime()