#!/bin/bash

echo "Warning!!!Warning!!!Warning!!!"
echo "This file will spend your time about more than 5 hours"
echo "You can just run it and go to sleep"
echo "Warning!!!Warning!!!Warning!!!"
echo "This file will spend your time about more than 5 hours"
echo "You can just run it and go to sleep"
for i in {5..1}
do
	echo $i
	sleep .8
done
echo "----------------------------------------------------------------"
cd
cd ~/rippled
mkdir .build
cd .build
conan install .. --output-folder . --build missing --settings build_type=Release
conan install .. --output-folder . --build missing --settings build_type=Debug
cmake -DCMAKE_TOOLCHAIN_FILE:FILEPATH=build/generators/conan_toolchain.cmake -Dxrpld=ON -Dtests=ON  ..
cmake --build . --config Release
cmake --build . --config Debug
./rippled --unittest
pip install gcovr
conan install .. --output-folder . --build missing --settings build_type=Debug
cmake -DCMAKE_BUILD_TYPE=Debug -Dcoverage=ON -Dxrpld=ON -Dtests=ON -Dcoverage_test_parallelism=2 -Dcoverage_format=html-details -Dcoverage_extra_args="--json coverage.json" -DCMAKE_TOOLCHAIN_FILE:FILEPATH=build/generators/conan_toolchain.cmake ..
cmake --build . --target coverage
echo "----------------------------------------------------------------"
echo "It's finished install conan's software and coverage"
echo "and build sonething necessary"
echo "----------------------------------------------------------------"
echo "finished"