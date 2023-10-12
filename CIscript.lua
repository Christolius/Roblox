local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Cookie Incremental Script",
    SubTitle = "by christolius",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
}

function collect(obj)
	local a={obj.Name:gsub("[^%-%d]","")}
	game:GetService("ReplicatedStorage").Remotes.CollectEvent:FireServer({{["cookieType"]=obj.Name:gsub("%d",""),["SecureNumber"]=tonumber(a[1])}})
	obj:Destroy()
end

local Options = Fluent.Options

do
	Tabs.Main:AddButton({
        Title = "Collect All Cookies",
        Description = "",
        Callback = function()
            for i,v in pairs(workspace.CookieSpawns.Spawn1:GetChildren()) do
				collect(v)
			end
        end
    })
	local acToggle = Tabs.Main:AddToggle("AC", {Title = "Auto Collect Cookies", Default = false })
	Fluent:Notify({
        Title = "Loaded!",
        Content = "Cookie Incremental Script Loaded.",
        Duration = 1
    })
    while task.wait(.05) do
    	if Options.AC.Value then
    		for i,v in pairs(workspace.CookieSpawns.Spawn1:GetChildren()) do
				collect(v)
			end
    	end
    end
end
