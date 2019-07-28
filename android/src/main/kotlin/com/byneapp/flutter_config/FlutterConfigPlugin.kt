package com.byneapp.flutter_config

import android.app.Activity
import android.content.res.Resources
import io.flutter.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.lang.IllegalArgumentException
import java.lang.reflect.Field

class FlutterConfigPlugin(private val activity: Activity): MethodCallHandler {

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_config")
      channel.setMethodCallHandler(FlutterConfigPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "loadEnvVariables") {
      val variables = loadEnvVariables()
      result.success(variables)
    } else {
      result.notImplemented()
    }
  }

  private fun loadEnvVariables(): Map<String, Any?> {
    val variables = hashMapOf<String, Any?>()

    try {
      val context = activity.applicationContext
      val resId = context.resources.getIdentifier("build_config_package", "string", context.packageName)
      var className: String
      try {
          className = context.getString(resId)
      } catch (e: Resources.NotFoundException) {
        className = activity.applicationContext.packageName
      }

      val clazz = Class.forName("$className.BuildConfig")

      fun extractValue(f: Field): Any? {
        return try {
          f.get(null)
        } catch (e: IllegalArgumentException) {
          null
        } catch (e: IllegalAccessException) {
          null
        }
      }

      clazz.declaredFields.forEach {
        variables += it.name to extractValue(it)
      }
    } catch (e: ClassNotFoundException) {
      Log.d("FlutterConfig", "Could not access BuildConfig")
    }
    return variables
  }
}
