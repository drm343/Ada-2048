MAIN=../src/matrix_2048-c.adb
LIB_NAME=matrix_2048
C_COMPILER_ARGS=-fPIC
LINK_ARGS=
SOURCE_PATH=
OPTIMIZATION=-O0 -gnata

# for slackware
GNAT_PATH=/usr/lib64/gcc/x86_64-slackware-linux/11.3.0/adalib



all:
	cd .. && make -C python3-version build

build: base-obj
	gnat bind -L$(LIB_NAME) -shared ../obj/matrix_2048.ali
	gnat make -D ../obj b~matrix_2048.adb -cargs $(C_COMPILER_ARGS) -largs $(LINK_ARGS)
	gcc -shared -Wl,-rpath=$(GNAT_PATH) -Wl,-soname,libmatrix_2048.so.1 -o libmatrix_2048.so.1.0.0 ../obj/*.o -L $(GNAT_PATH) -lgnat

base-obj:
	gnat make -D ../obj -gnatef -c $(OPTIMIZATION) $(SOURCE_PATH) $(MAIN) -cargs $(C_COMPILER_ARGS) -largs $(LINK_ARGS)

clean:
	gnat clean -D ../obj $(MAIN)
	-rm ../obj/b~matrix_2048.ali ../obj/b~matrix_2048.o b~matrix_2048.adb b~matrix_2048.ads libmatrix_2048.so.1.0.0
