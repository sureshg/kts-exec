#!/usr/bin/env bash
# A script to search for the given Kotlin compiler
# plugin jar and output it's full path.
set -euo pipefail

plugin=${1:-kotlinx-serialization}
plugin_file="${plugin}-compiler-plugin.jar"

case "$OSTYPE" in
darwin*)
  plugin_path=$(find /usr/local/Cellar/kotlin -type f -iname "${plugin_file}")
  if [ -n "${plugin_path}" ]; then
    kotlin_root=$(
      builtin cd "$(dirname "${plugin_path}")/../.."
      pwd
    )
  fi

  ;;
msys*)
  kotlin_root="/c/tools/kotlinc"
  plugin_path=$(find $kotlin_root -type f -iname "${plugin_file}")
  ;;
*)
  kotlin_root="/usr/share/kotlinc"
  plugin_path=$(find $kotlin_root -type f -iname "${plugin_file}")
  ;;
esac

# Set plugin path
if [ -z "${plugin_path}" ]; then
  echo "plugin-path=$plugin_file" >>"$GITHUB_OUTPUT"
else
  echo "plugin-path=$plugin_path" >>"$GITHUB_OUTPUT"
  echo "PLUGIN_PATH=$plugin_path" >>"$GITHUB_ENV"
fi

# Set kotlin install path
if [ -z "${kotlin_root}" ]; then
  echo "kotlin-root=UNKNOWN" >>"$GITHUB_OUTPUT"
else
  echo "kotlin-root=$kotlin_root" >>"$GITHUB_OUTPUT"
  echo "KOTLIN_ROOT=$kotlin_root" >>"$GITHUB_ENV"
  # echo "$kotlin_root" >> $GITHUB_PATH
fi
