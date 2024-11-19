package com.mm_terekhin.get_apps

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.*
import kotlin.collections.*
import android.net.Uri

/** GetAppsPlugin */
class GetAppsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "mm_terekhin/get_apps_channel")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val arguments = call.arguments as? Map<String, Any>

        when (call.method) {
            "getInstalledMessengers" -> getInstalledMessengers(result)
            "openMessenger" -> openMessenger(arguments)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getInstalledMessengers(result: Result) {
        val installedMessengers = arrayListOf<Map<String, String>>()

        for (messenger in messengers) {
            val isInstalled = isAppInstalled(messenger.packageName)

            if (isInstalled) {
                val app = mapOf("app_name" to messenger.name, "type" to messenger.type)
                installedMessengers.add(app)
            }
        }

        result.success(installedMessengers)

    }

    private fun openMessenger(args: Map<String, Any>?) {
        val type = args?.get("type") as? String
        val arg = args?.get("args") as? String

        if (type != null && arg != null) {
            when (type) {
                "whatsApp" -> open("https://api.whatsapp.com/send?phone=$arg")
                "telegram" -> open("tg://resolve?domain=$arg")
                else -> {}
            }
        }
    }

    private fun open(url: String) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }

    private fun isAppInstalled(packageName: String): Boolean {
        val packageManager = context.packageManager

        try {
            packageManager.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES)
            return true
        } catch (e: PackageManager.NameNotFoundException) {
            return false
        }
    }

}

class App {
    val name: String
    val type: String
    val packageName: String

    constructor(_name: String, _type: String, _packageName: String) {
        name = _name
        type = _type
        packageName = _packageName
    }
}

enum class MessengerType(val type: String) {
    WHATSAPP("whatsApp"),
    TELEGRAM("telegram")
}

private val messengers = arrayOf(
    App("whatsApp", MessengerType.WHATSAPP.type, "com.whatsapp"),
    App("telegram", MessengerType.TELEGRAM.type, "org.telegram.messenger")
)