package com.example.remedio_certeiro

import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "alarm_channel"
    private var ringtone: Ringtone? = null
    private val handler = Handler(Looper.getMainLooper())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "playAlarm" -> {
                    playAlarm()
                    result.success(null)
                }
                "stopAlarm" -> {
                    stopAlarm()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun playAlarm() {
        val alarmUri: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
        ringtone = RingtoneManager.getRingtone(applicationContext, alarmUri)
        ringtone?.play()
        handler.postDelayed({
            ringtone?.stop()
        }, 10000)
    }

    private fun stopAlarm() {
        ringtone?.stop()
        ringtone = null
    }
}
