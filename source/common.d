module common;
import std.stdio;
import std.traits;
import std.algorithm;
import std.range;

class ExitException : Exception {
    private int m_exitCode;
    this(int exitCode) {
        super("");
        m_exitCode = exitCode;
    }

    @property int exitCode() {
        return m_exitCode;
    }
}

int ecWriteln(Args...)(int ec, Args args) {
    writeln(args);
    return ec;
}

T orElse(T)(T a, lazy T b)
if (ifTestable!T) {
    if (a)
        return a;
    return b;
}

const(Range)[] smartSplit(Range, PrimSep, SecSep)(Range str, int width,
    PrimSep primarySeparator, SecSep secondarySeparator) {
    // dfmt off
    return str
        .splitter(primarySeparator)
        .map!(
            (line){
                int ctr = 1;
                return line
                    .enumerate
                    .splitter!(ch => ch[0] > (width * ctr) && ch[1] == secondarySeparator && ctr++)
                    .map!(l => l.map!(ch => cast(typeof(str[0]))ch[1]).array)
                    .array;
            }
        )
        .array
        .join
        //.map!(l => format("%s", l))
        .array;
    // dfmt on
}
