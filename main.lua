local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ตรวจสอบ LocalPlayer ให้แน่ชัดก่อนเริ่ม
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    task.wait()
    LocalPlayer = Players.LocalPlayer
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ตั้งค่า KEY ของคุณที่นี่
local CorrectKey = "MARTIN123" 

local function StartScript()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MartinAimbotGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local MainLabel = Instance.new("TextLabel")
    MainLabel.Parent = ScreenGui
    MainLabel.Size = UDim2.new(0, 200, 0, 50)
    MainLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
    MainLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    MainLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainLabel.Text = "Martin Aimbot Loaded!"
    MainLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    MainLabel.BackgroundTransparency = 1
    MainLabel.TextTransparency = 1
    MainLabel.TextScaled = true
    MainLabel.Font = Enum.Font.SourceSansBold
    MainLabel.BorderSizePixel = 0

    -- Animation แบบ Smooth
    TweenService:Create(MainLabel, TweenInfo.new(1), {TextTransparency = 0, BackgroundTransparency = 0.3}):Play()
    task.wait(2)
    TweenService:Create(MainLabel, TweenInfo.new(1.2, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, -110, 0, 40),
        Size = UDim2.new(0, 160, 0, 35)
    }):Play()

    -- ระบบ Hitbox
    RunService.RenderStepped:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local hb = hrp:FindFirstChild("CustomHitbox")
                if not hb then
                    hb = Instance.new("Part")
                    hb.Name = "CustomHitbox"
                    hb.Size = Vector3.new(100, 100, 100)
                    hb.Transparency = 0.7
                    hb.Color = Color3.fromRGB(0, 255, 0)
                    hb.AlwaysOnTop = true
                    hb.CanCollide = false
                    hb.Anchored = true
                    hb.Parent = hrp
                end
                hb.CFrame = hrp.CFrame
            end
        end
    end)
end

-- หน้าต่างกรอก KEY
local function CreateKeyUI()
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Parent = PlayerGui
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 150)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Parent = KeyGui
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0, 200, 0, 40)
    TextBox.Position = UDim2.new(0.5, -100, 0.3, 0)
    TextBox.PlaceholderText = "Enter Key..."
    TextBox.Text = ""
    TextBox.Parent = Frame
    
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 100, 0, 40)
    Btn.Position = UDim2.new(0.5, -50, 0.7, 0)
    Btn.Text = "Submit"
    Btn.Parent = Frame
    
    Btn.MouseButton1Click:Connect(function()
        if TextBox.Text == CorrectKey then
            KeyGui:Destroy()
            StartScript()
        else
            TextBox.Text = ""
            TextBox.PlaceholderText = "WRONG KEY!"
        end
    end)
end

CreateKeyUI()
