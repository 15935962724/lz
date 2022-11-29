<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

StringBuffer param2 = new StringBuffer("?community=").append(teasession._strCommunity);
StringBuffer sql2 = new StringBuffer();

String member = request.getParameter("member");
String nexturl = request.getParameter("nexturl");
String act = request.getParameter("act");
int cid = 0;
if(request.getParameter("cid")!=null && request.getParameter("cid").length()>0)
{
  cid = Integer.parseInt(request.getParameter("cid"));
}
Citypopedom cobj = Citypopedom.find(cid);
if(member!=null && member.length()>0)
{
  if(Profile.isExisted(member))
  {
    String a[] = request.getParameterValues("cityid");
    String cityid = "/";
    for(int i =0;i<a.length;i++)
    {
      cityid = cityid +a[i]+"/";
    }

    if(cid>0)
    {
      cobj.set(cityid,member);
    }else{
      if(Citypopedom.isExisted(member)){
        response.sendRedirect(nexturl+"?ismember=im2");
        return ;
      }else{
        Citypopedom.create(cityid,member,teasession._strCommunity);
      }
    }
    response.sendRedirect(nexturl);
    return ;
  }else
  {
    response.sendRedirect(nexturl+"?ismember=im");
    return ;
  }
}
if("delete".equals(act))
{
  cobj.delete();
}
String editmember = null,editcityid=null;
if("edit".equals(act))
{
  editmember = cobj.getMember();
  editcityid = cobj.getCityid();
}
String ismember = request.getParameter("ismember");
  int count2 = Citypopedom.count(teasession._strCommunity,sql2.toString());
  int pos2 = 0;
  int pageSize2 =20;
  if (teasession.getParameter("Pos2") != null) {
    pos2 = Integer.parseInt(teasession.getParameter("Pos2"));
  }
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body id="bodynone">
  <script type="">
  function editimd(igd)
  {
    form1.cid.value=igd;
    form1.act.value="edit";
    form1.action='?';
    form1.submit();
  }
  function deleteimd(igd)
  {
    if(confirm('您确认要删除！'))
    {
      form1.cid.value=igd;
      form1.act.value="delete";
      form1.action='?';
      form1.submit();
    }
  }
function f_ajax()
{
  if(form1.member.value=='')
  {
    alert("用户名不能为空!");
    return false;
  }


  var m=0;
  flag=false;
  if(form1.cityid.length)
  {
    for(i=0;i<form1.cityid.length;i++)
    {
      if(form1.cityid[i].checked)
      {
        flag=true;
        m++;
      }
    }
    if(!flag)
    {
      alert("你没有选中任何省份");
      return false;
    }
    else
    {
      return true;
    }

  }
}


  </script>
  <div id="tablebgnone" class="register">
    <h1>授权</h1>
    <div id="head6">
      <img height="6" src="about:blank" alt="">
    </div>
    <FORM name="form1" METHOD="POST" action="?" onSubmit="return f_ajax(this);">
    <input type="hidden" name="act" value=""/>
    <input type="hidden" name="cid" value="<%=cid%>" />
   <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
      <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>        用户ID：
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="text" name="member" value="<%if(editmember!=null)out.print(editmember);%>"/>
          <input type="submit" value="确定"/><span id="sv">&nbsp;<%if("im".equals(ismember)){out.print("用户不存在!");}if("im2".equals(ismember)){out.print("您已经给次用户授权了！");}%></span>
          </td>
        </tr>
      </table>
     <h2>省份列表</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
        <%
        java.util.Enumeration e = City.find(teasession._strCommunity," and father=0",0,Integer.MAX_VALUE);
        for(int i =1 ;e.hasMoreElements();i++)
        {
          int cityid = ((Integer)e.nextElement()).intValue();
          City c = City.find(cityid);
          out.print("<td>");
          out.print("<input type=checkbox name=cityid value="+cityid);
          if(editcityid!=null){
            String a[] = editcityid.split("/");
            for(int j=1;j<a.length;j++)
            {
              if(cityid==Integer.parseInt(a[j]))
              out.print(" checked=true");
            }
          }
          out.print(">"+c.getCityname());
          out.print("</td>");
          if(i%6==0)out.print("</tr>");
        }
        %>
      </table>
          <h2>会员权限列表</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap>会员ID</td>
          <td nowrap>所属省份</td>
          <td nowrap>操作</td>
        </tr>
        <%
           java.util.Enumeration e2 = Citypopedom.find(teasession._strCommunity,sql2.toString(),pos2,pageSize2);
           if(!e2.hasMoreElements())
           {
             out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
           }
           while(e2.hasMoreElements())
           {
                int id2 = ((Integer)e2.nextElement()).intValue();
                Citypopedom c2 = Citypopedom.find(id2);
             %>
             <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
               <td><%=c2.getMember()%></td>
               <td><%
               String b[] =c2.getCityid().split("/");
               for(int i=1;i<b.length;i++)
               {
                  City c = City.find(Integer.parseInt(b[i]));
                  out.print(c.getCityname()+",");
               }
               %></td>
               <td >
                 <input type ="button"  value="编辑" onClick="editimd('<%=id2%>');">

                 <input type=button value="删除"  onClick="deleteimd('<%=id2%>');">

               </td>
             </tr>  <%} if (count2 > pageSize2) {  %>
             <tr>
               <td>&nbsp;</td>
               <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param2.toString() + "&Pos2=", pos2, count2,pageSize2)%>      </td>
             </tr>
             <%}  %>
      </table>
    </FORM>
	  <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
  </body>
</html>
</html>
