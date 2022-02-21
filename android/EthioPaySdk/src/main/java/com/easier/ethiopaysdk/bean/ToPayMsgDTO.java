package com.easier.ethiopaysdk.bean;

public  class ToPayMsgDTO {
    private String launchIntentForPackage;
    private ExtrasDTO extras;

    public String getLaunchIntentForPackage() {
        return launchIntentForPackage;
    }

    public void setLaunchIntentForPackage(String launchIntentForPackage) {
        this.launchIntentForPackage = launchIntentForPackage;
    }

    public ExtrasDTO getExtras() {
        return extras;
    }

    public void setExtras(ExtrasDTO extras) {
        this.extras = extras;
    }

    public static class ExtrasDTO {
        private String totalAmount;
        private String returnApp;
        private String receiveName;
        private String subject;
        private String appId;
        private String outTradeNo;
        private String receiveCode;
        private String notifyUrl;
        private String timeoutExpress;
        private String shortCode;

        public String getTotalAmount() {
            return totalAmount;
        }

        public void setTotalAmount(String totalAmount) {
            this.totalAmount = totalAmount;
        }

        public String getReturnApp() {
            return returnApp;
        }

        public void setReturnApp(String returnApp) {
            this.returnApp = returnApp;
        }

        public String getReceiveName() {
            return receiveName;
        }

        public void setReceiveName(String receiveName) {
            this.receiveName = receiveName;
        }

        public String getSubject() {
            return subject;
        }

        public void setSubject(String subject) {
            this.subject = subject;
        }

        public String getAppId() {
            return appId;
        }

        public void setAppId(String appId) {
            this.appId = appId;
        }

        public String getOutTradeNo() {
            return outTradeNo;
        }

        public void setOutTradeNo(String outTradeNo) {
            this.outTradeNo = outTradeNo;
        }

        public String getReceiveCode() {
            return receiveCode;
        }

        public void setReceiveCode(String receiveCode) {
            this.receiveCode = receiveCode;
        }

        public String getNotifyUrl() {
            return notifyUrl;
        }

        public void setNotifyUrl(String notifyUrl) {
            this.notifyUrl = notifyUrl;
        }

        public String getTimeoutExpress() {
            return timeoutExpress;
        }

        public void setTimeoutExpress(String timeoutExpress) {
            this.timeoutExpress = timeoutExpress;
        }

        public String getShortCode() {
            return shortCode;
        }

        public void setShortCode(String shortCode) {
            this.shortCode = shortCode;
        }
    }
}
