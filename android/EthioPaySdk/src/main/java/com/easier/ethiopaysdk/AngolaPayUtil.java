package com.easier.ethiopaysdk;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import com.easier.ethiopaysdk.bean.PaymentResult;
import com.easier.ethiopaysdk.util.PaymentResultListener;

import org.json.JSONObject;

import java.util.TreeMap;

public class AngolaPayUtil {

    private final String TAG = this.getClass().getName();

    public static final String TRADESDKPAY = "tradeSDKPay";

    public static final String OUTTRADENO = "outtradeNO";

    private PaymentResultListener paymentResultListener;

    private Activity webViewActivity;

    protected void setWebViewActivity(Activity webViewActivity) {
        this.webViewActivity = webViewActivity;
    }

    private static AngolaPayUtil mInstance;

    private AngolaPayUtil() {

    }

    public static AngolaPayUtil getInstance() {
        if (mInstance == null) {
            synchronized (AngolaPayUtil.class) {
                if (mInstance == null) {
                    mInstance = new AngolaPayUtil();
                }
            }
        }
        return mInstance;
    }

    /**
     * 支付跳转
     */

    public void startPayment(TradePayMapRequest payMapRequest, Activity context) {
        if (payMapRequest == null) {
            Log.e(TAG, "startPayment tradeWebPayRequest is null");
        }
        Intent intent = new Intent(context, WebViewActivitiy.class);
        TradeSDKPayRequest request = new TradeSDKPayRequest();
        request.setAppid(payMapRequest.getAppId());
//        String sign= EncryptUtils.getInstance().encryptSHA256(tradeWebPayRequest);
//        Log.d(TAG,"startPayment Appid "+tradeWebPayRequest.getAppId()+" ,sign "+sign);
        request.setSign(EncryptUtils.getInstance().encryptSHA256(payMapRequest));
        JSONObject jsonObject = EncryptUtils.getInstance().objectToJson(payMapRequest);
        TreeMap<String, String> dataOptMap = EncryptUtils.getInstance().JsonToMap(jsonObject);
        String JsonStr = EncryptUtils.getInstance().objectToJsonString(dataOptMap);
//        Log.d(TAG,"startPayment publicRSAEncrypt "+JsonStr);
        String ussd = null;
        try {
            ussd = EncryptUtils.getInstance().encryptByPublicKey(JsonStr);
        } catch (Exception e) {
            e.printStackTrace();
        }
//        Log.d(TAG,"startPayment ussd "+ussd);
        request.setUssd(ussd);
        intent.putExtra(TRADESDKPAY, request);
        intent.putExtra(OUTTRADENO, payMapRequest.getOutTradeNo());
        context.startActivity(intent);
    }

    /**
     * 停止支付
     */
    public void stopPayment() {
        if (webViewActivity != null) {
            webViewActivity.finish();
            webViewActivity = null;
        }
    }

    public void setPaymentResultListener(PaymentResultListener paymentResultListener) {
        this.paymentResultListener = paymentResultListener;
    }

    /**
     * 支付结果回调
     */
    protected void callBackPaymentResult(PaymentResult result) {
        if (paymentResultListener != null) {
            paymentResultListener.paymentResult(result);
        }
    }
}
