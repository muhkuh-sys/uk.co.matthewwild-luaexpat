cmake_minimum_required(VERSION 2.8)

PROJECT("expat")

INCLUDE(ExternalProject)


SET(VERSION_EXTERNAL "2.2.0")


#----------------------------------------------------------------------------
#
# Build the project for the target architecture.
#
# This static library will be linked with a shared object later. Add "-fPIC" on GCC systems or X64 builds break.
IF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU"  AND  "${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
	SET(LOCAL_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")
ELSE("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU"  AND  "${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
	SET(LOCAL_C_FLAGS "${CMAKE_C_FLAGS}")
ENDIF("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU"  AND  "${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")


SET(EXPAT_CMAKE_ARGS "")
LIST(APPEND EXPAT_CMAKE_ARGS "-DBUILD_tools=OFF")
LIST(APPEND EXPAT_CMAKE_ARGS "-DBUILD_examples=OFF")
LIST(APPEND EXPAT_CMAKE_ARGS "-DBUILD_tests=OFF")
LIST(APPEND EXPAT_CMAKE_ARGS "-DBUILD_shared=OFF")
LIST(APPEND EXPAT_CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=install")
LIST(APPEND EXPAT_CMAKE_ARGS "-DCMAKE_C_FLAGS=${LOCAL_C_FLAGS}")
LIST(APPEND EXPAT_CMAKE_ARGS "-DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")
LIST(APPEND EXPAT_CMAKE_ARGS "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}")
LIST(APPEND EXPAT_CMAKE_ARGS "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}")
IF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	LIST(APPEND EXPAT_CMAKE_ARGS "-DCMAKE_RC_COMPILER=${CMAKE_RC_COMPILER}")
ENDIF(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")

ExternalProject_Add(TARGET_expat
                    PREFIX ${CMAKE_CURRENT_BINARY_DIR}/expat-${VERSION_EXTERNAL}
                    URL ${CMAKE_CURRENT_SOURCE_DIR}/expat-${VERSION_EXTERNAL}.tar.bz2
                    URL_HASH SHA1=8453bc52324be4c796fd38742ec48470eef358b3
                    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_BINARY_DIR}/expat-${VERSION_EXTERNAL}/src/TARGET_expat/doc ${CMAKE_CURRENT_BINARY_DIR}/expat-${VERSION_EXTERNAL}/src/TARGET_expat-build/doc
                    CMAKE_ARGS ${EXPAT_CMAKE_ARGS}
                    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install
)



# 3) Provide all variables for the build.
SET(LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/expat-${VERSION_EXTERNAL}/src/TARGET_expat-build/install/lib/libexpat.a)
SET(INCLUDE_DIRECTORIES ${CMAKE_CURRENT_BINARY_DIR}/expat-${VERSION_EXTERNAL}/src/TARGET_expat-build/install/include)

#----------------------------------------------------------------------------
#
# Create an imported library target.
#
SET(LIBEXPAT_LIBRARY              ${LIBRARY}              CACHE INTERNAL "The expat library with the complete path.")
SET(LIBEXPAT_INCLUDE_DIRECTORIES  ${INCLUDE_DIRECTORIES}  CACHE INTERNAL "The include folders for the library headers. The list must be separated with whitespace.")
