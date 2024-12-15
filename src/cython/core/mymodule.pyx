import logging
import sys

sys.path.insert(0, r"..\Lib\site-packages")  # This is necessary to use other python libraries

# Configure the logger
LOG_FILE = "cython_dev.log"
logging.basicConfig(
  level=logging.DEBUG,  # Set the minimum logging level
  format="%(asctime)s - %(threadName)s - %(levelname)s - %(filename)s:%(lineno)d - %(message)s",
  handlers=[
    logging.FileHandler(LOG_FILE),
    logging.StreamHandler()
  ]
)

# Get the logger instance
logger = logging.getLogger(__file__)


def add(a: int, b: int) -> int:
  return a + b

def long_running_task():
  cdef int i = 1
  for i in range(500000):
    print(i)
    i += 1

# <editor-fold desc="Main function">
def main() -> None:
  """This is the entry point for any functionality run in the main.exe file."""
  print("Hi there.")
  add(2, 1)
  long_running_task()
# </editor-fold>
