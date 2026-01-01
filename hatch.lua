-- 🕵️‍♂️ Stealth Purchase System Tester
-- ⚡ يختبر Remotes بدون ضغط على السيرفر

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "StealthTester" then
        gui:Destroy()
    end
end

-- واجهة خفية
local gui = Instance.new("ScreenGui")
gui.Name = "StealthTester"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 450)
frame.Position = UDim2.new(0.5, -175, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "🕵️‍♂️ STEALTH REMOTE TESTER"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- قائمة الـ Remotes المكتشفة
local remotesList = {
    {name = "ServerSideBulkPurchaseEvent", type = "RemoteEvent", path = "RobloxReplicatedStorage.ServerSideBulkPurchaseEvent", risk = "HIGH"},
    {name = "BuyItem", type = "RemoteFunction", path = "ReplicatedStorage.Remotes.BuyItem", risk = "HIGH"},
    {name = "BuyEventItem", type = "RemoteFunction", path = "ReplicatedStorage.Remotes.BuyEventItem", risk = "HIGH"},
    {name = "BuyEgg", type = "RemoteFunction", path = "ReplicatedStorage.Remotes.BuyEgg", risk = "MEDIUM"},
    {name = "BuyPaidGift", type = "RemoteEvent", path = "ReplicatedStorage.Remotes.BuyPaidGift", risk = "MEDIUM"},
    {name = "SuccessfulPurchase", type = "RemoteEvent", path = "ReplicatedStorage.Remotes.SuccessfulPurchase", risk = "MEDIUM"},
    {name = "OfferGift", type = "RemoteEvent", path = "ReplicatedStorage.Remotes.OfferGift", risk = "LOW"},
    {name = "UnequipItems", type = "RemoteEvent", path = "ReplicatedStorage.Remotes.UnequipItems", risk = "LOW"},
    {name = "EquipItem", type = "RemoteFunction", path = "ReplicatedStorage.Remotes.EquipItem", risk = "LOW"},
    {name = "UseItem", type = "RemoteFunction", path = "ReplicatedStorage.Remotes.UseItem", risk = "LOW"}
}

-- اختيار Remote
local selectedRemote = 1
local remoteButtons = {}

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.9, 0, 0, 200)
scrollFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
scrollFrame.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #remotesList * 40)
scrollFrame.Parent = frame

for i, remote in ipairs(remotesList) do
    local btn = Instance.new("TextButton")
    btn.Text = remote.risk .. " | " .. remote.name .. " (" .. remote.type .. ")"
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.Position = UDim2.new(0.025, 0, 0, (i-1)*40)
    btn.BackgroundColor3 = remote.risk == "HIGH" and Color3.fromRGB(200, 50, 50) or
                          remote.risk == "MEDIUM" and Color3.fromRGB(255, 150, 50) or
                          Color3.fromRGB(80, 80, 90)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = scrollFrame
    
    btn.MouseButton1Click:Connect(function()
        selectedRemote = i
        for j, b in pairs(remoteButtons) do
            b.BackgroundColor3 = remotesList[j].risk == "HIGH" and Color3.fromRGB(200, 50, 50) or
                               remotesList[j].risk == "MEDIUM" and Color3.fromRGB(255, 150, 50) or
                               Color3.fromRGB(80, 80, 90)
            b.BorderSizePixel = 0
        end
        btn.BorderSizePixel = 2
        btn.BorderColor3 = Color3.fromRGB(0, 200, 255)
    end)
    
    remoteButtons[i] = btn
end

-- محاكاة ذكية (Smart Fuzzing)
local testMode = Instance.new("TextLabel")
testMode.Text = "🔧 وضع الاختبار: SMART FUZZING"
testMode.Size = UDim2.new(0.9, 0, 0, 25)
testMode.Position = UDim2.new(0.05, 0, 0.65, 0)
testMode.BackgroundTransparency = 1
testMode.TextColor3 = Color3.new(1, 1, 1)
testMode.Font = Enum.Font.SourceSansSemibold
testMode.Parent = frame

-- إعدادات الذكاء
local stealthLevel = Instance.new("TextLabel")
stealthLevel.Text = "👻 مستوى التخفي: HIGH (0.5s delay)"
stealthLevel.Size = UDim2.new(0.9, 0, 0, 25)
stealthLevel.Position = UDim2.new(0.05, 0, 0.7, 0)
stealthLevel.BackgroundTransparency = 1
stealthLevel.TextColor3 = Color3.new(1, 1, 1)
stealthLevel.Font = Enum.Font.SourceSans
stealthLevel.Parent = frame

