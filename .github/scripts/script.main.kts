#!/usr/bin/env -S kotlin -Xplugin=/usr/local/Cellar/kotlin/1.6.10/libexec/lib/kotlinx-serialization-compiler-plugin.jar

// @file:Repository("https://maven.google.com")
@file:DependsOn("io.ktor:ktor-client-core:2.0.0-beta-1")
@file:DependsOn("io.ktor:ktor-client-cio:2.0.0-beta-1")
@file:DependsOn("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.0")
@file:DependsOn("org.jetbrains.kotlinx:kotlinx-serialization-json:1.3.2")
@file:DependsOn("org.jetbrains.kotlinx:kotlinx-datetime:0.3.2")
@file:DependsOn("org.slf4j:slf4j-simple:2.0.0-alpha7")
// @file:Import("common.main.kts")

@file:CompilerOptions("-Xopt-in=kotlin.RequiresOptIn", "-jvm-target", "1.8")
@file:OptIn(ExperimentalCoroutinesApi::class, ExperimentalSerializationApi::class)

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
    delay(1000)
    println("Done!")
}
