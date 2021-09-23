#!/usr/bin/env bash
# A script to search for the given Kotlin compiler
# plugin jar and output it's full path.
set -euo pipefail

plugin=${1:-kotlinx-serialization}
plugin_file="${plugin}-compiler-plugin.jar"

case "$OSTYPE" in
darwin*)
  plugin_path=$(find /usr/local/Cellar/kotlin -type f -iname "${plugin_file}")
  ;;
msys*)
  plugin_path=$(find /c/tools/kotlinc -type f -iname "${plugin_file}")
  ;;
*)
  plugin_path=$(find /usr/share/kotlinc -type f -iname "${plugin_file}")
  ;;
esac

if [ -z "${plugin_path}" ]; then
  echo "::set-output name=plugin-path::$plugin_file"
  echo "::set-output name=kotlin-root::UNKNOWN"
else
  echo "::set-output name=plugin-path::$plugin_path"
  kotlin_root=$(
    builtin cd "$(dirname "$plugin_path")/../.."
    pwd
  )
  echo "::set-output name=kotlin-root::$kotlin_root"
fi
