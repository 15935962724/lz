<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@page import="java.io.*"  %><%@page import="java.util.*"  %><%@page import="tea.entity.member.*"  %><%@ page  import="tea.entity.bbs.*"  %><%@ page  import="java.text.*"  %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);


String cn=teasession.getParameter("cn");

Profile p=Profile.find(teasession._rv!=null?teasession._rv._strR:session.getId());

BBSForum bf=BBSForum.find(teasession._nNode);

boolean type=Boolean.parseBoolean(teasession.getParameter("type"));
int bbsid=Integer.parseInt(teasession.getParameter("bbsid"));
if("POST".equals(request.getMethod()))
{
  int bbsattach=Integer.parseInt(teasession.getParameter("bbsattach"));
  if(bbsattach>0)
  {
    BBSAttach ba=BBSAttach.find(bbsattach);
    ba.delete();
  }else
  {
    String file=teasession.getParameter("file");
    if(file==null)
    {
      out.print("<script>alert('无效文件!');history.back();</script>");
      return;
    }
    String name=teasession.getParameter("fileName");
    BBSAttach.create(type,bbsid,p.getMember(),name,file);
  }
  //更新积分
  if(bbsid>0)
  {
    int point=bf.attach;
    if(bbsattach>0)point=-point;//删除扣积分
    p.setIntegral(p.getIntegral()+point);
  }
  //关闭上传进度条
  out.print("<script>parent.mt.close();window.open('/jsp/type/bbs/EditBBSAttach.jsp?bbsid="+bbsid+"&type="+type+"&node="+teasession._nNode+"&cn="+cn+"','_self');</script>");
  return;
}

DecimalFormat df=new DecimalFormat("#,##0.00");

Resource r=new Resource();




Forum fc = Forum.find(teasession._strCommunity);
String ext=fc.getExt();

int lattach=bf.getLAttach(p.getBbslevel());

String sql=" AND member="+DbAdapter.cite(p.getMember())+" AND time>"+DbAdapter.cite(new Date(),true);
int up=BBSAttach.count(sql);


if(bbsid!=0)sql="";//==0:显示今天未提交的附件, !=0:只是贴子上的附件

sql+=" AND type="+DbAdapter.cite(type)+" AND bbsid="+bbsid;

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_submit(a)
{
  var b=a.substring(a.lastIndexOf('.')+1).toLowerCase();
  if("<%=ext%>".indexOf(b)==-1)
  {
    parent.mt.show("对不起，不支持上传此类扩展名的附件。");
    return;
  }
  form1.submit();
  parent.mt.show("附件上传中...",0);
  mt.length(<%=fc.getSize()%>);
}
</script>
</head>
<body style="text-align:left;border:0;margin:0;background:transparent;" id="Accessories" class="<%if(cn!=null)out.print(cn+"Attach");%>">

<form name="form1" action="?" method="post" enctype="multipart/form-data">
<input type=hidden name="bbsid" value="<%=bbsid%>">
<input type=hidden name="type" value="<%=type%>" >
<input type=hidden name="bbsattach" value="0" >
<input type=hidden name="community" value="<%=teasession._strCommunity%>" >
<input type=hidden name="node" value="<%=teasession._nNode%>" >
<%
if(lattach-up>0)
{
  out.print("<table border=0 cellpadding=0 cellspacing=0><tr><td valign=middle width=80><input type='button' value='上传附件' /><input type='file' name='file' size='1' style='margin-top:-20px;width:10;filter:alpha(opacity=0);opacity:0;cursor:hand;' onchange='f_submit(value);' /></td>");//filter:alpha(opacity=0);opacity:0;
}
%>
<td valign="middle">您今天已上传了<%=up%>个附件,还可以上传<%=lattach-up%>附件.</td></tr></table>
<table border="0" cellpadding="0" cellspacing="0" id="table1" >
<%
java.util.Enumeration e=BBSAttach.find(sql,0,Integer.MAX_VALUE);
for(int index=1;e.hasMoreElements();index++)
{
  BBSAttach ba=(BBSAttach)e.nextElement();
  float len=new File(application.getRealPath(ba.getPath())).length()/1024F;
  String name=ba.getName();
  if(name.length()>15)name=name.substring(0,15)+"...";
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%>、</td>
    <td align="right"><%=name%></td>
    <td>&nbsp;</td>
    <td><%=df.format(len)%>K</td>
    <td>
      <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="f_act('del','<%=ba.getBbsattach()%>');">
    </td>
 </tr>
<%
}
%>
</table>
</form><br/>
上传附件最大为: <font color="#009900"><%=fc.getSize()%>M</font><br/>
可上传的附件类型: <font color="#009900"><%=ext.replaceAll(",",", ")%></font>
<script>
function f_act(act,id)
{
  if(act=='del'&&!confirm('确认删除?'))return;
  form1.bbsattach.value=id;
  form1.submit();
}
var ba=parent.document.getElementById('ba');
ba.height=$('table1').rows.length*25+70;
</script>
</body>
</html>
