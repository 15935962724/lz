package tea.service;

import java.util.*;
import java.net.*;
import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import tea.entity.member.SMSMessage;
import tea.entity.site.SMSScode;
import java.security.*;
import java.sql.SQLException;

// 充值网址:http://219.238.239.166:8005/EtoneService2_WebSite/Login.asp
// 登陆名是84797333131 密码是20071206
// 移动: 10657506103031

public class SMS
{
    private static final String sFinCode = "84797333131";
    private static final String pwd = "123456";
    public static final boolean debug = true;

    public static void main(String[] args)
    {
        try
        {
            SMS test = new SMS();
            // 发信息
            String content = "差不多了，收到消息你回复一下！";
            test.send(0, "13552491840;10052491840;", content, "");

            // // 收信息
            // String s = test.Recieve("00");
            // System.out.println(s);
            // test.parse(s);
            // // 取得帐户余额
            // String s1 = test.GetBanlance("00");
            // test.parseBalance(s1);
            // 更改密码
            /*
             * String
             * s=test.SetPassword("http://219.238.239.179:8008/webservice/etoneservice.asmx/GetBalanceEx","6562246300","javaedn","123456");
             * test.parseBalance(s);
             */
            // 充值
            /*
             * String code="65622463200512289766"; String password="12158828";
             * String s=test.FinCard("6562246300","javaedn",code,password);
             * System.out.println(s.substring(74,s.indexOf("/string")-1));
             */
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    private String conn(String url, String param) throws IOException
    {
        StringBuilder result = new StringBuilder();

        HttpURLConnection c = (HttpURLConnection)new URL("http://219.238.239.166:8005/EtoneService2/EtoneService2.asmx/" + url).openConnection();
        c.setDoOutput(true);
        c.setDoInput(true);
        PrintWriter out = new PrintWriter(c.getOutputStream());
        out.print(param.toString());
        out.flush();
        out.close();
        BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
        String line;
        while ((line = in.readLine()) != null)
        {
            result.append(line);
        }
        in.close();
        if (debug)
        {
            System.out.println("======conn=========");
            System.out.println("url:" + url);
            System.out.println("par:" + param);
            System.out.println("res:" + result.toString());
        }
        return result.toString();
    }

    public String toString(String xml)
    {
        xml = xml.replaceAll(" ", "").replaceFirst("<SendReport>", "");

        StringBuilder sb = new StringBuilder(xml);
        int tmp = xml.indexOf("</");
        tmp = xml.lastIndexOf(">", tmp);
        sb.delete(0, tmp + 1);
        //删除结束xml
        while ((tmp = sb.indexOf("</")) != -1)
        {
            sb.delete(tmp, sb.indexOf(">", tmp) + 1);
        }
        //替换开始xml
        while ((tmp = sb.indexOf("<")) != -1)
        {
            sb.delete(tmp, sb.indexOf(">", tmp));
            sb.setCharAt(tmp, '/');
        }
        return sb.toString();
    }

    // 发送短信
    public String send(int sSubNumber, String sDestTermID, String sMsgContent, String sSendTime) throws IOException
    {
        try
        {
            sMsgContent = URLEncoder.encode(sMsgContent, "UTF-8");
        } catch (UnsupportedEncodingException ex)
        {
        }
        Random r = new Random();
        String key = String.valueOf(r.nextInt(100));

        StringBuilder param = new StringBuilder();
        param.append("sFinCode=").append(sFinCode); // 企业代码
        param.append("&sRnd=").append(key); // 随机数
        param.append("&sHash=").append(md5(key + md5(pwd))); // 密码//SMSScode.find(scode).getPwd()
        param.append("&sSubNumber=").append(sSubNumber); // 子码
        param.append("&sDestTermID=").append(sDestTermID); // 目标手机号
        param.append("&sMsgContent=").append(sMsgContent); // 内容
        param.append("&sSendTime=").append(sSendTime); // 发送时间 可为空

        String xml = conn("SendSmsEx", param.toString());
        return toString(xml);
    }

    // 接收短信
    public String recv() throws IOException
    {
        Random r = new Random();
        String key = String.valueOf(r.nextInt(100));

        StringBuilder param = new StringBuilder();
        param.append("sEntCode=").append(sFinCode); // 企业代码
        param.append("&sRnd=").append(key); // 随机数
        param.append("&sHash=").append(md5(key + md5(pwd))); // 密码//SMSScode.find(scode).getPwd()
        String result = conn("RecvSmsEx", param.toString());
        result = result.replaceAll("&lt;", "<");
        result = result.replaceAll("&gt;", ">");
        return result;
    }

    // 查询剩余短信数量
    public String getBanlance() throws IOException
    {
        Random r = new Random();
        String key = String.valueOf(r.nextInt(100));

        StringBuilder param = new StringBuilder();
        param.append("sEntCode=").append(sFinCode); // 企业代码
        param.append("&sRnd=").append(key); // 随机数
        param.append("&sHash=").append(md5(key + md5(pwd))); // 密码

        String result = conn("GetBalanceEx", param.toString());
        return result;
    }

    // 充值
    public String finCard(String sAdvCode, String sAdvPassword) throws IOException
    {
        Random r = new Random();
        String key = String.valueOf(r.nextInt(100));

        StringBuilder param = new StringBuilder();
        param.append("sEntCode=").append(sFinCode); // 企业代码
        param.append("&sRnd=").append(key); // 随机数
        param.append("&sHash=").append(md5(key + md5(pwd))); // 密码
        param.append("&sAdvCode=").append(sAdvCode); // 充值卡号
        param.append("&sAdvPassword=").append(sAdvPassword); // 充值卡

        String result = conn("FinCard", param.toString());
        return result;
    }

    // 修改密码
    public String setPassword(String scode, String sNewPassword) throws SQLException, IOException
    {
        Random r = new Random();
        String key = String.valueOf(r.nextInt(100));

        StringBuilder param = new StringBuilder();
        param.append("sEntCode="); // 企业代码
        param.append(sFinCode).append(scode);
        param.append("&sRnd="); // 随机数
        param.append(key);
        param.append("&sHash=");
        param.append(md5(key + md5(SMSScode.find(scode).getPwd()))); // 密码
        param.append("&sNewPassword="); // 随机数
        param.append(sNewPassword);

        String result = conn("SetPassword", param.toString());
        return result;
    }

    public void parse(String s)
    {
        DocumentBuilderFactory domfac = DocumentBuilderFactory.newInstance();
        try
        {
            DocumentBuilder dombuilder = domfac.newDocumentBuilder();
            InputStream is = (InputStream) (new ByteArrayInputStream(s.getBytes("UTF-8")));
            // InputStream is=new FileInputStream("c:\\test.xml");
            Document doc = dombuilder.parse(is);
            // Element root=doc.getDocumentElement();
            NodeList msgs = doc.getElementsByTagName("UpSms");
            if (msgs != null)
            {
                for (int i = 0; i < msgs.getLength(); i++)
                {
                    Node msg = msgs.item(i);
                    if (msg.getNodeType() == Node.ELEMENT_NODE)
                    {
                        String number = null, time = null, DestTerm = null, content = null;
                        for (Node node = msg.getFirstChild(); node != null; node = node.getNextSibling())
                        {
                            if (node.getNodeType() == Node.ELEMENT_NODE)
                            {
                                if (node.getNodeName().equals("MobileNum"))
                                {
                                    number = node.getFirstChild().getNodeValue();
                                    System.out.println("手机号：" + number);
                                }
                                if (node.getNodeName().equals("UpSmsDate"))
                                {
                                    time = node.getFirstChild().getNodeValue();
                                    System.out.println("上传时间：" + time);
                                }
                                if (node.getNodeName().equals("DestTermID"))
                                {
                                    DestTerm = node.getFirstChild().getNodeValue();
                                    System.out.println("回复号码：" + DestTerm);
                                }
                                if (node.getNodeName().equals("MsgContent"))
                                {
                                    content = node.getFirstChild().getNodeValue();
                                    System.out.println("短信内容：" + content);
                                }
                            }
                        }
                        try
                        {
                            int id;
                            if (DestTerm.startsWith("10657506103031")) // 移动
                            {
                                id = Integer.parseInt(DestTerm.substring(14));
                            } else
                            // 联通10655*****
                            {
                                id = Integer.parseInt(DestTerm.substring(10));
                            }
                            SMSMessage.create(id, number, content, 1, null);
                            /*
                             * Profile profile = Profile.find(id); String member =
                             * profile.getMember(); SMSProfile smsprofile =
                             * SMSProfile.find(member); if (profile.isValidate() &&
                             * smsprofile.isAutor()) { SMSMoney smsmoney =
                             * SMSMoney.find(member); if
                             * (smsmoney.getBalance().compareTo(SMSMoney.SMS_PRICE) >=
                             * 0) { content = toUtf8String(content);
                             * sendPost(String.valueOf(id), profile.getMobile(),
                             * content, "");
                             * smsmoney.setPayout(smsmoney.getPayout() + 1); } }
                             */
                        } catch (NumberFormatException ex)
                        {
                            ex.printStackTrace();
                        }
                    }
                }
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public void parseBalance(String s)
    {
        DocumentBuilderFactory domfac = DocumentBuilderFactory.newInstance();
        try
        {
            DocumentBuilder dombuilder = domfac.newDocumentBuilder();
            InputStream is = (InputStream) (new ByteArrayInputStream(s.getBytes()));
            Document doc = dombuilder.parse(is);
            Element root = doc.getDocumentElement();
            NodeList msgs = root.getElementsByTagName("QueryBalance");
            Node node = msgs.item(0);
            System.out.println("剩余短信条数：" + node.getFirstChild().getNodeValue());
            msgs = root.getElementsByTagName("ReaderNumber");
            // node=msgs.item(0);
            // System.out.println("充值记录条数："+node.getFirstChild().getNodeValue());
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    // public static String toUtf8String(String s)
    // {
    // StringBuilder sb = new StringBuilder();
    // for (int i = 0; i < s.length(); i++)
    // {
    // char c = s.charAt(i);
    // if (c >= 0 && c <= 255)
    // {
    // sb.append(c);
    // } else
    // {
    // byte[] b;
    // try
    // {
    // b = Character.toString(c).getBytes("utf-8");
    // } catch (Exception ex)
    // {
    // System.out.println(ex);
    // b = new byte[0];
    // }
    // for (int j = 0; j < b.length; j++)
    // {
    // int k = b[j];
    // if (k < 0)
    // {
    // k += 256;
    // }
    // sb.append("%" + Integer.toHexString(k).toUpperCase());
    // }
    // }
    // }
    // return sb.toString();
    // }

    public static String md5(String s)
    {
        try
        {
            byte[] input = s.getBytes();
            java.security.MessageDigest alg = java.security.MessageDigest.getInstance("MD5"); // or "SHA-1"
            alg.update(input);
            byte[] digest = alg.digest();
            return byte2hex(digest);
        } catch (NoSuchAlgorithmException ex)
        {
            return null;
        }
    }

    public static String md5_16(String s)
    {
        try
        {
            byte[] input = s.getBytes();
            java.security.MessageDigest alg = java.security.MessageDigest.getInstance("MD5"); // or//
            // "SHA-1"
            alg.update(input);
            byte[] digest = alg.digest();
            return byte2hex(digest).substring(8, 24);
        } catch (NoSuchAlgorithmException ex)
        {
            return null;
        }
    }


    public static String byte2hex(byte[] b)
    {
        String hs = "";
        String stmp = "";
        for (int n = 0; n < b.length; n++)
        {
            stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
            if (stmp.length() == 1)
            {
                hs = hs + "0" + stmp;
            } else
            {
                hs = hs + stmp;
            }
            // if (n<b.length-1) hs=hs+":";
        }
        return hs.toUpperCase();
    }
}
