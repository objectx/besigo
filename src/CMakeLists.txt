
cmake_minimum_required (VERSION 3.3)

project (BESIGO
    LANGUAGES C CXX)

list (INSERT CMAKE_MODULE_PATH 0 ${BESIGO_SOURCE_DIR}/CMake)

include (FindOpenMP)
include (EnableTBB)
include (EnableEmbree)

if (${OPENMP_FOUND})
    add_compile_options (${OpenMP_CXX_FLAGS})
    # list (APPEND CMAKE_EXE_LINKER_FLAGS ${OpenMP_EXE_LINKER_FLAGS} "-fopenmp")
else ()
    message (FATAL_ERROR "Sorry, OpenMP required.")
endif ()

function (setvar_default var_)
    if (NOT DEFINED ${var_})
        set (${var_} ${ARGN} PARENT_SCOPE)
    endif ()
endfunction ()

setvar_default (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
setvar_default (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
setvar_default (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

set (CMAKE_INSTALL_RPATH "@executable_path/")

set (TARGET_NAME "besigo")
set (SOURCE_FILES zmxmlt.cpp stb_image.c)

add_subdirectory (TBB)
add_subdirectory (Embree)

include_directories (${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/include)

add_executable (${TARGET_NAME} ${SOURCE_FILES})
    target_compile_features (${TARGET_NAME} PRIVATE cxx_nonstatic_member_init)
    target_link_libraries (${TARGET_NAME} PRIVATE embree tbb tbbmalloc)

# Fixup dependend DLL pathes
if (${APPLE})
    add_custom_command (TARGET ${TARGET_NAME} POST_BUILD
        COMMAND "install_name_tool"
                "-change" "libembree.2.dylib" "${EMBREE_DIR}/lib/libembree.2.dylib"
                "-change" "@rpath/libtbb.dylib" "${TBB_DIR}/lib/libtbb.dylib"
                "-change" "@rpath/libtbbmalloc.dylib" "${TBB_DIR}/lib/libtbbmalloc.dylib"
                $<TARGET_FILE:${TARGET_NAME}>)
elseif (${WIN32})
    function (get_runtime_dlls var_)
        set (dlls)
        foreach (target_ ${ARGN})
            foreach (typ_ DEBUG RELEASE)
                get_target_property (dll ${target_} "IMPORTED_LOCATION_${typ_}")
                if (EXISTS ${dll})
                    list (APPEND dlls ${dll})
                endif ()
            endforeach ()
            get_target_property (dll ${target_} IMPORTED_LOCATION)
            if (EXISTS ${dll})
                list (APPEND dlls ${dll})
            endif ()
        endforeach ()
        set (${var_} ${dlls} PARENT_SCOPE)
    endfunction ()

    get_runtime_dlls (DLL_LIST tbb tbbmalloc embree)
    message ("DLL_LIST: ${DLL_LIST}")
    file (COPY ${DLL_LIST} DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/Debug)
    file (COPY ${DLL_LIST} DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/Release)
endif ()
