local SoundHandler = {}

SoundHandler.Weapons = {
	["Machine Gun"] = "rbxassetid://458287091",

}

SoundHandler.Impacts = {
	[{Enum.Material.Concrete, Enum.Material.Slate, Enum.Material.Marble, Enum.Material.Plastic, Enum.Material.SmoothPlastic}] = "rbxassetid://142082166", --Concrete
	[{Enum.Material.Pebble}] = "rbxassetid://1055287191", -- Dirt
	[{Enum.Material.Grass}] = "rbxassetid://1055286841", -- Grass
	[{Enum.Material.Metal, Enum.Material.DiamondPlate}] = "rbxassetid://2303101209", -- Metal
	[{Enum.Material.Wood, Enum.Material.WoodPlanks}] = "rbxassetid://142082171", -- Wood
	[{Enum.Material.Glass}] = "rbxassetid://142082167" -- Glass
}

SoundHandler.Nitro = ""
SoundHandler.Explosion = ""

function SoundHandler:Nitro(Vehicle)
	local sound = Instance.new("Sound")
	sound.Parent = Vehicle.Misc.NitroPart
	sound.PlayOnRemove = true

	sound.SoundId = SoundHandler.Nitro
	sound:Destroy()
end

function SoundHandler:FireSound(Vehicle, Weapon)
	local sound = Instance.new("Sound")
	sound.Parent = Vehicle.Misc
	sound.PlayOnRemove = true

	sound.SoundId = SoundHandler.Weapons[Weapon]	
	sound:Destroy()
end

function SoundHandler:Explode(Vehicle)
	local sound = Instance.new("Sound")
	sound.Parent = Vehicle.Body
	sound.PlayOnRemove = true

	sound.SoundId = SoundHandler.Explosion
	sound:Destroy()
end

function SoundHandler:Impact(Hit)
	local attach = Instance.new("Attachment")
	attach.Parent = Hit
	
	local Material = Hit.Material

	local sound = Instance.new("Sound")
	sound.Parent = attach
	sound.PlayOnRemove = true

	for m,s in pairs(SoundHandler.Impacts) do
		if table.find(m, Material) then
			sound.SoundId = s
			break
		end
	end

	sound:Destroy()
	attach:Destroy()
end

return SoundHandler
