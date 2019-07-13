# terminal-psi-effects
[![asciicast](https://asciinema.org/a/l9MzOIdK4TXaZBa5kB3OX5OmQ.svg)](https://asciinema.org/a/l9MzOIdK4TXaZBa5kB3OX5OmQ)

Have you ever played the SNES game, Earthbound, and thought:
> Man, if only I could get the psychedelic effects whenever I use a psychic attack
> to render in ASCII form in my unix terminal.

If so, this is for you.

## Dependencies
mplayer is required to render the effects and play audio, and bash is required to
run the 'pk' script.

## Installation
Just run `user-install.sh`, and the 'pk' script will be installed into `~/.local/bin`,
along with the webm files used to render the effects in `~/.local/share/terminal-psi`.
The webm files take up around 7MB of space, so if you're storing all your data on floppy
disks, you may want to consider upgrading to more modern hardware.

Trust me, it'll be worth it.

## Usage
To render a random PSi attack, just type `pk` and hit enter.

To render a specific PSi attack, type `pk <attack_name>`, for example `pk fire`.

To render a specific variation of a specific PSi attack, type
`pk <attack_name> <variation_letter>`, for example `pk rockin omega`.

## What about Jeff's gadgets with visual effects?
Those are included too.
Just type `pk <gadget_name>`, for example, `pk shield-killer`.