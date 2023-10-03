-- Localization for German Clients.
if GetLocale() ~= "deDE" then return; end

-- App locals
local appName, app = ...;
local L = app.L;

L.HELLO_WORLD = "Hallo Welt!";
--L.ADDON_SUMMARY = "|cffffffffThis is a fancy little addon developed on stream by |cffff0000Crieve|r to help people develop their own addons.|r\n\nNOTE: This is on its own line!";