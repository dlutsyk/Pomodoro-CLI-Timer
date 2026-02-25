# pom

Pomodoro timer w/ Focus mode integration.

## Dependencies

```bash
brew install gum timer terminal-notifier
```

## Setup

Create two shortcuts in Shortcuts.app:

### 1. Create new shortcut
Open Shortcuts.app, click `+` in toolbar.

![Add new shortcut](images/add-shortcut.png)

### 2. Focus On
- Search "Set Focus" action
- Configure: Turn Focus **On**
- Name it `Focus On`

![Focus On shortcut](images/focus-on.png)

### 3. Focus Off
- Same steps, but set Focus **Off**
- Name it `Focus Off`

![Focus Off shortcut](images/focus-off.png)

## Usage

```bash
./pom.zsh
# or
POMO_SPLIT="25/5" ./pom.zsh  # skip menu
```

Splits: `25/5`, `50/10`, `all done` (exit)

### Demo

![Split selection menu](images/split-menu.png)

![Timer running](images/timer.png)

![Break prompt](images/break-prompt.png)
