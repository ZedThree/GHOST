add_executable(decode interpcalla.f interpb.f g5jusl.f g5jusr.f)
add_executable(hpgl2 interpcalla.f interpa.f g5jusl.f g5jusr.f)
add_executable(postcl interpcalla.f interpa.f g5jusl.f g5jusr.f)
add_executable(postsc interpcalla.f interpa.f g5jusl.f g5jusr.f)
add_executable(trand trandcalla.f trand.f)
add_executable(trenc interpcalla.f interpb.f)
add_executable(xghost interpcalla.f interpc.f g5jusl.f g5jusr.f)
add_executable(demosurf demosurf.f)

target_link_libraries(decode ghost grid_decode)
target_link_libraries(hpgl2 ghost grid_hpgl2)
target_link_libraries(postcl ghost grid_postcl)
target_link_libraries(postsc ghost grid_postsc)
target_link_libraries(trand grid_trand grid)
target_link_libraries(trenc ghost grid_trenc)
target_link_libraries(xghost ghost grid_xghost)
target_link_libraries(demosurf ghost grid_xghost)

set(GHOST_EXECUTABLE_TARGETS
  decode
  hpgl2
  postcl
  postsc
  trand
  trenc
  xghost
  demosurf
  )

install(TARGETS ${GHOST_EXECUTABLE_TARGETS}
  EXPORT ghostExeTargets
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
