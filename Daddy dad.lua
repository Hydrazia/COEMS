--[[
This module contains crash functions to crash the LUA VM, and other useful things like RayCast functions.

Credits To : Khaloodyy
Example:

Module.Crash() -- Crashes the LUA VM.
Module.RayCast(x,y) -- Casts a ray from x,y on the ViewPort screen.
Module.RayCastFromMouseCursor() -- Fires a ray cast from the mouse cursor.
Module.SniffExec() -- Determines what Executor the user is running based on the amount of functions it has.
Module.GetDiscordLink(inviteCode) -- Returns the discord link for the discord server.
Module.LockMouse () -- Locks the mouse so the user can't move it, (Only works on Krnl)
Module.UnLockMouse () -- UnLocks the mouse so the user can't move it, (Only works on Krnl)
Module.BlindFold () -- Makes the entire Roblox Window be black so the user can't see what's on it. (Only works with Drawing lib)
Module.UnBlindFold () -- UnMakes the entire Roblox Window be black so the user can't see what's on it. (Only works with Drawing lib)
--]]

-- All of these work on Emergency Response Liberty County without Detected!
-- If there is bugs, please let me know on my discord server! https://discord.gg/nZHseUb
local Mouse=game:GetService("Players").LocalPlayer:GetMouse ()
local MouseLocked=false
local BlindFolded=false
return({

Crash=function()
while true do end
repeat until nil
pcall(function()
while true do end
end)
end,

RayCast=function(x,y)
return(workspace.CurrentCamera:ViewportPointToRay(x,y))
end,

RayCastFromMouseCursor=function()
if Mouse~=nil then
return({Mouse.UnitRay,Mouse.Hit,Mouse.Target,Mouse.TargetSurface})
else
return(error("The player doesnt have a mouse!!"))
end
end,

SniffExec=function()
if is_krnl_closure then
return("Krnl")
elseif syn then
return("Synapse X")
elseif is_protosmasher_closure then
return("ProtoSmasher")
elseif Fluxus then
return("Fluxus")
elseif is_our_closure then
if game:GetService("UserInputService").TouchEnabled then
return("Script-Ware iOS")
else
return("Script-Ware")
end
end
end,

GetDiscordLink=function(inviteCode) -- For discords
return("https://discord.gg/"..inviteCode)
end,

LockMouse=function()
MouseLocked=true
spawn(function()
pcall(function()
while MouseLocked do wait ()
mousemoveabs(0,0)
end
end)
end)
end,

UnLockMouse=function()
MouseLocked=false
end,

BlindFold=function() -- Synapse  Krnl and Script-Ware supports this
BlindFolded=true
spawn(function()
pcall(function()
local BlindFoldDrawing=Drawing.new("Square")
BlindFoldDrawing.Position=Vector2.new(0,0)
BlindFoldDrawing.Size=Vector2.new(99999,99999)
BlindFoldDrawing.Color=Color3.new(0,0,0)
BlindFoldDrawing.Visible=true
while BlindFolded do wait ()
end
BlindFoldDrawing:Destroy ()
end)
end)
end,

UnBlindFold=function()
BlindFolded=false
end

}) -- That's It! Hope you enjoyed this module it took a lot of work to make :>
