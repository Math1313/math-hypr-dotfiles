#!/usr/bin/env python3
import curses
import math
import time

CHARS = " .:-=+*#%@"
ARMS = 3        # nombre de bras
TIGHTNESS = 0.5 # plus grand = spirale plus serrée
SPEED = 0.15

def main(stdscr):
    curses.curs_set(0)          # cache le curseur
    stdscr.nodelay(True)
    curses.use_default_colors()
    for i in range(1, 7):
        curses.init_pair(i, i, -1)

    t = 0.0
    while True:
        if stdscr.getch() == ord("q"):
            break

        h, w = stdscr.getmaxyx()
        cx, cy = w / 2, h / 2
        stdscr.erase()

        for y in range(h):
            for x in range(w - 1):
                dx = (x - cx) / 2   # une cellule est ~2x plus haute que large
                dy = y - cy
                r = math.hypot(dx, dy)
                angle = math.atan2(dy, dx)

                v = (math.sin(ARMS * angle + TIGHTNESS * r - t) + 1) / 2
                idx = int(v * (len(CHARS) - 1))
                if idx:
                    color = 1 + int(r / 4 - t) % 6
                    try:
                        stdscr.addch(y, x, CHARS[idx], curses.color_pair(color))
                    except curses.error:
                        pass

        stdscr.refresh()
        t += SPEED
        time.sleep(0.04)

curses.wrapper(main)
