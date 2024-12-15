cmake_minimum_required(VERSION 3.14)

# Set the project name and specify it as a C project
project(MainExecutable C)

get_filename_component(VENDOR_DIR "${CMAKE_SOURCE_DIR}/../../../vendor" ABSOLUTE)
# Specify the path to the Python installation
set(PYTHON_INCLUDE_DIR "${VENDOR_DIR}/python/include")
set(PYTHON_LIBRARY_DIR "${VENDOR_DIR}/python/libs")
set(PYTHON_LIB "python311")

# Add the executable
add_executable(main auto/main.c)

# Include the Python header files
target_include_directories(main PRIVATE ${PYTHON_INCLUDE_DIR})

# Link against the Python library
target_link_directories(main PRIVATE ${PYTHON_LIBRARY_DIR})
target_link_libraries(main PRIVATE ${PYTHON_LIB})
