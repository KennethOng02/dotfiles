cf() {
  for path in "$@"; do
    if [ -d "$path" ]; then
      /usr/bin/find "$path" -type f -exec echo "===== {} =====" \; -exec /bin/cat {} \; 
    elif [ -f "$path" ]; then
      echo "===== $path ====="
      /bin/cat "$path"
    else
      echo "Error: $path not found"
    fi
  done | /usr/bin/pbcopy
  echo "Copied content of: $*"
}
