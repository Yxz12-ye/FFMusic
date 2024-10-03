cmake_minimum_required(VERSION 3.16)

project(FFMusic VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

find_package(Qt6 REQUIRED COMPONENTS Multimedia)

find_package(Qt6 REQUIRED COMPONENTS Quick Multimedia)

#find_package(Qt6 REQUIRED COMPONENTS Quick Timer)

qt_standard_project_setup(REQUIRES 6.5)

set(QML_IMPORT_PATH "${CMAKE_INSTALL_PREFIX}")

set(CMAKE_AUTORCC ON)


qt_add_executable(appFFMusic
    main.cpp src.qrc
)

qt_add_qml_module(appFFMusic
    URI FFMusic
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES readdata.h readdata.cpp
        QML_FILES PlayLogic.qml
        QML_FILES Volume.qml
        RESOURCES src.qrc
        SOURCES getalbumimg.h getalbumimg.cpp

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appFFMusic PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appFFMusic
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    QT_QML_IMPORT_PATH "${PROJECT_SOURCE_DIR}"
)

target_link_libraries(appFFMusic
    PRIVATE Qt6::Quick
    Qt6::Core
    Qt6::Qml
    Qt6::Multimedia

)

include(GNUInstallDirs)
install(TARGETS appFFMusic
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
