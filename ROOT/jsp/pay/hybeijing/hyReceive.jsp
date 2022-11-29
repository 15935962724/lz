<%@page contentType="text/html; charset=GBK" language="java"%><%@page import="com.capinfo.crypt.*"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="java.util.Date" %><%
request.setCharacterEncoding("GBK");
TeaSession teasession = new TeaSession(request);

String v_oid =request.getParameter("v_oid");
String v_count = request.getParameter("v_count");
String v_pstatus = request.getParameter("v_pstatus");
String v_pstring =request.getParameter("v_pstring");
String v_pmode =request.getParameter("v_pmode");
String v_md5info = request.getParameter("v_md5info");
String v_amount = request.getParameter("v_amount");
String v_moneytype = request.getParameter("v_moneytype");
String v_md5money = request.getParameter("v_md5money");
String v_sign = request.getParameter("v_sign");
String v_mac =request.getParameter("v_mac");
String v_oid_s[] = v_oid.split("\\|_\\|");
String v_pstatus_s[] = v_pstatus.split("\\|_\\|");
String text =v_oid+v_pmode+v_pstatus+v_pstring+v_count;
String publicKey = application.getRealPath("/WEB-INF/lib/Public1024.key");
Md5beijing md5 = new Md5beijing ( "" ) ;
md5.hmac_Md5beijing(text , publicKey);
byte b[]= md5.getDigest();
String digestString = md5.stringify(b) ;


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
          str1.append("　　您已支付成功，请您等待工作人员制卡（预计七个工作日），您的订单编号为"+oce.getOceanorder()).append("<br>");
          str1.append("　　制卡完成后，工作人员会将领卡通知发到您的电子邮箱，海洋护照办理进程及相关信息可查询北京海洋馆网站www.bj-sea.com 。").append("<br>");
          str1.append("　　感谢您购买2011年海洋护照，恭喜您成为北京海洋馆尊贵会员！").append("<br>");
          str1.append("　　凭2011年海洋护照可于2012年4月30日前不限次参观北京海洋馆、北京动物园（含熊猫馆）；尊享高品质专属会员活动（活动通知将以手机短信的形式发送给您，北京海洋馆网站会员专区也将同时进行活动内容公布）；乐享北京海洋馆内美食、购物优惠（9折优惠、特例商品除外）。").append("<br>");
          str1.append("　　温馨提示：海洋护照仅限本人使用，入馆及享受其他优惠时请主动出示。对于非本人使用，北京海洋馆将收回此卡。同时，我们还要再次提醒您，此卡售出后，不予退换，遗失不补。").append("<br>");
          str1.append("　　北京海洋馆会员是热衷海洋环保事业，关爱海洋生物的优秀公民。北京海洋馆丰富多彩的海洋生物展示及舒适的游览环境离不开您及广大会员朋友共同的爱心呵护，我们由衷地感谢您对北京海洋馆的支持与厚爱。祝您游览愉快！").append("<br>");
          str1.append("　　北京海洋馆永远超乎你的想象！").append("<br>");
          str1.append("　　官方网站：www.bj-sea.com").append("<br>");
          str1.append("　　联系电话：010-62176655-6738、6799、6792、6771").append("<br>");
          if(oce.getOrderstatic()>0)
          {
          }
          else
          {
            Ocean.updatetypebeijing(v_oid,1);
          }
        }else if("3".equals(v_pstatus))
        {
          Ocean.updatetypebeijing(v_oid,0);
          str1.append("您好！").append("<br>");
          str1.append("　　交易失败，请重新申请！").append("<br>");
        }
        else if("0".equals(v_pstatus))
        {
          Ocean.updatetypebeijing(v_oid,0);
          str1.append("您好！").append("<br>");
          str1.append("　　请重新申请！").append("<br>");
        }
        se.sendEmail(oce.getEmail(),"海洋护照支付信息！",str1.toString());

      } catch(Exception ex)
      {
        System.out.print(ex.toString());
        out.print("error");
        return;
      }
    }
  }
}
out.print("sent");

%>
