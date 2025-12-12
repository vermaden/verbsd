 rsync -e "ssh" --modify-window=1 -l -t -r -D -v -S -H -p --stats \
                      --force --info=progress2 --no-whole-file \
                      --numeric-ids --human-readable --no-inc-recursive \
                      --delete-after \
                      --exclude=.cache bsd_FreeBSD-14.1-PRERELEASE-amd64-20240503-19e335596658-267586-disc1.iso games:

