local function fpp(pp:ProximityPrompt):ProximityPrompt
    fireproximityprompt(pp)
    return pp
end
local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()
local win = DiscordLib:Window("A Dysfunctional Diner script.")
local main_serv = win:Server("Main","")
local get_things_ch = main_serv:Channel("Get Things")

local supplies = {}
local get_supply = function(supply:string)
    
end
local thing_drop = 
    get_things_ch:Dropdown(
    "Pick the items",
    {},
    function(bool)
        print(bool)
    end
)
get_things_ch:Button(
    "Get Item",
    function()
        
    end
)