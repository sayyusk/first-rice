import subprocess, time

WIDTH = 25

def get_title():
    try:
        return subprocess.check_output(
            ["playerctl1", "metadata", "--format", "{{artist}} - {{title}}"],
            stderr=subprocess.DEVNULL, text=True).strip()
    except Exception:
        return ""

pos, tick, text = 0, 0, ""
while True:
    if tick % 6 == 0:
        new = get_title()
        if new != text:
            text, pos = new, 0
    tick += 1

    if not text:
        print("", flush=True)