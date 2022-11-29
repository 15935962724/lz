<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();

StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);



String members = teasession.getParameter("members");
if(teasession.getParameter("delete")!=null && teasession.getParameter("delete").length()>0)
{
  if(teasession.getParameter("delete").equals("1"))
  {
    String memberd = teasession.getParameter("memberd");
    Volunteer.delete(memberd);
  }
}

int type=0;//审核通过
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  if(teasession.getParameter("type").equals("1"))
  {
    Volunteer.typeIf(members);
  }
}
sql.append(" and member in (select member from profilelayer where  1=1 ");
int province=0;
if(teasession.getParameter("province")!=null && teasession.getParameter("province").length()>0)
{
  province=Integer.parseInt(teasession.getParameter("province"));
  if(province!=0)
  {
    sql.append("  and  province="+province+")");
    param.append("&province+").append(province);
  }
}
String firstname="";
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname=teasession.getParameter("firstname");
  sql.append(" and  firstname = "+DbAdapter.cite(firstname));
  param.append("&firstname+").append(DbAdapter.cite(firstname));
}


String telephone ="";
if(teasession.getParameter("telephone")!=null && teasession.getParameter("telephone").length()>0)
{
  telephone = teasession.getParameter("telephone");
  sql.append(" and telephone="+DbAdapter.cite(telephone));
  param.append("&telephone+").append(DbAdapter.cite(telephone));
}
sql.append(" )");

String email="";
int sex=3;

if(teasession.getParameter("email")!=null && teasession.getParameter("email").length()>0|| teasession.getParameter("sex")!=null)
{

  sql.append("and member in (select member from  profile where 1=1 ");
  if(teasession.getParameter("email")!=null && teasession.getParameter("email").length()>0)
  {
    email= teasession.getParameter("email");
    sql.append(" and email="+DbAdapter.cite(email));
     param.append("&email+").append(DbAdapter.cite(email));
  }
   if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0)
  {

    sex=Integer.parseInt(teasession.getParameter("sex"));
    if(sex==3)
    {

    }
    else{
      sql.append("  and sex="+sex);
      param.append("&sex+").append(sex);
    }
  }
  sql.append(")");

}


String zhiye="";
if(teasession.getParameter("zhiye")!=null && teasession.getParameter("zhiye").length()>0)
{
  zhiye= teasession.getParameter("zhiye");
  sql.append(" and zhiye="+DbAdapter.cite(zhiye));
}
String yixiang="";

param.append("?community="+teasession._strCommunity);

StringBuffer ways = new StringBuffer(",");

int jk=0;
for(int i = 0;i < Volunteer.WAY.length;i++)
{

  if(teasession.getParameter("way" + i) != null)
  {
    if(jk==0)
    {
      sql.append(" and ( ");
    }
    else
    {
      sql.append(" or ");
    }
    sql.append(" way like "+DbAdapter.cite("%"+Volunteer.WAY[i]+"%")+" ");
    ways.append(Volunteer.WAY[i]).append(",");
    jk++;
  }

}
if(jk!=0)
{
  sql.append(" ) ");
}



