import subprocess
import os

# Tạo thư mục logs nếu chưa có
log_dir = "logs"
os.makedirs(log_dir, exist_ok=True)

tests = [
    "test_BlockingPutPort",
    "test_NonBlockingPutPort",
    "test_PortExportImp",
    "test_BlockingGetPort",
    "test_NonBlockingGetPort",
    "test_fifo",
    "test_example"
]

for test in tests:
    print(f"\nRunning {test}...\n")

    result = subprocess.run(
        ["make", "run", f"TESTNAME={test}"],
        capture_output=True,
        text=True
    )

    log_file = os.path.join(log_dir, f"{test}.log")
    with open(log_file, "w") as f:
        f.write(result.stdout)
        f.write(result.stderr)

    print(f"Test {test} completed. Log saved to {log_file}")

