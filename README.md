# Kotlin Script Github Action

[![Version][gh_action_img]][gh_action] [![Kotlin Script Test][workflow_img]][workflow_url]

[Kotlin][0] can also be used as a scripting language, which is safer, concise, and fun to write
than `bash` or `python`. GitHub has recently [enabled][3] `Kotlin` on `Github Action` runners, which
enables us to use [Kotlin Script][1] on GitHub Action out of the box. But using compiler plugins 
(eg: [kotlinx-serialization][2]) is not straightforward with Kotlin script and requires a bit of
fiddling. `kts-exec` is a composite GitHub Action to execute the Kotlin Script (on `mac`/`linux`
/`windows`) with a given kotlin compiler plugin and `dependency caching`.

## Inputs

### `script`

**Required** The Kotlin script to execute. Default script name is `script.main.kts`.

### `compiler-plugin`

**Optional** Kotlin compiler plugin to use. Currently, supported values are

- `kotlinx-serialization` (**Default**)
- `allopen`
- `noarg`
- `lombok`
- `sam-with-receiver`
- `kotlin-imports-dumper`

### `cache`

**Optional** Enable kotlin script dependencies caching. It is enabled (`true`) by default.

## Outputs

### `plugin-path`

Local path to the kotlin `compiler-plugin`. You may also access the path via `${{ env.PLUGIN_PATH }}`.

### `kotlin-root`

The kotlin installation path. You may also access the path via `${{ env.KOTLIN_ROOT }}`.

## Usage

Say, you want to execute the kotlin script with a `Serializable` data class for JSON processing

<details open>
<summary>script.main.kts</summary>

```kotlin
@file:DependsOn("org.jetbrains.kotlinx:kotlinx-serialization-json:1.4.0")

import kotlinx.serialization.*
import kotlinx.serialization.json.*

@Serializable
data class Lang(val name: String, val version: String)

val arg = args.firstOrNull() ?: "Kotlin"
println("Hello $arg!")

val serialized = Json.encodeToString(Lang("Kotlin", KotlinVersion.CURRENT.toString()))
println(serialized)
```

</details>  

Add the `kt-exec` to your workflow and run your kotlin script.

```yml
jobs:
  build:
    runs-on: ubuntu-lastest
    steps:
      - name: Check out repository
        uses: actions/checkout@v3

      - name: Run Kotlin Script
        uses: sureshg/kts-exec@v2.6
        with:
          script: "script.main.kts"
```

[0]: https://kotlinlang.org/

[1]: https://kotlinlang.org/docs/command-line.html#run-scripts

[2]: https://kotlinlang.org/docs/serialization.html

[3]: https://github.com/actions/virtual-environments/issues/3687

[gh_action_img]: https://img.shields.io/github/v/tag/sureshg/kts-exec?color=24292e&label=Github%20Action&logo=Github&logoColor=ffffff&style=for-the-badge
[gh_action]: https://github.com/marketplace/actions/execute-kotlin-script

[workflow_img]: https://img.shields.io/github/workflow/status/sureshg/kts-exec/Kotlin%20Script%20Test?color=green&label=Kotlin%20Script%20Test&logo=github%20actions&logoColor=green&style=for-the-badge
[workflow_url]: https://github.com/sureshg/kts-exec/actions/workflows/test.yml

[composite_actions_syntax]: https://docs.github.com/en/actions/creating-actions/metadata-syntax-for-github-actions#runs-for-composite-actions

