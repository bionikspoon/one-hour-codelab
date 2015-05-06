Dart Code Lab Samples
============================

**Playing with dart...**

![screenshot](screenshot.png "screenshot")


These are small Dart samples used by two codelabs: the [Avast Ye, Pirates][client-codelab], in which you learn to build and web app, and which takes about an hour to complete, and the [Beware the Nest o' Pirates][server-codelab] which shows you how to write a RESTful Dart server.

Repo and testing
----------------

Currently, drone.io tests only whether the .dart files under web/ pass static analysis (dartanalyzer). We could do real unit testing, and we could do better with HTML samples.

Project structure
-----------------

#### `darrrt/`
Code samples used by the Avast Ye, Pirates code lab. Each numberical version corresponds to a step in the code lab.
```
1-blankbadge/
2-inputnamebadge/
3-buttonbadge/
4-classbadge/
5-localbadge/
6-piratebadge/
```

#### `server/`
Code samples used by the Beware the Nest o' Pirates code lab. Each numberical version corresponds to a step in the code lab.
```
1-starter/
2-simple/
4-extended/
5-generated/
6-client/
7-serve/
```

#### `README.md`
This file.

#### `runtests.sh`
BASH script that runs dartanalyzer on all Dart source files in the web directory.

[client-codelab]: https://www.dartlang.org/codelabs/darrrt/
[server-codelab]: https://www.dartlang.org/codelabs/server/
