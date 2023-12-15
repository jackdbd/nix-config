{pkgs, ...}:
# https://www.linkedin.com/pulse/how-identify-kill-zombiedefunct-processes-linux-without-george-gabra/
pkgs.writeShellScriptBin "show-zombie-parents" ''
  # Show all zombie processes
  ps -A -o stat,ppid | grep -e '[zZ]'| awk '{ print $2 }' | uniq | xargs ps -p
''
