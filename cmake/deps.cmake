find_library(PTHREAD_LIB pthread)
if (PTHREAD_LIB)
  set(HAVE_PTHREAD ON)
endif(PTHREAD_LIB)

find_program(MBROLA_BIN mbrola)
if (MBROLA_BIN)
  set(HAVE_MBROLA ON)
endif(MBROLA_BIN)

find_library(SONIC_LIB sonic)
find_path(SONIC_INC "sonic.h")
if (SONIC_LIB AND SONIC_INC)
  set(HAVE_LIBSONIC ON)
else()
  include(FetchContent)
  FetchContent_Declare(sonic-git
    GIT_REPOSITORY https://github.com/waywardgeek/sonic.git
    GIT_TAG fbf75c3d6d846bad3bb3d456cbc5d07d9fd8c104
  )
  FetchContent_MakeAvailable(sonic-git)
  FetchContent_GetProperties(sonic-git)
  add_library(sonic OBJECT ${sonic-git_SOURCE_DIR}/sonic.c)
  target_include_directories(sonic PUBLIC ${sonic-git_SOURCE_DIR})
  set(HAVE_LIBSONIC ON)
  set(SONIC_LIB sonic)
  set(SONIC_INC ${sonic-git_SOURCE_DIR})
endif()

find_library(PCAUDIO_LIB pcaudio)
find_path(PCAUDIO_INC "pcaudiolib/audio.h")
if (PCAUDIO_LIB AND PCAUDIO_INC)
  set(HAVE_LIBPCAUDIO ON)
endif()
