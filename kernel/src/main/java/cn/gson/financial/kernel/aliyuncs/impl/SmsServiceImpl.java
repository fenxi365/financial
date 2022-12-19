package cn.gson.financial.kernel.aliyuncs.impl;

import cn.gson.financial.kernel.aliyuncs.SmsService;
import cn.gson.financial.kernel.exception.ServiceException;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.accountantplatform.service.aliyuncs</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年01月14日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Service
@Slf4j
public class SmsServiceImpl implements SmsService {

    private final String regionId = "cn-hangzhou";

    private final String endpointName = "cn-hangzhou";

    private IAcsClient acsClient;

    private ObjectMapper mapper = new ObjectMapper();

    public SmsServiceImpl(@Value("${aliyun.accessKeyId}") String accessKeyId,
                          @Value("${aliyun.accessKeySecret}") String accessKeySecret) {
        log.info("accessKeyId:{}", accessKeyId);
        log.info("accessKeySecret:{}", accessKeySecret);
        //初始化ascClient,暂时不支持多region（请勿修改）
        IClientProfile profile = DefaultProfile.getProfile(regionId, accessKeyId, accessKeySecret);
        try {
            DefaultProfile.addEndpoint(endpointName, regionId, PRODUCT, DOMAIN);
            this.acsClient = new DefaultAcsClient(profile);
        } catch (ClientException e) {
            e.printStackTrace();
        }
    }

    /**
     * 发送短信
     *
     * @param smsBody
     */
    @Override
    public void send(SmsBody smsBody) {
        try {
            //组装请求对象
            SendSmsRequest request = new SendSmsRequest();
            //使用post提交
            request.setMethod(MethodType.POST);
            //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式；发送国际/港澳台消息时，接收号码格式为国际区号+号码，如“85200000000”
            request.setPhoneNumbers(smsBody.getPhoneNumbers());
            //必填:短信签名-可在短信控制台中找到
            request.setSignName(smsBody.getSignName());
            //必填:短信模板-可在短信控制台中找到，发送国际/港澳台消息时，请使用国际/港澳台短信模版
            request.setTemplateCode(smsBody.getTemplateCode());
            //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
            //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
            if (smsBody.getTemplateParam() != null && smsBody.getTemplateParam().size() > 0) {
                request.setTemplateParam(mapper.writeValueAsString(smsBody.getTemplateParam()));
            }

            //可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
            if (StringUtils.isNotEmpty(smsBody.getSmsUpExtendCode())) {
                request.setSmsUpExtendCode(smsBody.getSmsUpExtendCode());
            }

            //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
            if (StringUtils.isNotEmpty(smsBody.getOutId())) {
                request.setOutId(smsBody.getOutId());
            }

            //请求失败这里会抛ClientException异常
            SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
            if (sendSmsResponse.getCode() == null || !sendSmsResponse.getCode().equals("OK")) {
                throw new RuntimeException(sendSmsResponse.getMessage());
            }
        } catch (Exception e) {
            log.error("短信发送失败", e);
            throw new ServiceException(e.getMessage(), e);
        }
    }
}
