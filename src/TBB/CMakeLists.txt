
cmake_minimum_required (VERSION 3.3)

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

