#! /bin/sh



find . \
  -mtime -7 \
  -type f \
    | grep -v \
           -e './.mozilla/firefox' \
           -e './.local/share/TelegramDesktop' \
           -e './.cache/' \
           -e './.config/google-chrome' \
           -e './.config/chromium' \
           -e './.config/pulse' \
           -e './.config/GIMP/2.10' \
           -e './_bahamas' \
           -e './.config/libreoffice' \
           -e 'Camera' \
           -e 'thunderbird' \
           -e 'ESTATE.nc.tr' \
           -e 'git.scripts' \
           -e './scripts/' \
           -e './.config/' \
           -e './_END_paski' \
           -e '0000' \
           -e './.local/share' \
           -e './gfx/wal' \
           -e './gfx/scr' \
           -e './____MOVE/' \
           -e './misc/ORG.fme/report.MONTH' \
           -e './misc/'


