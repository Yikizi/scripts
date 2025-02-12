# NOTE: put this script somewhere in your $PATH
# so that `sh -c` can find it (/usr/bin/)
fzf "$@" >/tmp/fzf.answer
status=$?
echo $status >/tmp/fzf.status
exit $status
