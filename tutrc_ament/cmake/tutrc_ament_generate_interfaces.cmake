macro(tutrc_ament_generate_interfaces)
  if(ARGN)
    set(idl_sources ${ARGN})
  else()
    file(
      GLOB
      idl_sources
      RELATIVE
      "${CMAKE_CURRENT_SOURCE_DIR}"
      "msg/*.msg"
      "srv/*.srv"
    )
  endif()

  rosidl_generate_interfaces("${PROJECT_NAME}"
    ${idl_sources}
    DEPENDENCIES ${${PROJECT_NAME}_FOUND_BUILD_DEPENDS}
  )

  ament_export_dependencies(rosidl_default_runtime)
endmacro()
