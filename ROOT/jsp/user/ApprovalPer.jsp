<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.Enumeration"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);

String mem = request.getParameter("mem");
if(mem!=null && mem.length()>0)
{
  sql.append(" and member like ").append(DbAdapter.cite("%"+mem+"%"));
  param.append("&mem=").append(mem);
}

String mob = request.getParameter("mob");
if(mob!=null && mob.length()>0)
{
  sql.append(" and mobile like ").append(DbAdapter.cite("%"+mob+"%"));
  param.append("&mob=").append(mob);
}

String ssx = request.getParameter("sex");
if(ssx!=null && ssx.length()>0 && !ssx.equals("2"))
{

  sql.append(" and sex=").append(ssx);
  param.append("&sex=").append(ssx);
}

String regstyle = "-1";

if(request.getParameter("regstyle")!=null && request.getParameter("regstyle").length()>0 && !request.getParameter("regstyle").equals("-1"))
{
  regstyle = request.getParameter("regstyle");
  sql.append(" and member in (select member from profilezh where regstyle="+regstyle+")");
  param.append("&regstyle=").append(regstyle);
}

String access = "0";

if(request.getParameter("access")!=null && request.getParameter("access").length()>0 && !request.getParameter("access").equals("0"))
{
  access=request.getParameter("access");
  param.append("&access=").append(access);
}

int count = 0;
int pos = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
int pageSize=10;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>
ApprovalPer
</title>
</head>
<body id="bodynone">
<div id="jspbefore" style="display:none">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
<h1>????????????</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <br>
  <h2>??????</h2>
  <form name="" action="?">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <table cellspacing="0" cellpadding="0"  id="tablecenter">
    <tr >
      <td width="20%">
        ???????????????<input type="text" name="mem" value="<%if(mem!=null)out.print(mem);%>"/>
      </td>
      <td width="20%">?????????<select name="sex"><option value="2">----</option><option value="1" <%if(ssx!=null){if(ssx.equals("1"))out.print("selected");}%>>???</option><option value="0" <%if(ssx!=null){if(ssx.equals("0"))out.print("selected");}%>>???</option></select></td>
      <td width="20%">???????????????<input type="text" name="mob" value="<%if(mob!=null)out.print(mob);%>"/></td>
      <td width="20%">?????????
          <select name="regstyle"><%=regstyle%>
            <option value="-1" <%if(regstyle.equals("-1"))out.print("selected");%>>---------</option>
            <option value="0" <%if(regstyle.equals("0"))out.print("selected");%>>??????</option>
            <option value="1" <%if(regstyle.equals("1"))out.print("selected");%>>??????</option>
            <option value="2" <%if(regstyle.equals("2"))out.print("selected");%>>??????</option>
            <option value="3" <%if(regstyle.equals("3"))out.print("selected");%>>???????????????</option>
          </select></td>
        <td width="20%">?????????
          <select name="access">
            <option value="0" <%if(access.equals("0"))out.print("selected");%>>---------</option>
            <option value="1" <%if(access.equals("1"))out.print("selected");%>>?????????</option>
            <option value="2" <%if(access.equals("2"))out.print("selected");%>>?????????</option>
          </select></td>
          <td><input type="submit" value="GO"/></td>
    </tr>
  </table>
  </form>
  <br />
  <h2>??????</h2>

  <table cellspacing="0" cellpadding="0"  id="tablecenter">
    <tr ID=tableonetr>
      <td width="15%">????????????</td><td width="10%">??????</td><td width="20%">????????????</td><td width="15%">??????</td><td width="20%">??????</td><td>??????</td>
    </tr>
    <%
    Enumeration e = ProfileZh.findByCommunity(teasession._strCommunity,sql.toString()+" order by time desc",pos,pageSize);
    count = ProfileZh.count(teasession._strCommunity,sql.toString());
    tea.entity.admin.AdminUsrRole aur = tea.entity.admin.AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR);

