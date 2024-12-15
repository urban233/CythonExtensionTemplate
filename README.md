# CythonExtensionTemplate

This project provides a Cython template that can be easily compiled into a standalone `.exe` file. The compiled executable can run without requiring a Python interpreter, using compiled `.pyd` files. This setup ensures seamless execution of Python code within a compiled environment, making it an ideal solution for creating Python-based applications that are portable and independent of the Python installation.

## Features

- **Standalone .exe Generation**: Convert Cython code into a Windows executable (.exe) that doesn’t require an external Python interpreter.
- **No Dependencies on Python Installation**: The `.exe` runs with compiled `.pyd` files, eliminating the need for a pre-installed Python environment.
- **Fully Customizable Template**: Ready to modify and tweak according to your project’s specific requirements. Easily extendable for your use cases.
- **Cross-Platform Compilation**: Designed primarily for Windows, but can be adapted for other platforms with minimal adjustments.

## Getting Started

### Prerequisites

- **Python 3.x** (any version compatible with Cython)
- **Cython** (installable via pip)
- **Microsoft Visual C++ Build Tools** (for compiling C extensions)
- **CMake 3.14** 

### Installation
1. **Clone this repository**:

   ```bash
   git clone https://github.com/urban233/CythonExtensionTemplate.git
   cd CythonExtensionTemplate
   ```

2. **Setup virtual environment**:

   Set up a virtual environment under the root directory and
   call it .venv (this is required for the make.bat file)

3. **Install dependencies**:

   Install Cython via pip:

   ```bash
   pip install cython
   ```

3. **Modify the Template**:

   The template contains the standalone script (`main.pyx`) and Cython file (`core/mymodule.pyx`). Modify these files to implement your desired functionality.

4. **Compile the Cython code**:

   In the root directory of the project, run the following command to compile the Cython code into `.pyd` files:

   ```bash
   .\make.bat build-pyx
   ```

5. **Generate the Executable**:

   Use the `make.bat` script to convert the Cython script into a standalone `.exe` file:

   ```bash
   .\make.bat rebuild-c
   ```

   This will generate the `.exe` file in the `dist/` directory.

### Running the Executable
You can test the `.exe` file by initially running: 
```bash
.\make.bat setup-test
```
and after that you can run:
```bash
.\make.bat test
```

## Customization

You can easily modify the template to suit your specific needs. Here are a few common customizations:

- **Add new Cython files**: Simply add additional `.pyx` files, and ensure they are imported properly in `main.pyx`.
- **Modify Cython code**: Update `mymodule.pyx` with your custom Cython logic. Rebuild the `.pyd` files after making changes.
- **Customizable build process**: You can tweak the build process by modifying the `setup.py` or the PyInstaller configuration.

## Contributing

Contributions are welcome! If you'd like to improve this template or add new features, feel free to open a pull request. Please ensure that your changes are well-documented and include tests where applicable.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free tpip listpo customize this README further depending on the specifics of your project or the features you'd like to emphasize!