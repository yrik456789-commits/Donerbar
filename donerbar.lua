-- DonerBar Hub | DM Arena
-- Execute this script in your executor (e.g. Wave, Solara, etc.)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Clean up existing UI if re-executing
if CoreGui:FindFirstChild("DonerBarUI") then
    CoreGui.DonerBarUI:Destroy()
end

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DonerBarUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

---------------------------------------------------------
-- 1. INTRO SYSTEM (Realistic & Detailed)
---------------------------------------------------------
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting
TweenService:Create(Blur, TweenInfo.new(1), {Size = 24}):Play()

local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
IntroFrame.BackgroundTransparency = 0.2
IntroFrame.Parent = ScreenGui

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Size = UDim2.new(0, 400, 0, 50)
IntroTitle.Position = UDim2.new(0.5, -200, 0.4, -50)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Text = "DONER BAR"
IntroTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroTitle.TextSize = 42
IntroTitle.Font = Enum.Font.FredokaOne
IntroTitle.Parent = IntroFrame

local IntroSubtitle = Instance.new("TextLabel")
IntroSubtitle.Size = UDim2.new(0, 400, 0, 20)
IntroSubtitle.Position = UDim2.new(0.5, -200, 0.4, 0)
IntroSubtitle.BackgroundTransparency = 1
IntroSubtitle.Text = "DM Arena Edition | Loading Framework..."
IntroSubtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
IntroSubtitle.TextSize = 16
IntroSubtitle.Font = Enum.Font.SourceSansItalic
IntroSubtitle.Parent = IntroFrame

local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Size = UDim2.new(0, 350, 0, 10)
LoadingBarBG.Position = UDim2.new(0.5, -175, 0.55, 0)
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
LoadingBarBG.BorderSizePixel = 0
LoadingBarBG.Parent = IntroFrame
local UICornerLoading = Instance.new("UICorner", LoadingBarBG)
UICornerLoading.CornerRadius = UDim.new(0, 5)

local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
LoadingBarFill.BorderSizePixel = 0
LoadingBarFill.Parent = LoadingBarBG
local UICornerFill = Instance.new("UICorner", LoadingBarFill)
UICornerFill.CornerRadius = UDim.new(0, 5)

local UIGradientLoading = Instance.new("UIGradient")
UIGradientLoading.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255))
})
UIGradientLoading.Parent = LoadingBarFill

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(0, 350, 0, 20)
StatusText.Position = UDim2.new(0.5, -175, 0.58, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Status: Initializing..."
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.TextSize = 14
StatusText.Font = Enum.Font.SourceSans
StatusText.Parent = IntroFrame

-- Intro Sequence Steps
local stages = {
    {time = 0.8, progress = 0.15, text = "Bypassing Anticheat & Fetching Modules..."},
    {time = 1.0, progress = 0.35, text = "Loading DM Arena Hitboxes & Bones..."},
    {time = 1.2, progress = 0.60, text = "Injecting Visuals Engine (ESP & Highlights)..."},
    {time = 0.9, progress = 0.85, text = "Setting up Rainbow Theme & Keybinds..."},
    {time = 0.7, progress = 1.00, text = "DonerBar Successfully Loaded!"}
}

task.spawn(function()
    for _, stage in ipairs(stages) do
        StatusText.Text = "Status: " .. stage.text
        TweenService:Create(LoadingBarFill, TweenInfo.new(stage.time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(stage.progress, 0, 1, 0)
        }):Play()
        task.wait(stage.time + 0.2)
    end
    
    TweenService:Create(Blur, TweenInfo.new(0.8), {Size = 0}):Play()
    TweenService:Create(IntroFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroTitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(IntroSubtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingBarBG, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoadingBarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(StatusText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    task.wait(0.8)
    IntroFrame:Destroy()
    Blur:Destroy()
end)

---------------------------------------------------------
-- 2. MAIN GUI WINDOW
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

-- Rainbow Stroke Effect
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

local RainbowGradient = Instance.new("UIGradient")
RainbowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})
RainbowGradient.Parent = UIStroke

-- Smooth Rainbow Rotation
RunService.RenderStepped:Connect(function()
    RainbowGradient.Rotation = (RainbowGradient.Rotation + 1) % 360
end)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner", TopBar)
TopBarCorner.CornerRadius = UDim.new(0, 10)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 200, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "doner bar"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.Font = Enum.Font.FredokaOne
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TopBar

local TitleGradient = RainbowGradient:Clone()
TitleGradient.Parent = TitleText

-- Window Controls (Minimize & Close)
local ControlHolder = Instance.new("Frame")
ControlHolder.Size = UDim2.new(0, 70, 1, 0)
ControlHolder.Position = UDim2.new(1, -75, 0, 0)
ControlHolder.BackgroundTransparency = 1
ControlHolder.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(0, 0, 0.5, -14)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = ControlHolder

local MinCorner = Instance.new("UICorner", MinimizeBtn)
MinCorner.CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(0, 36, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = ControlHolder

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)

---------------------------------------------------------
-- DRAGGABLE LOGIC
---------------------------------------------------------
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

---------------------------------------------------------
-- TAB NAVIGATION SYSTEM
---------------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -135, 1, -45)
ContentArea.Position = UDim2.new(0, 132, 0, 42)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local TabVisuals = Instance.new("ScrollingFrame")
TabVisuals.Size = UDim2.new(1, 0, 1, 0)
TabVisuals.BackgroundTransparency = 1
TabVisuals.ScrollBarThickness = 2
TabVisuals.Visible = true
TabVisuals.Parent = ContentArea

local TabKeybinds = Instance.new("ScrollingFrame")
TabKeybinds.Size = UDim2.new(1, 0, 1, 0)
TabKeybinds.BackgroundTransparency = 1
TabKeybinds.ScrollBarThickness = 2
TabKeybinds.Visible = false
TabKeybinds.Parent = ContentArea

local function CreateTabBtn(name, pos, targetTab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 32)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = Sidebar
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        TabVisuals.Visible = false
        TabKeybinds.Visible = false
        targetTab.Visible = true
    end)
    return btn
