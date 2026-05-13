local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- GUI มุมซ้ายบน
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MartinAimbotGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = ScreenGui
TextLabel.Size = UDim2.new(0, 180, 0, 40)
TextLabel.Position = UDim2.new(0, 10, 0, 10)
TextLabel.BackgroundTransparency = 0.3
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.Text = "Martin aimbot"
TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.BorderSizePixel = 0

local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude

            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

local function AddHitbox(player)
    if player == LocalPlayer then return end
    if not player.Character then return end

    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local hitbox = hrp:FindFirstChild("CustomHitbox")
    if not hitbox then
        hitbox = Instance.new("Part")
        hitbox.Name = "CustomHitbox"
        hitbox.Size = Vector3.new(100,100,100)
        hitbox.Transparency = 0.7
        hitbox.Color = Color3.fromRGB(0,255,0)
        hitbox.Material = Enum.Material.Neon
        hitbox.CanCollide = false
        hitbox.CanTouch = false
        hitbox.CanQuery = false
        hitbox.Anchored = true
        hitbox.Parent = hrp
    end

    hitbox.CFrame = hrp.CFrame
end

RunService.RenderStepped:Connect(function()
    local target = GetClosestPlayer()

    for _, player in pairs(Players:GetPlayers()) do
        AddHitbox(player)
    end

    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        Camera.CFrame = CFrame.new(
            Camera.CFrame.Position,
            target.Character.HumanoidRootPart.Position
        )
    end
end)
