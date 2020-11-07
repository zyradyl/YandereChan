YandereChan
=========
A utility bot for discord written in Ruby, with the help of [Discordrb](https://github.com/discordrb/discordrb).

Dual-licensed under both MIT and the [UNLICENSE](https://unlicense.org/). If you are in a jurisdiction that recognizes public domain I politely urge you to use the UNLICENSE grant instead of the MIT License.

This bot is currently under a lot of construction and isn't really ready for use yet. I'm focusing on getting most of the commands done and giving her some unique traits, after which I'll move on to refactoring the code. So expect a lot of Proof-of-Concept code that looks rather ugly.

### Current Development Plans: ###

- Broadcasts (Custom Embeds)
  - ~~Wizard to construct them.~~ **PoC Done.**
  - ~~Store them in a flatfile database for easy lookup.~~ **Done, works for now.**
  - Ability to list all broadcasts on the server.
  - ~~Ability to delete individual broadcasts.~~ **PoC Done.**
  - Ability to modify broadcasts after they're posted.
- ~~Users~~ **Essentially done, could use fine tuning.**
  - ~~Two major ranks, Admins and Moderators~~ **Done.** Implemented as "Senpais" and "Rivals" with appropriate flavor text.
  - ~~Easy function to check permissions that can be embedded into other commands.~~ **Done.** `CheckPermissions.process()` returns 0 for global, 1 for local, 2 for rival.
  - ~~Ability to add new members.~~ **Done.**
    - ~~Check for duplicates.~~ **Done.**
  - ~~Ability to delete members.~~ **PoC Done.**
  - ~~Ability to list members.~~ **Done.**
- Reaction Roles
  - Ability to create them using a wizard
  - Store them in a flatfile database for easy lookup
  - Removing a reaction removes the role
  - Should eventually have different types.
    - Normal
    - Unique
    - Others as needed
  - Ability to modify the RR menu after it is posted.
  - Ability to list all RR menus in the server
  - Ability to delete them
- Customization
  - Ability to change the responses for almost all commands.
  - Eventually able to change the commands too?
  - Could give each instance a "Persona" too.
- Long Term Goals
  - Twitch Integration?
  - Eventually move to SQLite for the database.
  - Sharding? Unlikely to ever need it.
  - Having her pick a new personality every day at random. Could be a fun bit of flavoring. Would literally double the size of the config for every single other personality.
  - Rewrite in a more performant language, probably Crystal.
