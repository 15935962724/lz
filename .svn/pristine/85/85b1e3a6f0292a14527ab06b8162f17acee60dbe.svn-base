<%@page contentType="text/html; charset=GBK" language="java"%><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="java.util.Date" %>
<%
request.setCharacterEncoding("GBK");
TeaSession teasession = new TeaSession(request);



Calendar cal = Calendar.getInstance();
int day = cal.get(Calendar.DAY_OF_MONTH);
cal.set(Calendar.DATE,day+5);


//获取参数
String v_oid = request.getParameter("v_oid"); // 订单号/商户发送的v_oid定单编号;
String v_pstatus = request.getParameter("v_pstatus");//支付结果，1待处理（支付结果未确定）；20支付完成；30支付被拒绝；
String v_pstring = request.getParameter("v_pstring");//已提交（当v_pstatus=1时）；//支付完成（当v_pstatus=20时）；//失败原因（当v_pstatus=30时,字符串）；
String v_pmode = request.getParameter("v_pmode");//支付方式（字符串）；/支付方式（字符串）；
String v_md5info = request.getParameter("v_md5info");// char* text     拼串结果//          char* key     对称密钥v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
String v_amount = request.getParameter("v_amount");//订单总金额  订单实际支付金额//
String v_moneytype = request.getParameter("v_moneytype");//7．v_moneytype 订单实际支付币种//
String v_md5money = request.getParameter("v_md5money");//8．v_md5money=char* hmac_md5(char* text, char* key)//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
String v_sign = request.getParameter("v_sign");


String v_oid_s[]=v_oid.split("\\|_\\|");
String v_pstatus_s[] = v_pstatus.split("\\|_\\|");//支付结果，1待处理（支付结果未确定）；20支付完成；30支付被拒绝；
String v_pstring_s[] = v_pstring.split("\\|_\\|");//已提交（当v_pstatus=1时）；//支付完成（当v_pstatus=20时）；//失败原因（当v_pstatus=30时,字符串）；
String v_pmode_s[] = v_pmode.split("\\|_\\|");//支付方式（字符串）；/支付方式（字符串）；
String v_md5info_s[] = v_md5info.split("\\|_\\|");// char* text     拼串结果//          char* key     对称密钥v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
String v_amount_s[] = v_amount.split("\\|_\\|");//订单总金额  订单实际支付金额//
String v_moneytype_s[] = v_moneytype.split("\\|_\\|");//7．v_moneytype 订单实际支付币种//
String v_md5money_s[] = v_md5money.split("\\|_\\|");//8．v_md5money=char* hmac_md5(char* text, char* key)//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
String v_sign_s[] = v_sign.split("\\|_\\|");

if(v_oid_s.length>1)
{
  for(int i=0;i<v_oid_s.length;i++)
  {
    v_oid=v_oid_s[i];
    v_pstatus= v_pstatus_s[i];
    int ids =Ocean.getIdtoBeijingorder(v_oid);
    Ocean oce = Ocean.find(ids);
    StringBuffer str1 = new StringBuffer();
    if(oce.getOrderstatic()!=0)
    {
      int type=0;
      try
      {
        tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
        if ("1".equals(v_pstatus))
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
          str1.append("　　联系电话：010-62176655-6738、6799、6792、677").append("<br>");
          type=0;
          System.out.println("交易成功1:v_oid:"+v_oid);
          Ocean.updatetypebeijing(v_oid,1);
        } else if ("20".equals(v_pstatus))
        {
          type=1;
          Ocean.updatetypebeijing(v_oid,1);
          str1.append("您好！").append("<br>");
          str1.append("　　您已支付成功，请您等待工作人员制卡（预计七个工作日），您的订单编号为"+oce.getOceanorder()).append("<br>");
          str1.append("　　制卡完成后，工作人员会将领卡通知发到您的电子邮箱，海洋护照办理进程及相关信息可查询北京海洋馆网站www.bj-sea.com 。").append("<br>");
          str1.append("　　感谢您购买2010年海洋护照，恭喜您成为北京海洋馆尊贵会员！").append("<br>");
          str1.append("　　凭2011年海洋护照可于2012年4月30日前不限次参观北京海洋馆、北京动物园（含熊猫馆）；尊享高品质专属会员活动（活动通知将以手机短信的形式发送给您，北京海洋馆网站会员专区也将同时进行活动内容公布）；乐享北京海洋馆内美食、购物优惠（9折优惠、特例商品除外）。").append("<br>");
          str1.append("　　温馨提示：海洋护照仅限本人使用，入馆及享受其他优惠时请主动出示。对于非本人使用，北京海洋馆将收回此卡。同时，我们还要再次提醒您，此卡售出后，不予退换，遗失不补。").append("<br>");
          str1.append("　　北京海洋馆会员是热衷海洋环保事业，关爱海洋生物的优秀公民。北京海洋馆丰富多彩的海洋生物展示及舒适的游览环境离不开您及广大会员朋友共同的爱心呵护，我们由衷地感谢您对北京海洋馆的支持与厚爱。祝您游览愉快！").append("<br>");
          str1.append("　　北京海洋馆永远超乎你的想象！").append("<br>");
          str1.append("　　官方网站：www.bj-sea.com").append("<br>");
          str1.append("　　联系电话：010-62176655-6738、6799、6792、6771").append("<br>");
            System.out.println("交易成功:20:v_oid:"+v_oid);
        }else if ("30".equals(v_pstatus))
        {
          type=0;
          Ocean.updatetypebeijing(v_oid,0);
          str1.append("您好！").append("<br>");
          str1.append("　　交易失败，请重新申请！").append("<br>");
        }
        se.sendEmail(oce.getEmail(),"海洋护照支付信息！",str1.toString());
      }
      catch(Exception ex)
      {
        System.out.print(ex.toString());
      }
    }
  }
}
//v_md5info校验四个参数，拼接字符串的顺序为：v_oid，v_pstatus，v_pstring和v_pmode/
//6．v_amount订单实际支付金额//
//7．v_moneytype 订单实际支付币种//
//8．v_md5money=char* hmac_md5(char* text, char* key)
//char* text     拼串结果
//             char* key     对称密钥
//v_md5money效验两个参数，拼接字符串的顺序为：v_amount，v_moneytype
 String qs22=request.getQueryString();
 System.out.print(qs22.toString());
