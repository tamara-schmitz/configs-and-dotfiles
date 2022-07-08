#/bin/sh
set -xeou

# tar folder, then compress with zstd, then gpg encrypt all using pipes.

# you may find out which folders to look at for bloat using either
# a graphical disk usage analyzer or: du -sh /home/<user>/*
tar -I 'zstd -T0 -15 --long' -cpv --acls --xattrs \
	--exclude-caches \
    --exclude='*/.cache*' --exclude='*/cache*' --exclude='*Cache*' \
    -f - /home/<user> | \
gpg -e --always-trust --yes -r '<your_public_key>' > \
	/home/$(date -Idate)-backup-home.tar.zstd.gpg
