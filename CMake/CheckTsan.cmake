set(TSAN_FLAG "-fsanitize=thread")
set(TSAN_C_FLAGS "-O1 -g ${TSAN_FLAG}")
set(TSAN_CXX_FLAGS ${TSAN_C_FLAGS})

get_property(TSAN_LANGUAGES GLOBAL PROPERTY ENABLED_LANGUAGES)
foreach(lang ${TSAN_LANGUAGES})
  set(TSAN_${lang}_LANG_ENABLED 1)
endforeach()

if(TSAN_C_LANG_ENABLED)
  include(CheckCCompilerFlag)
  set(CMAKE_REQUIRED_LINK_OPTIONS ${TSAN_FLAG})
  check_c_compiler_flag(${TSAN_FLAG} TSAN_C_FLAG_SUPPORTED)
  if(NOT TSAN_C_FLAG_SUPPORTED)
    message(STATUS "Asan flags are not supported by the C compiler.")
  else()
    if(NOT CMAKE_C_FLAGS_TSAN)
      set(CMAKE_C_FLAGS_TSAN ${TSAN_C_FLAGS} CACHE STRING "Flags used by the C compiler during TSAN builds." FORCE)
    endif()
  endif()
  unset(CMAKE_REQUIRED_LINK_OPTIONS)
endif()

if(TSAN_CXX_LANG_ENABLED)
  include(CheckCXXCompilerFlag)
  set(CMAKE_REQUIRED_LINK_OPTIONS ${TSAN_FLAG})
  check_cxx_compiler_flag(${TSAN_FLAG} TSAN_CXX_FLAG_SUPPORTED)
  if(NOT TSAN_CXX_FLAG_SUPPORTED)
    message(STATUS "Asan flags are not supported by the CXX compiler.")
  else()
    if(NOT CMAKE_CXX_FLAGS_TSAN)
      set(CMAKE_CXX_FLAGS_TSAN ${TSAN_CXX_FLAGS} CACHE STRING "Flags used by the CXX compiler during TSAN builds." FORCE)
    endif()
  endif()
  unset(CMAKE_REQUIRED_LINK_OPTIONS)
endif()

