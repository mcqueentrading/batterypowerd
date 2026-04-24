#!/usr/bin/env python3
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd


def main() -> int:
    csv_file = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("battery_data.csv")

    df = pd.read_csv(csv_file, parse_dates=["timestamp"])

    plt.figure(figsize=(10, 5))
    plt.plot(df["timestamp"], df["percentage"], marker="o", linestyle="-")
    plt.xlabel("Time")
    plt.ylabel("Battery %")
    plt.title("Battery Discharge Over Time")
    plt.grid(True)
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
