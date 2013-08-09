.PHONEY: clean all
.DEFAULT: all

ARM7=./libs/libEmailValidatorARM7.a
ARM7s=./libs/libEmailValidatorARM7s.a
I386=./libs/libEmailValidatorSim.a

all: ./libs/libEmailValidator.a

${ARM7} : 
	xcodebuild -configuration Release -arch armv7 clean build
	mv ./libs/libEmailValidator.a $@

${ARM7s} : ${BASEFILES}
	xcodebuild -configuration Release -arch armv7s clean build
	mv ./libs/libEmailValidator.a $@

${I386} : ${BASEFILES}
	xcodebuild -configuration Debug -arch i386 -sdk iphonesimulator clean build
	mv ./libs/libEmailValidator.a $@

./libs/libEmailValidator.a : ${ARM7} ${ARM7s} ${I386}
	lipo -create $^ -output $@

dist: ./libs/libEmailValidator.a
	rm ${ARM7} ${ARM7s} ${I386}

clean:
	-rm ${ARM7} ${ARM7s} ${I386} ./libs/libEmailValidator.a
	xcodebuild clean 
