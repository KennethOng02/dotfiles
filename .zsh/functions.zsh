cf() {
  for path in "$@"; do
    if [ -d "$path" ]; then
      /usr/bin/find "$path" \
        -type d \( -name 'node_modules' -o -name 'dist' -o -name '.turbo' -name 'target' -name '.git' \) -prune \
        -o \
        -type f \
          ! -name '.DS_Store' \
          ! -name 'LICENSE' \
          ! -name 'LICENSES' \
          ! -name 'licence*' \
          ! -name 'readme.*' \
          ! -name 'README.*' \
          ! -name '*.*md' \
          ! -name 'pnpm-lock.yaml' \
          ! -name '.gitignore' \
          -print0 \
      | while IFS= read -r -d $'\0' file; do
        echo "===== $file ====="
        /bin/cat "$file"
      done
    elif [ -f "$path" ]; then
      echo "===== $path ====="
      /bin/cat "$path"
    else
      echo "Error: $path not found"
    fi
  done | /usr/bin/pbcopy
  echo "Copied content of: $*"
}
