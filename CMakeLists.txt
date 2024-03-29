cmake_minimum_required(VERSION 3.14)

project(GHOST
  VERSION 1.0.0
  DESCRIPTION "Fortran plotting package"
  LANGUAGES Fortran C
  )

include(GNUInstallDirs)

option(GHOST_ENABLE_DOUBLE "Promotes precisions of real and complex to double" ON)

add_subdirectory(src/lib)
add_subdirectory(src/libexec)
add_subdirectory(src/bin)
add_subdirectory(src/hershey)

include(CMakePackageConfigHelpers)
configure_package_config_file(ghostConfig.cmake.in ghostConfig.cmake
  INSTALL_DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/ghostConfig.cmake
  )
write_basic_package_version_file(
  ghostConfigVersion.cmake
  VERSION ${PACKAGE_VERSION}
  COMPATIBILITY SameMajorVersion
  )
install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/ghostConfig.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/ghostConfigVersion.cmake"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/ghost"
  )

install(EXPORT ghostTargets
  FILE ghostTargets.cmake
  NAMESPACE ghost::
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/ghost"
  )
export(EXPORT ghostTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/ghostTargets.cmake"
  NAMESPACE ghost::
  )
export(PACKAGE ghost)
