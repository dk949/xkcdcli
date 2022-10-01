import args;
import info;
import common;
import draw;
import run: run;
import net: getComic;

import std.json;
import std.stdio;

int main(string[] args) {
    try {
        const parsed = Args.parseArgs(args);
        const info = getComic(parsed.comicNum).parseJSON().asInfo(parsed.comicNum);
        run(parsed, info);
    } catch (ExitException e)
        return e.exitCode;
    catch (ArgException e)
        return ecWriteln(1, "Argument error: ", e.msg);
    catch (JSONException e)
        return ecWriteln(-1, "Internal error: invalid JSON response.");
    catch (DrawException e)
        return ecWriteln(1, "Draw error: ", e.msg);
    catch (Exception e)
        return ecWriteln(2, "Unexpected error: ", typeid(e), ": ", e.msg);
    return 0;
}
