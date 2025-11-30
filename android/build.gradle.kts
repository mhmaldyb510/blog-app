allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    fun forceCompileSdk() {
        val android = extensions.findByName("android") ?: return
        try {
            // Try setting compileSdk property via reflection (setter)
            val setCompileSdk = android.javaClass.getMethod("setCompileSdk", Int::class.javaPrimitiveType)
            setCompileSdk.invoke(android, 36)
        } catch (e: Exception) {
            try {
                // Fallback to compileSdkVersion(Int)
                val compileSdkVersion = android.javaClass.getMethod("compileSdkVersion", Int::class.javaPrimitiveType)
                compileSdkVersion.invoke(android, 36)
            } catch (e2: Exception) {
                 println("Could not force compileSdk for ${project.name}: ${e2.message}")
            }
        }
    }

    if (state.executed) {
        forceCompileSdk()
    } else {
        afterEvaluate {
            forceCompileSdk()
        }
    }
}


