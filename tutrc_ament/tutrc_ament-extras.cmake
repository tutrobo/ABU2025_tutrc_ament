find_package(ament_cmake_auto QUIET REQUIRED)

include("${tutrc_ament_DIR}/tutrc_ament_init.cmake")
include("${tutrc_ament_DIR}/tutrc_ament_final.cmake")
include("${tutrc_ament_DIR}/tutrc_ament_add_library.cmake")
include("${tutrc_ament_DIR}/tutrc_ament_add_executable.cmake")
include("${tutrc_ament_DIR}/tutrc_ament_register_node.cmake")
include("${tutrc_ament_DIR}/tutrc_ament_generate_interfaces.cmake")
