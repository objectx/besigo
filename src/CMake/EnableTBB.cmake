
function (download_osx_tbb)
    message ("Download TBB into ${CMAKE_CURRENT_BINARY_DIR}")
    set (ARCHIVE "${CMAKE_CURRENT_BINARY_DIR}/${TBB_NAME}.tar.gz")
    if (NOT EXISTS ${ARCHIVE})
        file (DOWNLOAD "https://www.threadingbuildingblocks.org/sites/default/files/software_releases/mac/tbb44_20150728oss_osx.tgz"
                       ${ARCHIVE} SHOW_PROGRESS)
        execute_process (COMMAND "tar" "xzf" ${ARCHIVE})
    endif ()
endfunction ()

if (${APPLE})
    set (TBB_NAME tbb44_20150728oss)
    set (TBB_DIR ${CMAKE_CURRENT_BINARY_DIR}/${TBB_NAME})
    download_osx_tbb ()
else ()
    message (FATAL_ERROR "Sorry, Unsupported platform")
endif ()
