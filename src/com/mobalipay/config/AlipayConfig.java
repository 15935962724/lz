package com.mobalipay.config;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *版本：3.3
 *日期：2012-08-10
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
	
 *提示：如何获取安全校验码和合作身份者ID
 *1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
 *3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”

 *安全校验码查看时，输入支付密码后，页面呈灰色的现象，怎么办？
 *解决方法：
 *1、检查浏览器配置，不让浏览器做弹框屏蔽设置
 *2、更换浏览器或电脑，重新登录查询。
 */

public class AlipayConfig {
	
	//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	// 合作身份者ID，以2088开头由16位纯数字组成的字符串
	public static String partner = "2088801085003140";
	
	// 交易安全检验码，由数字和字母组成的32位字符串
	// 如果签名方式设置为“MD5”时，请设置该参数
	public static String key = "";
	
    // 商户的私钥
    // 如果签名方式设置为“0001”时，请设置该参数
	public static String private_key = "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAKj6A1DNAxawS4c/"+
			"JGCmCWTl2mGnHDwXmyVbd7FOlbnPaQ7rCC7Noj6a44/Vot7XmZBYcjdpXwtwxR1L"+
			"rd0xAh/WFR8lOAtTK/r3JQ5veTnIEtrerIOFn0Y1f4r5jqA7hUfs0+f7CgcfTAej"+
			"u4TftV0Q8Z66BKHcK/sL8hljBCXhAgMBAAECgYEAjcfBMnHiTo47wU5UqpeGOFe4"+
			"Rcmeojk4Xz8BDg+fB5olT3QbmJHHuXniyJP7pbkHS5s6so3CRuonKi6OwpJVcZ3E"+
			"V9xU2G7vbJoy6KV8zj9mrlIHwtTE22GQV0FPbo6GngBmMEPPQYOd+i0MiY/Q8IgT"+
			"VcjTZhF1aRXnoXnU5gUCQQDXbN63R8l+fW4pVOTaQa/HCpYd2GtE+OWlb4hKg0vW"+
			"d1QxI0kVq0Hxgq18z4XywEG1PaXU284Qb1yl6sP4c3dbAkEAyM2I0tjqanokDFV0"+
			"QA6O4vx2rN2M96+i4MfODPJZV/2MYtuex5PO/kGo8iOvuZm91GIFxX34yfcp2hTp"+
			"cu8YcwJBALZIGtP+3FI5lCNJADRl7HSBUrCCVZIRAVBQ5YQXQO6CHi1N7CN3u969"+
			"ckrv1imn4HGZbl6EdwKVGFIUKipqmY0CQQDFGHEPPBjDUIXnkU0cvu1jQRkfTgta"+
			"5ouCBLxsGsi1REqykg0EqkFHcZ1ppruJ+qzINTqjAaXcX3018Ma/qI2fAkA/6DAl"+
			"XwIxXsj3pm/muxBdl8NO00GnROxyY1AXX1Rt/WU0ZLaIrcH1hwnXh80Zwtj58aRF"+
			"edfLbXC5xf70I13B";

    // 支付宝的公钥
    // 如果签名方式设置为“0001”时，请设置该参数
	public static String ali_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCHejDqR87XRIIx7fSIeh4IAcQdh2ey5RzA76U0n4rl3sQUoril5ILWt4Vg8wnxd87uejeMryGWaIVKTCPywEdWTs+OMxYZM3emYWJXNIZDVolREwAA29pXgqCGORGOag0jCnzI1wN86ydOP1WosSiDjR0R4OE8LSW+Z832Q1IgNwIDAQAB";

	//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	

	// 调试用，创建TXT日志文件夹路径
	public static String log_path = "D:\\";

	// 字符编码格式 目前支持  utf-8
	public static String input_charset = "utf-8";
	
	// 签名方式，选择项：0001(RSA)、MD5
	public static String sign_type = "0001";
	// 无线的产品中，签名方式为rsa时，sign_type需赋值为0001而不是RSA

}
