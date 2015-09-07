
cmake_minimum_required (VERSION 3.3)

if (${APPLE})
    add_library (tbbmalloc SHARED IMPORTED GLOBAL)
        set_target_properties (tbbmalloc PROPERTIES
            IMPORTED_LOCATION_RELEASE ${TBB_DIR}/lib/libtbbmalloc.dylib
            IMPORTED_LOCATION_DEBUG ${TBB_DIR}/lib/tbbmalloc_debug.dylib
            INTERFACE_INCLUDE_DIRECTORIES ${TBB_DIR}/include)

    add_library (tbb SHARED IMPORTED GLOBAL)
        set_target_properties (tbb PROPERTIES
            IMPORTED_LOCATION_RELEASE ${TBB_DIR}/lib/libtbb.dylib
            IMPORTED_LOCATION_DEBUG ${TBB_DIR}/lib/libtbb_debug.dylib
            INTERFACE_INCLUDE_DIRECTORIES ${TBB_DIR}/include
            IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE ${TBB_DIR}/libtbbmalloc.dylib
            IMPORTED_LINK_DEPENDENT_LIBRARIES_DEBUG ${TBB_DIR}/libtbbmalloc_debug.dylib)
elseif (${WIN32})
    message ("Config: ${CONFIGURATION}")
    add_library (tbbmalloc SHARED IMPORTED GLOBAL)
        set_target_properties (tbbmalloc PROPERTIES
            IMPORTED_IMPLIB_RELEASE   ${TBB_DIR}/lib/intel64/vc12/tbbmalloc.lib
            IMPORTED_LOCATION_RELEASE ${TBB_DIR}/bin/intel64/vc12/tbbmalloc.dll
            IMPORTED_IMPLIB_DEBUG   ${TBB_DIR}/lib/intel64/vc12/tbbmalloc_debug.lib
            IMPORTED_LOCATION_DEBUG ${TBB_DIR}/bin/intel64/vc12/tbbmalloc_debug.dll
            INTERFACE_INCLUDE_DIRECTORIES ${TBB_DIR}/include)

    add_library (tbb SHARED IMPORTED GLOBAL)
        set_target_properties (tbb PROPERTIES
            # IMPORTED_IMPLIB ${TBB_DIR}/lib/intel64/vc12/tbb.lib
            # IMPORTED_LOCATION ${TBB_DIR}/bin/intel64/vc12/tbb.dll
            IMPORTED_IMPLIB_RELEASE   ${TBB_DIR}/lib/intel64/vc12/tbb.lib
            IMPORTED_LOCATION_RELEASE ${TBB_DIR}/bin/intel64/vc12/tbb.dll
            IMPORTED_IMPLIB_DEBUG   ${TBB_DIR}/lib/intel64/vc12/tbb_debug.lib
            IMPORTED_LOCATION_DEBUG ${TBB_DIR}/bin/intel64/vc12/tbb_debug.dll
            INTERFACE_INCLUDE_DIRECTORIES ${TBB_DIR}/include)
endif ()
