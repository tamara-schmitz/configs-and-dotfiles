Make sure that you can run `git lfs`. If you cannot you are missing a dependency.

If you start a new repo all you need to do is to use `git lfs track "*.zip"` to mark future file types or directories.
But this does not work if you want to migrate an existing repo. If your goal is to save space and make cloning faster,
you need to rewrite the entire git history!

It is good to clone the entire repo in a separate folder, before pushing any of your changes.

Do not run git lfs track yet and if you have, remove any `.gitattributes` files that it has created.

Instead, start the migration like this:

```bash
git lfs migrate import --everything \
    --include="*.mp4,*.MP4,*.mov,*.MOV,*.webm,*.mkv,*.flac,*.mp3,*.jpg,*.JPG,*.jpeg,*.JPEG,*.png,*.PNG,*.bmp,*.webp,*.ogg,*.gz,*.xz,*.bz2,*.zstd,*.7z,*.rar,*.zip,*.gpg,*.pdf,*.docx,*.doc,*.odt,*.xls,*.ods,*.pptx,*.odp"
```

Once completed, run `git push --force` **to rewrite history!! muahahah!**.

Ahem yeah if thinks go wrong, just force-push the old clone again.

### Cleanup

Let's clean up. To remove unreferenced LFS objects from your local clone, run `git lfs prune`.

Cleaning up a remote repo is more tricky:
- GitHub does not allow you to clean them up and recommends you to delete, create and push the same repo
- BitBucket seems to have a manual deletion function
- GitLab has a Rake task for this that may or may not run regularly: https://docs.gitlab.com/ee/raketasks/cleanup.html#remove-unreferenced-lfs-files-from-filesystem

### Resources

- [https://git-lfs.github.com/]
- [https://github.com/git-lfs/git-lfs/blob/main/docs/man/git-lfs-migrate.1.ronn]
