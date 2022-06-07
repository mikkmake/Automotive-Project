cmake_minimum_required(VERSION 3.16)

project(SpaceCar VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

set(HEADERS
  carcontrol.h
)

set(SOURCES
  main.cpp
  carcontrol.cpp
)

qt_add_executable(appSpaceCar
  ${HEADERS}
  ${SOURCES}
)

qt_add_qml_module(appSpaceCar
    URI SpaceCar
    VERSION 1.0
    QML_FILES
      main.qml
      LoopingImage.qml
      PowerButton.qml
      SteeringWheel.qml
      PitchStick.qml
      InfoScreen.qml
    RESOURCES
      images/Stars_quadrants.png
      images/Interior-background_alpha_smaller.png
      images/SteeringWheel/Steeringwheel-base.png
      images/SteeringWheel/Steeringwheel-middle.png
      images/SteeringWheel/Steeringwheel-leftbutton.png
      images/SteeringWheel/Steeringwheel-rightbutton.png
      images/GearShift.png
      images/Infotainment/Infoscreen.png
)

set_target_properties(appSpaceCar PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appSpaceCar
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appSpaceCar
    PRIVATE Qt6::Quick)
