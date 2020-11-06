package com.byneapp.flutter_config

import android.app.Activity
import android.content.Context
import android.content.res.Resources
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.lang.IllegalArgumentException
import java.lang.reflect.Field

class FlutterConfigPlugin(private val context: Context? = null): FlutterPlugin, MethodCallHandler {

  private var applicationContext: Context? = context

  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_config")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    applicationContext = null
  }

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
      val context = applicationContext!!.applicationContext
      val resId = context.resources.getIdentifier("build_config_package", "string", context.packageName)
      val className: String = try {
        context.getString(resId)
      } catch (e: Resources.NotFoundException) {
        applicationContext!!.packageName
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
