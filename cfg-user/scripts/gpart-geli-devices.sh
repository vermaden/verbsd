#! /bin/sh

unset TYPE
unset GPART
unset TARGET

ls /dev \
  | grep -E "(da|ad|ada|mmcsd)+[0-9]+$" \
  | while read DEV
    do
      if [ -h /dev/${DEV} ]
      then
        continue
      fi
      GPART=$( gpart show /dev/${DEV} 2> /dev/null )
      if echo "${GPART}" | grep -q -E '\!159|dragonfly-hammer'
      then
        if echo "${GPART}" | grep -q 'MBR'
        then
          TYPE=MBR
        fi
        if echo "${GPART}" | grep -q 'GPT'
        then
          TYPE=GPT
        fi
        case ${TYPE} in
          (0)
            echo "GPART: part TYPE not detected '0'."
            exit 1
            ;;
          (GPT)
            echo "${GPART}" \
        | grep -E '\!159|dragonfly-hammer' \
        | awk '{print $3}' \
        | while read I
          do
            echo /dev/${DEV}p${I}
          done
            ;;
          (MBR)
            echo "${GPART}" \
        | grep -E '\!159|dragonfly-hammer' \
        | awk '{print $3}' \
        | while read I
          do
            echo /dev/${DEV}p${I}
          done
            ;;
        esac
      fi
    done
