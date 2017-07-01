CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

PROJECT("uk.co.matthewwild-lua5.2-luaexpat")

INCLUDE(../../../cmake/version.cmake)

SET(INSTALL_WINDOWS_X86        "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/windows_x86")
SET(INSTALL_WINDOWS_X86_64     "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/windows_x86_64")
SET(INSTALL_UBUNTU_1404_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1404_x86")
SET(INSTALL_UBUNTU_1404_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1404_x86_64")
SET(INSTALL_UBUNTU_1604_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1604_x86")
SET(INSTALL_UBUNTU_1604_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1604_x86_64")
SET(INSTALL_UBUNTU_1610_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1610_x86")
SET(INSTALL_UBUNTU_1610_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1610_x86_64")
SET(INSTALL_UBUNTU_1704_X86    "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1704_x86")
SET(INSTALL_UBUNTU_1704_X86_64 "${CMAKE_CURRENT_SOURCE_DIR}/../../../build/lua5.2/ubuntu_1704_x86_64")

# Get the project version. All installation folders should have the same.
INCLUDE(${INSTALL_WINDOWS_X86}/uk.co.matthewwild-luaexpat.version)
SET(PROJECT_VERSION ${uk.co.matthewwild-luaexpat_VERSION})

SET(CPACK_OUTPUT_FILE_PREFIX targets/jonchki/repository/uk/co/matthewwild/luaexpat/${PROJECT_VERSION})
SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
SET(CPACK_PACKAGE_FILE_NAME "lua5.2-luaexpat-${PROJECT_VERSION}")

SET(CPACK_GENERATOR "TXZ")
INCLUDE(CPack)


#-----------------------------------------------------------------------------
#
# Install all files.
#

# Windows 32bit
INSTALL(FILES ${INSTALL_WINDOWS_X86}/lua_plugins/lxp.dll
        DESTINATION windows_x86/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_WINDOWS_X86}/lua/
        DESTINATION windows_x86/lua)

# Windows 64bit
INSTALL(FILES ${INSTALL_WINDOWS_X86_64}/lua_plugins/lxp.dll
        DESTINATION windows_x86_64/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_WINDOWS_X86_64}/lua/
        DESTINATION windows_x86_64/lua)

# Ubuntu 14.04 32bit
INSTALL(FILES ${INSTALL_UBUNTU_1404_X86}/lua_plugins/lxp.so
        DESTINATION ubuntu_1404_x86/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1404_X86}/lua/
        DESTINATION ubuntu_1404_x86/lua)

# Ubuntu 14.04 64bit
INSTALL(FILES ${INSTALL_UBUNTU_1404_X86_64}/lua_plugins/lxp.so
        DESTINATION ubuntu_1404_x86_64/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1404_X86_64}/lua/
        DESTINATION ubuntu_1404_x86_64/lua)

# Ubuntu 16.04 32bit
INSTALL(FILES ${INSTALL_UBUNTU_1604_X86}/lua_plugins/lxp.so
        DESTINATION ubuntu_1604_x86/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1604_X86}/lua/
        DESTINATION ubuntu_1604_x86/lua)

# Ubuntu 16.04 64bit
INSTALL(FILES ${INSTALL_UBUNTU_1604_X86_64}/lua_plugins/lxp.so
        DESTINATION ubuntu_1604_x86_64/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1604_X86_64}/lua/
        DESTINATION ubuntu_1604_x86_64/lua)

# Ubuntu 16.10 32bit
INSTALL(FILES ${INSTALL_UBUNTU_1610_X86}/lua_plugins/lxp.so
        DESTINATION ubuntu_1610_x86/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1610_X86}/lua/
        DESTINATION ubuntu_1610_x86/lua)

# Ubuntu 16.10 64bit
INSTALL(FILES ${INSTALL_UBUNTU_1610_X86_64}/lua_plugins/lxp.so
        DESTINATION ubuntu_1610_x86_64/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1610_X86_64}/lua/
        DESTINATION ubuntu_1610_x86_64/lua)

# Ubuntu 17.04 32bit
INSTALL(FILES ${INSTALL_UBUNTU_1704_X86}/lua_plugins/lxp.so
        DESTINATION ubuntu_1704_x86/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1704_X86}/lua/
        DESTINATION ubuntu_1704_x86/lua)

# Ubuntu 17.04 64bit
INSTALL(FILES ${INSTALL_UBUNTU_1704_X86_64}/lua_plugins/lxp.so
        DESTINATION ubuntu_1704_x86_64/lua_plugins)
INSTALL(DIRECTORY ${INSTALL_UBUNTU_1704_X86_64}/lua/
        DESTINATION ubuntu_1704_x86_64/lua)


#-----------------------------------------------------------------------------

INSTALL(FILES install.lua
        DESTINATION .)


CONFIGURE_FILE(luaexpat.xml
               ${CPACK_OUTPUT_FILE_PREFIX}/lua5.2-luaexpat-${PROJECT_VERSION}.xml
               @ONLY)


#-----------------------------------------------------------------------------
#
# Filter the pom.xml file.
#
SET(POM_ARTIFACT_ID  "lua5.2-luaexpat")
SET(POM_GROUP_ID     "uk.co.matthewwild")
SET(POM_VERSION      "${PROJECT_VERSION}")
SET(POM_PACKAGING    "tar.xz")
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/pom.xml ${CPACK_OUTPUT_FILE_PREFIX}/pom.xml)
