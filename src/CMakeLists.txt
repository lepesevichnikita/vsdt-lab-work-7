qt5_wrap_cpp(QT_CLASSES
  "${INCLUDE_DIR}/task1.h"
  "${INCLUDE_DIR}/task2.h"
  "${INCLUDE_DIR}/task3.h"
  )

set(BIN_SOURCES
  main.cpp
  task1.cpp
  task2.cpp
  task3.cpp
  ${RESOURCES}
  ${QT_CLASSES}
  )

if (ANDROID)
  set(BINARY_NAME ${LIBRARY_NAME})
  add_library(BINARY_NAME
    ${BIN_SOURCES}
    )
else()
  set(BINARY_NAME ${EXECUTABLE_NAME})
  add_executable(${BINARY_NAME}
    ${BIN_SOURCES}
    )
endif()

target_compile_definitions(${BINARY_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${BINARY_NAME} PRIVATE Qt5::Core Qt5::Quick)


if (ANDROID) 
  add_qt_android_apk(${APK_NAME} ${LIBRARY_NAME})
endif()
