# NOTE: put this script somewhere in your $PATH
# so that `sh -c` can find it (/usr/bin/)
fzf "$@"
status=$?
echo $status >/tmp/fzf.status
exit $status