-- زر الاختبار الذكي
local testBtn = Instance.new("TextButton")
testBtn.Text = "🎯 START SMART TEST"
testBtn.Size = UDim2.new(0.9, 0, 0, 45)
testBtn.Position = UDim2.new(0.05, 0, 0.76, 0)
testBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
testBtn.TextColor3 = Color3.new(1, 1, 1)
testBtn.Font = Enum.Font.SourceSansBold
testBtn.TextSize = 16
testBtn.Parent = frame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "📊 النتائج تظهر هنا..."
resultBox.Size = UDim2.new(0.9, 0, 0, 90)
resultBox.Position = UDim2.new(0.05, 0, 0.88, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.TextXAlignment = Enum.TextXAlignment.Left
resultBox.TextYAlignment = Enum.TextYAlignment.Top
resultBox.Parent = frame

-- دالة الحصول على Remote
local function getRemoteObject(remoteInfo)
    local current = game
    for part in remoteInfo.path:gmatch("[^.]+") do
        current = current:FindFirstChild(part)
        if not current then
            return nil
        end
    end
    return current
end

-- دالة الاختبار الذكية (بدون ضغط)
local function smartTestRemote(remoteInfo)
    local results = {}
    local remote = getRemoteObject(remoteInfo)
    
    if not remote then
        return {"❌ Remote غير موجود: " .. remoteInfo.path}
    end
    
    table.insert(results, "✅ وجدت: " .. remoteInfo.name)
    table.insert(results, "📡 النوع: " .. remoteInfo.type)
    
    -- اختبارات ذكية حسب نوع الـ Remote
    if remoteInfo.name:find("Buy") then
        -- اختبارات شراء
        local testPayloads = {
            {itemId = 1001, price = 0},  -- سعر صفر
            {itemId = 1001, price = 1},  -- سعر وهمي
            {itemId = 999999, price = 100}, -- ID غير موجود
            {playerId = player.UserId, receipt = "FAKE_RECEIPT"}
        }
        
        for i, payload in ipairs(testPayloads) do
            local success, response = pcall(function()
                if remoteInfo.type == "RemoteFunction" then
                    return remote:InvokeServer(payload)
                else
                    remote:FireServer(payload)
                    return "Fired (No Response)"
                end
            end)
            
            table.insert(results, string.format("   Test %d: %s | Response: %s", 
                i, success and "✅" or "❌", 
                tostring(response):sub(1, 50)))
            
            -- تأخير بين المحاولات
            task.wait(0.5)
        end
        
    elseif remoteInfo.name:find("Purchase") then
        -- اختبارات إيصالات
        local fakeReceipt = {
            receiptId = "RECEIPT_TEST_" .. math.random(1000, 9999),
            playerId = player.UserId,
            productId = 123456,
            currency = "ROBUX",
            price = 0,
            timestamp = os.time()
        }
        
        local success, response = pcall(function()
            remote:FireServer(fakeReceipt)
        end)
        
        table.insert(results, "🧾 Test Receipt: " .. (success and "✅ Accepted" or "❌ Rejected"))
        
    elseif remoteInfo.name:find("Gift") or remoteInfo.name:find("Offer") then
        -- اختبارات هدايا
        local giftData = {
            targetPlayer = player.Name,
            itemId = 1001,
            price = 0,
            message = "Test Gift"
        }
        
        local success = pcall(function()
            remote:FireServer(giftData)
        end)
        
        table.insert(results, "🎁 Test Gift: " .. (success and "✅ Sent" or "❌ Failed"))
    end
    
    -- اختبار نهائي (بسيط)
    table.insert(results, "\n🔍 Final Stealth Check...")
    task.wait(0.3)
    
    -- التحقق من عدم وجود كيك
    local antiCheat = workspace:FindFirstChild("AntiCheat") or 
                     game:GetService("ReplicatedStorage"):FindFirstChild("AntiCheat")
    
    if not antiCheat then
        table.insert(results, "👻 No Anti-Cheat Detected")
    else
        table.insert(results, "⚠️ Anti-Cheat System Found")
    end
    
    return results
end

-- تشغيل الاختبار
testBtn.MouseButton1Click:Connect(function()
    local remoteInfo = remotesList[selectedRemote]
    
    if not remoteInfo then
        resultBox.Text = "❌ اختر Remote أولاً"
        return
    end
    
    resultBox.Text = "🕵️‍♂️ بدء الاختبار الذكي...\n"
    resultBox.Text = resultBox.Text .. "🎯 الهدف: " .. remoteInfo.name .. "\n"
    resultBox.Text = resultBox.Text .. "⚠️ الخطورة: " .. remoteInfo.risk .. "\n\n"
    
    task.spawn(function()
        local results = smartTestRemote(remoteInfo)
        resultBox.Text = table.concat(results, "\n")
        
        -- إضافة توصية
        resultBox.Text = resultBox.Text .. "\n\n💡 التوصية: "
        if remoteInfo.risk == "HIGH" then
            resultBox.Text = resultBox.Text .. "فحص كود السيرفر لهذا الـ Remote"
        else
            resultBox.Text = resultBox.Text .. "هذا Remote آمن نسبياً"
        end
    end)
end)

-- زر إغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("======================================")
print("🕵️‍♂️ Stealth Remote Tester Loaded")
print("⚡ Smart Fuzzing Mode: ACTIVE")
print("👻 Stealth Level: HIGH")
print("======================================")
