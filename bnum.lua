--[[
                          Big Number Library 

              made by idontthinkofacool and FoundForces, circa early 2020

          Open-Source Version (May not include every functions that BigNum has)


This piece of a module will let you store BigNum tables that are used in such a way that the number
limit goes from 2^1024 (1.79e308) to 9.999999999 * 10^2^1024! (1e1.79e308) This is useful for these
cases using {x, n} which is simply x * 10^n to store numbers, for example:

Simulators

Case 1: When you are working on a Saber Simulator and you have 18,000 players. Doing good. But then your
players will reach 10^308 and will reach Infinity money then.. People figure out how to fix the bug,
but that is just the hard-coded ROBLOX limit! People start reporting the bug left and right, and you
try to fix it but you just can't. Then, you start to lose players and your simulator dies. End of a
game.

Case 2: You are working on a Button Simulator, you have 60-70 players that are mostly Tycoon Sim players.
You reach the 1e308 limit, and people are used to it! Until you add a couple more stats...
People demand the 1e308 limit to be removed, then Button Simulator 3 did using a Beta version of this bignum, 
then your players start switching. Your Button Simulator will only have a few players, and it dies.
End of a game, again.

----------------------

Messing With Scripts

You might use this script to mess around with big numbers and tables. You can happily use it.
As long as you do not break it, then you have to get another copy.


More documentation at other points.

How it Works, and advantage vs. other opensource BigNums

How this works is that it store numbers instead of one double value, it's a table containing 2 elements.

{E, D} = E * 10^D.

Number Examples:

{1, 0} = 1. {8, 3} = 8000. {6.5, 2} = 650. {2.345, 1} = 23.45. {8.21, 1900} = 8.21 * 10 ^ 1900.

This can also handle really low numbers:

{4.567876543, -2} = 0.04567876543. {0, anything} = 0. {2.34343434344334353, -16784} =
0.0000...0000234343434344334353 (16,783 zeroes). 

And negatives:

{-b, c} = -(b * 10^c). This is how the number system works.

----------------------

Advantages:

This is way faster (up to a few seconds on Extuls's BigNum on random e4000*e4000 numbers vs
idontthinkofacool's random e10K*e10K numbers taking bare microseconds, as precision will take up
more memory and exponentially more resources, so precision is limited to 2 NumberValues.) than 
competing bignums, and also has a higher limit (this BigNum has 10^10^308 limit, while other BigNums
that are public have varying limits between 10^640 and 10^100000 (i choosed 10^100000 as it will take
too long to compute adding or multiplying) while this one has a limit of 10^2^1024!).



Unlike other BigNums, you CAN save the BigNum on a DataStore or a OrderedDataStore.
Here's how:

For a DataStore, you can save it by converting the BigNum to a string using the xN.bnumtostr function:

local BigNum = require(game.ServerScriptService.BigNum)

local BN2 = {8.10897029805, 11562} -- Example number

BN2 = BigNum.bnumtostr(BN2) -- converts a table to a string "8.10897029805e11562" suitable for
    --datastore saving without using up many DataStore characters. It can be easily halved by using a
    --basic compression algorithm doing like this: 

{{0, "a"},{1,"b"},{2,"c"},etc.} 

--and converting the string to this table. You DO NOT need to do that,
--this is a optional step.

----------------------

OrderedDataStore:

local BigNum = require(game.ServerScriptService.BigNum)
local BN2 = {8.108, 11562}

--You can't save the BigNum and call it that. You can do this:

BN2 = BigNum.log10(BigNum.add(BN2, {1, 0}))

--This will increase the leaderboard limit from 2^64 to 10^308, but that's not enough... You must do it again:

BN2 = BigNum.log10(BigNum.add(BN2, {1, 0}))

--This will increase the leaderboard limit to 10^10^308. Always keep a note that there is unavoidable

--accuracy issues with this BigNum as a compromise for this high limit and speed. You must add that once again:

BN2 = BigNum.add(BN2, {1, 0})

--You must convert that to a float, and multiply it by 29000000000000000:

BN2 = BigNum.bnumtofloat(BN2) * 29000000000000000

--Then you must save it as that. This is how it should look like:

local BigNum = require(game.ServerScriptService.BigNum)

local BN2 = {8.108, 11562}

BN2 = BigNum.log10(BigNum.add(BN2, {1, 0}))

BN2 = BigNum.log10(BigNum.add(BN2, {1, 0}))

BN2 = BigNum.add(BN2, {1, 0})

BN2 = BigNum.bnumtofloat(BN2) * 29000000000000000

DataStore:SaveAsync(the key you want, BN2)

--If you try to load, your values will be jumbled up. Here, we will be decoding this value:

local Cash = data.Value

Cash = Cash / 29000000000000000 -- to divide it.

Cash = BigNum.floattobnum(Cash) -- to convert it back.

BN2 = BigNum.sub(BN2, {1, 0}) -- to offset it closer to the right.

BN2 = BigNum.pow({1, 1}, BN2) -- {1, 1} -> 10^BN2 to decode it once.

BN2 = BigNum.sub(BN2, {1, 0}) -- to offset it even closer to the right.

BN2 = BigNum.pow({1, 1}, BN2) -- {1, 1} -> 10^BN2 to decode it the last time.

BN2 = BigNum.sub(BN2, {1, 0}) -- to fully decode it.

--Then, you can use xN.short to make the value readable.

You can also add new functions simply, but that will be explained later.

----------------------

Disadvantages:

Compared to other BigNums, there are several compromises:

For speed, the Precision goes from down to the last digit to normal precision. For some functions,
precision gets worse the more it gets.

For size, this has the same compromise as speed. 

For potential, it is harder to develop. Instead of doing {8, 147} ^ ({2.1, 4} + {8, 373} + {1, 1}),

you need to do this: BigNum.pow({8, 147}, BigNum.add({2.1, 4}, BigNum.add({8, 373}, {1, 1}))). 

This is a neccessary compromise unless metatables are used, which is not used in sake for new functions
being easier to add.


----------------------



-- How to Use --



First, to add 2 numbers together (regular 8.85 + regular 5), you need to require the BigNum, convert 
normal numbers onto BigNums, then add it:

local BigNum = require(game.ServerScriptService.BigNum)

N1,N2 = 5,8.85

N1 = BigNum.convert(N1) -- converts 5 to {5, 0}

N2 = BigNum.convert(N2) -- converts 8.85 to {8.85, 0}

N3 = BigNum.add(N1,N2) -- adds 5 and 8.85 = {1.385, 1}

print(BigNum.bnumtostr(N3)) -- converts {1.385, 1} to string: 1.385e1

It is harder to do becuse of how BigNum works. With extensive scripting knowledge, you may make it 
easy to use and distribute it.

To compare, you must do:

local w = require(game.ServerScriptService.BigNum)

N1 = BigNum.convert("1.459e11") -- 145.9B

N2 = BigNum.convert(-8979) -- -8979

if BigNum.le(N2,N1) then --it is true

    print("true")

end

----------------------

    -- Converting a Game from Normal to BigNum --

You only need to convert a game from Normal to BigNum ONCE. The diffucilty can vary game per game.
On the easy end of the spectrum, it can take a few minutes to a hour to convert a simple idle game
to BigNum.

On the middle end of the spectrum, Button Simulator 3 took 3 days to convert from normal to BigNum
thanks to it's Button Transformer, so only a few scripts getting converted was required. Otherwise,
it would be at the other end of the spectrum:

On the other end of the spectrum, if you have a game like Miner's Haven... oh boy. It can take upwards
of a few MONTHS to a year to convert it fully. Miner's Haven tried to convert to a competing, older
BigNum but failed. Make sure to check your game infastructure. If the configs are in-script, you are
on this end of the spectrum.

First, you must change player's NumberValues to StringValues (You store the values as strings). 

You may encounter many errors, so PLEASE
MAKE A TESTING PLACE BEFORE YOU ATTEMPT TO CONVERT TO BIGNUM. Then, you might have a script like this:


Door = script.Parent
 
local debounce = false 

function getPlayer(humanoid) 

local players = game.Players:children()
 
for i = 1, #players do 

if players[i].Character.Humanoid == humanoid then return players[i] end 

end 

return nil 

end 

function onTouched(hit)
 
if debounce == false then 

local human = hit.Parent:findFirstChild("Humanoid") 

if (human == nil) then return end 

local player = getPlayer(human) 

debounce = true 

if (player == nil) then return end 

local stats = player:findFirstChild("leaderstats") 

local sp = stats:findFirstChild("Cash") -- replace nani with the stat that is getting removed/subtracted.

local ao = stats:findFirstChild("Multi")

local a = stats:findFirstChild("Rebirths")

local u = stats:findFirstChild("Ultra")

local m = stats:findFirstChild("Mega")

local p = stats:findFirstChild("Prestige")

local o = stats:findFirstChild("Levelc") -- replace nani with the stat that is getting removed/subtracted.

if sp == nil then return false end

if ao == nil then return false end 

if (sp.Value >=1500) then -- replace 100 with stat cost

sp.Value = 1500

o.Value = 0

print("Enough Money") 

ao.Value = ao.Value + 47*a.Value*m.Value*p.Value -- the multiplier you want

wait(0) 

debounce = false 

else debounce = false 

end 

end 

end 

connection = Door.Touched:connect(onTouched) 


----------------------

By looking at the script, it is at the other end of the spectrum.

You replace checks like (sp.Value >=1500) with BigNum.meeq(BigNum.convert(sp.Value), {1.5, 3}).
You will not find the meeq function, but I will tell you how to make the function later on the
tutorial.

Then, you replace sp.Value = 1500 with sp.Value = "1500". This is a optional step. Next, you
replace ao.Value = ao.Value + 47*a.Value*m.Value*p.Value with: (May take a while):


local SVB = BigNum.convert(ao.Value) -- Converting string to BigNum

local Val = {4.7, 1}

local Val = BigNum.mul(Val, BigNum.convert(a.Value)) -- Multiplier #1

local Val = BigNum.mul(Val, BigNum.convert(m.Value)) -- Multiplier #2

local Val = BigNum.mul(Val, BigNum.convert(p.Value)) -- Multiplier #3

SVB = BN.add(SVB, Val) -- adding

ao.Value = BigNum.bnumtostr(SVB) -- to finalize the transaction


This is the final product:


Door = script.Parent 

local debounce = false 

function getPlayer(humanoid) 

local players = game.Players:children() 

for i = 1, #players do 

if players[i].Character.Humanoid == humanoid then return players[i] end 

end 

return nil 

end 

function onTouched(hit)
 
if debounce == false then 

local human = hit.Parent:findFirstChild("Humanoid") 

if (human == nil) then return end 

local player = getPlayer(human) 

debounce = true 

if (player == nil) then return end 

local stats = player:findFirstChild("leaderstats") 

local sp = stats:findFirstChild("Cash") -- replace nani with the stat that is getting removed/subtracted.

local ao = stats:findFirstChild("Multi")

local a = stats:findFirstChild("Rebirths")

local u = stats:findFirstChild("Ultra")

local m = stats:findFirstChild("Mega")

local p = stats:findFirstChild("Prestige")

local o = stats:findFirstChild("Levelc") -- replace nani with the stat that is getting removed/subtracted.

if sp == nil then return false end

if ao == nil then return false end 

if  BigNum.meeq(BigNum.convert(sp.Value), {1.5, 3}) then -- replace 100 with stat cost

sp.Value = "1500"

o.Value = "0"

print("Enough Money") 

local SVB = BigNum.convert(ao.Value) -- Converting string to BigNum

local Val = {4.7, 1}

local Val = BigNum.mul(Val, BigNum.convert(a.Value)) -- Multiplier #1

local Val = BigNum.mul(Val, BigNum.convert(m.Value)) -- Multiplier #2

local Val = BigNum.mul(Val, BigNum.convert(p.Value)) -- Multiplier #3

SVB = BN.add(SVB, Val) -- adding

ao.Value = BigNum.bnumtostr(SVB) -- to finalize the transaction

wait(0) 

debounce = false 

else debounce = false 

end 

end 

end 

connection = Door.Touched:connect(onTouched) .


----------------------

More documentation below this script. Have fun using this BigNum to create better games!


-- List of all the function that are included: --

-short(x) -- Converts a Bnum to a suffix, Example: short({1,3}) = 1K (1e3) ,, INPUT FORMAT: {X,N}

-strtobnum(x) -- Converts a string to Bnum, Example: strtobnum( '1e4' ) = {1,4} ,, INPUT FORMAT: 'XeN'

-floattobnum(x) -- Converts a number to Bnum, Example: bnumtofloat( 1000 ) = {1, 3} (1e3) ,, INPUT FORMAT: X

-convert(x) -- Converts number/string to Bnum, Example: convert( '1e3' ) = {1,3} ,, INPUT FORMAT: X / 'XeN'

-new(x, y) -- Makes a new bignum from 2 number, Example: new( 1, 3 ) = {1,3} (1e3) ,, INPUT FORMAT: X, N

-bnumtofloat(x) -- Converts a Bnum to number, Example: bnumtofloat( {1,3} ) = 1000 ,, INPUT FORMAT: {X,N}

-bnumtostr(x) -- Converts a Bnum to string, Example: bnumtostr( {1,3} ) = 1e3 ,, INPUT FORMAT: {X,N}

-errorcorrection(x) -- Correct a Bnum (Very important), Example: errorcorrection({11, 2}) = {1.1,3} ,, INPUT FORMAT: {X,N}

-div(x, y) -- Divides a Bnum with a Bnum, Example: div( {1,1}, {5,0} ) (10 / 5) = {2,0} (2) ,, INPUT FORMAT: {X,N} , {X,N}

-mul(x, y) -- Multiplies a Bnum with a Bnum, Example: mul( {1,1}, {5,0} ) (10 * 5) = {5,1} (50) ,, INPUT FORMAT: {X,N} , {X,N}

-log10(x) -- Gets the log10 of a Bnum, Example: log10( {1,2} ) (100) = {2,0} (2) ,, INPUT FORMAT: {X,N}

-le(x, y) -- Is a Bnum smaller then a Bnum, Example: le( {1,1}, {9,0} ) (10 < 9) = false ,, INPUT FORMAT: {X,N} , {X,N}

-me(x, y) -- Is a Bnum bigger then a Bnum, Example: le( {1,1}, {9,0} ) (10 > 9) = true ,, INPUT FORMAT: {X,N} , {X,N}

-eq(x, y) -- Is a Bnum equal to a Bnum, Example eq( {1,0}, {1,0} ) = true ,, INPUT FORMAT: {X,N} , {X,N}

-add(x, y) -- Adds a Bnum with a Bnum, Example: add( {1,1}, {5,0} ) (10 + 5) = {1.5,1} (15) ,, INPUT FORMAT: {X,N} , {X,N}

-sub(x, y) -- Subtracts a Bnum with a Bnum, Example: sub( {1,1}, {5,0} ) (10 - 5) = {5,0} (5) ,, INPUT FORMAT: {X,N} , {X,N}

-sqrt(x) -- Gets the Square root of a Bnum, Example: sqrt( {1.6,1} ) (16) = {4,0} (4) ,, INPUT FORMAT: {X,N}

-log(x) -- Gets log of a Bnum, Example: log( {1,2} ) (100) = {4.6051, 0} (4.6051) ,, INPUT FORMAT: {X,N}

-abs(x) -- Gets absolute value of a Bnum, Example: abs( {-3, 0} ) (-3) = {3,0} ,, INPUT FORMAT: {X,N}

-shift(x, y) -- Round a Bnum to y decimal places, Example: shift( {3.12, 0} ) (3.12) = {3,0}  ,, INPUT FORMAT: {X,N} , X

-pow(x, y) -- Does Bnum to the power of Bnum, Example: pow( {2, 0} , {2, 0} ) (2) (2) = {4,0} (4) ,, INPUT FORMAT: {X,N} , {X,N}

-rand(min, max) -- Gets a random Bnum bewteen min and max, Example: rand( {0,0}, {9,0} ) (0) (9) = {5.16443014098954, 0} ,, INPUT FORMAT: {X,N} , {X,N}

-floor(x) -- Floors a Bnum, Example: floor( {9.1, 0} ) (9.1) = {9 , 0} (9) ,, INPUT FORMAT: {X,N}

]]--


