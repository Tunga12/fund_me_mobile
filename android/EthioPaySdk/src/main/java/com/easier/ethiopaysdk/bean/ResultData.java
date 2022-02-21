package com.easier.ethiopaysdk.bean;

/**
 * 功能描述
 *
 * @author liudo
 * @version [V8.5.70.1, 2021/06/21]
 * @since V8.5.70.1
 */
public class ResultData {

    private String outTradeNo;

    private String tradeNo;

    private String tradeStatus;

    public String getTradeStatus() {
        return tradeStatus;
    }

    public void setTradeStatus(String tradeStatus) {
        this.tradeStatus = tradeStatus;
    }

    public String getOutTradeNo() {
        return outTradeNo;
    }

    public void setOutTradeNo(String outTradeNo) {
        this.outTradeNo = outTradeNo;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }
}
