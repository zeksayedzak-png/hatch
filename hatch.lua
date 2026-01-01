-- ⚠️ DIRECT BUTTON HACK - لأغراض اختبارية فقط
-- ⚠️ Use only with explicit permission

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "ButtonHackTool" then
        gui:Destroy()
    end
end

-- الواجهة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ButtonHackTool"
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 300)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Text = "🔴 DIRECT BUTTON HACK"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = mainFrame

-- زر البحث عن الأزرار
local scanBtn = Instance.new("TextButton")
scanBtn.Text = "🔍 SCAN PREMIUM BUTTONS"
scanBtn.Size = UDim2.new(0.9, 0, 0, 40)
scanBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
scanBtn.TextColor3 = Color3.new(1, 1, 1)
scanBtn.Font = Enum.Font.SourceSansBold
scanBtn.Parent = mainFrame

-- زر الهجوم
local attackBtn = Instance.new("TextButton")
attackBtn.Text = "💣 HACK ALL BUTTONS"
attackBtn.Size = UDim2.new(0.9, 0, 0, 40)
attackBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
attackBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
attackBtn.TextColor3 = Color3.new(1, 1, 1)
attackBtn.Font = Enum.Font.SourceSansBold
attackBtn.Parent = mainFrame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "📊 ابحث عن الأزرار أولاً..."
resultBox.Size = UDim2.new(0.9, 0, 0, 120)
resultBox.Position = UDim2.new(0.05, 0, 0.55, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.TextXAlignment = Enum.TextXAlignment.Left
resultBox.TextYAlignment = Enum.TextYAlignment.Top
resultBox.Parent = mainFrame

local foundButtons = {}

-- دالة البحث عن أزرار الشراء
local function findPurchaseButtons()
    resultBox.Text = "🔍 جاري البحث عن أزرار الشراء...\n"
    
    local playerGui = player:WaitForChild("PlayerGui")
    foundButtons = {}
    
    local keywordPatterns = {
        "buy", "purchase", "premium", "gamepass", 
        "shop", "store", "paid", "الشراء", "اشتري"
    }
    
    local function checkButton(button)
        local buttonText = button.Text:lower()
        local buttonName = button.Name:lower()
        
        for _, keyword in ipairs(keywordPatterns) do
            if buttonText:find(keyword) or buttonName:find(keyword) then
                return true
            end
        end
        return false
    end
    
    -- البحث في PlayerGui
    for _, guiObj in pairs(playerGui:GetDescendants()) do
        if guiObj:IsA("TextButton") then
            if checkButton(guiObj) then
                table.insert(foundButtons, {
                    object = guiObj,
                    path = guiObj:GetFullName(),
                    text = guiObj.Text
                })
            end
        end
    end
    
    -- البحث في الأماكن المحددة من التقرير
    local specificPaths = {
        "StarterGui.Main.Menus.Quests.Rewards.Premium.PremiumLocked.Buttons.BuyPremium",
        "StarterGui.Main.Menus.PaidShop.Features.Gamepasses",
        "StarterGui.Main.Menus.PaidShop.Features.ExclusiveEgg_Festive"
    }
    
    for _, path in ipairs(specificPaths) do
        local current = game
        local exists = true
        
        for part in path:gmatch("[^.]+") do
            current = current:FindFirstChild(part)
            if not current then
                exists = false
                break
            end
        end
        
        if exists and current:IsA("GuiButton") then
            table.insert(foundButtons, {
                object = current,
                path = path,
                text = current.Text or "No Text"
            })
        end
    end
    
    resultBox.Text = resultBox.Text .. "✅ وجدت " .. #foundButtons .. " زر شراء:\n"
    
    for i, btnInfo in ipairs(foundButtons) do
        resultBox.Text = resultBox.Text .. i .. ". " .. btnInfo.text .. "\n"
    end
    
    if #foundButtons == 0 then
        resultBox.Text = resultBox.Text .. "❌ ما فيش أزرار شراء!"
    end
end

-- دالة اختراق الأزرار
local function hackAllButtons()
    if #foundButtons == 0 then
        resultBox.Text = "❌ ابحث عن الأزرار أولاً!"
        return
    end
    
    resultBox.Text = "💣 بدء اختراق الأزرار...\n"
    local hackedCount = 0
    
    for i, btnInfo in ipairs(foundButtons) do
        local button = btnInfo.object
        
        resultBox.Text = resultBox.Text .. "\n🔧 معالجة زر: " .. btnInfo.text
        
        -- تعطيل الوظيفة الأصلية
        if getconnections then
            local connections = getconnections(button.MouseButton1Click)
            for _, conn in pairs(connections) do
                pcall(function()
                    conn:Disable()
                    resultBox.Text = resultBox.Text .. "\n   ❌ عطلت وظيفة أصلية"
                end)
            end
        end
        
        -- إضافة وظيفة جديدة
        local newConnection = button.MouseButton1Click:Connect(function()
            resultBox.Text = resultBox.Text .. "\n   ⚡ تم النقر على زر مخترق: " .. btnInfo.text
            
            -- بيانات مزورة للشراء
            local fakeData = {
                type = "HACKED_PURCHASE",
                buttonName = btnInfo.text,
                playerId = player.UserId,
                playerName = player.Name,
                price = 0,
                receipt = "BUTTON_HACK_" .. os.time(),
                timestamp = os.time(),
                hacked = true
            }
            
            -- إرسال لجميع Remotes
            local remoteCount = 0
            for _, remote in pairs(game:GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    pcall(function()
                        remote:FireServer("PURCHASE", fakeData)
                        remote:FireServer("BUTTON_CLICK", fakeData)
                        remoteCount = remoteCount + 1
                    end)
                end
            end
            
            -- إرسال لـ RemoteFunctions
            for _, remote in pairs(game:GetDescendants()) do
                if remote:IsA("RemoteFunction") then
                    pcall(function()
                        remote:InvokeServer("BUY_ITEM", fakeData)
                        remote:InvokeServer("PURCHASE_ITEM", fakeData)
                        remoteCount = remoteCount + 1
                    end)
                end
            end
            
            resultBox.Text = resultBox.Text .. "\n   📤 أرسلت إلى " .. remoteCount .. " Remote"
            
            -- محاولة فتح نافذة الشراء الحقيقية
            task.wait(0.1)
            
            -- البحث عن GamePass ID في نص الزر
            local gamepassId = nil
            local numbers = btnInfo.text:gmatch("%d+")
            for num in numbers do
                if #num >= 6 then  -- GamePass ID عادة طويل
                    gamepassId = tonumber(num)
                    break
                end
            end
            
            if gamepassId then
                pcall(function()
                    local MarketplaceService = game:GetService("MarketplaceService")
                    MarketplaceService:PromptGamePassPurchase(player, gamepassId)
                    resultBox.Text = resultBox.Text .. "\n   🛒 فتحت شراء GamePass: " .. gamepassId
                end)
            end
        end)
        
        -- حفظ الـ Connection للتعديل لاحقاً
        button:SetAttribute("HackedConnection", newConnection)
        
        hackedCount = hackedCount + 1
        resultBox.Text = resultBox.Text .. "\n✅ زر مخترق: " .. btnInfo.text .. "\n"
        
        task.wait(0.2)  -- تأخير بين الأزرار
    end
    
    resultBox.Text = resultBox.Text .. "\n🎯 الانتهاء! " .. hackedCount .. "/" .. #foundButtons .. " أزرار مخترقة"
    
    -- إضافة زر للاختبار التلقائي
    local autoTestBtn = Instance.new("TextButton")
    autoTestBtn.Text = "🔄 TEST ALL BUTTONS"
    autoTestBtn.Size = UDim2.new(0.9, 0, 0, 35)
    autoTestBtn.Position = UDim2.new(0.05, 0, 1.1, 0)
    autoTestBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    autoTestBtn.TextColor3 = Color3.new(1, 1, 1)
    autoTestBtn.Parent = mainFrame
    
    autoTestBtn.MouseButton1Click:Connect(function()
        resultBox.Text = "🔄 جاري النقر على جميع الأزرار...\n"
        for i, btnInfo in ipairs(foundButtons) do
            pcall(function()
                btnInfo.object:Fire("click")
                resultBox.Text = resultBox.Text .. i .. ". نقرت على: " .. btnInfo.text .. "\n"
            end)
            task.wait(0.5)  -- تأخير طويل لتجنب الضغط
        end
        resultBox.Text = resultBox.Text .. "\n✅ انتهى الاختبار التلقائي"
    end)
end

-- الأحداث
scanBtn.MouseButton1Click:Connect(findPurchaseButtons)
attackBtn.MouseButton1Click:Connect(hackAllButtons)

-- زر الإغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

print("========================================")
print("🔴 DIRECT BUTTON HACK TOOL LOADED")
print("🎯 Targets: Premium/Gamepass/Purchase Buttons")
print("⚠️  USE RESPONSIBLY - FOR SECURITY TESTING")
print("========================================")
