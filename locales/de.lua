-- Localization for German Clients.
if GetLocale() ~= "deDE" then return; end

-- App locals
local appName, app = ...;
local L = app.L;

L.HELLO_WORLD = "Hallo Welt!";