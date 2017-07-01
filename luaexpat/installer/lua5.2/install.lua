local t = ...
local strDistId, strDistVersion, strCpuArch = t:get_platform()
local tResult

if strDistId=='windows' then
  if strCpuArch=='x86' then
    t:install('windows_x86/lua_plugins/lxp.dll',           '${install_lua_cpath}/')
    t:install('windows_x86/lua',                           '${install_lua_path}/')
    tResult = true
  elseif strCpuArch=='x86_64' then
    t:install('windows_x86_64/lua_plugins/lxp.dll',        '${install_lua_cpath}/')
    t:install('windows_x86_64/lua',                        '${install_lua_path}/')
    tResult = true
  end

elseif strDistId=='ubuntu' then
  if strDistVersion=='14.04' then
    if strCpuArch=='x86' then
      t:install('ubuntu_1404_x86/lua_plugins/lxp.so',      '${install_lua_cpath}/')
      t:install('ubuntu_1404_x86/lua',                     '${install_lua_path}/')
      tResult = true
    elseif strCpuArch=='x86_64' then
      t:install('ubuntu_1404_x86_64/lua_plugins/lxp.so',   '${install_lua_cpath}/')
      t:install('ubuntu_1404_x86_64/lua',                  '${install_lua_path}/')
      tResult = true
    end

  elseif strDistVersion=='16.04' then
    if strCpuArch=='x86' then
      t:install('ubuntu_1604_x86/lua_plugins/lxp.so',      '${install_lua_cpath}/')
      t:install('ubuntu_1604_x86/lua',                     '${install_lua_path}/')
      tResult = true
    elseif strCpuArch=='x86_64' then
      t:install('ubuntu_1604_x86_64/lua_plugins/lxp.so',   '${install_lua_cpath}/')
      t:install('ubuntu_1604_x86_64/lua',                  '${install_lua_path}/')
      tResult = true
    end

  elseif strDistVersion=='16.10' then
    if strCpuArch=='x86' then
      t:install('ubuntu_1610_x86/lua_plugins/lxp.so',      '${install_lua_cpath}/')
      t:install('ubuntu_1610_x86/lua',                     '${install_lua_path}/')
      tResult = true
    elseif strCpuArch=='x86_64' then
      t:install('ubuntu_1610_x86_64/lua_plugins/lxp.so',   '${install_lua_cpath}/')
      t:install('ubuntu_1610_x86_64/lua',                  '${install_lua_path}/')
      tResult = true
    end

  elseif strDistVersion=='17.04' then
    if strCpuArch=='x86' then
      t:install('ubuntu_1704_x86/lua_plugins/lxp.so',      '${install_lua_cpath}/')
      t:install('ubuntu_1704_x86/lua',                     '${install_lua_path}/')
      tResult = true
    elseif strCpuArch=='x86_64' then
      t:install('ubuntu_1704_x86_64/lua_plugins/lxp.so',   '${install_lua_cpath}/')
      t:install('ubuntu_1704_x86_64/lua',                  '${install_lua_path}/')
      tResult = true
    end
  end
end

return tResult
