local GetWoWVersion = ((select(4, GetBuildInfo())))
local ModelFrame_Model1
local ModelFrame_Model2
local ModelFramePlayer = CreateFrame("Frame", "$parentModelFramePlayer", PlayerFrame)
local ModelFrameTarget = CreateFrame("Frame", "$parentModelFrameTarget", TargetFrame)
local uiChanged
local APP_borderplayer
local APP_bordertarget


local function loadmodelPlayer()
    if (GetWoWVersion > 100000) then
        ModelFramePlayer:SetAllPoints(PlayerFrame.PlayerFrameContainer.PlayerPortrait)
        PlayerName:SetPoint("TOPLEFT", PlayerFrame.PlayerFrameContent.PlayerFrameContentMain, "TOPLEFT", 95, -26)
    else
        ModelFramePlayer:SetAllPoints(PlayerPortrait)
    end
    ModelFramePlayer:SetWidth(56)
    ModelFramePlayer:SetHeight(56)
    ModelFramePlayer:SetAlpha(1)
    if GetWoWVersion > 100000 then
        ModelFramePlayer:SetFrameStrata("LOW")
    else
        ModelFramePlayer:SetFrameStrata("MEDIUM")
    end

    if ModelFrame_Model1 == nil then
        ModelFrame_Model1 = CreateFrame("PlayerModel", "$parentModelFrame_Model1", ModelFramePlayer)
        --ModelFrame_Model1:ClearModel()
        ModelFrame_Model1:SetUnit("player")
        ModelFrame_Model1:SetAllPoints(ModelFramePlayer)
        ModelFrame_Model1:SetCustomCamera(0)
        ModelFrame_Model1:SetPortraitZoom(1)

        -- Create a texture and overlay it on the model frame
        local overlay = ModelFrame_Model1:CreateTexture(nil, "BACKGROUND")
        overlay:SetTexture("Interface\\Addons\\AnimatedProfilePicture\\textures\\tempback")
        overlay:SetAllPoints(ModelFrame_Model1)
        overlay:SetBlendMode("ALPHAKEY")
        if GetWoWVersion > 100000 then
            PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetAlpha(0)
            --PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetScale(1.03) -- weird scale to match target
            PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetScale(1)
            PlayerFrameModelFramePlayerModelFrame_Model1:SetPoint("TOPLEFT", PlayerFrameModelFramePlayer, "TOPLEFT", 0, 0)
        else
            PlayerPortrait:SetAlpha(0)
        end

        -- Create a border texture
        APP_borderplayer = ModelFrame_Model1:CreateTexture(nil, "OVERLAY")
        APP_borderplayer:SetTexture("Interface\\Addons\\AnimatedProfilePicture\\textures\\border")  -- Set this to your border texture
        APP_borderplayer:SetAllPoints(ModelFrame_Model1)
        APP_borderplayer:SetPoint("TOPLEFT", -2, 2)  -- Adjust these values to position the border correctly
        APP_borderplayer:SetPoint("BOTTOMRIGHT", 2, -2)  -- Adjust these values to position the border correctly
        uiChanged = false
    elseif uiChanged == true then
        --ModelFrame_Model1:ClearModel()
        ModelFrame_Model1:SetUnit("player")
        ModelFrame_Model1:SetAllPoints(ModelFramePlayer)
        uiChanged = false
    end
end

-- Combat Color Change
local function UpdateBorderColor(inCombat)
    if inCombat then
        APP_borderplayer:SetVertexColor(1, 0, 0)
        APP_bordertarget:SetVertexColor(1, 0, 0)
    else
        APP_borderplayer:SetVertexColor(1, 1, 0)
        APP_bordertarget:SetVertexColor(1, 1, 0)
    end
end    

-- Events in Combat
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED") -- In combat
eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- Out of combat
eventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        UpdateBorderColor(true)
    elseif event == "PLAYER_REGEN_ENABLED" then
        UpdateBorderColor(false)
    end
end)

