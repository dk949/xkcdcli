module net;
import std.net.curl;
import std.format;

immutable BASE_NAME = "https://xkcd.com";
immutable FILE_NAME = "info.0.json";
immutable DO_CURL = true;

char[] getComic(int i) {
    static if (DO_CURL)
        return format("%s/%d/%s", BASE_NAME, i, FILE_NAME).get();
    else {
        assert(i == 47);
        return `
{
"month": "1",
"num": 47,
"link": "",
"year": "2006",
"news": "",
"safe_title": "Counter-Red Spiders",
"transcript": "[[A stack of stick figures, standing on each others shoulders extends from the bottom of the frame to the top.  Cuboids hang in the air]]\nThe counter-red-spider offensive begins ...\n{{title text: I hope we can stop them}}",
"alt": "I hope we can stop them",
"img": "https://imgs.xkcd.com/comics/counter-red-spiders.jpg",
"title": "Counter-Red Spiders",
"day": "9"
}
`.dup;
    }
}