end

CreateTabBtn("Visuals", 10, TabVisuals)
CreateTabBtn("Keybinds", 48, TabKeybinds)

---------------------------------------------------------
-- UI ELEMENTS BUILDER
---------------------------------------------------------
local function CreateToggle(parent, text, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 0, 36)
    frame.Position = UDim2.new(0, 0, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 44, 0, 22)
    btn.Position = UDim2.new(1, -50, 0.5, -11)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    btn.Text = ""
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = btn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(circle, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 50, 65)
        }):Play()
        callback(state)
    end)
    return frame
end

---------------------------------------------------------
-- VISUALS FEATURES LOGIC
---------------------------------------------------------
local VisualSettings = {
    OutlineEnabled = false,
    OutlineColor = Color3.fromRGB(255, 0, 0),
    BoxEnabled = false,
    ShowHP = false,
    SkeletonEnabled = false
}

-- 1. Highlight Outline & Submenu Color Picker
local OutlineToggle = CreateToggle(TabVisuals, "Outline ESP", 0, function(val)
    VisualSettings.OutlineEnabled = val
end)

local ColorSubmenu = Instance.new("Frame")
ColorSubmenu.Size = UDim2.new(0.95, 0, 0, 32)
ColorSubmenu.Position = UDim2.new(0, 0, 0, 40)
ColorSubmenu.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
ColorSubmenu.Parent = TabVisuals
Instance.new("UICorner", ColorSubmenu).CornerRadius = UDim.new(0, 6)

local colors = {
    {Color3.fromRGB(255, 0, 0), "Red"},
    {Color3.fromRGB(0, 255, 0), "Green"},
    {Color3.fromRGB(0, 150, 255), "Blue"},
    {Color3.fromRGB(255, 255, 0), "Yellow"},
    {Color3.fromRGB(255, 0, 255), "Purple"},
    {Color3.fromRGB(255, 255, 255), "White"}
}

for i, colData in ipairs(colors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 20, 0, 20)
    cBtn.Position = UDim2.new(0, 10 + (i - 1) * 28, 0.5, -10)
    cBtn.BackgroundColor3 = colData[1]
    cBtn.Text = ""
    cBtn.Parent = ColorSubmenu
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 4)
    
    cBtn.MouseButton1Click:Connect(function()
        VisualSettings.OutlineColor = colData[1]
    end)
end

-- 2. Box ESP & HP Submenu
CreateToggle(TabVisuals, "Box ESP", 80, function(val)
    VisualSettings.BoxEnabled = val
end)

