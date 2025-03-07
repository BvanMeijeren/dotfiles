https://github.com/MiniApollo/kickstart.emacs/assets/72389030/5c66130d-66b9-459b-a26d-210f3f937459

## Packages

### Included Package list

-   Package Manager: Package.el with Use-package (built in)
-   [Evil mode](https://github.com/emacs-evil/evil): An extensible vi/vim layer
-   [General](https://github.com/noctuid/general.el): Keybindings
-   [Gruvbox-theme](https://github.com/greduan/emacs-theme-gruvbox): Color scheme
-   [Doom-modeline](https://github.com/seagle0128/doom-modeline): Prettier, more useful modeline
-   [Projectile](https://github.com/bbatsov/projectile): Project interaction library
-   [Eglot](https://www.gnu.org/software/emacs/manual/html_mono/eglot.html): Language Server Protocol Support
-   [Yasnippet](https://github.com/joaotavora/yasnippet): Template system and snippet collection package
-   Some [Org mode](https://orgmode.org/) packages (toc-org, org-superstar)
-   [Eat](https://codeberg.org/akib/emacs-eat): Fast terminal emulator within Emacs
-   [Nerd Icons](https://github.com/rainstormstudio/nerd-icons.el): For icons and more helpful ui (Supports both GUI and TUI)
-   [Magit](https://github.com/magit/magit): Complete text-based user interface to Git
-   [Diff-hl](https://github.com/dgutov/diff-hl): Highlights uncommitted changes
-   [Corfu](https://github.com/minad/corfu): Enhances in-buffer completion
-   [Cape](https://github.com/minad/cape): Provides Completion At Point Extensions
-   [Orderless](https://github.com/oantolin/orderless): Completion style that matches candidates in any order
-   [Vertico](https://github.com/minad/vertico): Provides a performant and minimalistic vertical completion UI.
-   [Marginalia](https://github.com/minad/marginalia): Adds extra metadata for completions in the margins (like descriptions).
-   [Consult](https://github.com/minad/consult): Provides search and navigation commands.
-   [Diminish](https://github.com/myrjola/diminish.el): Hiding or abbreviation of the modeline displays
-   [Rainbow Delimiters](https://github.com/Fanael/rainbow-delimiters): Adds colors to brackets.
-   [Which key](https://github.com/justbur/emacs-which-key): Helper utility for keychords

### Recommended Packages

If you want to see how to configure these, look up their git repositories or check out my [config](https://github.com/MiniApollo/config/blob/main/emacs/config.org).

-   **[DashBoard](https://github.com/emacs-dashboard/emacs-dashboard):** Extensible startup screen.
-   **[Drag Stuff](https://github.com/rejeep/drag-stuff.el):** Makes it possible to move selected text, regions and lines.
-   **[Rainbow Mode](https://github.com/emacsmirror/rainbow-mode):** Displays the actual color as a background for any hex color value (ex. #ffffff).
-   **[UndoTree](https://www.emacswiki.org/emacs/UndoTree):** Visualizes the undo history (alternative: [Vundo](https://github.com/casouri/vundo) with [undo-fu-session](https://github.com/emacsmirror/undo-fu-session)).
-   **[Vterm](https://github.com/akermu/emacs-libvterm):** Fast, Fully-fledged terminal emulator inside GNU Emacs.
-   **[Sudo-edit](https://github.com/nflath/sudo-edit):** Utilities for opening files with root privileges (also works with doas).
-   **[Treesit-auto](https://github.com/renzmann/treesit-auto):** Automatically installs and uses tree-sitter major modes in Emacs 29+.
-   **[Ws-butler](https://github.com/lewang/ws-butler):** Removes whitespace from the ends of lines.


## Requirements

-   Gnu Emacs 29.1 (Latest stable release)
-   Git (To clone/download this repository)


### Optional:

-   ripgrep
-   fd (improves file indexing performance for some commands)
-   Gnu Emacs with [native-compilation](https://www.emacswiki.org/emacs/GccEmacs) (provides noticeable performance improvements)



## Install fonts

Run the following command with M-x (alt-x) C-y to paste

```sh
nerd-icons-install-fonts
```

Change or install JetBrains Mono font


## 2. Open the configuration file

1.  Hit Space-f-c to open the config file at $HOME/.config/emacs

> **Note**
> If you use Windows you need to change the path (hit C-x C-f, find the config file and in general region replace the path)

2.  Now you can Edit and add more configuration.

