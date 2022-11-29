package tea.ui.ocean;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.member.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import tea.entity.ocean.*;
import java.text.*;
import tea.entity.util.Spell;
import java.math.*;
import tea.db.*;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import tea.entity.util.ZoomOut;
import tea.entity.SeqTable;

public class EditOceansms extends TeaServlet
{
    public void init() throws ServletException
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        tea.ui.TeaSession teasession = null;
        teasession = new tea.ui.TeaSession(request);
        ServletContext application = getServletContext();
        String act = teasession.getParameter("act");
        try
        {
            String qs22 = request.getQueryString();
            System.out.print(qs22.toString());
            //获取参数
            String v_oid = request.getParameter("v_oid"); // 订单号/商户发送的v_oid定单编号;
            System.out.println(v_oid);
            String v_pstatus = request.getParameter("v_pstatus"); //支付结果，1待处理（支付结果未确定）；20支付完成；30支付被拒绝；
//            String v_pstring = request.getParameter("v_pstring"); //已提交（当v_pstatus=1时）；//支付完成（当v_pstatus=20时）；//失败原因（当v_pstatus=30时,字符串）；
//            String v_pmode = request.getParameter("v_pmode"); //支付方式（字符串）；/支付方式（字符串）；
//            String v_md5info = request.getParameter("v_md5info"); // char* text     拼串结果//          char* key     对称密钥v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
//            String v_amount = request.getParameter("v_amount"); //订单总金额  订单实际支付金额//
//            String v_moneytype = request.getParameter("v_moneytype"); //7．v_moneytype 订单实际支付币种//
//            String v_md5money = request.getParameter("v_md5money"); //8．v_md5money=char* hmac_md5(char* text, char* key)//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
//            String v_sign = request.getParameter("v_sign");

            String v_oid_s[] = v_oid.split("\\|_\\|");
            String v_pstatus_s[] = v_pstatus.split("\\|_\\|"); //支付结果，1待处理（支付结果未确定）；20支付完成；30支付被拒绝；
//            String v_pstring_s[] = v_pstring.split("\\|_\\|"); //已提交（当v_pstatus=1时）；//支付完成（当v_pstatus=20时）；//失败原因（当v_pstatus=30时,字符串）；
//            String v_pmode_s[] = v_pmode.split("\\|_\\|"); //支付方式（字符串）；/支付方式（字符串）；
//            String v_md5info_s[] = v_md5info.split("\\|_\\|"); // char* text     拼串结果//          char* key     对称密钥v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
//            String v_amount_s[] = v_amount.split("\\|_\\|"); //订单总金额  订单实际支付金额//
//            String v_moneytype_s[] = v_moneytype.split("\\|_\\|"); //7．v_moneytype 订单实际支付币种//
//            String v_md5money_s[] = v_md5money.split("\\|_\\|"); //8．v_md5money=char* hmac_md5(char* text, char* key)//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
//            String v_sign_s[] = v_sign.split("\\|_\\|");

            if(v_oid_s.length > 0)
            {
                for(int i = 0;i < v_oid_s.length;i++)
                {
                    v_oid = v_oid_s[i];
                    v_pstatus = v_pstatus_s[i];
                    int ids = Ocean.getIdtoBeijingorder(v_oid);
                    Ocean oce = Ocean.find(ids);
                    StringBuffer str1 = new StringBuffer();
                    if(oce.getOrderstatic() == 0)
                    {
                        try
                        {
                            tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
                            if("1".equals(v_pstatus))
                            {
                                str1.append("您好！").append("<br>");
                                str1.append("　　您已支付成功，请您等待工作人员制卡（预计七个工作日），您的订单编号为" + oce.getOceanorder()).append("<br>");
                                str1.append("　　制卡完成后，工作人员会将领卡通知发到您的电子邮箱，海洋护照办理进程及相关信息可查询北京海洋馆网站www.bj-sea.com 。").append("<br>");
                                str1.append("　　感谢您购买2009年海洋护照，恭喜您成为北京海洋馆尊贵会员！").append("<br>");
                                str1.append("　　凭2009年海洋护照可于2010年4月30日前不限次参观北京海洋馆、北京动物园（含熊猫馆）；尊享高品质专属会员活动（活动通知将以手机短信的形式发送给您，北京海洋馆网站会员专区也将同时进行活动内容公布）；乐享北京海洋馆内美食、购物优惠（9折优惠、特例商品除外）。").append("<br>");
                                str1.append("　　温馨提示：海洋护照仅限本人使用，入馆及享受其他优惠时请主动出示。对于非本人使用，北京海洋馆将收回此卡。同时，我们还要再次提醒您，此卡售出后，不予退换，遗失不补。").append("<br>");
                                str1.append("　　北京海洋馆会员是热衷海洋环保事业，关爱海洋生物的优秀公民。北京海洋馆丰富多彩的海洋生物展示及舒适的游览环境离不开您及广大会员朋友共同的爱心呵护，我们由衷地感谢您对北京海洋馆的支持与厚爱。祝您游览愉快！").append("<br>");
                                str1.append("　　北京海洋馆永远超乎你的想象！").append("<br>");
                                str1.append("　　官方网站：www.bj-sea.com").append("<br>");
                                str1.append("　　联系电话：010-62176655-6738、6799、6792、6103").append("<br>");
                                Ocean.updatetypebeijing(v_oid,1);
                            } else if("20".equals(v_pstatus))
                            {
                                Ocean.updatetypebeijing(v_oid,1);
                                str1.append("您好！").append("<br>");
                                str1.append("　　您已支付成功，请您等待工作人员制卡（预计七个工作日），您的订单编号为" + oce.getOceanorder()).append("<br>");
                                str1.append("　　制卡完成后，工作人员会将领卡通知发到您的电子邮箱，海洋护照办理进程及相关信息可查询北京海洋馆网站www.bj-sea.com 。").append("<br>");
                                str1.append("　　感谢您购买2009年海洋护照，恭喜您成为北京海洋馆尊贵会员！").append("<br>");
                                str1.append("　　凭2009年海洋护照可于2010年4月30日前不限次参观北京海洋馆、北京动物园（含熊猫馆）；尊享高品质专属会员活动（活动通知将以手机短信的形式发送给您，北京海洋馆网站会员专区也将同时进行活动内容公布）；乐享北京海洋馆内美食、购物优惠（9折优惠、特例商品除外）。").append("<br>");
                                str1.append("　　温馨提示：海洋护照仅限本人使用，入馆及享受其他优惠时请主动出示。对于非本人使用，北京海洋馆将收回此卡。同时，我们还要再次提醒您，此卡售出后，不予退换，遗失不补。").append("<br>");
                                str1.append("　　北京海洋馆会员是热衷海洋环保事业，关爱海洋生物的优秀公民。北京海洋馆丰富多彩的海洋生物展示及舒适的游览环境离不开您及广大会员朋友共同的爱心呵护，我们由衷地感谢您对北京海洋馆的支持与厚爱。祝您游览愉快！").append("<br>");
                                str1.append("　　北京海洋馆永远超乎你的想象！").append("<br>");
                                str1.append("　　官方网站：www.bj-sea.com").append("<br>");
                                str1.append("　　联系电话：010-62176655-6738、6799、6792、6103").append("<br>");
                            } else if("30".equals(v_pstatus))
                            {
                                Ocean.updatetypebeijing(v_oid,0);
                                str1.append("您好！").append("<br>");
                                str1.append("　　交易失败，请重新申请！").append("<br>");
                            }
                            se.sendEmail(oce.getEmail(),"海洋护照支付信息！",str1.toString());
                        } catch(Exception ex)
                        {
                            System.out.print(ex.toString());
                        }
                    }
                }
            }
            return;
        } catch(Exception ex)
        {
            System.out.print(ex.toString());
        }
    }

    public EditOceansms()
    {
    }

    public void destroy()
    {
    }

}
