#!/usr/bin/env bash
# A script to search for the given Kotlin compiler
# plugin jar and output it's full path.

set -euo pipefail

plugin_file=${1:-kotlinx-serialization-compiler-plugin.jar}
echo "Searching kotlin compiler plugin: $plugin_file"

case "$OSTYPE" in
darwin*)
  plugin_path=$(find /usr/local/Cellar/kotlin -type f -name "${plugin_file}")
  ;;
msys*)
  plugin_path=$(find /c/ProgramData/Chocolatey/lib/kotlinc -type f -name "${plugin_file}")
  ;;
*)
  plugin_path=$(find /usr/share/kotlinc -type f -name "${plugin_file}")
  ;;
esac

if [ -n "${plugin_path}" ]; then
  echo "::set-output name=plugin-path::$plugin_path"
else
  echo "::set-output name=plugin-path::$plugin_file"
fi
