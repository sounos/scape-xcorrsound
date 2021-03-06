#DEBUG_FLAGS = -ggdb
DEBUG_FLAGS = 
PRODUCTION_FLAGS = -O2
CPPFLAGS = -m64 
CXXFLAGS = -Wall -pedantic $(PRODUCTION_FLAGS)
FFTW3_LIBS = -lfftw3
BOOST_LIBS = -lboost_program_options
LDFLAGS = -Wl,$(FFTW3_LIBS),$(BOOST_LIBS),-s,--as-needed
#STATIC = -static-libgcc -static-libstdc++ -static
STATIC = 
CXX = /usr/bin/g++
#CXX=~/third_party/llvm-build/Release+Asserts/bin/clang++ $(SAN)
#SAN=-faddress-sanitizer -fno-omit-frame-pointer 
OBJECT_FILES := my_utils.o
#VERSION = 2.0.0


all: sound-match overlap-analysis waveform-compare 

clean:
	rm -rf *.o overlap-analysis test_cross soundMatch waveform-compare data *.deb *.gz

my_utils.o : my_utils.cpp my_utils.h
	$(CXX) -v
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(STATIC) -c my_utils.cpp -o my_utils.o

cross_correlation : cross_correlation.h
	$(CXX) $(CXXFLAGS) $(CPPFLAGS)  $(STATIC) cross_correlation_test.cpp -o cross_correlation_test  $(LDFLAGS) 

overlap-analysis.o : overlap-analysis.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(STATIC) -c overlap-analysis.cpp -o overlap-analysis.o

logstream.o : logstream.h logstream.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(STATIC) -c logstream.cpp -o logstream.o

overlap-analysis : $(OBJECT_FILES) overlap-analysis.o logstream.o
	$(CXX) $(CXXFLAGS) $(STATIC) -m64 logstream.o my_utils.o overlap-analysis.o -o overlap-analysis $(LDFLAGS) 

AudioFile.o : AudioFile.h AudioFile.cpp AudioStream.h my_utils.o
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(STATIC) -c AudioFile.cpp -o AudioFile.o

sound-match : AudioStream.h AudioFile.o sound_match.cpp my_utils.o
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(OBJECT_FILES) $(STATIC) AudioFile.o sound_match.cpp -o sound-match $(LDFLAGS)

test_cross : test_cross.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(STATIC) test_cross.cpp -o test_cross $(LDFLAGS)

waveform-compare : waveform-compare.cpp cross_correlation.h AudioFile.o my_utils.o logstream.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(STATIC) logstream.o my_utils.o AudioFile.o waveform-compare.cpp -o waveform-compare $(LDFLAGS)

.PHONY : all clean
