module draw;
import info;
import common;

import std.algorithm;
import std.array;
import std.conv;
import std.format;
import std.stdio;

class DrawException : Exception {
    this(string msg) {
        super(msg);
    }
}

void draw(const ref Info info) {
    auto width = 60;
    const lines = {
        if (info.transcript) {
            const s = info.transcript.smartSplit(width, '\n', ' ');
            width = s.map!`a.length`
                .reduce!max
                .to!int + 4;
            return s;
        } else {
            return [""];
        }
    }();

    const top = //
        format("╭%*=s╮\n", width - 1, info.title.replace(' ', '\\')) //
        .replace(' ', '─') //
        .replace('\\', ' ');

    const bottom = //
        format("╰%*=s╯\n", width - 1, info.altTitle.replace(' ', '\\')) //
        .replace(' ', '─') //
        .replace('\\', ' ');

    char[] buf;
    buf.reserve(width * (lines.length * 2));
    buf ~= top;
    buf ~= format("│%*=s│\n", width - 1, "");
    foreach (line; lines) {
        buf ~= format("│%*=s│\n", width - 1, line);
    }
    buf ~= format("│%*=s│\n", width - 1, "");
    buf ~= bottom;
    writeln(buf);
}
