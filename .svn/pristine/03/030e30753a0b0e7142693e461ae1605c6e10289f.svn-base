<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);

Http h=new Http(request);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource().add("/tea/resource/deptuser");

String menuid=h.get("id");
CommunityOption co=CommunityOption.find(teasession._strCommunity);
boolean sms;
sms=co.get("smstype")!=null;


int pos=h.getInt("pos");

StringBuffer sql = new StringBuffer();
StringBuffer par=new StringBuffer();
boolean isSel = false;//是否查询

par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(menuid);
String name = h.get("name","");
if(name.length()>0)
{
  isSel = true;
  sql.append(" AND member in (select member from profilelayer where (lastname+firstname) like '%"+name+"%')");
  par.append("&name=").append(name);
}
par.append("&pos=");

int sum=0;
if(!isSel){
  sum = AdminUnit.countByCommunity(teasession._strCommunity,"");
}else{
  sum = Profile.count(sql.toString());
}

%><HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
.file{position:absolute;width:10;cursor:pointer;filter:alpha(opacity=0);opacity:0;margin-left:-70px;}
</style>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "设置签名")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" >
<tr><td>
姓名：<input type="text" name="name" value="<%=name%>"/>&nbsp;<input type="submit" value="GO"/>
</td>
</table>
</form>

<form name="form2" action="/servlet/EditProfileBBS" METHOD=POST enctype="multipart/form-data">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="allisign">
<input type="hidden" name="param">
<table id="tablecenter" >
<%
if(sum>0)
{
  if(isSel)
  {
    Enumeration enumer1 =tea.entity.member.Profile.findByCommunityMem(teasession._strCommunity,sql.toString(),true);
    while(enumer1.hasMoreElements())
    {
      String member =(String)enumer1.nextElement();
      Profile p = Profile.find(member);
      if(p==null)continue;
      ProfileBBS pb =ProfileBBS.find(teasession._strCommunity ,member);
      String isign=MT.f(pb.getISign(teasession._nLanguage));
      String nid=Http.enc(member).replace('%','_');
      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td nowrap=nowrap title=\"电话:"+p.getTelephone(teasession._nLanguage)+"&#13;手机:"+p.getMobile()+"&#13;邮箱:"+p.getEmail()+"\">　&nbsp;");
      out.print(p.getName(teasession._nLanguage)+"</td><td>");
      out.print("<img id='i"+nid+"' src='"+(isign.length()>0?isign:"/tea/image/public/blank_png.gif")+"'/>");
      out.print("</td><td><input type='button' value='上传签名'/><input name='"+nid+"' type='file' size='1' class='file' onchange=$('i"+nid+"').src=value;>　");
      out.print("<input type=checkbox name='clear_"+nid+"' id='clear_"+nid+"' onclick='f_clear(this)'><label for='clear_"+nid+"'>清空</label></td></tr>");
    }
  }else
  {
    Enumeration e = AdminUnit.findByCommunity(teasession._strCommunity," ORDER BY sequence",pos,300);
    for(int i=1;e.hasMoreElements();i++)
    {
      AdminUnit obj=(AdminUnit)e.nextElement();
      int id=obj.getId();
      int fid=obj.getFather();
      out.print("<tr><td colspan=2 nowrap=nowrap>&nbsp;&nbsp;");
      out.print(obj.getPrefix());
      out.print("<b>"+obj.getName() + "</b></td></tr>");
      Enumeration enumer =tea.entity.member.Profile.findByCommunityNew(teasession._strCommunity,sql.toString(),id,true);
      while(enumer.hasMoreElements())
      {
        String member =(String)enumer.nextElement();
        Profile p = Profile.find(member);
        if(p==null)continue;
        ProfileBBS pb =ProfileBBS.find(teasession._strCommunity ,member);
        String isign=MT.f(pb.getISign(teasession._nLanguage));
        String nid=Http.enc(member).replace('%','_');
        out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td nowrap=nowrap title=\"电话:"+p.getTelephone(teasession._nLanguage)+"&#13;手机:"+p.getMobile()+"&#13;邮箱:"+p.getEmail()+"\">　&nbsp;");
        out.print(obj.getPrefix().replaceAll("├",""));
        out.print(p.getName(teasession._nLanguage)+"</td><td>");
        out.print("<img id='i"+nid+"' src='"+(isign.length()>0?isign:"/tea/image/public/blank_png.gif")+"'/>");
        out.print("</td><td><input type='button' value='上传签名'/><input name='"+nid+"' type='file' size='1' class='file' onchange=$('i"+nid+"').src=value;>　");
        out.print("<input type=checkbox name='clear_"+nid+"' id='clear_"+nid+"' onclick='f_clear(this)'><label for='clear_"+nid+"'>清空</label></td></tr>");
      }
    }
  }
}else
{
  out.print("<tr><td colspan='5' align='center'>暂无组织机构");
}
out.print("</table>");
%>
<%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,300)%>
<input type="submit" value="提交"/>
<script>
var is=form2.elements,v="/";
for(var i=0;i<is.length;i++)
{
  if(is[i].type=='file')v+=is[i].name+"/";
}
form2.param.value=v;
function f_clear(a)
{
  var n=a.name.substring(6);
  n=eval('form2.'+n);
  if(!n.length)n=new Array(n);
  for(var i=0;i<n.length;i++)n[i].previousSibling.disabled=n[i].disabled=a.checked;
}
</script>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
