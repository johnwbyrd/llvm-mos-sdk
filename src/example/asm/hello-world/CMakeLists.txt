add_executable(hello-world hello-world.s)

add_custom_command(
  TARGET hello-world
  POST_BUILD 
  COMMAND ${CMAKE_OBJCOPY}
  ARGS --output-target binary --strip-unneeded $<TARGET_FILE:hello-world> $<TARGET_FILE:hello-world>.bin
)