<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String pkorder = teasession.getParameter("pkorder");
PackageOrder pobj = PackageOrder.find(pkorder);



%>
<html>
<head>
<title>打印</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>
//关闭窗口
function f_close() 
{
	window.close();
}
</script>
 

<div id="head6"><img height="6" src="about:blank"></div>
 

<form action="?" name="form1" method="POST"   >


       <object  id="WebBrowser"  width=0  height=0  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
      </object>
      

             <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
             <tr>
             		<td align="right">订单号:</td>
             		<td><%=pkorder%></td>
             </tr>
              <tr>
             		<td align="right">订单日期:</td>
             		<td><%=pobj.getOrderstimeToString() %></td>
             </tr>
              <tr>
             		<td align="right">套餐价格:</td>
             		<td>￥<%=pobj.getMarketprice() %>&nbsp;/&nbsp;＄<%=pobj.getPromotionsprice() %></td>
             </tr>
             <tr>
    				<td nowrap align="right">银行转账:</td>
    				<td>
    				  户　名：人民网发展有限公司<br/>开户行：中国农业银行北京水碓西里支行<br/>账　号：02136598545697458<br/>
    				</td>
    			</tr>
    			
    			<tr>
    				<td nowrap align="right">邮局汇款:</td>
    				<td>收款人：北京科技有限公司<br/>地　址：北京市海淀区上地<br/>邮　编：100100</td>
    			</tr>
    			<tr>
    				<td nowrap align="right">汇款提示:</td>
    				<td>务必在汇款的附言或备注上填写：<br/>1、括号内的订单号（20100503000010）<br/>2、括号内的用户名（admin）</td>
    			</tr>
    			<tr>
    				<td></td>
    				<td>若未注明订单号和用户名，我们将无法及时为您开通权限.</td>
    			</tr>
    			
    			<tr>
    				<td colspan="2"  id="printbutton"  >  <input type="button"   value="　关闭窗口　"  onclick="f_close();">&nbsp;
  <input type="button" value="　打　印　"  onClick="return userPrint();" ></td>
    			</tr>
             </table>


   
      
      <script type="text/javascript">
      //-----  下面是打印控制语句  ----------
      window.onbeforeprint=beforePrint;
      window.onafterprint=afterPrint;

      var hkey_root,hkey_path,hkey_key;
      hkey_root="HKEY_CURRENT_USER";
      hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
//设置网页打印的页眉页脚为空
    function pagesetup_null(){
     try{
             var RegWsh = new ActiveXObject("WScript.Shell");
             hkey_key="header"; 
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
             hkey_key="footer";
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
             }catch(e){
         }
    }
//设置网页打印的页眉页脚为默认值
    function pagesetup_default(){
     try{
             var RegWsh = new ActiveXObject("WScript.Shell");
             hkey_key="header" ;
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"&w&b页码，&p/&P");
             hkey_key="footer";
             RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"&u&b&d");
             print();
            }catch(e){}
        }


      
      //打印之前隐藏不想打印出来的信息
      var printbutton=document.getElementById('printbutton');

      function beforePrint()
      {
        printbutton.style.display='none';
      }
      //打印之后将隐藏掉的信息再显示出来
      function afterPrint()
      {
        printbutton.style.display='';
          
      }
      function userPrint()
      {
    	  pagesetup_null();
        document.WebBrowser.Execwb(6,6);//打印
        window.close();
        return false;
      }
      　　</SCRIPT>
      
   
   


</form>
</body>
</html>