local function loadmodelTarget()
    if (GetWoWVersion > 100000) then
        ModelFrameTarget:SetAllPoints(TargetFrame.TargetFrameContainer.Portrait)
        TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar:SetFrameLevel(9)
        TargetFrame.TargetFrameContent.TargetFrameContentMain.ManaBar:SetFrameLevel(9)
        TargetFrame.TargetFrameContent.TargetFrameContentMain:SetFrameLevel(9)
        TargetFrame.TargetFrameContent.TargetFrameContentContextual:SetFrameLevel(10000)
        TargetFrame.TargetFrameContainer:SetFrameLevel(9998)
        TargetFrame.TargetFrameContainer.Portrait:SetAlpha(0)
        TargetFrame.TargetFrameContainer:SetFrameLevel(1)
        local bossrare = TargetFrame:CreateTexture(nil, "OVERLAY")
        bossrare:SetTexture("Interface\\Addons\\AnimatedProfilePicture\\textures\\UIUnitFrameBoss2x")
        bossrare:SetAllPoints(ModelFrameTarget)
    else
        ModelFrameTarget:SetAllPoints(TargetFramePortrait)
    end
    ModelFrameTarget:SetWidth(56)
    ModelFrameTarget:SetHeight(56)
    ModelFrameTarget:SetAlpha(1)
    ModelFrameTarget:SetFrameStrata("LOW")
    TargetFrameToT:SetFrameStrata("HIGH")

    if ModelFrame_Model2 == nil then
        ModelFrame_Model2 = CreateFrame("PlayerModel", "$parentModelFrame_Model2", ModelFrameTarget)
        ModelFrame_Model2:SetUnit("target")
        ModelFrame_Model2:SetAllPoints(ModelFrameTarget)
        ModelFrame_Model2:SetCustomCamera(0)
        ModelFrame_Model2:SetPortraitZoom(1)

        -- Create a texture and overlay it on the model frame
        local overlay = ModelFrame_Model2:CreateTexture(nil, "BACKGROUND")
        overlay:SetTexture("Interface\\Addons\\AnimatedProfilePicture\\textures\\tempback")
        overlay:SetAllPoints(ModelFrame_Model2)
        overlay:SetBlendMode("ALPHAKEY")
        if GetWoWVersion > 100000 then
            TargetFrame.TargetFrameContainer.Portrait:SetAlpha(0)
            --TargetFrame.TargetFrameContainer.Portrait:SetScale(1.1) -- weird scale that works
            TargetFrameModelFrameTargetModelFrame_Model2:SetPoint("TOPRIGHT", TargetFrameModelFrameTarget, "TOPRIGHT", 5, 0)
            TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar.RightText:SetPoint("RIGHT", TargetFrame.TargetFrameContent.TargetFrameContentMain.HealthBarsContainer.HealthBar, "RIGHT", -10, 0)
            --TargetFrame.TargetFrameContainer:SetAlpha(0.2)
        else
            TargetFrameTextureFramePVPIcon:SetAlpha(0)
            TargetFramePortrait:SetAlpha(0)
        end
        -- Create a border texture
        APP_bordertarget = ModelFrame_Model2:CreateTexture(nil, "OVERLAY")
        APP_bordertarget:SetTexture("Interface\\Addons\\AnimatedProfilePicture\\textures\\border")  -- Set this to your border texture
        APP_bordertarget:SetAllPoints(ModelFrame_Model2)
        APP_bordertarget:SetPoint("TOPLEFT", -1, 2)  -- Adjust these values to position the border correctly
        APP_bordertarget:SetPoint("BOTTOMRIGHT", 2, -1)  -- Adjust these values to position the border correctly
        uiChanged = false
    elseif uiChanged == true then
        --ModelFrame_Model2:ClearModel()
        ModelFrame_Model2:SetUnit("target")
        ModelFrame_Model2:SetAllPoints(ModelFrameTarget)
        uiChanged = false
    end
end

-- Add an event listener for the "PLAYER_TARGET_CHANGED" event
ModelFrameTarget:RegisterEvent("PLAYER_TARGET_CHANGED")
ModelFrameTarget:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_TARGET_CHANGED" then
        --ModelFrame_Model2:ClearModel()
        if ModelFrame_Model2 then
            ModelFrame_Model2:SetUnit("target")
        end
    end
