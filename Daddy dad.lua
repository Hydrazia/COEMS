--[[
This module contains crash functions to crash the LUA VM, and other useful things like RayCast functions.

Credits To : Khaloodyy
Example:

Module.Crash() -- Crashes the LUA VM
Module.Kick() -- Kicks the local player
Module.Destroy() -- Destroys the local player
Module.ShutDown() -- Shuts down the game
Module.RayCast(x,y) -- Casts a ray from x,y on the ViewPort screen
Module.RayCastFromMouseCursor() -- Fires a ray cast from the mouse cursor
Module.SniffExec() -- Determines what Executor the user is running
Module.GetDiscordLink(inviteCode) -- Returns a discord invite link
Module.LockMouse() -- Locks the mouse (Krnl only)
Module.UnLockMouse() -- Unlocks the mouse (Krnl only)
Module.BlindFold() -- Covers screen in black (Drawing lib required)
Module.UnBlindFold() -- Removes screen cover
--]]

local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local MouseLocked = false
local BlindFolded = false

local Module = function()
    return {
        -- Destructive functions grouped together
        Crash = function()
            while true do end
            repeat until nil
            pcall(function()
                while true do end
            end)
        end,

        Kick = function()
            game:GetService("Players").LocalPlayer:Kick("You have been kicked from the game")
        end,

        Destroy = function()
            game:GetService("Players").LocalPlayer:Destroy()
        end,

        ShutDown = function()
            game:Shutdown()
        end,

        -- Utility functions
        RayCast = function(x, y)
            return workspace.CurrentCamera:ViewportPointToRay(x, y)
        end,

        RayCastFromMouseCursor = function()
            if Mouse ~= nil then
                return {Mouse.UnitRay, Mouse.Hit, Mouse.Target, Mouse.TargetSurface}
            else
                return error("The player doesn't have a mouse!")
            end
        end,

        SniffExec = function()
            if is_krnl_closure then
                return "Krnl"
            elseif syn then
                return "Synapse X"
            elseif is_protosmasher_closure then
                return "ProtoSmasher"
            elseif Fluxus then
                return "Fluxus"
            elseif is_our_closure then
                return game:GetService("UserInputService").TouchEnabled 
                    and "Script-Ware iOS" 
                    or "Script-Ware"
            end
            return "Unknown"
        end,

        GetDiscordLink = function(inviteCode)
            return "https://discord.gg/" .. inviteCode
        end,

        LockMouse = function()
            MouseLocked = true
            task.spawn(function()
                pcall(function()
                    while MouseLocked do 
                        wait()
                        mousemoveabs(0, 0)
                    end
                end)
            end)
        end,

        UnLockMouse = function()
            MouseLocked = false
        end,

        BlindFold = function()
            BlindFolded = true
            task.spawn(function()
                pcall(function()
                    local BlindFoldDrawing = Drawing.new("Square")
                    BlindFoldDrawing.Position = Vector2.new(0, 0)
                    BlindFoldDrawing.Size = Vector2.new(99999, 99999)
                    BlindFoldDrawing.Color = Color3.new(0, 0, 0)
                    BlindFoldDrawing.Visible = true
                    BlindFoldDrawing.Filled = true
                    
                    while BlindFolded do 
                        wait() 
                    end
                    
                    BlindFoldDrawing:Remove()
                end)
            end)
        end,

        UnBlindFold = function()
            BlindFolded = false
        end
    }
end

local Module = setmetatable(Module(), {
    __index = function(self, key)
        if key == "ExecutorName" then
            return (identifyexecutor() or ""):lower()
        end
    end,
    __newindex = function() end
})

return Module
