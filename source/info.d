module info;
import common;
import net;
import std.json;
import std.typecons;
import std.format;
import std.stdio;

struct Date {
    string day = null;
    string month = null;
    string year = null;

    string toString() const
    in (day && month && year) {
        return format("%s-%s-%s", year, month, day);
    }
}

alias NullDate = Nullable!(Date, nullDate);

immutable nullDate = Date(null, null, null);

struct Info {
    NullDate date = nullDate;

    string title = null;
    string altTitle = null;

    string transcript = null;

    string imgUrl = null;

    string comicUrl = null;

    int comicNum;
}

Info asInfo(JSONValue json, int num) {
    Info i = {
        date: json.getDate(), //
        title: json.getTitle(), //
        altTitle: json.getAltTitle(), //
        transcript: json.getTranscript(), //
        imgUrl: json.getImgUrl(), //
        comicUrl: getComicUrl(num), comicNum: num,
    };
    return i;
}

private NullDate getDate(const ref JSONValue json) {
    const day = json.hasNonEmptyString("day");
    const month = json.hasNonEmptyString("month");
    const year = json.hasNonEmptyString("year");

    if (day && month && year) {
        Date d = {day: day, month: month, year: year};
        return NullDate(d);
    } else {
        return NullDate(nullDate);
    }
}

private string getTitle(const ref JSONValue json) {
    return orElse(json.hasNonEmptyString("safe_title"), json.hasNonEmptyString("title"));
}

private string getAltTitle(const ref JSONValue json) {
    return json.hasNonEmptyString("alt");
}

private string getTranscript(const ref JSONValue json) {
    return json.hasNonEmptyString("transcript");
}

private string getImgUrl(const ref JSONValue json) {
    return json.hasNonEmptyString("img");
}

private string getComicUrl(int num) {
    return format("%s/%d", BASE_NAME, num);
}

private string hasNonEmptyString(const ref JSONValue json, string str) {
    const s = str in json;
    if (!s) {
        writeln(str, " not found in json");
        return null;
    }
    if (s.type() != JSONType.string) {
        writeln(str, " not of type string");
        return null;
    }
    const asStr = s.str();
    if (asStr == "") {
        writeln(str, " is empty");
        return null;
    }
    return asStr;
}