yixiang=ways.toString();
int count = Volunteer.count(teasession._strCommunity,sql.toString());
%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <style>
#bodyvl h1{width:1002px;margin-left:0px;}
#bodyvl h2{width:1002px;margin-left:0px;}
#bodyvl #tablecenter{border:1px solid #dfdfdf;width:1002px;margin-bottom:15px;border-collapse:collapse;
}
</style>
</HEAD>
<body id="bodyvl">
<h1>志愿者报名列表</h1>
<form name="form2" action="/jsp/volunteer/VolunteerList.jsp" method="POST">
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td>姓名</td><td><input type="text" size="16" name="firstname" /></td><td>手机号</td><td><input type="text" name="telephone" size="20"  mask="int" value=""></td>
    <td>性别</td><td><select name="sex">
      <option value="3"   <%if(sex==3)out.print("selected");%> >---</option>
      <option value="1"   <%if(sex==1)out.print("selected");%> >男</option>
      <option value="0" <%if(sex==0)out.print("selected");%>>女</option></select></td></tr>
      <tr><td>邮件</td><td><input type="text" name="email" size="20" value="<%=email%>" ></td><td>居住地所在城市</td><td>
        <select name="province">
      <%
      for(int i=0;i<Common.CSVCITYS.length;i++)
      {
        out.print("<option value="+Common.CSVCITYS[i][0]);
        if(province==i)
        {
          out.print(" selected ");
        }
        out.print(" >"+Common.CSVCITYS[i][1]+"</option>");
      }

      %>
      </select></td><td>职业</td><td><input type="text" name="zhiye" size="20" value="<%=zhiye%>"  ></td></tr>
      <tr><td>参与意向</td><td colspan="2">   <%
      for(int i=0;i<Volunteer.WAY.length;i++)
      {

        if(i==(Volunteer.WAY.length/2))
        {
          out.print("<br>");
        }
        out.print("<input  name=\"way"+i+"\" type=\"checkbox\" value="+Volunteer.WAY[i]);

        if(yixiang!=null)
        {

          if(yixiang.indexOf(Volunteer.WAY[i])!=-1)
          {
            out.print(" checked='checked'　");
          }
        }
        out.print("/>"+Volunteer.WAY[i]+"   ");
      }
      %>
</td><td><input type="submit" value="查询" /></td></tr>

</table>
</form>

<form name="form1" action="/servlet/EditVolunteer" method="GET">

<table border="1" CELLPADDING="0" CELLSPACING="0" id="tablecenter"  bordercolor="#dfdfdf">
  <tr><td>会员ID
      </td><td nowrap>姓名</td><td nowrap>性别</td><td nowrap>职业</td><td nowrap>年龄</td><td nowrap>联系电话</td><td nowrap>手机号</td><td>意向</td><td>答案</td>
    <td>状态</td><td>&nbsp;</td>
</tr>
<%
java.util.Enumeration eu = Volunteer.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
if(!eu.hasMoreElements())
{
  out.print("<tr><td>暂时没有信息</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
  String member = String.valueOf(eu.nextElement());
  Volunteer vt  =  Volunteer.find(member);
  Profile pro = Profile.find(member);
  String sexy = pro.isSex()?"男":"女";

  int age=0;
  if(pro.getBirth()!=null)
    {
      Calendar cal = Calendar.getInstance();
      Calendar caldate = Calendar.getInstance();
      cal.setTime(pro.getBirth());
      caldate.setTime(date);
      int year =cal.get(Calendar.YEAR);
      int yeardate=caldate.get(Calendar.YEAR);
      age = yeardate - year;
    }
  %>
  <tr>
      <td nowrap="nowrap"><%=member%></td>
    <td nowrap="nowrap"><%=pro.getName(teasession._nLanguage)%></td>
    <td nowrap="nowrap"><%=sexy%></td>
    <td nowrap="nowrap"><%=vt.getZhiye()%></td>
    <td nowrap><%=age%></td>
    <td nowrap><%=pro.getMobile()%></td>
    <td nowrap><%=pro.getTelephone(teasession._nLanguage)%></td>
    <td><%=vt.getWay()%></td>
    <td><%=vt.getAnswer().replaceAll("1","A").replaceAll("2","B").replaceAll("3","C").replaceAll("4","D")%></td>
    <td nowrap><%if(vt.getType()==1){out.print("审核通过");}else{out.print("未审核");}%></td>
    <td>
      <input type="button" value="删除" onClick="if(confirm('确认删除')){window.open('/jsp/volunteer/VolunteerList.jsp?delete=1&memberd=<%=member%>', '_self');this.disabled=true;};" >
      <input type="button" value="编辑" onClick="window.open('/jsp/volunteer/Volunteer.jsp?shenhe=1&members=<%=member%>','_self');">
      <input type="button" value="审核通过" onClick="window.open('/jsp/volunteer/VolunteerList.jsp?type=1&members=<%=member%>','_self');">
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
