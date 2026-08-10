# Anderix Homebrew tap

Homebrew formulas for [Anderix](https://anderix.com) tools.

```
brew tap anderix/tap
```

## What is here

Formulas are written to this repository by each project's release workflow, so
they are machine-maintained. Editing one by hand does not survive: the next
tagged release of that project overwrites it. A change belongs in the project
that produces the formula, not here.

## lux

`lux` is a small language built to be a great first language and then to be
outgrown — [anderix/lux](https://github.com/anderix/lux). Its formula publishes
here with the next tagged release, and installs with:

```
brew install anderix/tap/luxc
```

The formula is named `luxc` rather than `lux`, matching the crate name on
crates.io. `lux` was already taken in each place the project needed a name: on
crates.io by an unrelated 2016 package, and in homebrew-core by a video
downloader, which wins the plain name over any tap and would quietly install
something else entirely. One name across all three registries is easier to hold
onto than one exception per channel.

The binary is `lux`. That is the only name to type after installing — the
package name is for the install command and nothing else.
