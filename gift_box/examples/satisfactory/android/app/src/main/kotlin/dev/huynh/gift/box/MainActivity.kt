package dev.huynh.gift.box

import android.content.pm.ActivityInfo
import android.content.res.Configuration
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import androidx.window.core.layout.WindowHeightSizeClass
import androidx.window.core.layout.WindowSizeClass
import androidx.window.core.layout.WindowWidthSizeClass
import androidx.window.layout.WindowMetricsCalculator
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private fun compactScreen(): Boolean {
        val metrics = WindowMetricsCalculator.getOrCreate().computeMaximumWindowMetrics(this)
        val width = metrics.bounds.width()
        val height = metrics.bounds.height()
        val density = resources.displayMetrics.density
        val windowSizeClass = WindowSizeClass.compute(width / density, height / density)

        return windowSizeClass.windowWidthSizeClass == WindowWidthSizeClass.COMPACT || windowSizeClass.windowHeightSizeClass == WindowHeightSizeClass.COMPACT
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestedOrientation = when (compactScreen()) {
            false -> ActivityInfo.SCREEN_ORIENTATION_FULL_USER
            true -> ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
        }

        val decorView = window.decorView as? ViewGroup
        decorView?.addView(object : View(this) {
            override fun onConfigurationChanged(newConfig: Configuration?) {
                super.onConfigurationChanged(newConfig)
                requestedOrientation = when (compactScreen()) {
                    false -> ActivityInfo.SCREEN_ORIENTATION_FULL_USER
                    true -> ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
                }
            }
        })
    }
}
