local function CreateKeyUI()
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 150)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.Parent = KeyGui

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0, 200, 0, 40)
    TextBox.Position = UDim2.new(0.5, -100, 0.3, 0)
    TextBox.PlaceholderText = "Enter Key Here..."
    TextBox.Parent = Frame

    local Submit = Instance.new("TextButton")
    Submit.Size = UDim2.new(0, 100, 0, 40)
    Submit.Position = UDim2.new(0.5, -50, 0.7, 0)
    Submit.Text = "Submit"
    Submit.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    Submit.Parent = Frame

    Submit.MouseButton1Click:Connect(function()
        if TextBox.Text == CorrectKey then
            KeyGui:Destroy()
            StartScript() -- ถ้าคีย์ถูก ให้เริ่มทำงาน (UI Smooth + Hitbox)
        else
            TextBox.Text = ""
            TextBox.PlaceholderText = "WRONG KEY!"
            TextBox.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
        end
    end)
end

CreateKeyUI()
