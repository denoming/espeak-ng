cmake_minimum_required(VERSION 3.8)

project(espeak-ng
  VERSION 1.52.0.1
  DESCRIPTION "open source speech synthesizer that supports more than hundred languages and accents"
  HOMEPAGE_URL "https://github.com/espeak-ng/espeak-ng"
)

option(BUILD_ESPEAK_NG_EXE "Whether to build espeak-ng-bin" ON)
option(BUILD_ESPEAK_NG_TESTS "Whether to build tests" OFF)
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

include(cmake/deps.cmake)
include(cmake/config.cmake)
if(BUILD_ESPEAK_NG_EXE)
  include(cmake/data.cmake)
endif()
include(cmake/docs.cmake)

add_subdirectory(src)

include(cmake/package.cmake)
include(CPack)

if(BUILD_ESPEAK_NG_TESTS)
  include(CTest)
  add_subdirectory(tests)
endif()

message(STATUS "Configuration:")
message(STATUS "  shared: ${BUILD_SHARED_LIBS}")
message(STATUS "  mbrola: ${USE_MBROLA} (${MBROLA_BIN})")
message(STATUS "  libsonic: ${USE_LIBSONIC} (${SONIC_LIB} ${SONIC_INC})")
message(STATUS "  libpcaudio: ${USE_LIBPCAUDIO} (${PCAUDIO_LIB} ${PCAUDIO_INC})")
message(STATUS "  klatt: ${USE_KLATT}")
message(STATUS "  speech-player: ${USE_SPEECHPLAYER}")
message(STATUS "  async: ${USE_ASYNC}")
message(STATUS "  output data dir: ${DATA_DIR_ROOT}")

install(
  DIRECTORY vim/ftdetect
            vim/syntax
  DESTINATION share/vim/vimfiles
)
