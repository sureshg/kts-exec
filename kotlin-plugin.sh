#!/usr/bin/env bash
# A script to search for the given Kotlin compiler
# plugin jar and output it's full path.
set -euo pipefail

plugin=${1:-kotlinx-serialization}
plugin_file="${plugin}-compiler-plugin.jar"
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

if [ -z "${plugin_path}" ]; then
  echo "::set-output name=plugin-path::$plugin_file"
else
  echo "::set-output name=plugin-path::$plugin_path"
fi
