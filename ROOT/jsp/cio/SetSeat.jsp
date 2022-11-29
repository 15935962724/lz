<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession=new TeaSession(request);

String nexturl = "/jsp/cio/SetSeat.jsp";

String noseat = CioSeatSet.notSeat();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="">
  var notseat='<%=noseat%>';

  function f_click(id)
  {
    var obj=document.all(id).style;

    if(obj.backgroundColor=='')
    {
      obj.backgroundColor='#FF9966';
      notseat+=id+'/';
    }
    else
    {
      obj.backgroundColor='';
      notseat=notseat.replace(id+'/','');
    }
   document.form1.noseat.value=notseat;;
  }

 function submitInteger(text, alerttext)
 {
   if(text.value=="")
   {
     return true;
   }
   if (isNaN(parseInt(text.value)))
   {
     alert(alerttext);
     text.focus();
     return false;
   }

   text.value=parseInt(text.value);
   if(text.value>29)
   {
   alert('数字请小于30！');
     text.focus();
     return false;
   }
   return true;
 }

  </script>
  </head>
  <body id="qiyelog">
  <h1>设置会场坐席</h1>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br/>

    <form name="form1" action="/servlet/EditCioSetSeat" method="post" onSubmit="return submitInteger(form1.seatrow,'请输入小于30的整数！')&&submitInteger(form1.seatcol,'请输入小于30的整数！');">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="act" value="setseat"/>
    <input type="hidden" name="nexturl" value="<%=nexturl %>"/>
    <input type="hidden" name="noseat"/>

    <div id="mihu">坐席排数：　　　　<input type="text" name="seatrow">
      　　　坐席列数：　　<input type="text" name="seatcol"/>
      　　<input type="submit" value="保存设置"/>
    </div>
    <br />
    <div id="mihu"><a href="#">布置效果</a></div>
	<style>
	#tablecenterleft td{padding:0px 5px;}
	</style>
    <table width="40%" border='1' cellpadding='0' cellspacing='0' id='tablecenterleft'>
      <tr id='tableonetr'><td width="8%"><img src="/res/cavendishgroup/u/0810/081018936.jpg"></td>
      <%
      int sumcol = CioSeatSet.sumCol();
      for(int i = 1; i <=sumcol; i++)
      {
        out.print("<td nowrap>"+i+"</td>");
      }
      %>
      </tr>
      <%
      int sumrow = CioSeatSet.sumRow();
      for(int j= 1; j <=sumrow;j++)
      {
        out.print("<tr><td align=center>"+j+"</td>");
        for(int i = 1; i<=sumcol;i++)
        {
          out.print("<td id='"+j+"-"+i+"' nowrap align=center onclick=f_click(this.id);>"+j+"-"+i+"</td>");
        }
        out.print("</tr>");
      }
      %>
      </table>

    </form>
    <div id='tablebottom_02' style="clear:both;">
    说明：<br />
    如果会场中有不能坐人的位置请点击表格相应区域。<br />
    </div>

    <div id="head6"><img height="6" src="about:blank"></div>
      <map name="Map"><area shape="rect" coords="208,615,361,639" href="/jsp/cio/OkCioCompan12.jsp">
      </map>
      <script type="">
        var noseat= '<%=noseat%>';

        var ns = noseat.split("/");

        for(var i = 1;i < ns.length-1;i++)
        {

          document.getElementById(ns[i]).style.backgroundColor='#FF9966';
        }

        </script>
  </body>
</html>
