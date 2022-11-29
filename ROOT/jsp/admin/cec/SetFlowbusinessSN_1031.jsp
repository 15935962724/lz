<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="java.util.regex.*" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;

int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));

Resource r=new Resource("/tea/resource/Dynamic");

String dtw=request.getParameter("dtw");
int dynamictype=Integer.parseInt(request.getParameter("dynamictype"));
String issuecode=request.getParameter("issuecode");//发文代号

Flowbusiness fb=Flowbusiness.find(flowbusiness);

DynamicValue dv = DynamicValue.find(-flowbusiness, teasession._nLanguage, dynamictype);

String code=MT.f(request.getParameter("code"),dv.getValue());

if(code==null)
{
  Calendar c=Calendar.getInstance();
  Date ftime=fb.getFtime();
  if(ftime!=null)
  {
    c.setTime(ftime);
  }
  int year=c.get(Calendar.YEAR);
  //String issuecode= DynamicValue.find(-flowbusiness, teasession._nLanguage, dtissuecode).getValue();

  //CommunityOffice co=CommunityOffice.find(teasession._strCommunity);
  code=issuecode+"【"+year+"】第"+SeqTable.getSeqNo("flowbusiness.sn")+"号";
}else if(!code.startsWith(issuecode))
{
  code=issuecode+code.substring(code.indexOf('【'));
}

%><html>
<head>
<title>发文字号</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin:10px;
 background-color:menu;
}
-->
</style>
<script>

var dt=(opener?opener:dialogArguments).form1.dynamictype<%=dynamictype%>;
var code=dt.value;
function f_submit()
{
  dt.value=document.getElementById("before").innerHTML+(form1.sn?form1.sn.value:document.getElementById("sn").innerHTML)+document.getElementById("after").innerHTML;
  window.close();
  return false;
}
</script>
</head>
<body>
<br/>
<form name="form1" action="?" method="post" onSubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>"/>
<input type="hidden" name="dynamictype" value="<%=dynamictype%>"/>
<input type="hidden" name="code" />
<table class="Views">
<tr class="Date">
<!--  <td>发文字号:</td>-->
  <td align="center">
<%
int i=code.lastIndexOf('第')+1;
int j=code.length()-1;
out.print("<span id=before>"+code.substring(0,i)+"</span>");
out.print("<input name=sn size=4 value="+code.substring(i,j)+" onkeypress='if(event.keyCode<48||event.keyCode>57)event.returnValue=false;' />");
out.print("<span id=after>"+code.substring(j)+"</span>");

%>
<%--
    <script>
    var arr=new Array('综','财','投','人','市','工会','临党');
    var isCreator="<%=member.equals(fb.getCreator())%>";
    var dtw=<%=dtw.indexOf("/"+dynamictype+"/")!=-1%>;
    var sn="<%=sn%>";
    if(isCreator)
    {
      document.write('<select name=type>');
      for(var i=0;i<arr.length;i++)
      {
        document.write('<option value='+arr[i]);
        if(code.indexOf(arr[i]+'〔')!=-1)
        {
          document.write(' selected');
        }
        document.write('>'+arr[i]);
      }
      document.write('</select>');
    }else
    {
      document.write('<span id=type>');
      for(var i=0;i<arr.length;i++)
      {
        if(code.indexOf(arr[i]+'〔')!=-1)
        {
          document.write(arr[i]);
          break;
        }
      }
      document.write('</span>');
    }
    document.write("〔<%=year%>〕");
    //
    var i=code.lastIndexOf('〕')+1;
    if(i>0)
    {
      sn=code.substring(i,code.length-1);
    }
    if(dtw)
    {
      document.write('<input name=sn size=4 value='+sn+' />');
    }else
    {
      document.write('<span id=sn>'+sn+'</span>');
    }
    </script>
--%>
  </td>
</tr>
</table>
<input type="submit" value=" 确 定 "/>
<input type="button" value=" 取 消 " onclick="window.close();"/>
</form>

</body>
</html>
