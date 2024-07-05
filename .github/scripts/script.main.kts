#!/usr/bin/env -S kotlin -Xplugin=/usr/local/opt/kotlin/libexec/lib/kotlinx-serialization-compiler-plugin.jar

// @file:Repository("https://maven.google.com")
@file:DependsOn("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.9.0-RC")
@file:DependsOn("org.jetbrains.kotlinx:kotlinx-serialization-json:1.7.1")
// @file:Import("common.main.kts")

@file:CompilerOptions("-opt-in=kotlin.RequiresOptIn", "-jvm-target", "1.8")

import kotlinx.coroutines.*
import kotlinx.serialization.*
import kotlinx.serialization.json.*

@Serializable
data class Lang(val name: String, val version: String)

val arg = args.firstOrNull() ?: "Kotlin"
println("Hello $arg!")

val serialized = Json.encodeToString(Lang("Kotlin", KotlinVersion.CURRENT.toString()))
println(serialized)

val javaVer: String = System.getProperty("java.version")
val deserialized = Json.decodeFromString<Lang>("""{"name" : "Java", "version": "$javaVer"}""")
println(deserialized)

runBlocking {
    delay(100)
    println("Done!")
}
