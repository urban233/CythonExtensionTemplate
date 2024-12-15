from setuptools import setup
from Cython.Build import cythonize

setup(
  name="main",
  ext_modules=cythonize(
    "main.pyx",
    compiler_directives={"language_level": "3"},
    # build_dir="build"  # Change this to your desired intermediate output directory
  ),
  script_args=["build_ext", "--build-lib", "dist"],
)
