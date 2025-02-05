local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Roact

local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)

local container = Instance.new("ScreenGui")
container.Parent = PlayerGui

local Update = React.Component:extend("Update")

Update = ReactRoblox.createRoot(container)

local function BlockColor(props)

	return ReactRoblox.createPortal({
		MainPart = React.createElement("Part", {
			Anchored = true,
			Position = Vector3.new(0, 5, 0),
			Color = props.color

		}, {
			ClickActivate = React.createElement("ClickDetector", {
				[React.Event.MouseClick] = function()
					props.invokeClick()
				end,

			})
		})
	}, workspace)

end

function Update:init()

	self.buttonRef = React.createRef()

	self:setSate({
		genNum = React.useState(math.random(10, 20))
		
		
	})
	
	print(self.state)
	self.color, self.colorUpdate = React.useState(Color3.fromRGB(0,0,0))

end

function Update:render()

	self.count, self.countUpdate = React.createBinding(0)
	
	
	print(self.genNum)
	local count = self.count
	local color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))


	local function state()

		if count:getValue() == self.genNum then
			Update:render(nil)
			return 
		end

		self.countUpdate(self.count:getValue() + 1)

	


	end
	print()
	return {
		myElement = React.createElement("", {
			Size = UDim2.new(0, 50, 0, 50),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundColor3 = color,
			Text = self.count:map(function(value)
				return count:getValue()
			end),
			ref = self.buttonRef,
			[React.Event.MouseButton1Click] = state,
		}), 

		part = React.createElement(BlockColor, {
			color = color,
			invokeClick = state,	
		})
		}


end

app = Update:render(Update)
print(app)
