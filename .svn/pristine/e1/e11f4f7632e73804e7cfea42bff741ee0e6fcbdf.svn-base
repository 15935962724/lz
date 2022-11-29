<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession=new TeaSession(request);
Enumeration fs = CioSeatSet.fingSeat();
if(!fs.hasMoreElements())
{
  response.sendRedirect("/jsp/cio/error.jsp");
  return;
}

String type = request.getParameter("type");
String menuid=request.getParameter("id");
String nexturl=request.getParameter("nexturl");
String q=request.getParameter("q");
int ciocompany=-1;
StringBuffer sql =new StringBuffer();
StringBuffer sql1 =new StringBuffer();
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity+"&type="+type);
sql.append(" and receipt=1 AND time IS NOT NULL");
if(q!=null)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
  param.append("&q=").append(q);
}

String name = request.getParameter("name");
if(name!=null && name.length()>0)
{
  sql1.append(" and name like ").append(DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(name);
}

String rSex = request.getParameter("sex");
if(rSex!=null&& rSex.length()>0&&!rSex.equals("2"))
{
  sql1.append(" and sex=").append(rSex);
  param.append("&sex=").append(rSex);
}

String member = request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql1.append(" and member like ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(member);
}

Resource r=new Resource();

int count = 0;
int pos = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
int pageSize=10;

int sumRow = CioSeatSet.sumRow();
int sumCol = CioSeatSet.sumCol();
String noseat1 = "";
String noseat = "";
noseat=CioSeatSet.notSeat();

  Enumeration eee = CioSeatSet.noProSeat();
  String noProSeat="";
  if(noseat!= null){
  while(eee.hasMoreElements())
  {
    noProSeat += ","+eee.nextElement();
  }
  if(noseat.length()>2)
  {
    noseat1=noseat.substring(1,noseat.length()-1).replaceAll("/","),new Array(").replaceAll("-",",");
  }
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="">
  function d_submit()
  {

      form1.action="/servlet/EditCioSetSeat";
      form1.method="get";
    form1.submit();
  }
  </script>
  </head>
  <body id="qiyelog">
  <%if(type.equals("bd"))
  {
    out.print("<h1>参会人员报到管理</h1>");
  }else if(type.equals("vip"))
  {
    out.print("<h1>VIP人员管理</h1>");
  }else{
    out.print("<h1>参会人员座位安排</h1>");
  }

  %>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br/>

    <form name="form1" action="?" method="post" >
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <input type="hidden" name="act" value="receipt"/>
    <input type="hidden" name="ciopart"/>
    <input type="hidden" name="type" value="<%=type%>"/>


    <div id="mihu">企业集团名称：<input type="text" name="q" value="<%if(q!=null)out.print(q);%>">
      　　　　参会人员姓名：<input type="text" name="name" value="<%if(name!=null)out.print(name);%>"/><br />
      性别：　　　　<select name="sex">
        <option value="2" <%if(rSex!=null&&rSex.equals("2"))out.print("selected");%>>-------</option>
        <option value="1" <%if(rSex!=null&&rSex.equals("1"))out.print("selected");%>>男</option>
        <option value="0" <%if(rSex!=null&&rSex.equals("0"))out.print("selected");%>>女</option>
</select>　　　　　　　　　　&nbsp;&nbsp;&nbsp;代表号：　　　<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/>
  <input type="submit" value="模糊查找"/>
    </div>

    <table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'><tr id='tableonetr'><td id='xuhao' width='5%'>序号</td><td id="xingming" width='10%'>姓名</td><td id='member' width='10%'>代表号</td><td id='sex' width='10%'>性别</td><td id='zhiwu' width='10%'>职务</td><td id='gongsi' width='30%'>企业（集团）名称</td><td id='denglumm'>操作</td></tr>
    <%
    Enumeration e=CioCompany.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
    int i = 1;

    while(e.hasMoreElements())
    {
      CioCompany cc=(CioCompany)e.nextElement();
      int ccid=cc.getCioCompany();
      Enumeration ee = CioPart.findCioPart("and ciocompany="+ccid+" and "+type+"=0"+sql1.toString(),pos,pageSize);
      count +=CioPart.count(teasession._strCommunity,"and ciocompany="+ccid+" and "+type+"=0"+sql1.toString());

      while(ee.hasMoreElements())
      {
        int ciop=((Integer)ee.nextElement()).intValue();
        CioPart cp = CioPart.find(ciop);
        String sex = cp.isSex()?"男":"女";
        out.print("<tr><td id='xuhao' >"+(pos+i)+"</td>");
        out.print("<td id='xingming' align=center>"+cp.getName()+"</td>");
        out.print("<td id='member' align=center>"+cp.getMember()+"</td>");
        out.print("<td id='sex' align=center>"+sex+"</td>");
        out.print("<td id='zhiwu' align=center>"+cp.getJob()+"</td>");
        out.print("<td id='gongsi' align=center>"+cc.getName()+"</td>");
        if(type.equals("bd"))
        {
          out.print("<td id='denglumm'><a href=/jsp/cio/setBdVip.jsp?type=bd&ciopart="+ciop+"&nexturl=/jsp/cio/OkCioCompany2.jsp?type=bd target='_self'>设为已报到</a></td></tr>");
        }else if(type.equals("vip"))
        {
          out.print("<td id='denglumm'><a href=/jsp/cio/setBdVip.jsp?type=vip&ciopart="+ciop+"&nexturl=/jsp/cio/OkCioCompany2.jsp?type=vip target='_self'>设为VIP</a></td></tr>");
        }else
        {
          out.print("<td id='denglumm"+i+"' align=center ><a href=# onclick='c_seat(denglumm"+i+",setseat,\""+ciop+"\");'>安排座位</a></td></tr>");
        }
        i++;
      }


    }
    if(count==0)
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }
    if(count>pageSize){
      %>
      <tr>
        <td colspan="10" align="right" style="padding-right:5px;">
          <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>      </td>
      </tr>
      <%}%>
</table>
<div id="tablebottom_button02">
<%if(type.equals("bd"))
{
  out.print("<input type=\"button\" value=\"查看已报到的人员\" onclick=\"window.location.href='/jsp/cio/VIPBdView.jsp?type=bd';\"/>");
}else if(type.equals("vip"))
{
  out.print("<input type=\"button\" value=\"查看VIP人员\" onclick=\"window.location.href='/jsp/cio/VIPBdView.jsp?type=vip';\"/>");
}else
{
  out.print("<input type=\"button\" value=\"查看已安排座位人员\" onclick=\"window.location.href='/jsp/cio/VIPBdView.jsp?type=seat';\"/>");
}

%>

</div>

<div id="setseat" style="display:none;position:absolute;z-index:99;background-color:#E0EDFE;">
<script type="">
var nos = new Array(new Array(<%=noseat1+")"+noProSeat+")"%>;

function f_find(v1,v2)
{
    for(var j=0;j<nos.length;j++)
    {
      if(nos[j][0]==v1&&nos[j][1]==v2)
      return false;
    }
    return true;
}
function f_change(obj)
{
  var v=parseInt(obj.value);
  var c=form1.seatcol.options;
  while(c.length>0)
  {
    c[0]=null;
  }
  for(var i=1;i<=<%=sumCol%>;i++)
  {
    if(f_find(v,i))    c[c.length]=new Option(i);
  }
}

</script>
 <div class="sr"> 排：<select name="seatrow" onChange="f_change(this)">
    <%
    for(int z=1;z<=sumRow;z++)
    {
        out.print("<option value="+z+">"+z+"</option>");
    }
    %>
    </select>
    </div><div class="sc">
    列：<select name="seatcol">
      </select>
    </div>
      <a href="#" onClick="d_submit();">确定</a>
</div>
    </form>

    <div  id="tablebottom_02">
    <%if(type.equals("bd")){
    out.print("      说明：<br/>      如报到人员不在此显示。<br/>      如查看已报到人员，请进入已报到人员界面。");
  }else if(type.equals("vip")){
    out.print("      说明：<br/>      设为VIP的人员不在此显示。<br/>      如需查看设为VIP的人员，请进入查看VIP人员界面。");
  }else
  {
    out.print("  说明：<br/>      已安排座位的人员不在此显示。<br/>      如有需修改座位的人员，请进入已安排座位人员界面。");
  }

  %>
  </div>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <map name="Map"><area shape="rect" coords="208,615,361,639" href="/jsp/cio/OkCioCompan12.jsp">
    </map>

    <script type="">
    var cm = null;

    function getPos(el,sProp)
    {
      var iPos = 0 ;
      　　while (el!=null)   　　
      {
        iPos+=el["offset" + sProp];
        　el = el.offsetParent;
      }
      　　return iPos;
    }
    function c_seat(id,m,cp)
    {
      form1.ciopart.value=cp;
      f_change(form1.seatrow);

      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left")+100;
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight-18;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }


    }

    function div_display()
    {
      document.all('setseat').style.display='none';
    }
    </script>
    </body>
</html>
