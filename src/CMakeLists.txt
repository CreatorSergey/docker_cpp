cmake_minimum_required(VERSION 3.2)
project(example)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20")

set(Boost_USE_STATIC_LIBS ON)
find_package(Boost COMPONENTS chrono REQUIRED)
include_directories(${BOOST_INCLUDE_DIRS})

add_executable(example main.cpp)
target_link_libraries(example ${Boost_LIBRARIES})