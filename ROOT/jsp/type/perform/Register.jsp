<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.node.*" %><%@page  import="tea.entity.site.*" %><%@ page import="java.util.*" %><%@ page import="java.io.*" %>
<%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %>
<%@ page import="tea.htmlx.*"%>
<%

request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);

if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}



String nexturl=teasession.getParameter("nexturl");
String act = teasession.getParameter("act");

int  psid = 0;
if(teasession.getParameter("psid")!=null && teasession.getParameter("psid").length()>0)
{
  psid = Integer.parseInt(teasession.getParameter("psid"));
}
int void2 = 0;
if(teasession.getParameter("void2")!=null && teasession.getParameter("void2").length()>0)
{
	 void2 = Integer.parseInt(teasession.getParameter("void2"));
}

Vote vobj = Vote.find(void2);


if("EditVote".equals(act))
{

  String votename = teasession.getParameter("votename");
   int voteid = void2;
  if(vobj.isExist())
  {
    vobj.set(psid,votename,0,0,0,0,0,0,0,0,0,0,teasession._rv.toString());
  }else
  {
    voteid =  Vote.create(psid,votename,0,0,0,0,0,0,0,0,0,0,teasession._rv.toString(),teasession._strCommunity);
  }

     java.util.Enumeration e4 = PriceSubarea.find(teasession._strCommunity," AND psid="+psid,0,Integer.MAX_VALUE);
      while(e4.hasMoreElements())
      {
        int prsubid = ((Integer)e4.nextElement()).intValue();
        PriceSubarea prsubobj = PriceSubarea.find(prsubid);
        int carfare = Integer.parseInt(teasession.getParameter("carfare"+prsubid));
         VoteCarfare vcobjssss = VoteCarfare.find(VoteCarfare.getVcid(void2,prsubid));

        if(VoteCarfare.getVcid(void2,prsubid)>0)
        {
            vcobjssss.set(voteid,carfare,prsubid);

        }else
        {
        // int vid =  Vote.create(psid,votename,0,0,0,0,0,0,0,0,0,0,teasession._rv.toString(),teasession._strCommunity);
         VoteCarfare.create(voteid,carfare,prsubid);
        }
      }

  out.print("<script>alert('票种添加成功！');window.open ('/jsp/type/perform/EditVote.jsp?community="+teasession._strCommunity+"&psid="+psid+"','tar');</script>");

}else if("delete".equals(act))
{
	vobj.delete();
    VoteCarfare.delete(" and  vottid="+void2);
	out.println("<script>alert('您已经删除这个票种!');window.open ('/jsp/type/perform/EditVote.jsp?community="+teasession._strCommunity+"&psid="+psid+"','tar');</script>");
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script>
window.name='tar';
function f_submit()
{
  if(form1.votename.value=='')
  {
    alert('请添加票种名称!');
    document.form1.votename.focus();
    return false;
  }
}
//编辑票种
function f_edit(igd)
{
  form1.void2.value=igd;
  form1.act.value='';
  form1.submit();

}
//删除票种
function f_delete(igd)
{
	form1.void2.value=igd;
	form1.act.value='delete';
	form1.submit();
}
</script>
<h1>演出管理--场次设置--票种设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td  align="left" colspan=10><%=PerformStreak.find(psid).getPsname() %></td>
	</tr>
  <form name="form1" method="post" action="?"   target="tar"   onSubmit="return f_submit();">
  <input type="hidden" name="act" value="EditVote">
  <input type="hidden" name="psid" value="<%=psid %>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity %>">
 <input type="hidden" name="void2" value="<%=void2 %>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>票种名称</td>
    </tr>
  </table>
  <br>
  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="添加票种">&nbsp;
  <input type="button" value="关闭"  onClick="javascript:window.close();">

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>


</body>
</html>

