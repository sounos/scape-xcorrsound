add_executable(overlap-analysis overlap-analysis.cpp)
add_executable(wavmatch sound_match.cpp sound_match.h)
add_executable(waveform-compare waveform-compare.cpp)
#add_executable(ismir_impl ismir_impl.cc)
add_executable(ismir_query ismir_query.cc)
add_executable(ismir_build_index ismir_build_index.cc)
add_executable(ismir_merge ismir_merge.cc)

#add_executable(revindex revindex.cc)

#add_executable(mything mything.cc)

#add_executable(test test.cc)

#target_link_libraries(test ${LIBAVFORMAT_LIBRARIES} ${LIBAVCODEC_LIBRARIES} ${LIBAVUTIL_LIBRARIES} chromaprint)
target_link_libraries(overlap-analysis wavcore ${Boost_LIBRARIES})
target_link_libraries(wavmatch wavcore ${Boost_LIBRARIES})
target_link_libraries(waveform-compare wavcore ${Boost_LIBRARIES})
#target_link_libraries(ismir_impl wavcore sound_index ${Boost_LIBRARIES})
target_link_libraries(ismir_query wavcore sound_index ${Boost_LIBRARIES})
target_link_libraries(ismir_build_index wavcore sound_index ${Boost_LIBRARIES})
target_link_libraries(ismir_merge wavcore sound_index ${Boost_LIBRARIES})

#target_link_libraries(revindex tpie)

#target_link_libraries(mything tpie)

install(TARGETS overlap-analysis wavmatch waveform-compare RUNTIME DESTINATION bin)
