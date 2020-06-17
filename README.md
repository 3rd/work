# work

> Simple utility to work on multiple things at the same time, powered by git-worktree and fzf.

---

`work` is a convenient wrapper over `git-worktree`.

Extra dependencies:
- fzf
- ripgrep

---

### Usage

```
Usage:
  work                   interactive switcher, prints tree path
  work i, init           prepare cwd for work
  work ls, list          list work trees
  work b, branch [name]  switch current work tree to branch
                         if name is provided, switch to branch or create it
                         if name is not provided, select branch interactively
  work help              print usage
```

### Shell wrapping

You need to create a function in your shell that will `cd` based on `work`'s output.

**Fish shell:**

- Edit `work.fish` and replace the path to the `work` script.
- Add `work.fish` to your fish functions directory.

