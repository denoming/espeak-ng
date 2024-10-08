include(GNUInstallDirs)

add_library(ucd)
add_library(eSpeakNg::Ucd ALIAS ucd)

set_target_properties(ucd
  PROPERTIES EXPORT_NAME Ucd
             POSITION_INDEPENDENT_CODE ON
)

target_include_directories(ucd
  PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/src/include>
)

target_sources(ucd
  PRIVATE src/case.c
          src/categories.c
          src/ctype.c
          src/proplist.c
          src/scripts.c
          src/tostring.c
)

install(TARGETS ucd
  EXPORT eSpeakNg
  COMPONENT eSpeakNgRuntime
)