---------------------- BigNum it self


local xN = {}
function xN.short(bnum)
	--[[
	
	xN.short(bnum).
	
	Description:
	Shorts the BigNum onto a suffix, like modern games, simulators, tycoons or modern talking
	today use auto-generated suffixes. The Open-Source version includes suffixes up to and
	including 10^3,000,000,000,000. To add more, you can put more suffixes on MultOnes. This
	may error and break scripts if you try and xN.short more than it can handle. You can add
	more suffixes by adding things onto table MultOnes. Make sure to not add more than 102
	entries onto MultOnes otherwise the 103rd entry and higher will be over the BigNum limit
	and will not be used.
	
	Examples:
	{8.65, 282} -> 8.65e282. 279 / 3 = 93, so put the 9th on the SecondOnes and 3rd on the
	FirstOnes, but NOT the 3rd one. Result: 8.65TNg

	{2.13374, 283}, 280 / 3 = 93 remainder 1, so put the 9th on the SecondOnes and 3rd on the
	FirstOnes, but NOT the 3rd one. Instead of 2.13TNg, it is multiplied by 10^remainder and
	only 2 decimal places are shown. Result: 21.33TNg

	{9.4811852, 2}, -1 / 3 = -1 remainder 2. Since it is below 0, just put 9.4811 * 10^2. 
        Result: 948.11
	{4, 4}. 1 / 3 = 0 remainder 1. There is cases where x/3 are lower or equal to 2 remainder 2.
	If the standard case was applied to remainder 1, it would be called "40U", but that is not
	what it is called. The backup is applied instead of U, so it's "40k".
	{1.23456, 78907} = 78904 / 3 = 26301 remainder 1. It applies the SecondOnes #2 and FirstOnes
	#6 so "VtSx". But unlike the normal ones, it uses the first MultOnes, which is "Mi". So, it
	becomes "VtSxMi". Then, it returns back to ThirdOnes, so it uses 3rd ThirdOnes which is "Tr".
	It knows it can't use the 0th SecondOnes, so it's "VtSxMiTr". It uses the first FirstOnes but
	does NOT use it AFTER, but BEFORE the Tr, so it's "VtSxMiUTr". Finally, it merges it as normal.
	Result: "12.34VtSxMiUTr".
	
	
	
	
	]]--
	bnum = xN.errorcorrection(bnum)
	local SNumber = bnum[2]
	local SNumber1 = bnum[1]
	local leftover = math.fmod(SNumber, 3)
	SNumber = math.floor(SNumber / 3)
	SNumber = SNumber - 1
	if SNumber <= -1 then
		return math.floor(xN.bnumtofloat(bnum) * 100) / 100	
	end
	local FirstOnes = {"", "U","D","T","Qd","Qn","Sx","Sp","Oc","No"}
	local SecondOnes = {"", "De","Vt","Tg","qg","Qg","sg","Sg","Og","Ng"}
	local ThirdOnes = {"", "Ce", "Du","Tr","Qa","Qi","Se","Si","Ot","Ni"}
	local MultOnes = {"", "Mi","Mc","Na", "Pi", "Fm", "At", "Zp", "Yc", "Xo", "Ve", "Me", "Due", "Tre", "Te", "Pt", "He", "Hp", "Oct", "En", "Ic", "Mei", "Dui", "Tri", "Teti", "Pti", "Hei", "Hp", "Oci", "Eni", "Tra", "TeC", "MTc", "DTc", "TrTc", "TeTc", "PeTc", "HTc", "HpT", "OcT", "EnT", "TetC", "MTetc", "DTetc", "TrTetc", "TeTetc", "PeTetc", "HTetc", "HpTetc", "OcTetc", "EnTetc", "PcT", "MPcT", "DPcT", "TPCt", "TePCt", "PePCt", "HePCt", "HpPct", "OcPct", "EnPct", "HCt", "MHcT", "DHcT", "THCt", "TeHCt", "PeHCt", "HeHCt", "HpHct", "OcHct", "EnHct", "HpCt", "MHpcT", "DHpcT", "THpCt", "TeHpCt", "PeHpCt", "HeHpCt", "HpHpct", "OcHpct", "EnHpct", "OCt", "MOcT", "DOcT", "TOCt", "TeOCt", "PeOCt", "HeOCt", "HpOct", "OcOct", "EnOct", "Ent", "MEnT", "DEnT", "TEnt", "TeEnt", "PeEnt", "HeEnt", "HpEnt", "OcEnt", "EnEnt", "Hect", "MeHect"}
	if bnum[2] == 1/0 then
	if bnum[1] < 0 then
		return "-Infinity"
	else
		return "Infinity"
	end
	end
	-- suffix part
	if SNumber == 0 then
		return math.floor(SNumber1 * 10^leftover * 100)/100 .. "k"
	elseif SNumber == 1 then
		return math.floor(SNumber1 * 10^leftover * 100)/100 .. "M"
	elseif SNumber == 2 then
		return math.floor(SNumber1 * 10^leftover * 100)/100 .. "B"
	end
	local txt = ""
	
	local function suffixpart(n)
		
		local Hundreds = math.floor(n/100)
		n = math.fmod(n, 100)
		local Tens = math.floor(n/10)
		n = math.fmod(n, 10)
		local Ones = math.floor(n/1)
		
		txt = txt .. FirstOnes[Ones + 1]
		txt = txt .. SecondOnes[Tens + 1]
		txt = txt .. ThirdOnes[Hundreds + 1]
		
	end
	local function suffixpart2(n)
		if n > 0 then
			n = n + 1
		end
		if n > 1000 then
			n = math.fmod(n, 1000)
		end
		local Hundreds = math.floor(n/100)
		n = math.fmod(n, 100)
		local Tens = math.floor(n/10)
		n = math.fmod(n, 10)
		local Ones = math.floor(n/1)
		
		txt = txt .. FirstOnes[Ones + 1]
		txt = txt .. SecondOnes[Tens + 1]
		txt = txt .. ThirdOnes[Hundreds + 1]
		
	end
	
	if SNumber < 1000 then
		suffixpart(SNumber)
		return math.floor(SNumber1 * 10^leftover * 100)/100 .. txt
	end
	
	for i=#MultOnes,0,-1 do
		if SNumber >= 10^(i*3) then
			suffixpart2(math.floor(SNumber / 10^(i*3))- 1)
			txt = txt .. MultOnes[i+1]
			
			SNumber = math.fmod(SNumber, 10^(i*3))
		end
	end
	return math.floor(SNumber1 * 10^leftover * 100)/100 .. txt
