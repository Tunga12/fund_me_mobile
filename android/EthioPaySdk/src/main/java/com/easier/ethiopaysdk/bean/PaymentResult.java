package com.easier.ethiopaysdk.bean;

/**
 * 功能描述
 *
 * @author liudo
 * @version [V8.5.70.1, 2021/06/21]
 * @since V8.5.70.1
 */
public class PaymentResult {

    public static final int SERVER_ERROR = -1;

    private int code;

    private String msg;

    private ResultData data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public ResultData getData() {
        return data;
    }

    public void setData(ResultData data) {
        this.data = data;
    }

}
