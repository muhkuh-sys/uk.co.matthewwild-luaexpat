local t = ...
local strDistId, strDistVersion, strCpuArch = t:get_platform()
local tResult

if strDistId=='@JONCHKI_PLATFORM_DIST_ID@' and strDistVersion=='@JONCHKI_PLATFORM_DIST_VERSION@' then
  t:install('lua_plugins/lxp.dll',  '${install_lua_cpath}/')
  t:install('lua',                  '${install_lua_path}/')
  tResult = true
end

return tResult
