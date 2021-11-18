local Keybindings = {
	["Forward"] = "W",
	["Backward"] = "S",
	["Left"] = "A",
	["Right"] = "D",
	["Nitro"] = "LeftShift",
	["Shoot"] = "Space",
	["Swap"] = "Q"
}

local plr = script.Parent.Parent

function Keybindings.GetKeys(F,B,L,R,N,S,Sw)
	Keybindings.Forward = F
	Keybindings.Backward = B
	Keybindings.Left = L
	Keybindings.Right = R
	Keybindings.Nitro = N
	Keybindings.Shoot = S
	Keybindings.Swap = Sw
end

function Keybindings.SetKeys()
	
end

return Keybindings
