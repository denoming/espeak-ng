include(GNUInstallDirs)

add_library(espeak-ng)
add_library(eSpeakNg::eSpeakNg ALIAS espeak-ng)

set_target_properties(espeak-ng
  PROPERTIES EXPORT_NAME eSpeakNg
             MACOSX_RPATH ON
             INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib"
)

target_sources(espeak-ng
  PRIVATE common.c
          mnemonics.c
          error.c
          ieee80.c
          compiledata.c
          compiledict.c
          dictionary.c
          encoding.c
          intonation.c
          langopts.c
          numbers.c
          phoneme.c
          phonemelist.c
          readclause.c
          setlengths.c
          soundicon.c
          spect.c
          ssml.c
          synthdata.c
          synthesize.c
          tr_languages.c
          translate.c
          translateword.c
          voices.c
          wavegen.c
          speech.c
          espeak_api.c
)

target_link_libraries(espeak-ng
  PUBLIC espeak-ng-include
  PRIVATE ucd
          espeak-ng-config
)

if (NOT MSVC)
  target_compile_options(espeak-ng PRIVATE
    "-fPIC"
    "-fvisibility=hidden"
    "-fno-exceptions"
    "-fwrapv"
    "-pedantic"
    "-Wunused-parameter"
    "-Wunused"
    "-Wuninitialized"
    "-Wreturn-type"
    "-Wmissing-prototypes"
    "-Wint-conversion"
    "-Wimplicit"
    "-Wmisleading-indentation"
  )
endif()

target_compile_definitions(espeak-ng PRIVATE "LIBESPEAK_NG_EXPORT=1")
if (NOT BUILD_SHARED_LIBS)
  target_compile_definitions(espeak-ng INTERFACE "LIBESPEAK_NG_EXPORT=1")
endif()

target_compile_definitions(espeak-ng
  PRIVATE "PATH_ESPEAK_DATA=\"${CMAKE_INSTALL_PREFIX}/share/espeak-ng-data\""
)

if (USE_ASYNC)
  target_sources(espeak-ng PRIVATE
    event.c
    fifo.c
    espeak_command.c
  )
endif(USE_ASYNC)

if (USE_MBROLA)
  target_sources(espeak-ng PRIVATE
    mbrowrap.c
    compilembrola.c
    synth_mbrola.c
  )
endif(USE_MBROLA)

if (USE_KLATT)
  target_sources(espeak-ng PRIVATE klatt.c)
endif(USE_KLATT)

if (USE_SPEECHPLAYER)
  target_sources(espeak-ng PRIVATE sPlayer.c)
  target_link_libraries(espeak-ng PRIVATE speechPlayer)
endif(USE_SPEECHPLAYER)

if (HAVE_LIBSONIC AND USE_LIBSONIC)
  target_link_libraries(espeak-ng PRIVATE ${SONIC_LIB})
  target_include_directories(espeak-ng PRIVATE ${SONIC_INC})
endif()

if (HAVE_LIBPCAUDIO AND USE_LIBPCAUDIO)
  target_link_libraries(espeak-ng PRIVATE ${PCAUDIO_LIB})
  target_include_directories(espeak-ng PRIVATE ${PCAUDIO_INC})
endif()

if (NOT MSVC)
  target_link_libraries(espeak-ng PRIVATE m)
endif()
if (MINGW)
  target_link_options(espeak-ng PRIVATE "-static-libstdc++" "-static")
endif()

install(TARGETS espeak-ng
  EXPORT eSpeakNg
  LIBRARY
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
    COMPONENT eSpeakNgRuntime
    NAMELINK_COMPONENT eSpeakNgDevelopment
  ARCHIVE
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
    COMPONENT eSpeakNgDevelopment
  INCLUDES
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(EXPORT eSpeakNg
  FILE eSpeakNgConfig.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/eSpeakNg
  NAMESPACE eSpeakNg::
  COMPONENT eSpeakNgDevelopment
)
