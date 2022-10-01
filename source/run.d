module run;

import args;
import info;
import common;
import draw: draw;

import std.json;
import std.stdio;
import std.traits;

private string maybeUnavailable(T)(auto ref T t)
if (hasMember!(T, "isNull")) {
    return t.isNull ? "unavailable" : t.get.toString();
}

private string maybeUnavailable(T)(auto ref T t)
if (ifTestable!T) {
    return orElse(t, "unavailable");
}

void run(Args args, const ref Info info) {
    if (!args.noDraw)
        draw(info);
    if (args.date)
        writeln("date: ", maybeUnavailable(info.date));
    if (args.link)
        writeln("link: ", maybeUnavailable(info.comicUrl));
    if (args.imgLink)
        writeln("image link: ", maybeUnavailable(info.imgUrl));
    if (args.title)
        writeln("title: ", maybeUnavailable(info.title));
    if (args.altTitle)
        writeln("alt title: ", maybeUnavailable(info.altTitle));
    if (args.transcript)
        writeln("transcript: ", maybeUnavailable(info.transcript));
    if (args.download || args.outFile)
        assert(0);

}
