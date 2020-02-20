#!/usr/bin/env python3

import sys

class FirmwarePart:
    def __init__(self, name, offset, size):
        self.name = name
        self.offset = offset
        self.size = size

firmware_parts = [
    FirmwarePart("uimage_kernel", 0x0, 0x11AA97),
    FirmwarePart("squashfs", 0x11AAD7, 5505028-0x11AAD7),
]

if sys.argv[1] == "unpack":
    f = open(sys.argv[2], "rb")
    for part in firmware_parts:
        outfile = open(part.name, "wb")
        f.seek(part.offset, 0)
        data = f.read(part.size)
        outfile.write(data)
        outfile.close()
        print(f"Wrote {part.name} - {hex(len(data))} bytes")
elif sys.argv[1] == "pack":
    f = open(sys.argv[2], "wb")
    for part in firmware_parts[1:]:
        i = open(part.name, "rb")
        data = i.read()
        f.write(data)
        padding = (part.size - len(data))
        print(f"Wrote {part.name} - {hex(len(data))} bytes")
        print(f"Padding: {hex(padding)}")
        f.write(b'\x00' * padding)
