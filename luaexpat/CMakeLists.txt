cmake_minimum_required(VERSION 2.8)

PROJECT("luaexpat")

INCLUDE(ExternalProject)

SET(VERSION_EXTERNAL "1.3.0")
SET(VERSION_PACKAGE  "5")
SET(PROJECT_VERSION  "${VERSION_EXTERNAL}.${VERSION_PACKAGE}")

# Get the VCS version for the jonchki configuration.
INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/version.cmake)

# Filter the jonchki configuration.
CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/luaexpat.xml
               ${CMAKE_CURRENT_BINARY_DIR}/lua${BUILDCFG_LUA_VERSION}-luaexpat-${PROJECT_VERSION}.xml
               @ONLY)

#----------------------------------------------------------------------------
#
# Build the project.
#
IF((${BUILDCFG_ONLY_JONCHKI_CFG} STREQUAL "OFF"))
	# Select the LUA version.
	INCLUDE(${CMAKE_HOME_DIRECTORY}/cmake/muhkuh_lua.cmake)

	SET(PRJ_CMAKE_ARGS "")
	LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}")
	LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")
	LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}")
	LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}")
	IF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
		LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_RC_COMPILER=${CMAKE_RC_COMPILER}")
	ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")

	LIST(APPEND PRJ_CMAKE_ARGS "-DLUA_INCLUDE_DIR=${LUA_INCLUDE_DIR}")
	LIST(APPEND PRJ_CMAKE_ARGS "-DLUA_LIBRARIES=${LUA_LIBRARIES}")

	LIST(APPEND PRJ_CMAKE_ARGS "-DLIBEXPAT_INCLUDE_DIRECTORIES=${EXTERNAL_INCLUDE_DIR}")
	LIST(APPEND PRJ_CMAKE_ARGS "-DLIBEXPAT_LIBRARY=${EXTERNAL_LIB_DIR}/libexpat.a")

	IF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
		LIST(APPEND PRJ_CMAKE_ARGS "-DTEST_SCRIPT_FOLDER=${CMAKE_HOME_DIRECTORY}/cmake/tests")
	ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")

	LIST(APPEND PRJ_CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/install")
	LIST(APPEND PRJ_CMAKE_ARGS "-DINSTALL_DIR_LUA_MODULES=${INSTALL_DIR_LUA_MODULES}")
	LIST(APPEND PRJ_CMAKE_ARGS "-DINSTALL_DIR_LUA_SCRIPTS=${INSTALL_DIR_LUA_SCRIPTS}")

	ExternalProject_Add(TARGET_luaexpat
	                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/luaexpat-${VERSION_EXTERNAL}
	                    URL ${CMAKE_CURRENT_SOURCE_DIR}/luaexpat-${VERSION_EXTERNAL}.tar.gz
	                    URL_HASH SHA1=e56bbf2e980ffb3f82629270221bdf98f3bd757b
	                    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/copy_over ${CMAKE_CURRENT_BINARY_DIR}/luaexpat-${VERSION_EXTERNAL}/src/TARGET_luaexpat
	                    CMAKE_ARGS ${PRJ_CMAKE_ARGS}
	                    TEST_BEFORE_INSTALL 1
	                    TEST_COMMAND pwd && ${CMAKE_MAKE_PROGRAM} test
	                    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install
	)

	INSTALL(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/install/lua_plugins/
	        DESTINATION ${INSTALL_DIR_LUA_MODULES})
	INSTALL(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/install/lua/
	        DESTINATION ${INSTALL_DIR_LUA_SCRIPTS})


	#----------------------------------------------------------------------------
	#
	# Build a package for the selected platform.
	#

	SET(CPACK_OUTPUT_FILE_PREFIX ${CMAKE_BINARY_DIR}/../../repository/uk/co/matthewwild/luaexpat/${PROJECT_VERSION})
	SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
	SET(CPACK_PACKAGE_FILE_NAME "lua${BUILDCFG_LUA_VERSION}-luaexpat-${PROJECT_VERSION}-${JONCHKI_PLATFORM}")

	SET(CPACK_GENERATOR "TXZ")
	INCLUDE(CPack)

	# This is the folder where the external project TARGET_bitop installed the files.
	SET(SUB_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/install/lua_plugins")

	IF(${JONCHKI_PLATFORM_DIST_ID} STREQUAL "windows")
		# Package a windows build.

		# All package contents were already processed with "INSTALL".

		CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/install_windows.lua
		               ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		               @ONLY)

		INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		        DESTINATION .)
	ELSE(${JONCHKI_PLATFORM_DIST_ID} STREQUAL "windows")
		# Package a linux build.

		# All package contents were already processed with "INSTALL".

		CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/install_linux.lua
		               ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		               @ONLY)

		INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/package/install.lua
		        DESTINATION .)
	ENDIF(${JONCHKI_PLATFORM_DIST_ID} STREQUAL "windows")

	CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/luaexpat.xml
	               ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-luaexpat-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.xml
	               @ONLY)


	#-----------------------------------------------------------------------------
	#
	# Create a custom target named "pack".
	# It builds the package and creates the hashes.
	#
	ADD_CUSTOM_TARGET(pack
	                  COMMAND ${CMAKE_MAKE_PROGRAM}
	                  COMMAND ${CMAKE_MAKE_PROGRAM} package
	                  COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tools/generate_hash.py ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-luaexpat-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.xml
	                  COMMAND "${PYTHON_EXECUTABLE}" ${CMAKE_HOME_DIRECTORY}/cmake/tools/generate_hash.py ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-luaexpat-${PROJECT_VERSION}-${JONCHKI_PLATFORM}.tar.xz
	                  COMMENT "Pack the artifact and generate the hashes...")


	#-----------------------------------------------------------------------------
	#
	# Filter the pom.xml file.
	#
	SET(POM_ARTIFACT_ID  "lua${BUILDCFG_LUA_VERSION}-luaexpat")
	SET(POM_GROUP_ID     "uk.co.matthewwild")
	SET(POM_VERSION      "${PROJECT_VERSION}")
	SET(POM_PACKAGING    "tar.xz")
	CONFIGURE_FILE(installer/lua${BUILDCFG_LUA_VERSION}/pom.xml
	               ${CPACK_OUTPUT_FILE_PREFIX}/lua${BUILDCFG_LUA_VERSION}-luaexpat-${PROJECT_VERSION}.pom
	               @ONLY)
ENDIF((${BUILDCFG_ONLY_JONCHKI_CFG} STREQUAL "OFF"))