end


function xN.strtobnum(str)
	--[[
		xN.strtobnum(str). Takes strings instead of BigNums.
		
		Description:
		Converts a string "4.21897632e11561178" onto a BigNum usable with this BigNum. This
		is the only valid format, and "2.62716e+1753" does NOT work.
		Examples:
		"1.72e18" gets converted to {1.72, 18}
		"-8.88e-888" gets converted to {-8.88, -888}.
		"2.147483648e-1.23456789e+123" gets converted to {2.147483648, -1.23456789e+123} or
		2.147483648 * 10^-(1.23 * 10^123).
		
		
	
	]]--
	local Synapse = string.find(str, "e")
	return {tonumber(string.sub(str, 1, Synapse-1)), tonumber(string.sub(str, Synapse+1))}
end

function xN.bnumtofloat(bnum)	
	--[[
		xN.bnumtofloat(str)
		
		Description:
		Converts a BigNum back to a normal number with the normal 1.79e308 cap.
		
		Examples:
		{8.2813, 21} gets converted back to 8281299999999999868928 beacuse of
		unavoidable floating-point precision,
		{-4.5, 12} gets converted back to -4500000000000.
		{1.4, 0} gets converted back to 1.39999999999999991118215802999 beacuse
		of the same thing as {8.2813, 21}.
		
		Exceptions:
		Any numbers not in the normal limit are converted to "inf". or "-inf". 
		Please take notice.
		{8.72, 321} gets converted back to inf beacuse of this exception.
	]]--
	return tonumber(xN.bnumtostr(bnum))
