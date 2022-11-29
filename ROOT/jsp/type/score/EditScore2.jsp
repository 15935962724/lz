<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.node.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}





String tmp=request.getParameter("score");
int score=tmp!=null?Integer.parseInt(tmp):0;

tmp=request.getParameter("golf");
int golf=tmp!=null?Integer.parseInt(tmp):0;

String member;
Score obj=Score.find(score);
if(golf<1)
{
  golf=obj.getNode();
  member=obj.member;
}else
{
  member=request.getParameter("member");
}

Node node=Node.find(golf);
Golf g=Golf.find(golf,teasession._nLanguage);

String name=node.getSubject(teasession._nLanguage);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<title>提交个人成绩</title>
<script language="JavaScript" type="text/JavaScript">
function setSums()
{
  var v=0;
  for(index=0;index<form1.fact.length;index++)
  {
    v+=parseInt(form1.fact[index].value);
  }
  form1.sums.value=v;
}
function setFact(i)
{
  var v=form1.up[i].value;
  if(v.length>1&&v.charAt(0)=='0')form1.up[i].value=v=v.substring(1);
  v=parseInt(v);
  if(isNaN(v))return;
  form1.fact[i].value=v+parseInt(form1.bunt[i].value);
  setSums();
}

function setParticularShow()//输入详细实际杆
{
  particular.style.display=form1.particular_checkbox.checked?"":"none";
  form1.fact[0].readOnly=true;
}
function f_9(f)
{
  var arr=document.getElementsByTagName("TABLE")[1].rows;
  for(var i=0;i<arr.length;i++)
  {
    var td=arr[i].childNodes;
    for(var j=10;j<td.length;j++)
    {
      td[j].style.display=f?"":"none";
    }
  }
}
function fsubmit()
{
  var len=form1.cavity[0].checked?9:18;
  for(var i=0;i<len;i++)
  {
    var v=parseInt(form1.up[i].value);
    if(isNaN(v)||v<1)
    {
      alert('请输入真实的杆数(上果岭杆数必需大于0)');
      form1.up[i].select();
      return false;
    }
  }
  return true;
}
function f_sub()
{
	//if(confirm('您确定要更换场地吗？如果更换场地您所填写数据将重新填写!'))
	//{
		var f1,f2;
		var a = document.getElementsByName("fieldid");
		for(i=0;i<a.length;i++)
		{
		if(a[i].checked)
			f1=a[i].value;
		} 
		var a2 = document.getElementsByName("fieldid2");
		for(i=0;i<a2.length;i++)
		{
		if(a2[i].checked)
			f2=a2[i].value;
		} 
		  sendx("/jsp/type/score/EditScore2_ajax.jsp?act=EditScore2_ajax&role=false&score="+form1.score.value+"&golf="+form1.golf.value+"&fieldid="+f1+"&fieldid2="+f2,
			 function(data)
			 {
	
			  //alert("4444->>>>."+data.length);
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
			   {
	 
				 // alert(data);
				 document.getElementById("show").innerHTML=data;
				  
			   }
			 }
			 );
		//}
	
}
</script>


</head>
<body onload="f_sub();">

<h1>填写成绩</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" method="post" action="/servlet/EditScore" onSubmit="return fsubmit()">
<input type=hidden name="community" value="<%=teasession._strCommunity%>" >
<input type=hidden name="score" value="<%=score%>" >
<input type=hidden name="member" value="<%=member%>" >
<input type=hidden name="golf" value="<%=golf%>" >
<input type=hidden name="name" value="<%=name%>">
<input type=hidden name="times" value="<%if(obj.getTimes()!=null)tea.entity.Entity.sdf2.format(obj.getTimes()); %>"/> 
<input type=hidden name="nexturl" value="/jsp/type/score/Scores.jsp">


