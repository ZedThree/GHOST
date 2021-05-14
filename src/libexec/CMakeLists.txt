add_executable(xgenie)
target_sources(xgenie PRIVATE
  xgenie.c
  Plot.c
  PlotGraphics.c
  PlotReplay.c
  Plot.h
  PlotP.h
  ../lib/Opcodes.h
  )

target_compile_definitions(xgenie PRIVATE
  GHOST_RECL_UNIT=4
  GHOST_LIBDIR="${CMAKE_INSTALL_LIBDIR}"
  GHOST_LIBEXECDIR="${CMAKE_INSTALL_LIBEXECDIR}"
  USEUNDERSCORE
  LITTLE_ENDIAN
  )
target_include_directories(xgenie PRIVATE ../lib)

find_package(X11)
target_link_libraries(xgenie PRIVATE X11::Xt X11::X11)

install(TARGETS xgenie
  EXPORT xgenieTargets
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
