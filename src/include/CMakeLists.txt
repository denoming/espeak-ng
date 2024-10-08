add_library(espeak-ng-include INTERFACE)

target_include_directories(espeak-ng-include
    INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
)

install(TARGETS espeak-ng-include
    EXPORT eSpeakNg
    COMPONENT eSpeakNgDevelopment
)
