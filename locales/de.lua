-- Localization for German Clients.
if GetLocale() ~= "deDE" then return; end

-- App locals
local appName, app = ...;
local L = app.L;

L.HELLO_WORLD = "Hallo Welt!";
L.ADDON_SUMMARY = "|cffffffffDies ist ein schickes kleines Add-on, das von |cffff0000Crieve|r im Stream entwickelt wurde, um Leuten bei der Entwicklung ihrer eigenen Add-ons zu helfen. |r\n\nHINWEIS: Dies ist eine eigene Zeile!";

