
cmake_minimum_required (VERSION 3.3)

add_library (embree SHARED IMPORTED GLOBAL)
    if (${WIN32})
        set_target_properties (embree PROPERTIES
            IMPORTED_LOCATION ${EMBREE_DIR}/bin/embree.dll
            IMPORTED_IMPLIB ${EMBREE_DIR}/lib/embree.lib
            INTERFACE_INCLUDE_DIRECTORIES ${EMBREE_DIR}/include)
    elseif (${APPLE})
        set_target_properties (embree PROPERTIES
                IMPORTED_LOCATION ${EMBREE_DIR}/lib/libembree.2.dylib
                INTERFACE_INCLUDE_DIRECTORIES ${EMBREE_DIR}/include)
    endif ()

