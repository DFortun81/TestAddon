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
		relativePoint = "BOTTOMRIGHT",
		point = "BOTTOMRIGHT",
		x = 385,
		y = 500,
	};
end

-- Create a Frame and attach an event to it.
local frame = CreateFrame("FRAME", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate");
app.frame = frame;
frame:SetPoint(TestAddonData.relativePoint, TestAddonData.x, TestAddonData.y);
frame:SetSize(640, 640);
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