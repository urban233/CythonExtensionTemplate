import importlib


def main():
  # Load the DLL (Python module)
  mymodule = importlib.import_module("mymodule")
  mymodule.main()

if __name__ == "__main__":
  main()
