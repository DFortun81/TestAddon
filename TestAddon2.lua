--------------------------------------------------------------------------------
--                            T E S T   A D D O N  2                          --
--------------------------------------------------------------------------------
--				   Copyright 2023 Dylan Fortune (Crieve-Sargeras)             --
--------------------------------------------------------------------------------
-- App locals
local appName, app = ...;
local L = app.L;

-- Default Variables
local TestAddonData = _G["TestAddonData"];
if not TestAddonData then
	TestAddonData = {
		relativePoint = "CENTER",
		point = "CENTER",
		x = 0,
		y = 0,
	};
end

-- Create a Frame and attach an event to it.
local frame = CreateFrame("FRAME", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate");
app.frame = frame;
frame:SetPoint(TestAddonData.relativePoint, TestAddonData.x, TestAddonData.y);
frame:SetSize(320, 320);
frame:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 }
});
frame:SetBackdropBorderColor(1, 1, 1, 1);
frame:SetBackdropColor(0, 0, 0, 1);
frame:EnableMouse(true);
frame:SetMovable(true);
frame:RegisterForDrag("LeftButton", "RightButton");
frame:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		self:StartMoving()
	end
end)
frame:SetScript("OnMouseUp", function(self)
	self:StopMovingOrSizing();
	local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
	TestAddonData.relativePoint = relativePoint;
	TestAddonData.point = point;
	TestAddonData.x = xOfs;
	TestAddonData.y = yOfs;
end)

local fontStringObject = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
fontStringObject:SetPoint("TOP", 0, -6);
fontStringObject:SetText(L.HELLO_WORLD);

local fontStringObject2 = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
fontStringObject2:SetPoint("TOP", fontStringObject, "BOTTOM", 0, -6);
fontStringObject2:SetPoint("LEFT", frame, "LEFT", 20, 0);
fontStringObject2:SetPoint("RIGHT", frame, "RIGHT", -20, 0);
fontStringObject2:SetText(L.ADDON_SUMMARY);
fontStringObject2:SetTextColor(1, 0.25, 0.25);

local textureObject = frame:CreateTexture(nil, "ARTWORK");
textureObject:SetTexture("Interface/Addons/TestAddon2/assets/icon_256");
textureObject:SetPoint("TOP", fontStringObject2, "BOTTOM", 0, -6);
textureObject:SetPoint("LEFT", frame, "LEFT", 20, 0);
textureObject:SetPoint("RIGHT", frame, "RIGHT", -20, 0);
textureObject:SetPoint("BOTTOM", frame, "BOTTOM", 0, 20);

-- Register some events
local events = {};
frame:SetScript("OnEvent", function(self, e, ...) (events[e] or print)(e, ...); end);


events.ADDON_LOADED = function(e, addonName)
	if addonName == appName then
		frame:UnregisterEvent("ADDON_LOADED");
		
		local TestAddDataGlobal = _G["TestAddonData"];
		if TestAddDataGlobal then
			local changed = false;
			for key,value in pairs(TestAddDataGlobal) do
				if TestAddonData[key] ~= value then
					TestAddonData[key] = value;
					changed = true;
				end
			end
			_G["TestAddonData"] = TestAddonData;
			if changed then
				frame:ClearAllPoints();
				frame:SetPoint(TestAddonData.point, TestAddonData.x, TestAddonData.y, TestAddonData.relativePoint);
			end
		end
	end
end
frame:RegisterEvent("ADDON_LOADED");