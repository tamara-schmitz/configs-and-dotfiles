How I renamed the master repo in my fork and then pulled the upstream master:

- Rename branch: `git branch -m orig-name new-name`
- Delete branch with old name from remote and push local under new name: `git push origin :orig-name new-name` (can fail on Github as you need at least one branch in your repo)
- Add upstream as second remote: `git remote upstream git-url`
- Pull upstream as local remote: `git pull upstream orig-name`
- Push upstream to fork: `git push origin orig-name`
- Change remote of orig-name to remote of fork: `git branch orig-name --set-upstream-to=origin/orig-name`
- If you want to merge new changes from upstream into your fork use: `git fetch upstream && git checkout orig-name && git merge upstream/orig-name`
- Use LFS: `git lfs init`, `git lfs track "*.gz,*.xz,*.bz2,*.zstd,*.7z,*.rar,*.zip"`
