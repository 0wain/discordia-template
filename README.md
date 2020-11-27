# discordia-template
A template for [Discordia](https://github.com/SinisterRectus/Discordia), including base handlers and a command engine.
I honestly believe that Lua is the perfect language for something like a Discord bot. Being easy to both write and read, it creates a great environment to learn the basics of Discord bot development along with basic programming logic.

# Features
- A command engine. Allowing for easy command registration with automatic argument filtering and prefix hot-swapping.
- An SQLite wrapper. Using [SinisterRectus'](https://github.com/SinisterRectus/lit-sqlite3) sqlite3 for Luvit. Instructions for installing the deps for this are in the Set-Up section.
- Simple commands and events folders that are autoloaded.
- Basic config for including your token

# Note
This is made primarily for me. There is some things that maybe aren't best practice (For example forcing CLIENT, CONFIG and the handlers into the global table). This is public so you can either use it for quickly getting a bot started or just to learn. The command handler and SQL wrapper are both basic implementations but work fine. There are ofc limitations to this, but for my use case, it works fine.

# Set-Up
There are a few things you need to do in order to have this working.
1. Make sure you have [luvit](https://luvit.io/) installed and up to date.
2. Clone this repo into your work environment.
3. Install [Discordia](https://github.com/SinisterRectus/Discordia) in this root directory: `lit install SinisterRectus/discordia`
4. Install [Lit SQLite3](https://github.com/SinisterRectus/lit-sqlite3) in this root directory: `lit install SinisterRectus/sqlite3` (SinisterRectus really carrying the luvit community)
5. Install the SQLite3 binaries in your root directory. You can find it [here](https://sqlite.org/download.html). Or can take a look at [this](https://github.com/SinisterRectus/lit-sqlite3) for more info on [Lit SQLite3](https://github.com/SinisterRectus/lit-sqlite3)
