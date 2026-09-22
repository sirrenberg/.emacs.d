# Emacs rice

In order to get this setup to work, you need to perform some additional steps:

## Yank to clipboard

Install additionally wl-clipboard:

```
sudo apt install wl-clipboard
```

## Insert into .bashrc

Open emacs always in the terminal (no-window mode):

```
alias emacs='emacs -nw'
```

Start emacs deamon in the background upon first launching emacs.
Opening files afterwards just attaches to the emacs deamon, drastically reducing launch time.

```
alias e='emacsclient -t -a ""'
```

### Stopping emacs deamon to load now config

Note: If you make changes to the emacs config, you need to stop the emacs deamon so it loads the new config upon boot. You can stop it with `killall emacs`.

`kill <pid>`, `pkill` and `killall` all send the signal `SIGTERM` as default. This is a request to terminate gracefully that can be cought by a registered signal handler in the program. (interrupt handlers are a hadrdware/kernel concept, signal handlers are the kernel/userspace process analogue). 

`CTRL-C` sends `SIGINT`. Programms may treat `SIGTERM` and `SIGINT` differently. Often, `C-c` is treated as "stop what you are doing right now, but don't shut down." The `python3` shell for example doesn't terminate on `C-c`, but rather stops the current computation.

`kill -9`, `pkill -9` and `killall -9` lead to the signal `SIGKILL` getting posted. The process never sees it; the kernel simply removes the process.

`kill` takes one ore more PIDs.
`pkill` takes an extended regular expression matched against the process name. Substrings are automatically matched, so `pkill emacs` also kills `emacsclient` directly.
`killall` takes exact process names. So `killall emacs` won't match emacsclient. But since emacsclient talks to the emacs server over a socket, it automatically terminates when the deamon dies.

So `killall` is preferrable, because it is less prone to errors and typos. `pkill e` will kill all processes that contain `e` anywhere, because it is an *unanchored* regex. Anchoring could be done with `pkill '^e'` for processes starting with `e`. `killall e` will only attempt to kill processes called `e` (there could be multiple, only PID is unique).


## C++ and HTML formatting

You need to install the language servers separately:

```
sudo apt install clangd-22
sudo apt install npm
sudo npm install -g --save-exact prettier@3.9.8
```
