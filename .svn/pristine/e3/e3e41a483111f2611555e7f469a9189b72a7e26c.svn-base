<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.node.*" %>
<%@include file="/jsp/Header.jsp"%>
<%




r.add("/tea/resource/Score");
int score=0;
if(request.getParameter("score")!=null)
score=Integer.parseInt(request.getParameter("score"));



Score obj=Score.find(score);

int gid=obj.getNode();

Golf objcourt= Golf.find(gid,teasession._nLanguage);

String fieldid= obj.getFieldid();
String fieldid2= obj.getFieldid2();

GolfSite obj1 = GolfSite.find(GolfSite.getGSid(gid,fieldid));
GolfSite obj2 = GolfSite.find(GolfSite.getGSid(gid,fieldid2));


tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(obj.member);

String gname=Node.find(obj.getNode()).getSubject(teasession._nLanguage);
if(gname==null)obj.getName();

%><html>
<head><link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ScoreBrowse")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<div  style="width:630px"> <span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">　浏览个人成绩</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：<%=profile_obj.getName(teasession._nLanguage)%></span></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="text-align:left ">
 <tr>
    <td>球场：<%=gname%></td>
    <td>发球台 ： <%=r.getString(teasession._nLanguage,Score.TEE_TYPE[obj.getTee()])%></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>是否是比赛：
      <%if(obj.isCompete())out.print("是");else out.print("否");%></td>
    <td>总杆数 ： <%=obj.getSums()%></td>
    <td>洞数：<%=obj.getCavity()%>洞</td>

  </tr>
  <tr>
    <td colspan="3"><table align="left" id="cavitytext" style="visibility:">
  <tr>
    <td>Hole</td>
    <td>1</td>
    <td>2</td>
    <td>3</td>
    <td>4</td>
    <td>5</td>
    <td>6</td>
    <td>7</td>
    <td>8</td>
    <td>9</td>
    </tr>
	<tr>
	<td>球洞图</td>
<%
for(int index=0;index<9;index++)
{
  if(objcourt.getHole()[index]!=null&&objcourt.getHole()[index].length()>0)
  out.print("<td><A name=ahole"+index+" href="+objcourt.getHole()[index]+" target=_blank><img src="+objcourt.getHole()[index]+" name=imghole"+index+" width=20 height=20></a></td>");
  else
  out.print("<td>无</td>");
}
%>
	</tr>
  <tr>
    <td>标准杆</td>
    <%
    for(int index=0;index<9;index++)
    out.print("<td>"+obj1.getStandard(index+1)+"</td>");
    %>  
    </tr>
  <tr>
    <td>实际杆</td>
        <%boolean bool_particular=false;
    for(int index=0;index<9;index++)
    {
      if(obj.getFact()[index]<=0)
      {
        bool_particular=true;
      }
      out.print("<td>"+obj.getFact()[index]);
    }
    out.print(new tea.html.Script("form1.particular.checked="+bool_particular+";fcavity();"));
    %>
    </tr>
      <tr id="particular" style="visibility:"><td  >上</td> <%
           bool_particular=false;
    for(int index=0;index<9;index++)
    {
      if(obj.getFact()[index]>0)
      {
        bool_particular=true;
      }
      out.print("<td>"+obj.getUp()[index]);
    }
    %>
      </tr>
	  <tr id="particular" style="visibility:"><td  >推</td> <%
    for(int index=0;index<9;index++)
    {
      out.print("<td>"+obj.getBunt()[index]+"</td>");
    }
    %>
      </tr>
</table>
      <table id="cavitytext2" style="visibility:<%//if(obj.getCavity()==9)out.print("hidden");%>">
        <tr>
          <td>10</td>
          <td>11</td>
          <td>12</td>
          <td>13</td>
          <td>14</td>
          <td>15</td>
          <td>16</td>
          <td>17</td>
          <td>18</td>
        </tr><tr>

<%
for(int index=9;index<18;index++)
{
  if(objcourt.getHole()[index]!=null&&objcourt.getHole()[index].length()>0)
  out.print("<td><A name=ahole"+index+" href="+objcourt.getHole()[index]+" target=_blank><img src="+objcourt.getHole()[index]+" name=imghole"+index+" width=20 height=20></a></td>");
  else
  out.print("<td>无</td>");
}
%>
	</tr>   
        <tr>
    <%
    for(int index=9;index<18;index++)
        out.print("<td>"+obj2.getStandard(index-8)+"</td>");
    %><!--input name='standard' readonly type='text'  onchange=\"submitStandard()\" onkeyup='submitStandard()'  value='' size='2'-->
        </tr>
        <tr>
        <%
    for(int index=9;index<18;index++)
    out.print("<td>"+obj.getFact()[index]+"</td>");
    %>
        </tr><!--tr><td>&nbsp;</td></tr-->
          <tr id="particular" style="visibility:"><%
    for(int index=9;index<18;index++)
    {
      out.print("<td>"+obj.getUp()[index]+"</td>");
    }
    %>
      </tr>
	  <tr id="particular" style="visibility:"><%
    for(int index=9;index<18;index++)
    {
      out.print("<td>"+obj.getBunt()[index]+"</td>");
    }
    %>
      </tr>
      </table>

      </td>
  </tr>
  <tr><td>备忘记录</td>
    <td colspan="20"><%=tea.html.HtmlElement.htmlToText(obj.getText())%></td>
  </tr>
  <tr>
    <td>打球日期</td>
    <td><%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>
    </td>
    <td>&nbsp;      </td>
    <td>&nbsp;</td>
  </tr>
  <%
java.text.SimpleDateFormat sdf=new  java.text.SimpleDateFormat ("yyyy-MM-dd hh:mm");
  %>
  <tr><td>创建日期</td><td><%=sdf.format(obj.getCreateTime())%></td></tr>
  <tr><td>打球日期</td><td><%=sdf.format(obj.getAlterTime())%></td></tr>
</table>



<input name="submit" type="submit" class="edit_button" onClick="javaScript:window.close();"  id="edit_submit"  value="关闭">
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
