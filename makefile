MAIN=src/main_ada_2048.adb
LINK_ARGS=-lSDL2 -lSDL2_ttf obj/my_world-event.o
SOURCE_PATH=-aIsdl2 -aIrc_cstring
OPTIMIZATION=-O3 -gnata


all:
	make -f rc_cstring/makefile
	make -f sdl2/makefile
	gnat make -D obj -gnatef $(OPTIMIZATION) $(SOURCE_PATH) $(MAIN) -largs $(LINK_ARGS) obj/c_put_line.o

clean:
	make -f rc_cstring/makefile clean
	make -f sdl2/makefile clean
	gnat clean -D obj $(MAIN)
