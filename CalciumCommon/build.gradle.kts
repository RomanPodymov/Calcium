import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    kotlin("multiplatform")
}

kotlin {
   val xcf = XCFramework()
   val iosTargets = listOf(iosX64(), iosArm64(), iosSimulatorArm64())

   iosTargets.forEach {
       it.binaries.framework {
           baseName = "CalciumCommon"
           xcf.add(this)
       }
   }

    sourceSets {
        commonMain.dependencies {
            implementation("com.ionspin.kotlin:bignum:0.3.10")
        }
    }
}
