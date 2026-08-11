-- Services
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- Target Parent (CoreGui preferred, fallback to PlayerGui for mobile)
local parentGui = pcall(function() return CoreGui.Name end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Clean up existing instances
if parentGui:FindFirstChild("AutoFlipGUI_Mobile") then
    parentGui.AutoFlipGUI_Mobile:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoFlipGUI_Mobile"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui

-- Resolve Remote Event
local ClickedEvent
pcall(function()
    local SharedPackage = ReplicatedStorage:WaitForChild("SharedPackage", 3)
    local ControllerPackage = SharedPackage.Packages.ControllerPackage
    local ReplicationController = ControllerPackage.ReplicationController
    ClickedEvent = ReplicationController.RemoteEvents:FindFirstChild("Clicked")
end)

-- Main Container Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(55, 55, 70)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0.6, 0, 1, 0)
TitleText.Position = UDim2.new(0.05, 0, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Auto-Flip"
TitleText.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleText.TextSize = 13
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Minimize Button (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -56, 0, 4)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MinimizeBtn.Text = "–"
MinimizeBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
MinimizeBtn.TextSize = 16
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- Destroy Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 45, 45)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Draggable Floating Minimize Button
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenBtn"
OpenBtn.Size = UDim2.new(0, 48, 0, 48)
OpenBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
OpenBtn.Text = "FLIP"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 12
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(80, 80, 110)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

-- Delay Input Section
local DelayFrame = Instance.new("Frame")
DelayFrame.Size = UDim2.new(0.9, 0, 0, 30)
DelayFrame.Position = UDim2.new(0.05, 0, 0, 40)
DelayFrame.BackgroundTransparency = 1
DelayFrame.Parent = MainFrame

local DelayLabel = Instance.new("TextLabel")
DelayLabel.Size = UDim2.new(0.55, 0, 1, 0)
DelayLabel.BackgroundTransparency = 1
DelayLabel.Text = "Delay (ms):"
DelayLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
DelayLabel.TextXAlignment = Enum.TextXAlignment.Left
DelayLabel.TextSize = 12
DelayLabel.Font = Enum.Font.SourceSans
DelayLabel.Parent = DelayFrame

local DelayInput = Instance.new("TextBox")
DelayInput.Size = UDim2.new(0.45, 0, 1, 0)
DelayInput.Position = UDim2.new(0.55, 0, 0, 0)
DelayInput.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
DelayInput.Text = "500"
DelayInput.PlaceholderText = "100 - 10000"
DelayInput.TextColor3 = Color3.fromRGB(255, 255, 255)
DelayInput.TextSize = 12
DelayInput.Font = Enum.Font.SourceSansSemibold
DelayInput.Parent = DelayFrame

local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 6)
DelayCorner.Parent = DelayInput

-- Toggle AutoFlip Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 85)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleBtn.Text = "AutoFlip: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleBtn

-- Delay Validation (100ms - 10000ms)
local function getSanitizedDelay()
    local val = tonumber(DelayInput.Text)
    if not val then
        val = 500
    else
        val = math.clamp(val, 100, 10000)
    end
    DelayInput.Text = tostring(val)
    return val / 1000
end

DelayInput.FocusLost:Connect(function()
    getSanitizedDelay()
end)

-- Minimize & Restore Logic
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    OpenBtn.Visible = false
    MainFrame.Visible = true
end)

-- Destroy Logic
local autoFlipping = false

CloseBtn.MouseButton1Click:Connect(function()
    autoFlipping = false
    ScreenGui:Destroy()
end)

-- AutoFlip Execution with Single-Fire Debounce Guard
local isFiring = false

ToggleBtn.MouseButton1Click:Connect(function()
    autoFlipping = not autoFlipping
    
    if autoFlipping then
        ToggleBtn.Text = "AutoFlip: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
        
        task.spawn(function()
            while autoFlipping and ScreenGui.Parent do
                if ClickedEvent and not isFiring then
                    isFiring = true
                    ClickedEvent:FireServer()
                    task.delay(0.05, function()
                        isFiring = false
                    end)
                end
                
                local delayTime = getSanitizedDelay()
                task.wait(delayTime)
            end
        end)
    else
        ToggleBtn.Text = "AutoFlip: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    end
end)
