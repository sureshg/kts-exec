# Kotlin Script Github Action

[![Kotlin Script Test](https://github.com/sureshg/kts-exec/actions/workflows/test.yml/badge.svg)](https://github.com/sureshg/kts-exec/actions/workflows/test.yml)

[Kotlin][0] can also be used as a scripting language, which is more safer, concise, and fun to write
than `bash` or `python`. Github has recently [enabled][3] `Kotlin` on `Github Action` runners, which
enables us to use [Kotlin Script][1] on Github Action out of the box. But using compiler plugins (
eg: [kotlinx-serialization][2]) is not straightforward with Kotlin script and requires a bit of
fiddling. `kts-exec` is a composite Github Action to execute the Kotlin Script (on `mac`/`linux`
/`windows`) with a given kotlin compiler plugin.

## Inputs

### `script`

**Required** The Kotlin script to execute. Default script name is `script.main.kts`.

### `compiler-plugin`

**Optional** Kotlin compiler plugin to use. Currently supported values are,

- `kotlinx-serialization` (**Default**)
- `allopen`
- `noarg`
- `lombok`
- `sam-with-receiver`

## Usage

Say, you want to execute the kotlin script with a `Serializable` data class for JSON processing

<details open>
<summary>script.main.kts</summary>

```kotlin
@file:DependsOn("org.jetbrains.kotlinx:kotlinx-serialization-json:1.2.2")

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
        uses: actions/checkout@v2

      - name: Run Kotlin Script
        uses: sureshg/kts-exec@v2
        with:
          script: "script.main.kts"
```

[0]: https://kotlinlang.org/

[1]: https://kotlinlang.org/docs/command-line.html#run-scripts

[2]: https://kotlinlang.org/docs/serialization.html

[3]: https://github.com/actions/virtual-environments/issues/3687