int index=0;
    while(e.hasMoreElements())
    {
      String member = (String)e.nextElement();
      Profile p = Profile.find(member);
      ProfileZh pz = ProfileZh.find(member);
      String sex = p.isSex()?"???":"???";
      String ace = "";
      if(pz.getRegbuffer()==1){
       ace = ProfileZh.AisExisted(member)?"?????????":"?????????";
      }else{
        ace="?????????";
      }

      if(access.equals("1")&&ace.equals("?????????")||access.equals("2")&&ace.equals("?????????")||access.equals("0")){
        out.print("<tr><td align=center><a href='/jsp/user/ProfileZhView.jsp?member="+java.net.URLEncoder.encode(p.getMember(),"utf-8")+"'>"+p.getMember());
        out.print("<td align=center>"+sex);
        out.print("<td align=center>"+p.getMobile());
        out.print("<td align=center>"+pz.getRegToHtml());
        out.print("<td align=center>"+ace);
        out.print("<td id=cz"+index+"><input type=button value=?????? onclick=window.location.href='/jsp/user/EditProfileZh.jsp?member="+java.net.URLEncoder.encode(member,"utf-8")+"&back=1&nexturl=/jsp/user/ApprovalPer.jsp'; />&nbsp;<input type=button value=?????? onclick=if(confirm('????????????????????????')){window.location.href='/jsp/user/DelProfileZh.jsp?member="+java.net.URLEncoder.encode(member,"utf-8")+"&act=del';} />&nbsp;");
        out.print("<input type=button value=???????????? onclick=c_seat(cz"+index+",wai,'"+member+"','"+pz.getRegstyle()+"'); />&nbsp;");
        if(pz.getRegbuffer()==1){
          if(!ProfileZh.AisExisted(member)){
            out.print("<input type=button value=?????? onclick=window.location.href='/jsp/user/DelProfileZh.jsp?member="+java.net.URLEncoder.encode(member,"utf-8")+"&regs="+pz.getRegstyle()+"&act=app'; />&nbsp;");
          }else{
            out.print("<input type=button value=?????? onclick=if(confirm('???????????????????????????????????????')){window.location.href='/jsp/user/DelProfileZh.jsp?member="+java.net.URLEncoder.encode(member,"utf-8")+"&act=napp';} />&nbsp;");
          }
        }

        if(aur.getRole().length()>1)
        {
          out.print("<input type=button value=???????????? onclick=if(confirm('??????????????????????????????')){window.location.href='/jsp/user/DelProfileZh.jsp?member="+java.net.URLEncoder.encode(member,"utf-8")+"&act=condel';} />&nbsp;");

          if(pz.getRegbuffer()!=1){
            out.print("<input type=button value=?????????????????? onclick=window.location.href='/jsp/user/DelProfileZh.jsp?member="+java.net.URLEncoder.encode(member,"utf-8")+"&act=upreg'; />");
          }else{
            out.print("<input type=button value=????????? />");
          }
        }
      }
      index++;
    }
    if(count==0)
    {
      out.print("<tr><td colspan=10 align=center>????????????</td></tr>");
    }
    if(count>pageSize){
      %>
      <tr>
        <td colspan="10" align="right" style="padding-right:5px;">
          <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>      </td>
      </tr>
      <%}
      %>
      </table>
      <div id="wai"  style="display:none;width:250px;position:absolute;z-index:99;background-color:#E0EDFE;">
  <form name="reg" action="/servlet/EditProfileZh" method="POST">
  <input type="hidden" name="type" value="regstyle"/>
  <input type="hidden" name="member"/>

        <input id="lx0" type="radio" name="regstyle" value="0" checked="checked"/>&nbsp;<label for="lx0">??????</label>
        <input id="lx1" type="radio" name="regstyle" value="1"/>&nbsp;<label for="lx1">??????</label>
        <input id="lx2" type="radio" name="regstyle" value="2"/>&nbsp;<label for="lx2">??????</label>
        <input id="lx3" type="radio" name="regstyle" value="3"/>&nbsp;<label for="lx3">???????????????</label><br /><br />
   <center>
        <input type="submit" value="??????"/>
    </center>
  </form>
</div>

      <div id="jspafter" style="display:none">
        <%=community.getJspAfter(teasession._nLanguage)%>
      </div>
<script type="">
 var cm = null;

    function getPos(el,sProp)
    {
      var iPos = 0 ;
      ??????while (el!=null)   ??????
      {
        iPos+=el["offset" + sProp];
        ???el = el.offsetParent;
      }
      ??????return iPos;
    }
    function c_seat(id,m,ids,sandz)
    {
      document.reg.member.value=ids;
      document.getElementById('lx'+sandz).checked=true;

      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left");
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight-75;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }
    }
</script>
</body>
</html>