local BoxSubmenu = Instance.new("Frame")
BoxSubmenu.Size = UDim2.new(0.95, 0, 0, 36)
BoxSubmenu.Position = UDim2.new(0, 0, 0, 120)
BoxSubmenu.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
BoxSubmenu.Parent = TabVisuals
Instance.new("UICorner", BoxSubmenu).CornerRadius = UDim.new(0, 6)

CreateToggle(BoxSubmenu, "  -> Show HP Bar (Left)", 0, function(val)
    VisualSettings.ShowHP = val
end)

-- 3. Skeleton ESP
CreateToggle(TabVisuals, "Skeleton ESP", 165, function(val)
    VisualSettings.SkeletonEnabled = val
end)

---------------------------------------------------------
-- ESP RENDER ENGINE (Drawing API)
---------------------------------------------------------
local ESP_Cache = {}

local function CreateESPForPlayer(plr)
    if plr == LocalPlayer then return end
    
    local objects = {
        Highlight = Instance.new("Highlight"),
        Box = Drawing.new("Square"),
        HPBG = Drawing.new("Square"),
        HPFill = Drawing.new("Square"),
        Skeletons = {}
    }
    
    -- Box setup
    objects.Box.Thickness = 1.5
    objects.Box.Filled = false
    objects.Box.Color = Color3.fromRGB(255, 255, 255)
    
    -- HP Setup
    objects.HPBG.Filled = true
    objects.HPBG.Color = Color3.fromRGB(0, 0, 0)
    objects.HPFill.Filled = true
    
    -- Highlight setup
    objects.Highlight.Name = "DonerBarHighlight"
    objects.Highlight.FillTransparency = 0.5
    
    ESP_Cache[plr] = objects
end

for _, plr in ipairs(Players:GetPlayers()) do CreateESPForPlayer(plr) end
Players.PlayerAdded:Connect(CreateESPForPlayer)
Players.PlayerRemoving:Connect(function(plr)
    if ESP_Cache[plr] then
        ESP_Cache[plr].Highlight:Destroy()
        ESP_Cache[plr].Box:Remove()
        ESP_Cache[plr].HPBG:Remove()
        ESP_Cache[plr].HPFill:Remove()
        for _, line in pairs(ESP_Cache[plr].Skeletons) do line:Remove() end
        ESP_Cache[plr] = nil
    end
end)

-- Render Loop
RunService.RenderStepped:Connect(function()
    for plr, esp in pairs(ESP_Cache) do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        
        if char and hrp and hum and hum.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            
            -- 1. Highlight
            if VisualSettings.OutlineEnabled then
                esp.Highlight.Parent = char
                esp.Highlight.OutlineColor = VisualSettings.OutlineColor
                esp.Highlight.FillColor = VisualSettings.OutlineColor
                esp.Highlight.Enabled = true
            else
                esp.Highlight.Enabled = false
            end
            
            -- 2. Box & HP
            if VisualSettings.BoxEnabled and onScreen then
                local head = char:FindFirstChild("Head")
                if head then
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    local height = math.abs(headPos.Y - legPos.Y)
                    local width = height / 1.8
                    
                    esp.Box.Size = Vector2.new(width, height)
                    esp.Box.Position = Vector2.new(pos.X - width/2, pos.Y - height/2)
                    esp.Box.Visible = true
                    
                    if VisualSettings.ShowHP then
                        local hpPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        esp.HPBG.Size = Vector2.new(3, height)
                        esp.HPBG.Position = Vector2.new(pos.X - width/2 - 6, pos.Y - height/2)
                        esp.HPBG.Visible = true
                        
                        esp.HPFill.Size = Vector2.new(3, height * hpPercent)
                        esp.HPFill.Position = Vector2.new(pos.X - width/2 - 6, pos.Y + height/2 - (height * hpPercent))
                        esp.HPFill.Color = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), hpPercent)
                        esp.HPFill.Visible = true
                    else
                        esp.HPBG.Visible = false
                        esp.HPFill.Visible = false
                    end
                end
            else
                esp.Box.Visible = false
                esp.HPBG.Visible = false
                esp.HPFill.Visible = false
            end
            
            -- 3. Skeleton ESP
            if VisualSettings.SkeletonEnabled and onScreen then
                local limbs = {
                    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
                    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"},
                    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
                    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"},
                    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}
                }
                
                for idx, pair in ipairs(limbs) do
                    local p1, p2 = char:FindFirstChild(pair[1]), char:FindFirstChild(pair[2])
                    if p1 and p2 then
                        if not esp.Skeletons[idx] then
                            esp.Skeletons[idx] = Drawing.new("Line")
                            esp.Skeletons[idx].Thickness = 1.5
                            esp.Skeletons[idx].Color = Color3.fromRGB(255, 255, 255)
                        end
                        local v1, vis1 = Camera:WorldToViewportPoint(p1.Position)
                        local v2, vis2 = Camera:WorldToViewportPoint(p2.Position)
                        if vis1 and vis2 then
                            esp.Skeletons[idx].From = Vector2.new(v1.X, v1.Y)
                            esp.Skeletons[idx].To = Vector2.new(v2.X, v2.Y)
                            esp.Skeletons[idx].Visible = true
                        else
                            esp.Skeletons[idx].Visible = false
                        end
                    end
                end
            else
                for _, line in pairs(esp.Skeletons) do line.Visible = false end
            end
        else
            esp.Highlight.Enabled = false
            esp.Box.Visible = false
            esp.HPBG.Visible = false
            esp.HPFill.Visible = false
            for _, line in pairs(esp.Skeletons) do line.Visible = false end
        end
    end