end

function xN.convert(str)
	--[[
		xN.convert(str)
		
		Description:
		The main API to convert a string OR a number to BigNum. It is recommended to
		use this function to convert it to usable BigNum.
		
		Examples:
		"2.227175e1892" gets converted to {2.227175, 1892}.
		-3.717e16 gets converted to {-3.717, 16}.
		0.8 gets converted to {8, -1}.
		"0.922318e1" gets convertetd to {0.922318, 1} which is invalid. Use error correction
		to fix it.
		Exceptions:
		If you try to convert normal number inf, it gets converted to {1, 1.797693e308}
		beacuse it's already inf.
	]]--	
	if tonumber(str) == nil then
		local V,Uw = pcall(function()
			return xN.strtobnum(str) 
		end)
		if V then
			return xN.strtobnum(str)
		else
			return "0"
		end
	end
	if type(str) == "number" then
		if tonumber(str) == 1/0 or  tonumber(str) == -1/0 then
			return {1, 1.797693e308}
		end
	end
	if tonumber(str) == 1/0 or  tonumber(str) == -1/0 then
		return xN.strtobnum(str)
		
	elseif tostring(tonumber(str)) == "nil" then
		return xN.strtobnum(str)
	else
		
		return xN.floattobnum(tonumber(str))
	end
	