end)

local UIplayer = CreateFrame("Frame", nil, nil)
UIplayer:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
UIplayer:SetScript("OnEvent", function(self, event, ...)
    if event == "UNIT_MODEL_CHANGED" then
        loadmodelPlayer()
    end
end)

local UIchanged = CreateFrame("Frame", nil, nil)
UIchanged:RegisterEvent("UI_SCALE_CHANGED")
UIchanged:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE", "player")
UIchanged:SetScript("OnEvent", function(self, event, ...)
    if event == "UI_SCALE_CHANGED" or event == "UNIT_PORTRAIT_UPDATE" then
        C_Timer.After(1, loadmodelPlayer)
        C_Timer.After(1, loadmodelTarget)
        uiChanged = true
    end
end)

local UILoad = CreateFrame("Frame", nil, nil)
UILoad:RegisterEvent("PLAYER_ENTERING_WORLD")
UILoad:RegisterEvent("PLAYER_LOGIN")
UILoad:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(1, loadmodelPlayer)
        C_Timer.After(1, loadmodelTarget)
    end
end)

-- First Reload Frame
local dialogFrameTextureBorder  = "Interface\\DialogFrame\\UI-DialogBox-Background"
-- ReloadFrameFirstFrame
local ReloadFrameFirstFrame = CreateFrame("Frame", "ReloadFrameFirstFrame", UIParent)
ReloadFrameFirstFrame:Hide()
ReloadFrameFirstFrame:SetWidth(GetScreenWidth())
ReloadFrameFirstFrame:SetHeight(GetScreenHeight())
ReloadFrameFirstFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
ReloadFrameFirstFrame:EnableMouse(true)
ReloadFrameFirstFrame:SetFrameStrata("HIGH")
ReloadFrameFirstFrame.text = ReloadFrameFirstFrame.text or ReloadFrameFirstFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
ReloadFrameFirstFrame.text:SetScale(5)
ReloadFrameFirstFrame.text:SetAllPoints(true)
ReloadFrameFirstFrame.text:SetPoint("CENTER")
ReloadFrameFirstFrame.text:SetText("A reload it's necessary!\nClick here!")
----------------------------------------------------
local ReloadFrameFirstFrameBorder = ReloadFrameFirstFrame:CreateTexture(nil, "BACKGROUND")
ReloadFrameFirstFrameBorder:SetTexture(dialogFrameTextureBorder)
ReloadFrameFirstFrameBorder:SetPoint("TOPLEFT", -3, 3)
ReloadFrameFirstFrameBorder:SetPoint("BOTTOMRIGHT", 3, -3)
--ReloadFrameFirstFrameBorder:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = ReloadFrameFirstFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture(dialogFrameTextureBorder)
BorderBody:SetAllPoints(ReloadFrameFirstFrame)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = ReloadFrameFirstFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture(dialogFrameTextureBorder)
Texture:SetAllPoints(ReloadFrameFirstFrame)
ReloadFrameFirstFrame.texture = Texture
----------------------------------------------------
local CloseButton = CreateFrame("Button", "$parentFrameButton", ReloadFrameFirstFrame, "UIPanelButtonTemplate")
CloseButton:SetHeight(40)
CloseButton:SetWidth(40)
CloseButton:SetPoint("TOPRIGHT", ReloadFrameFirstFrame, "TOPRIGHT", 0, 0)
CloseButton:SetText("x")
----------------------------------------------------
local BorderCloseButton = CloseButton:CreateTexture(nil, "ARTWORK")
BorderCloseButton:SetTexture(dialogFrameTextureBorder)
BorderCloseButton:SetAllPoints(CloseButton)
CloseButton:SetScript("OnClick", function()
    ReloadFrameFirstFrame:Hide()
    ReloadFrame:Show()
end)
----------------------------------------------------
local FrameButton = CreateFrame("Button", "$parentFrameButton", ReloadFrameFirstFrame, "UIPanelButtonTemplate")
FrameButton:SetHeight(GetScreenHeight())
FrameButton:SetWidth(GetScreenWidth())
FrameButton:SetPoint("CENTER", ReloadFrameFirstFrame, "CENTER", 0, 0)
FrameButton:SetAlpha(0)
FrameButton:SetScript("OnClick", function()
    UIFrameFadeIn(ReloadFrameFirstFrame, 1, 1, 0)
    C_Timer.After(1, function()
        ReloadFrameFirstFrame:Hide()
        UIFrameFadeIn(ReloadFrame, 1, 0, 1)
    end)
end)