if(request.getMethod().equals("GET"))
{
  String qs=request.getQueryString();
  if(qs==null)
  return;
  String param[]=qs.split("&");
  for(int i=0;i<param.length;i++)
  {
    if(param[i].startsWith("v_pmode="))
    {
      v_pmode=java.net.URLDecoder.decode(param[i].substring("v_pmode=".length()),"GBK");
    }else if(param[i].startsWith("v_pstring="))
    {
      v_pstring=java.net.URLDecoder.decode(param[i].substring("v_pstring=".length()),"GBK");
    }
  }
}


String text = v_oid + v_pstatus + v_amount + v_moneytype;

//首信公钥文件
String publicKey = application.getRealPath("/WEB-INF/lib/Public1024_1459.key");

/////变量修改
int ids =Ocean.getIdtoBeijingorder(v_oid);
Ocean oce = Ocean.find(ids);
StringBuffer str1 = new StringBuffer();
int type=0;
try
{
  tea.service.SendEmaily se = new tea.service.SendEmaily(teasession._strCommunity);
  if ("1".equals(v_pstatus))
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
    type=0;
    Ocean.updatetypebeijing(v_oid,1);
  } else if ("20".equals(v_pstatus))
  {
    type=1;
    Ocean.updatetypebeijing(v_oid,1);
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
  }else if ("30".equals(v_pstatus))
  {
    type=0;
    Ocean.updatetypebeijing(v_oid,0);
    str1.append("您好！").append("<br>");
    str1.append("　　交易失败，请重新申请！").append("<br>");
  }
  se.sendEmail(oce.getEmail(),"海洋护照支付信息！",str1.toString());
}
catch(Exception ex)
{
  System.out.print(ex.toString());
}
%>

<html>
<head>
<link href="/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<title>
交易成功
</title>
</head>
<body class="OceanPassport">
<div class="body">
  <table class="Flow1">
    <tr>
      <td class="td01"></td><td class="td02">服务条款</td><td class="td03">填写登记表</td><td class="td04">确认订单</td><td class="td05">支付费用</td>
    </tr></table>
    <div class="Ocean">
      <div class="Ocean_top"></div><div class="Ocean_con"><div class="Ocean_bottom">
        <div class="Success">
          <form  name="form1" action="/servlet/EditOcean" method="get" enctype="multipart/form-data">
          <input   type="hidden"  name="act"  value="OceanSuccess">
          <input   type="hidden"  name="ids"  value="<%=ids%>">
          <input type="hidden" name="type" value="<%=type%>" />

          <table id="tablecenter">
            <tr><td class="td01"><%if
            ("1".equals(v_pstatus))
            {
              out.print("已提交！");
            } else if ("20".equals(v_pstatus))
            {
              out.print("交易成功！");
              Ocean.updatetype(v_oid,1);
            }else if ("30".equals(v_pstatus))
            {
              out.print("交易失败！");
            }%></td>
            </tr>
            <tr><td class="td02">您好：</td>
</tr>
<tr>
  <td class="td03"><%if
  ("1".equals(v_pstatus))
  {
    %>
    　　您的资金已提交，请等待工作人员进行支付确认！<br>
    　　支付成功后，工作人员会将通知发送到您的电子邮箱。<br>
    　　您的订单编号为<%=oce.getOceanorder()%>，海洋护照办理进程可在北京海洋馆网站“查询制卡信息”栏目中查询。<br>
    <%
    } else if ("20".equals(v_pstatus))
    {

      %>
      　　支付成功，请您等待工作人员制卡（预计七个工作日）。制卡完成后，工作人员会将领卡通知发到您的电子邮箱，您也可登陆北京海洋馆网站，在“查询制卡信息”栏目中进行海洋护照办理进程查询，您的订单编号为<%=oce.getOceanorder()%>。
      　


      您的资金已提交成功，预计七个工作日，完成后我们会将通知发到您的邮箱，也欢迎您随时在海洋馆网站上的“查询制卡信息中”查询，您的订单编号为<%=oce.getOceanorder()%>。<br>
      <%
      }else if ("30".equals(v_pstatus))
      {
        %>
        　　　交易失败，请重新申请！
        <%
        }%></td>
        </tr>

          </table>
          <div class="chaxunhuzxx"><a href="/jsp/ocean/OceanSearch.jsp"><img src="/res/bj-sea/u/0902/090264986.jpg"/></a></div>
          <div class="Success_bottom"><input type="button" onclick="window.open('/jsp/ocean/EditOceanRoll.jsp','_self')" value=""/></div>
          </form>
      </div>
    </div>
</div>
</div>
<div class="footer">Copyright(c)2001-2010 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）</br>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>