end

function xN.new(man,exp)	
	--[[
		xN.new(man,exp)
		
		Description:
		Creates a brand new BigNum man * 10^exp.
		
		Examples:
		xN.new( 1, 2) creates { 1, 2} or 100.
		xN.new(-6,-7) creates {-6,-7} or -0.0000006.
		
	]]--	
	return {man, exp}
end

function xN.floattobnum(float)
	--[[
		xN.floattobnum(float)
		
		Description:
		Converts normal number 'float' onto BigNum.
		
		Examples:
		1.6180933 gets converted to {1.6180933, 0}.
		23456652.18 gets converted to {2.345665218, 7}.
		-89000 gets convertetd to {-8.9, 4}.
		-1.286e-182 gets converted to {-1.286, -182}.
		
		Exception:
		Unpredictable results can happen when converting inf.
		
	]]--	
	local ZeN = tostring(float)
	local Synapse = string.find(ZeN, "+")	
	if Synapse then
		return xN.strtobnum(string.sub(ZeN, 1, Synapse-1) .. string.sub(ZeN, Synapse+1))
	elseif string.find(ZeN, "e") then
		return xN.strtobnum(ZeN)
	else
		return xN.errorcorrection(xN.strtobnum(ZeN .. "e0")	)
	end	
end

function xN.bnumtostr(bnum)	
	--[[
		xN.bnumtostr(bnum)
		
		Description:
		Converts BigNum to a string. It is strongly used for saving and storing BigNums.
	]]--
	return tostring(bnum[1]) .. "e" .. tostring(bnum[2])
