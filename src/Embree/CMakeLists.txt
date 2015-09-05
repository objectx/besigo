
cmake_minimum_required (VERSION 3.3)

add_library (embree SHARED IMPORTED GLOBAL)
    set_target_properties (embree PROPERTIES
        IMPORTED_LOCATION ${EMBREE_DIR}/lib/libembree.2.dylib
        IMPORTED_SONAME "@executable_path/libembree.2.dylib"
        INTERFACE_INCLUDE_DIRECTORIES ${EMBREE_DIR}/include)
