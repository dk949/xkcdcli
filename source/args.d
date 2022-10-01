module args;
import std.getopt;
import core.stdc.stdlib: exit;
import std.conv;
import std.range;
import common;

class ArgException : Exception {
    this(string msg) {
        super(msg);
    }
}

struct Args {
    bool all;
    bool date;
    bool link;
    bool imgLink;
    bool title;
    bool altTitle;
    bool transcript;
    bool noDraw;
    string outFile;
    bool download;
    int comicNum;

    static Args parseArgs(string[] args) {
        auto o = Args.init;
        try {
            // dfmt off
            auto info = args.getopt(
                "a|all",       "print all information",                         &o.all,
                "n|no-draw",   "do not draw comic in the terminal",             &o.noDraw,
                "d|date",      "get the publication date of the comic",         &o.date,
                "l|link",      "get the link to the comic",                     &o.link,
                "i|img-link",  "get a link to just the image file",             &o.imgLink,
                "c|content",   "get the transcript as plain text",              &o.transcript,
                "t|title",     "get title of the comic",                        &o.title,
                  "alt-title", "get alternative title",                         &o.altTitle,
                "o|out-file",  "download the image and use this for file name", &o.outFile,
                  "download",  "get alternative title",                         &o.download,
            );
            // dfmt on

            if (info.helpWanted) {
                defaultGetoptPrinter("Usage: xkcd [options...] NUM", info.options);
                throw new ExitException(0);
            }
            if (args.length != 2)
                throw new ArgException("Missing number.");
            o.comicNum = args[1].to!int;
            if (o.all) {
                o.date = true;
                o.link = true;
                o.imgLink = true;
                o.title = true;
                o.altTitle = true;
                o.transcript = true;
            }
            return o;

        } catch (GetOptException e) {
            throw new ArgException(e.msg);
        }
    }
}