local ReloadFrame = CreateFrame("Frame", "ReloadFrame", UIParent)
ReloadFrame:Hide()
ReloadFrame:SetWidth(GetScreenWidth())
ReloadFrame:SetHeight(GetScreenHeight())
ReloadFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
ReloadFrame:EnableMouse(false)
ReloadFrame:SetFrameStrata("HIGH")
ReloadFrame.text = ReloadFrame.text or ReloadFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
ReloadFrame.text:SetScale(3)
ReloadFrame.text:SetAllPoints()
ReloadFrame.text:SetText("Let's save the variables and prepare the interface for the first use.\n"
.."To do this, click on the screen or just reload the UI /reload.")
----------------------------------------------------
local ReloadBorder = ReloadFrame:CreateTexture(nil, "BACKGROUND")
ReloadBorder:SetTexture(dialogFrameTextureBorder)
ReloadBorder:SetPoint("TOPLEFT", -3, 3)
ReloadBorder:SetPoint("BOTTOMRIGHT", 3, -3)
--ReloadBorder:SetVertexColor(0.2, 0.2, 0.2, 0.6)
----------------------------------------------------
local BorderBody = ReloadFrame:CreateTexture(nil, "ARTWORK")
BorderBody:SetTexture(dialogFrameTextureBorder)
BorderBody:SetAllPoints(ReloadFrame)
BorderBody:SetVertexColor(0.34, 0.34, 0.34, 0.7)
----------------------------------------------------
local Texture = ReloadFrame:CreateTexture(nil, "BACKGROUND")
Texture:SetTexture(dialogFrameTextureBorder)
Texture:SetAllPoints(ReloadFrame)
ReloadFrame.texture = Texture
-- Close and reload
local f = CreateFrame("Frame", nil)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function() 
    local FrameButtonConfirm = CreateFrame("Button","$parentFrameButtonConfirm", ReloadFrame, "UIPanelButtonTemplate")
    FrameButtonConfirm:SetHeight(48)
    FrameButtonConfirm:SetWidth(120)
    FrameButtonConfirm:SetPoint("CENTER", ReloadFrame, "CENTER", 0, -80)
    FrameButtonConfirm.text = FrameButtonConfirm.text or FrameButtonConfirm:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
    --FrameButtonConfirm.text:SetFont(globalFont, 14)
    FrameButtonConfirm.text:SetScale(1.4)
    FrameButtonConfirm.text:SetPoint("CENTER", FrameButtonConfirm, "CENTER", 0, 0)
    FrameButtonConfirm.text:SetText("Confirm")
    FrameButtonConfirm:SetScript("OnClick", function()
        ReloadFrame:Hide()
        ReloadUI()
    end)
end)

-- Start Function
local function ReloadStart()
    ReloadFrameFirstFrame:Show()
end
--Save
local ReloadUISave = CreateFrame("Frame")
ReloadUISave:RegisterEvent("ADDON_LOADED")
ReloadUISave:RegisterEvent("PLAYER_LOGOUT")
ReloadUISave:SetScript("OnEvent", function(self, event, arg1)
    if (event == "ADDON_LOADED" and arg1 == "AnimatedProfilePicture") then
        if (ReloadCount == nil) then
            ReloadCount = 0
        end
        if (ReloadUIProfile == nil) then
            ReloadCount = ReloadCount + 1
            ReloadStart()
        else
            ReloadFrameFirstFrame:Hide()
        end
    elseif (event == "PLAYER_LOGOUT") then
        ReloadUIProfile = time()
    else
        return nil
    end
end)