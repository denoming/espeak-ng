add_library(espeak-ng-config INTERFACE)

set(ESPEAK_CONFIG_DIR
    ${CMAKE_CURRENT_BINARY_DIR}/include)
set(ESPEAK_CONFIG_H
    ${ESPEAK_CONFIG_DIR}/config.h)

configure_file(config.h.in ${ESPEAK_CONFIG_H})

target_include_directories(espeak-ng-config
    INTERFACE ${ESPEAK_CONFIG_DIR}
)