<table cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>球场</td>
    <td><%=name%></td>
    <td>会员</td>
    <td><%=member%></td>
  </tr>
  
  <tr>
  
    <td>球洞</td>
    <td>
     <!--  <input name="cavity"  id="radio" type="radio" <%if(obj.getCavity()==9)out.print(" CHECKED ");%> value="9" onclick="f_9(false);">9洞-->
      <input name="cavity"  id="radio" type="radio" value="18" onclick="f_9(true);" <%if(obj.getCavity()!=9)out.print(" CHECKED ");%> >18洞&nbsp;(前九区和后九区之和)
    </td>
    <td>发球台</td>
    <td>
    <%
    for(int i=0;i<5;i++)
    {
      out.print("<img src=/tea/image/score/0"+(i+1)+".jpg width=12 height=12 /><input  type=radio name=tee value="+i);
      if(obj.tee==i)out.print(" checked=''");
      out.print(" />　");
    }
    %>
    </td>
  </tr>
  <tr>
    <td>是否是比赛</td>
    <td><input type="CHECKBOX" name="compete" <%if(obj.isCompete())out.print(" CHECKED ");%>>比赛成绩请打勾</td>
    <td>总杆数</td>
    <td><input name="sums" type="text" value="<%=obj.getSums()%>" size="10" readonly="readonly" mask='int'>
    <%--
      <input name="particular"   id="CHECKBOX" type="CHECKBOX" onclick="fcavity();">只输入总杆数
      --%>
    </td>
  </tr>
  <tr>
  	<td>前九区场地:</td>
  	<td>
  		<%
  		Enumeration e = GolfSite.find(teasession._strCommunity," and node = "+golf,0,100);

  			while(e.hasMoreElements())
  			{
  				int gsid = ((Integer)e.nextElement()).intValue();
  				GolfSite gsobj = GolfSite.find(gsid);
  				out.print("<input type=\"radio\" name=\"fieldid\" value=\""+gsobj.getSeq()+"\"");
  				if(obj.getFieldid()!=null && obj.getFieldid().equals(gsobj.getSeq())){
  					out.print("  checked ");
  				}
  				out.print(" onclick=f_sub();");
  				out.print(">&nbsp;"+gsobj.getGsname()+"&nbsp;");
  			}
  		%>
  		
   	</td>
  	<td>后九区场地:</td>
  	<td><%
  		Enumeration e2 = GolfSite.find(teasession._strCommunity," and node = "+golf,0,100);

  			while(e2.hasMoreElements())
  			{
  				int gsid2 = ((Integer)e2.nextElement()).intValue();
  				GolfSite gsobj2 = GolfSite.find(gsid2);
  				out.print("<input type=\"radio\"  name=\"fieldid2\" value=\""+gsobj2.getSeq()+"\"");
  				if(obj.getFieldid2()!=null && obj.getFieldid2().equals(gsobj2.getSeq())){
  					out.print("  checked ");
  				}
  				out.print(" onclick=f_sub();");
  				out.print(">&nbsp;"+gsobj2.getGsname()+"&nbsp;");
  			}
  		%></td>
  </tr>
  
</table>

<span id=show>&nbsp;</span>
<table cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>球童编号</td>
    <td><input name="caddy" value="<%if(obj.caddy!=null)out.print(obj.caddy);%>"/></td>
</tr>
<tr><td>备忘记录</td>
  <td><textarea  name="text" cols="80" rows="6" ><%=tea.html.HtmlElement.htmlToText(obj.getText())%></textarea></td>
</tr>
<tr>
  <td>打球日期</td>
  <td>
    <%=new tea.htmlx.TimeSelection("times", obj.times,true,true)%>
    <%--
    <input type="text"  readonly="readonly" name="times" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
    <input type="button" name="Submit" value="..." onclick="ShowCalendar('form1.times')"></td>
    --%>
</tr>
</table>
<br/> 
<%
if(score<1)out.print("<input type=button value='上一步' onclick=window.open('/jsp/type/score/EditScore1.jsp?"+request.getQueryString()+"','_self') />");
%>
<input type="submit" value="提交">
<input type="button" value="返回" onclick="window.open(form1.nexturl.value+'?community='+form1.community.value,'_self');" />
</form>


<script>
var arr=document.getElementsByTagName("INPUT");
for(var i=0;i<arr.length;i++)
{
   if(arr[i].readOnly)arr[i].style.backgroundColor="#CCCCCC";
}
</script>
</body>
</html>
