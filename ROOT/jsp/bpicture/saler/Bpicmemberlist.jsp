<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.bpicture.*" %>
<%@page import="java.io.File.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %>

<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community = teasession._strCommunity;
int pos=0;
if(teasession.getParameter("pos")!=null && teasession.getParameter("pos").length()>0)
{
  pos = Integer.parseInt(teasession.getParameter("pos"));
}
int count=0;
count=Bperson.count("");

StringBuffer param=new StringBuffer("&community="+community);
int type=0;
int delete=0;

String memberss ="";
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
  memberss = teasession.getParameter("memberss");

  Bperson.setTypestatic(memberss,type);
}
if(teasession.getParameter("delete")!=null && teasession.getParameter("delete").length()>0)
{
  delete = Integer.parseInt(teasession.getParameter("delete"));
  if(delete==1)
  {
    StringBuffer buff =new  StringBuffer("/res/bigpic/salepic/");
    memberss = teasession.getParameter("memberss");

    if(memberss!=null && memberss.length()>0)
    {
      File fpic = new File(application.getRealPath(buff.append(memberss).toString()));
      FileSystem.delTree(fpic);
      count=Baudit.count(teasession._strCommunity," and member="+DbAdapter.cite(memberss));
      Enumeration eu = Baudit.findByCommunity(teasession._strCommunity," and member="+DbAdapter.cite(memberss),0,count);
      if(!eu.hasMoreElements())
      {

      }else
      {
        for(int i=0;eu.hasMoreElements();i++)
        {
          int nodeid=Integer.parseInt(String.valueOf(eu.nextElement()));
          File file = new File(application.getRealPath("/res/"+teasession._strCommunity+"/picture/"+String.valueOf(nodeid)+".jpg"));
          Baudit.delete(teasession._strCommunity, nodeid,file);
        }
      }
    }
  }
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<script>
function Loadnew(aa)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
  var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;scroll:yes;dialogWidth:520px;dialogHeight:245px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
  var url = "/jsp/bpicture/saler/dialogbox.jsp";
  var aio ="";
  document.all.memberpic.value =window.showModalDialog(url,aio,sFeatures);
}
</script>
<style>
#table005{width:95%;margin-top:15px;}
#table005 td{background:#eee;padding:5px 10px;}
.lzj_001{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
</style>
</head>
<body bgcolor="#ffffff">
<h1>
会员信息
</h1>
<FORM name=form1 METHOD=POST action="" onSubmit="">
  <table border="0" cellpadding="0" cellspacing="2" id="table005">
    <input type='hidden' name=memberpic VALUE="<%=2198116%>"/>
    <tr>
      <td>会员姓名</td><td>会员ID</td><td>联系电话</td><td>状态</td><td></td>
    </tr>
    <%
    Enumeration en = Bperson.findByCommunitymember("",pos,10);
    if(!en.hasMoreElements())
    {
      %>
      <tr><td colspan="2">暂无信息</td>
</tr>
<%
}
for(int i=0;en.hasMoreElements();i++)
{
  String member =String.valueOf(en.nextElement());
  Profile pro = Profile.find(member);
  Bperson bpobj = Bperson.findmember(member);
  %>
  <tr><td><%=pro.getFirstName(teasession._nLanguage)%></td>
    <td nowrap=nowrap ><a href="/jsp/bpicture/AuditPicture.jsp?member=<%=member%>"><%=member%></a></td>
    <td nowrap=nowrap ><%=pro.getMobile()%></td>
    <td><%if(bpobj.getTypestatic()==1)
    {
      out.print("注销");
    }else{

      out.print("正常");
    }%></td>
    <td nowrap=nowrap >

    <%if(bpobj.getTypestatic()==1)
    {
     %>
     <input type="button" value="解除注销" onClick="if(confirm('确认解除注销')){window.open('/jsp/bpicture/saler/Bpicmemberlist.jsp?type=0&memberss=<%=member%>', '_self');this.disabled=true;};" >
     <%
    }else{

     %>
          <input type="button" value="注销" onClick="if(confirm('确认注销')){window.open('/jsp/bpicture/saler/Bpicmemberlist.jsp?type=1&memberss=<%=member%>', '_self');this.disabled=true;};" >
     <%
    }%>
    <input type="button" value="删除会员图片" onClick="if(confirm('确认删除会员图片')){window.open('/jsp/bpicture/saler/Bpicmemberlist.jsp?delete=1&memberss=<%=member%>', '_self');this.disabled=true;};" >

      <!--input type="button" value="删除全部信息" /-->
    </td>
</tr>

<%
}
%>
<tr><td colspan="5"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>

  </table>

</form>
</body>
</html>
