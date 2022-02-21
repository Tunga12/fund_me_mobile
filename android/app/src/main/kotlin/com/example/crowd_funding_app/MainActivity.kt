package com.example.crowd_funding_app

import io.flutter.embedding.android.FlutterActivity

import android.content.BroadcastReceiver
import android.os.Bundle
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import com.example.crowd_funding_app.main.Constants
import com.easier.ethiopaysdk.bean.PaymentResult
import com.easier.ethiopaysdk.AngolaPayUtil
import com.easier.ethiopaysdk.util.PaymentResultListener
import com.easier.ethiopaysdk.TradePayMapRequest
import java.util.*

import android.os.Handler
import android.os.Looper

class MainActivity: FlutterActivity(), PaymentResultListener {

    private val CHANNEL = "https:www.crowdfund.com/channel"
    private val EVENTS = "https:www.crowdfund.com/events"
    private var startString: String? = null
    private var linksReceiver: BroadcastReceiver? = null

    // telebirr variables
    private val TELEBIRR_CHANNEL = "legas/telebirr_channel"
    var listner: MethodChannel.Result? = null

    //private var uiThreadHandler: Handler? = null



    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                if (startString != null) {
                    result.success(startString)
                }
            }
        }

        EventChannel(flutterEngine.dartExecutor, EVENTS).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(args: Any?, events: EventSink) {
                        linksReceiver = createChangeReceiver(events)
                    }

                    override fun onCancel(args: Any?) {
                        linksReceiver = null
                    }
                }
        )


        // the telebirr part
        AngolaPayUtil.getInstance().setPaymentResultListener(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TELEBIRR_CHANNEL)
            .setMethodCallHandler { call, result ->
            // manage method calls here
            this.listner = result
            if (call.method == "showNativeView") {
                val arguments = call.arguments() as Map<String, String>
                //initTeleBirr(getRandomNumber().toString(),"1")
                initTeleBirr(arguments["outTradeNo"],arguments["price"], arguments["subject"])
            } else {
                result.notImplemented()
            }
        }
    }

    fun initTeleBirr( payOTN: String?, price: String?, subject: String?) {
        val request = TradePayMapRequest()
        request.appId = Constants.appidetProduction
        request.setNotifyUrl(Constants.notifyUrlet)
        request.setOutTradeNo(payOTN)
        request.setReceiveName(Constants.receiverNameet)
        request.setReturnUrl(Constants.returnUrlet)
        request.setShortCode(Constants.shortcodeProduction)
        request.setSubject(subject)
        request.setTimeoutExpress(Constants.timeoutExpresset)
        request.setTotalAmount(price)
        AngolaPayUtil.getInstance().startPayment(request, this)
    }

    override fun paymentResult(result: PaymentResult) {
        if(listner != null){
            try {
                //this.uiThreadHandler = new Handler(Looper.getMainLooper())
                //uiThreadHandler.post(() -> { listner!!.success("{'CODE': result.getCode(), 'MSG': result.getMsg(), 'DATA': result.getData()}") })  

                this@MainActivity.runOnUiThread(java.lang.Runnable {
                    listner!!.success("{\"CODE\": \"${result.getCode()}\", \"MSG\": \"${result.getMsg()}\", \"TRADE_STATUS\": \"${result.getData().getTradeStatus()}\"}")  
                })
      
            }catch (e:Exception){
                println(e)
                println(e.printStackTrace())
            }
            //listner!!.error(result.msg, result.code.toString(),"test")
            //finish()
        }
    }
    /*override fun onBackPressed() {
        super.onBackPressed()
        val result = PaymentResult()
        result.code = -3
        result.msg = "Payment Cancelled"
        paymentResult(result)
        AngolaPayUtil.getInstance().stopPayment()
    }*/
    fun getRandomNumber(): Int {
        // It will generate 6 digit random Number.
        // from 0 to 999999
        val rnd = Random()
        // this will convert any number sequence into 6 character.
        //return rnd.nextInt(999999);
        return rnd.nextInt(999999)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent = getIntent()
        startString = intent.data?.toString()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.action === Intent.ACTION_VIEW) {
            linksReceiver?.onReceive(this.applicationContext, intent)
        }
    }

    fun createChangeReceiver(events: EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) { // NOTE: assuming intent.getAction() is Intent.ACTION_VIEW
                val dataString = intent.dataString ?:
                events.error("UNAVAILABLE", "Link unavailable", null)
                events.success(dataString)
            }
        }
    }

}

