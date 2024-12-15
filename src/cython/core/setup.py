from Cython.Build import cythonize
from setuptools import setup
from setuptools.command.build_ext import build_ext


class CustomBuildCommand(build_ext):
  def run(self):
    super().run()
    # Your custom code here

setup(
  name="mymodule",
  ext_modules=cythonize(
    "mymodule.pyx",
    compiler_directives={"language_level": "3"},
    build_dir="build"  # Change this to your desired intermediate output directory
  ),
  script_args=["build_ext", "--build-lib", "dist"],  # Change 'output_dir' to your desired final output directory
  cmdclass={"build_ext": CustomBuildCommand},
)