end


function xN.errorcorrection(bnum)	
	--[[
		xN.errorcorrection(bnum)
		
		Description:
		Errorcorrects BigNums. Without this, this BigNum would not even be possible.
		All things are error corrected.
		
		
	]]--
	local signal = "+"
	if bnum[1] == 0 then
		return {0, 0}
	end
	if bnum[1] < 0 then
		signal = "-"
	end
	if signal == "-" then
		bnum[1] = bnum[1] * -1
		-- Preparing for the worst to come.
	end
	-- get bnum ecc
	local signal2 = "+"
	if bnum[2] < 0 then
		signal2 = "-"
		bnum[2] = bnum[2] * -1
	end
	if math.fmod(bnum[2], 1) > 0 then
		bnum[1] = bnum[1] * (10^ (1 - math.fmod(bnum[2], 1)))
		bnum[2] = math.floor(bnum[2]) + 1
	end
	if signal2 == "-" then
		bnum[2] = bnum[2] * -1		
	end
	-- get digit after digits
	local DgAmo = math.log10(bnum[1])
	DgAmo = math.floor(DgAmo)
	bnum[1] = bnum[1] / 10^DgAmo
	bnum[2] = bnum[2] + DgAmo	
	bnum[2] = math.floor(bnum[2])
	-- do not forget signals!
	if signal == "-" then
		bnum[1] = bnum[1] * -1		
	end
	return bnum
