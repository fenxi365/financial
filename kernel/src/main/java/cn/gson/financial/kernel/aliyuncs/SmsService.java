package cn.gson.financial.kernel.aliyuncs;

import lombok.Data;
import lombok.NonNull;

import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : 短信发送服务</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年01月14日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
public interface SmsService {

    String PRODUCT = "Dysmsapi";

    String DOMAIN = "dysmsapi.aliyuncs.com";

    /**
     * 发送短信
     *
     * @param smsBody
     */
    void send(SmsBody smsBody);

    @Data
    class SmsBody {
        @NonNull
        private String phoneNumbers;
        @NonNull
        private String signName;
        @NonNull
        private String templateCode;

        private Map<String, String> templateParam;
        private String outId;
        private String smsUpExtendCode;
    }

    enum SignName {
        纷析云
    }

    enum TemplateCode {
        /**
         * 验证码模板
         */
        SMS_175580136,
        /**
         * 注册成功发送密码
         */
        SMS_183262497
    }
}
