cmake_minimum_required(VERSION 3.13 FATAL_ERROR)

project(vsdt_lab_work_7 VERSION 1.0.0 LANGUAGES CXX)

set(PROJECT_BINARY_DIR build)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(INCLUDE_DIR "${PROJECT_SOURCE_DIR}/include")
set(RESOURCES_DIR "${PROJECT_SOURCE_DIR}/resources")
set(RESOURCES "${RESOURCES_DIR}/resources.qrc")

set(EXECUTABLE_NAME "${PROJECT_NAME}_executable")
set(LIBRARY_NAME "${PROJECT_NAME}.o")
set(APK_NAME "${PROJECT_NAME}")

include_directories(${INCLUDE_DIR})

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

add_subdirectory(src build)
