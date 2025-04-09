#!/bin/bash

cd
echo "build instructions"
echo "----------------------------------------------------------------"
sleep .5
git clone https://github.com/XRPLF/rippled.git
sudo apt install --yes curl git libssl-dev python3.10-dev python3-pip make g++-11 libprotobuf-dev protobuf-compiler
echo "----------------------------------------------------------------"
echo "If next one if error plz download by yourself"
echo "and delete the curl"
echo "----------------------------------------------------------------"
sleep .8
curl --location --remote-name \
  "https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1.tar.gz"
tar -xzf cmake-3.25.1.tar.gz
rm cmake-3.25.1.tar.gz
cd cmake-3.25.1
echo "----------------------------------------------------------------"
echo "It's gonna take you a little time"
echo "----------------------------------------------------------------"
sleep .8
./bootstrap --parallel=$(nproc)
make --jobs $(nproc)
make install
cd
echo "----------------------------------------------------------------"
echo "conan install"
echo "----------------------------------------------------------------"
pip3 install 'conan<2' --user
echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
source ~/.bashrc
echo "----------------------------------------------------------------"
echo "conan setup"
echo "----------------------------------------------------------------"
conan profile new default --detect
conan profile update settings.compiler.cppstd=20 default
conan config set general.revisions_enabled=1
conan profile update settings.compiler.libcxx=libstdc++11 default
conan profile update 'conf.tools.build:cxxflags+=["-DBOOST_BEAST_USE_STD_STRING_VIEW"]' default
conan profile update 'env.CXXFLAGS="-DBOOST_BEAST_USE_STD_STRING_VIEW"' default
conan profile show default
conan profile update 'conf.tools.build:compiler_executables={"c": "/usr/bin/gcc", "cpp": "/usr/bin/g++"}' default
echo "----------------------------------------------------------------"
echo "conan setup finished"
echo "conan install snappy | rocksdb | soci | nudb |"
echo "----------------------------------------------------------------"
sleep .5
conan export external/snappy snappy/1.1.10@
conan export external/rocksdb rocksdb/9.7.3@
conan export external/soci soci/4.0.3@
conan export external/nudb nudb/2.0.8@
echo "----------------------------------------------------------------"
echo "conan install snappy | rocksdb | soci | nudb |"
echo "finished"