end	

function xN.div(bnum1, bnum2)
	--[[
		xN.div(bnum1, bnum2)
		
		Description:
		Divides 2 BigNums.
		
	]]--	
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	local bnum3 = xN.new(0, 0)
	bnum3[1] = bnum1[1] / bnum2[1]
	bnum3[2] = bnum1[2] - bnum2[2]
	bnum3 = xN.errorcorrection(bnum3)
	return bnum3
end
	
function xN.mul(bnum1, bnum2)
	--[[
		xN.mul(bnum1, bnum2)
		
		Description:
		Multiplies 2 BigNums.
		
	]]--	
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	local bnum3 = xN.new(0, 0)
	bnum3[1] = bnum1[1] * bnum2[1]
	bnum3[2] = bnum1[2] + bnum2[2]
	bnum3 = xN.errorcorrection(bnum3)
	return bnum3
end
	
function xN.log10(bnum)
	--[[
		xN.log10(bnum1, bnum2)
		
		Description:
		Gets the log10 of the BigNum.
		
	]]--	
	local LogTen = bnum[2] + math.log10(bnum[1])
	return xN.errorcorrection(xN.new(LogTen, 0))
end
	
function xN.eq(bnum1, bnum2)
	--[[
		xN.eq(bnum1, bnum2) (DOES NOT RETURN BIGNUM)
		
		Description:
		Returns true if bnum1 is the same as bnum2, otherwise returns false.
		
	]]--	
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	if bnum1[1] == bnum2[1] then
		if bnum1[2] == bnum2[2] then
			return true
		end
	end
	return false
end
	
function xN.le(bnum1, bnum2)
	--[[
		xN.le(bnum1, bnum2) (DOES NOT RETURN BIGNUM)
		
		Description:
		Returns true if bnum1 is less than bnum2, otherwise returns false.
		
	]]--	
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	local signal = "+"
	local signal2 = "+"
	if bnum1[1] < 0 then
		signal = "-"
	end
	if bnum2[1] < 0 then
		signal2 = "-"
	end
	if signal == "+" and signal2 == "-" then
		return false
	elseif signal == "-" and signal2 == "+" then
		return true
	elseif signal == "-" and signal2 == "-" then
		if bnum1[2] > bnum2[2] then
			-- passed test 1.
			return true
		end
		if bnum1[2] < bnum2[2] then
			-- passed test 1.
			
			return false
		end
		if bnum1[1] < bnum2[1] then
			-- passed test 2.
			return true
		end	
	elseif signal == "+" and signal2 == "+" then
		if bnum1[2] < bnum2[2] then
			-- passed test 1.
			return true
		end
		if bnum1[2] > bnum2[2] then
			-- passed test 1.
			
			return false
		end
		if bnum1[1] < bnum2[1] then
			-- passed test 2.
			return true
		end	
	end	
	return false
end

function xN.me(bnum1, bnum2)
	--[[
		xN.me(bnum1, bnum2) (DOES NOT RETURN BIGNUM)
		
		Description:
		Returns true if bnum1 is more than bnum2, otherwise returns false.
		
	]]--	
	
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	local signal = "+"
	local signal2 = "+"
	if bnum1[1] < 0 then
		signal = "-"
	end
	if bnum2[1] < 0 then
		signal2 = "-"
	end
	if signal == "+" and signal2 == "-" then
		return true
	elseif signal == "-" and signal2 == "+" then
		return false
	elseif signal == "-" and signal2 == "-" then
		if bnum1[2] < bnum2[2] then
			-- passed test 1.
			return true
		end 
		if bnum1[2] < bnum2[2] then
			-- passed test 1.
			
			return false
		end
		if bnum1[1] > bnum2[1] then
			-- passed test 2.
			return true
		end	
	elseif signal == "+" and signal2 == "+" then
		
		
		if bnum1[2] > bnum2[2] then
			-- passed test 1.
			
			return true
		end
		if bnum1[2] < bnum2[2] then
			-- passed test 1.
			
			return false
		end
		
		if bnum1[1] > bnum2[1] then
			-- passed test 2.
			
			return true
		
		end
		
	end
	return false
