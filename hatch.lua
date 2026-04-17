-- سكريبت: مراقب ومضاعف إرسال آلة معينة
local player = game.Players.LocalPlayer

-- 1. المسار المستهدف
local targetMachine = workspace:FindFirstChild("GameObjects")
if targetMachine then
    targetMachine = targetMachine:FindFirstChild("PlaceSpecific")
    if targetMachine then
        targetMachine = targetMachine:FindFirstChild("root")
        if targetMachine then
            targetMachine = targetMachine:FindFirstChild("SpawnMachines")
            if targetMachine then
                targetMachine = targetMachine:FindFirstChild("Default")
                if targetMachine then
                    targetMachine = targetMachine:FindFirstChild("Main")
                end
            end
        end
    end
end

if not targetMachine then
    warn("❌ لم يتم العثور على الآلة المستهدفة")
    return
end

-- 2. إنشاء واجهة التحكم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MachineDuplicator"
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0.5, -100, 0.8, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.5, -60, 0.5, -20)
toggleButton.Text = "▶ تشغيل"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 180, 0, 20)
statusLabel.Position = UDim2.new(0.5, -90, 0, 5)
statusLabel.Text = "⚪ غير نشط"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = frame

-- 3. مراقبة الآلة وتضاعف الإرسال
local active = false
local originalFire = nil
local originalInvoke = nil
local originalClick = nil

local function enableDuplication()
    if active then return end
    active = true
    
    -- 3.1 مراقبة RemoteEvents داخل الآلة
    for _, obj in ipairs(targetMachine:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            if not originalFire then
                originalFire = obj.FireServer
                obj.FireServer = function(self, ...)
                    local args = {...}
                    originalFire(self, unpack(args))
                    originalFire(self, unpack(args))  -- إرسال ثانٍ (تضاعف)
                    print("🔄 تم مضاعفة إرسال RemoteEvent:", obj.Name)
                end
            end
        elseif obj:IsA("RemoteFunction") then
            if not originalInvoke then
                originalInvoke = obj.InvokeServer
                obj.InvokeServer = function(self, ...)
                    local args = {...}
                    local result1 = originalInvoke(self, unpack(args))
                    local result2 = originalInvoke(self, unpack(args))
                    print("🔄 تم مضاعفة استدعاء RemoteFunction:", obj.Name)
                    return result2  -- نعيد نتيجة الثانية (أو الأولى)
                end
            end
        elseif obj:IsA("TextButton") or obj:IsA("ImageButton") then
            if not originalClick then
                originalClick = obj.Click
                obj.Click = function(...)
                    originalClick(...)
                    originalClick(...)  -- مضاعفة الضغط
                    print("🔄 تم مضاعفة الضغط على الزر:", obj.Name)
                end
            end
        end
    end
    
    statusLabel.Text = "🟢 نشط (تضاعف الإرسال)"
    toggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    toggleButton.Text = "⏹ إيقاف"
    print("✅ تم تفعيل تضاعف الإرسال للآلة")
end

local function disableDuplication()
    if not active then return end
    active = false
    
    -- استعادة الوظائف الأصلية (إذا أردت)
    -- لكن لا يمكن استعادتها بسهولة (لأننا فقدنا المرجع الأصلي)
    -- لذا نفضل إعادة تشغيل السكريبت كاملاً
    
    statusLabel.Text = "⚪ غير نشط"
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    toggleButton.Text = "▶ تشغيل"
    print("⏹️ تم إيقاف تضاعف الإرسال")
end

toggleButton.MouseButton1Click:Connect(function()
    if active then
        disableDuplication()
    else
        enableDuplication()
    end
end)

print("✅ سكريبت مراقب الآلة يعمل - اضغط 'تشغيل' لتفعيل التضاعف")
