
# Install latest version of DMD, LDC, GDC and load 'dlang' function

source ../../../prepareD.sh
# crystal build test.cr --release -o base64_cr --no-debug
go build -o base64_go test.go
# gccgo -O3 -g -o base64_go_gccgo test.go
g++ -O3 -o base64_cpp test.cpp -lcrypto
gcc -O3 -std=c99 -o base64_c test.c
scalac-2.12 -optimize test.scala
javac Base64Java.java
# kotlinc Test.kt -include-runtime -d Test-kt.jar
dlang dmd && dmd -ofbase64_d -O -release -inline test.d && deactivate
dlang gdc && gdc -o base64_d_gdc -O3 -frelease -finline test.d && deactivate
dlang ldc && ldc2 -ofbase64_d_ldc -O5 -release test.d && deactivate
# julia -e 'Pkg.add("Codecs")'
# mcs -debug- -optimize+ test.cs
# dotnet build -c Release

if [ ! -d aklomp-base64-ssse ]; then
    git clone --depth 1 https://github.com/aklomp/base64.git aklomp-base64-ssse
    cd aklomp-base64-ssse
    SSSE3_CFLAGS=-mssse3 make
    cd -
fi
gcc --std=c99 -O3 test-aklomp.c -I aklomp-base64-ssse/include/ aklomp-base64-ssse/lib/libbase64.o -o base64_c_ak_ssse
# wget -qO - https://cpanmin.us | perl - -L perllib MIME::Base64::Perl