end


function xN.add(bnum1, bnum2)
	--[[
		xN.add(bnum1, bnum2)
		
		Description:
		The simplest of them all. Adds two BigNums together.
	]]--	
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	local bnum3 = xN.new(0,0)
	local Diff = bnum2[2] - bnum1[2]
	if Diff > 20 then
		return bnum2
	elseif Diff < - 20 then
		return bnum1
	else
		bnum3[2] = bnum1[2]
		bnum3[1] = bnum1[1] + (bnum2[1] * 10^Diff)
	end
	bnum3 = xN.errorcorrection(bnum3)
	return bnum3
end


function xN.sub(bnum1, bnum2)
	--[[
		xN.sub(bnum1, bnum2)
		
		Description:
		Substracts the second BigNum from the first BigNums.
	]]--
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	local bnum3 = xN.new(0,0)
	local Diff = bnum2[2] - bnum1[2]
	if Diff > 20 then
		bnum3 = xN.new(bnum1[1] * -1, bnum2[2])
	elseif Diff < - 20 then
		return bnum1
	else
		bnum3[2] = bnum1[2]
		bnum3[1] = bnum1[1] - (bnum2[1] * 10^Diff)
	end
	bnum3 = xN.errorcorrection(bnum3)
	return bnum3
end


function xN.pow(bnum1, bnum2)
	--[[
		xN.pow(bnum1, bnum2)
		
		Description:
		Substracts the second BigNum from the first BigNums.
		
		Exceptions:
		Negative exponenting (-4)^x is not supported, and will put {1,nil} instead.
		
	]]--
	if bnum1[1] < 0 then
		-- warn("Negative exponenting is not supported on this BigNum.")
		return {1,nil}
	end
	if bnum1[1] == 0 and bnum2[2] == 0 then
		-- warn("I agree that 0 ^ 0 is 0.5")
		return {0.5, 0}
	elseif bnum2[1] == 0 then
		return {1, 0}
	elseif bnum1[1] == 0 then
		return {0, 0}
	
	end
	
	bnum1 = xN.errorcorrection(bnum1)
	bnum2 = xN.errorcorrection(bnum2)
	local bnum3 = {0, 0}
	local N = xN.log10(bnum1)
	N = xN.bnumtofloat(N)	
	N = N * xN.bnumtofloat(bnum2)
	bnum3[2] = N
	--bnum3[2] = math.floor(N)
	bnum3[1] = 1
	return xN.errorcorrection(bnum3)
end


function xN.sqrt(bnum1)
	--[[
		xN.sqrt(bnum1)
		
		Description:
		Returns the square root of a BigNum.
	]]--
	bnum1 = xN.errorcorrection(bnum1)	
	return xN.pow(bnum1, {5, -1})
end




function xN.log(bnum)
	--[[
		xN.log(bnum1)
		
		Description:
		Returns the natural logarthim of a BigNum.
	]]--
	local b = xN.bnumtofloat({2.718281828045905, 0})
	local LogTen = bnum[2] + math.log10(bnum[1])
	LogTen = LogTen / math.log10(b)	
	return xN.errorcorrection(xN.new(LogTen, 0))
end


function xN.rand(bnum1, bnum2)
	--[[
		xN.rand(bnum1, bnum2)
		
		Description:
		Returns a random BigNum between bnum1 and bnum2.
	]]--
	local Ye = xN.convert(math.random())
	
	local bnum3 = xN.mul(Ye, xN.sub(bnum1, bnum2))
	bnum3 = xN.add(bnum3, bnum2)
	return bnum3
end



function xN.abs(bnum1)
	--[[
		xN.rand(bnum1)
		
		Description:
		Returns the absolute value of a BigNum.
	]]--
	return {math.abs(bnum1[1]), bnum1[2]}
end

function xN.floor(bnum1)
	--[[
		xN.rand(bnum1)
		
		Description:
		Returns the absolute value of a BigNum.
	]]--
	if bnum1[2] > 15 then
		return bnum1
	end
	return xN.convert(math.floor(xN.bnumtofloat(bnum1)))
end



function xN.meeq(bnum, bnum1) -- more or equal to

  if xN.me(bnum, bnum1) or xN.eq(bnum, bnum1) then -- check if its bigger or equal to

   return true -- if so return true

   end

return false -- otherwise return false

end -- close function


return xN
