<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.util.*" %>
<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();

StringBuffer param=new StringBuffer("?node="+teasession._nNode);
StringBuffer sql=new StringBuffer(" AND lsstatic= 0");

String lsname = teasession.getParameter("lsname");
if(lsname!=null && lsname.length()>0)
{
  sql.append(" AND lsname LIKE ").append(DbAdapter.cite("%"+lsname+"%"));
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}
int lstype =0;
if(teasession.getParameter("lstype")!=null && teasession.getParameter("lstype").length()>0)
{
  lstype = Integer.parseInt(teasession.getParameter("lstype"));
  if(lstype>0){
    sql.append(" AND lstype ="+lstype);
    param.append("&lstype=").append(lstype);
  }
}
int lsstype =0;
if(teasession.getParameter("lsstype")!=null && teasession.getParameter("lsstype").length()>0)
{
  lsstype = Integer.parseInt(teasession.getParameter("lsstype"));
  if(lsstype>0){
    sql.append(" AND lsstype ="+lsstype);
    param.append("&lsstype=").append(lsstype);
  }
}

 //所属区域
int s1=0,s2=0,csarea=0;
if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
{
  s1=Integer.parseInt(teasession.getParameter("s1"));
  sql.append("  and  province=").append(s1);
  param.append("&s1=").append(s1);
}
if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
{
  s2=Integer.parseInt(teasession.getParameter("s2"));
  sql.append("  and  city=").append(s2);
  param.append("&s2=").append(s2);
}
if(teasession.getParameter("csarea")!=null && teasession.getParameter("csarea").length()>0)
{
  csarea=Integer.parseInt(teasession.getParameter("csarea"));
  if(csarea==0)
  {

  }
  else
  {
    sql.append("  and  csarea=").append(csarea);
    param.append("&csarea=").append(csarea);
  }
}


int count=0;
int pos=0;
int pageSize=10;
if( teasession.getParameter("pos")!=null)
{
  pos=Integer.parseInt(  teasession.getParameter("pos"));
}
count = LeagueShop.count(teasession._strCommunity,sql.toString());



%>
<html>
<head>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
<title>查找加盟店</title>
</head>
<body id="bodynone" >
<script type="">
window.name='tar';
function f_button(igd)
{
 window.returnValue=igd;
  window.close();
}
</script>
  <h1>查找加盟店</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form accept="?" name="form1"  target="tar">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>加盟店名称:</td><td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
    <td>加盟店类型:</td><td>
    <select name="lstype">
    <option value="0">请选择类型</option>
    <%
    java.util.Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
    for(int i=0;eu.hasMoreElements();i++)
    {
      int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
      LeagueShopType objty = LeagueShopType.find(idtt);
      out.print("<option value="+idtt);
      if(lstype==idtt)
      {
        out.print(" selected ");
      }
      out.print(">"+objty.getLstypename()+"</option>");
    }
    %>
    </select>

    </td>
    </tr>
    <tr>
    <td>加盟店级别:</td>
    <td>
    <select name="lsstype">
    <option value="0">请选择级别</option>
    <%
   java.util.Enumeration e3 = LeagueShopServer.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
   while(e3.hasMoreElements())
   {
     int leassid = ((Integer)e3.nextElement()).intValue();
     LeagueShopServer leassobj = LeagueShopServer.find(leassid);
     out.print("<option value="+leassid);
     if(lsstype==leassid)
     {
       out.print(" selected ");
     }
     out.print(">"+leassobj.getLssname());
     out.print("</option>");
   }
    %>
    </select>
    </td>
    <td>所属区域:</td>
    <td>
       <script src="/tea/card.js" type=""></script>
        <script type="">
        var delcct=new Array();
        function f_area(objcct)
        {
          var rscct=area[parseInt(objcct.value)][1];
          var op=form1.s1.options;
          for(var i=0;i<delcct.length;i++)
          {
            op[op.length]=new Option(delcct[i][0],delcct[i][1]);
          }
          delcct=new Array();
          for(var i=0;i<op.length;i++)
          {
            if(rscct.indexOf(op[i].value)==-1)
            {
              delcct[delcct.length]=new Array(op[i].text,op[i].value);
              op[i--]=null;
            }
          }
        }
        document.write("<select name='csarea' onchange=f_area(this)>");
        for(var i=0;i<area.length;i++)
        {
          document.write("<option value="+i+">"+area[i][0]+"</option>");
        }

        document.write("</select>　");
        selectcard("s1","s2",null,"<%=s2%>");
        if(<%=s1%>>0)
        {
          form1.s1.value='<%=s1%>';
        }
        form1.csarea.value="<%=csarea%>";
        form1.csarea.onchange();
        </script>
        </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>

<h2>列表(<%=count%>)</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>加盟店名称</td>
      <td nowrap>加盟店类型</td>
      <td nowrap>加盟店级别</td>
      <td nowrap>加盟店地址</td>
    </tr>
    <%
    java.util.Enumeration  e = LeagueShop.findByCommunity(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }

       while(e.hasMoreElements())
       {
         int lsid = ((Integer)e.nextElement()).intValue();
         LeagueShop lsobj = LeagueShop.find(lsid);
         LeagueShopType objty = LeagueShopType.find(lsobj.getLstype());
         LeagueShopServer objser = LeagueShopServer.find(lsobj.getLsstype());
    %>
    <tr onclick="f_button('/<%=lsid%>/<%=lsobj.getLsname()%>/');" onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td><%=lsobj.getLsname()%></td>
      <td><%if(objty.getLstypename()!=null)out.print(objty.getLstypename());%></td>
      <td><%=objser.getLssname()%></td>
       <td><%
         out.print(LeagueShop.CSAREA[lsobj.getCsarea()]+"　　");

            Card dd = Card.find(lsobj.getCity());
            Card dd2 = Card.find(lsobj.getCity());
            out.print(dd.getAddress()+"&nbsp;"+dd2.getAddress()+"&nbsp;");
            if(lsobj.getRegion()!=null&&lsobj.getRegion().length()>0)
            {
               out.print(lsobj.getRegion()+"区");
            }
              if(lsobj.getPort()!=null&&lsobj.getPort().length()>0)
            {
               out.print(lsobj.getPort()+"巷");
            }
             if(lsobj.getNumber()!=null&&lsobj.getNumber().length()>0)
            {
               out.print(lsobj.getNumber()+"号");
            }
           // out.print(lsobj.getRegion()+"区"+lsobj.getPort()+"巷"+lsobj.getNumber()+"号");

             %>
       </td>
    </tr>
    <%} %>
     <%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%
 out.print("<script>document.getElementById('go').style.display='none';</script>");
}  %>
  </table>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <script>
var as=document.getElementById("tdpage");
if(as)
{
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}

</script>
</body>
</html>
