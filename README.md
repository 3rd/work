# work

> Simple utility to work on multiple things at the same time, powered by git-worktree and fzf.

---

`work` is a convenient wrapper over `git-worktree`.
It keeps all work trees of a repository side by side in one directory:

```
project/
├── main/      the original checkout, moved here by `work init`
├── feature/   a work tree created by `work new feature`
└── hook.sh    optional, see "Hooks"
```

Extra dependencies:
- fzf

---

### Usage

```
Usage:
  work                   interactive switcher, prints tree path
  work i, init           setup "work" in cwd
  work new <name>        create new work tree and switch to it
  work rm, remove <name> remove work tree
  work ls, list          list work trees
  work b, branch [name]  switch current work tree to branch
                         if [name] is provided, switch to branch or create it
                         if [name] is not provided, select branch interactively
  work help              print usage
  work <command>         run a command of the work hook
```

Run `work init` once, from the repository root. It moves everything in that directory, including `.git`, into a new `main` directory, so the original directory becomes `project/` above.

`work new <name>` creates `project/<name>` with a detached `HEAD` at the current commit. Use `work b` inside it to pick a branch.

Every command except `init` and `help` works from anywhere inside `project/`, including `project/` itself.

### Where new trees go

New trees go next to the main tree, unless the repository sets `work.dir`:

```
git config work.dir ../project.trees
```

The value is an absolute path, or a path relative to the main tree. Trees made before you set it stay where they are.

### Hooks

A hook is an executable that `work` runs at points in a tree's life. It is the file named by `git config work.hook <path>`, or `project/hook.sh` when that setting is unset. Like `work.dir`, the path is absolute or relative to the main tree. `work` runs it directly, so it needs the executable bit; if it doesn't have it, every command stops with an error.

`work` calls the hook with an event name and the tree's absolute path:

- `new <tree>` runs after `work new` creates the tree. If it fails, `work` removes the tree again.
- `switch <tree>` runs after you select a tree with the switcher.
- `remove <tree>` runs before `work remove`. If it fails, the tree is kept.
- `removed <tree>` runs after the tree is removed.
- `describe <tree>` prints one line, which `work` shows next to the tree in the switcher and in `work ls`.

Commands `work` doesn't know go to the hook with their arguments, so a hook that handles `sync` gives you `work sync`. `work help` also prints the output of `<hook> help`. A hook should exit 0 for events and commands it doesn't handle.

Every call gets `WORK_MAIN_TREE` and `WORK_TREES_DIR`, the main tree and the folder for new trees. Except for `describe` and `help`, the hook's output goes to stderr, so nothing it prints can make the shell wrapper change directory. A command that should move you to another directory writes that path into the file named by `WORK_CD_FILE`; after the hook exits 0, `work` prints `-> <path>` if the path is an existing directory. A relative path is relative to the directory you ran `work` from.

`example_hook.sh` keeps a `project/current` symlink pointing at the tree you last created or switched to. Copy it to `project/hook.sh` to use it.

### Shell wrapping

A program cannot change the directory of the shell that started it. When `work` wants you in another tree, it prints `-> <path>` on its own line, and a shell function has to `cd` there and print the other lines.

**Fish shell:**

- Edit `work.fish` and replace the path to the `work` script.
- Add `work.fish` to your fish functions directory.
