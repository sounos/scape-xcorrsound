add_library (wavcore 
  SHARED
  wavcore.h
  wavcore.cpp
  AudioFile.cpp
  AudioFile.h
  AudioStream.h
  cross_correlation.h
  logstream.cpp
  logstream.h
  my_utils.cpp
  my_utils.h
  wavStdinReader.cc
  wavStdinReader.hh
)

set(CMAKE_CXX_FLAGS "-fno-rtti -fno-exceptions")
set(CMAKE_CPP_FLAGS "-fno-rtti -fno-exceptions")

target_link_libraries(wavcore ${FFTW_LIBRARIES})
#set_target_properties(core PROPERTIES LIBRARY_OUTPUT_DIRECTORY ../..)

install(TARGETS wavcore DESTINATION lib)

install(FILES wavcore.h DESTINATION include)