end)

---------------------------------------------------------
-- KEYBINDS & MINIMIZE CONTROLS
---------------------------------------------------------
local toggleKey = Enum.KeyCode.LeftAlt

local KeybindFrame = Instance.new("Frame")
KeybindFrame.Size = UDim2.new(0.95, 0, 0, 45)
KeybindFrame.Position = UDim2.new(0, 0, 0, 0)
KeybindFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
KeybindFrame.Parent = TabKeybinds
Instance.new("UICorner", KeybindFrame).CornerRadius = UDim.new(0, 6)

local KeyText = Instance.new("TextLabel")
KeyText.Size = UDim2.new(0.6, 0, 1, 0)
KeyText.Position = UDim2.new(0, 10, 0, 0)
KeyText.BackgroundTransparency = 1
KeyText.Text = "Toggle Menu Keybind"
KeyText.TextColor3 = Color3.fromRGB(220, 220, 220)
KeyText.TextSize = 13
KeyText.Font = Enum.Font.Gotham
KeyText.TextXAlignment = Enum.TextXAlignment.Left
KeyText.Parent = KeybindFrame

local KeyBtn = Instance.new("TextButton")
KeyBtn.Size = UDim2.new(0, 90, 0, 26)
KeyBtn.Position = UDim2.new(1, -100, 0.5, -13)
KeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
KeyBtn.Text = "LeftAlt"
KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBtn.TextSize = 12
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.Parent = KeybindFrame
Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 4)

local isBinding = false
KeyBtn.MouseButton1Click:Connect(function()
    isBinding = true
    KeyBtn.Text = "Press key..."
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if isBinding and input.UserInputType == Enum.UserInputType.Keyboard then
        toggleKey = input.KeyCode
        KeyBtn.Text = input.KeyCode.Name
        isBinding = false
    elseif not gpe and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == toggleKey then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Minimize Animation System
local isMinimized = false
local originalSize = MainFrame.Size
local originalPos = MainFrame.Position

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        originalPos = MainFrame.Position
        Sidebar.Visible = false
        ContentArea.Visible = false
        
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 180, 0, 36),
            Position = UDim2.new(0.5, -90, 0, 15)
        }):Play()
        TitleText.Text = "DonerBar"
        ControlHolder.Visible = false
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = originalSize,
            Position = originalPos
        }):Play()
        task.wait(0.2)
        Sidebar.Visible = true
        ContentArea.Visible = true
        ControlHolder.Visible = true
        TitleText.Text = "doner bar"
    end
end)

-- Re-open from top bar click if minimized
TopBar.InputBegan:Connect(function(input)
    if isMinimized and input.UserInputType == Enum.UserInputType.MouseButton1 then
        isMinimized = false
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = originalSize,
            Position = originalPos
        }):Play()
        task.wait(0.2)
        Sidebar.Visible = true
        ContentArea.Visible = true
        ControlHolder.Visible = true
        TitleText.Text = "doner bar"
    end
end)

-- Close Button
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
