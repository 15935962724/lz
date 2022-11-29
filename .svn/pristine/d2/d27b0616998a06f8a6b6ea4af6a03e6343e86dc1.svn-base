
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.confab.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


int sort =7;
if(request.getParameter("sort")!=null && request.getParameter("sort").length()>0)
     sort = Integer.parseInt(request.getParameter("sort"));
String community = teasession._strCommunity;
boolean _bCount=request.getParameter("count")!=null;
boolean _bFather=request.getParameter("father")!=null;
int father=0;
if(_bFather)
father=Integer.parseInt(request.getParameter("father"));

DCommunity dc=DCommunity.find(community);
if(father==0)
{
  father=dc.getNode();
}


StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();


int itemid =0;
if(request.getParameter("itemid")!=null && request.getParameter("itemid").length()>0)
{
	itemid = Integer.parseInt(request.getParameter("itemid"));
	if(itemid!=0){
		sql.append(" and itemid=").append(itemid);
		param.append("&itemid=").append(itemid);
	}
}

String itemname=request.getParameter("itemname");
if(itemname!=null&&(itemname=itemname.trim()).length()>0)
{
  sql.append(" AND itemname like ").append(" ").append(DbAdapter.cite("%"+itemname+"%"));
  param.append("&itemname="+java.net.URLEncoder.encode(itemname,"UTF-8"));
}

String cardname=request.getParameter("cardname");
if(cardname!=null&&(cardname=cardname.trim()).length()>0)
{
  sql.append(" AND cardname like ").append(" ").append(DbAdapter.cite("%"+cardname+"%"));
  param.append("&cardname="+java.net.URLEncoder.encode(cardname,"UTF-8"));
}
int id = 0;
if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
   id = Integer.parseInt(request.getParameter("id"));


int count=CertiBrand.count(teasession._strCommunity,sql.toString());
int size = 10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
//param.append("&pos=").append(pos);
String o=request.getParameter("o");
if(o==null)
{
  o="certibrand";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

//sql.append(" ORDER BY times desc  ");

%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>

  <script >
  function editimd(igd)
  {
    form1.certibrand.value=igd;
    form1.deletes.value='deletes';
    form1.action='/jsp/admin/certificate/EditBrand.jsp';
    form1.submit();
  }
  function deleteimd(igd)
  {
    if(confirm('您确认要删除！'))
    {
      form1.certibrand.value=igd;
      form1.act.value="delete";
      form1.action='/servlet/EditCertiBrand';
      form1.submit();
    }
  }

  function rad(id)
  {

    var ewebeditor=document.all('a');
    if(form1.itemid.value==0)
    {
        ewebeditor.style.display="";

    }
    else
    {
        ewebeditor.style.display="none";
        form1.itemname.value=='';

    }
  }

   function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }
  </script>
  <body onLoad="rad();">

  <h1>品牌申请管理</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <h2>查询</h2>
    <form name=form1 METHOD=post  action="?">
      <input type=hidden name="act" />
      <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>">
      <input type="hidden" name="certibrand" />
      <input type="hidden" name="deletes"/>
        <input type="hidden" name="o" VALUE="<%=o%>">
      <input type="hidden" name="aq" VALUE="<%=aq%>">

      <input type="hidden" name="id" value="<%=id%>">
       <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
          <td>工程项目名称
    <select name="itemid" onclick ="rad();" >
    <option value="0">----------</option>

      <%

      DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT node FROM Node WHERE type>=1024 AND community="+db.cite(community)+" AND path LIKE "+db.cite("%/"+father+"/%")+" AND vcreator="+db.cite(teasession._rv._strV));
  while(db.next())
  {
    int node_id=db.getInt(1);
    Node node_obj=Node.find(node_id);
    Dynamic d_obj=Dynamic.find(node_obj.getType());
    Category c=Category.find(node_id);
    Dynamic dynamic = Dynamic.find(c.getCategory());
    if(d_obj.getSort()==sort){

     out.print("<option value="+node_id);
     if(itemid==node_id)
         out.print("  selected");
     out.print(">"+node_obj.getSubject(teasession._nLanguage));
      out.print("</option>");
   }
  }
}finally
{
  db.close();
}
%>
       </select><span id="a" style="display:none"><input type="text" name="itemname" value=""> </span></td>
          <td><input type="submit" value="查询"/></td>
       </tr>
       </table>

      <h2>列表</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

        <tr id="tableonetr">
          <td nowrap="nowrap">序号</td>
          <td nowrap><a href="javascript:f_order('itemid');">工程项目名称</a>
           <%
          if(o.equals("itemid"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
          </td>
          <td nowrap><a href="javascript:f_order('certificate1');">公司证照</a>
           <%
          if(o.equals("certificate1"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %>
          </td>
          <td nowrap><a href="javascript:f_order('certificate2');">个人证照</a> <%
          if(o.equals("certificate2"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <td nowrap><a href="javascript:f_order('type');">审核状态</a> <%
          if(o.equals("type"))
          {
            if(aq)
            out.print("↓");
            else
            out.print("↑");
          }
          %></td>
          <td nowrap >操作</td>

        </tr>

        <%
        Enumeration e = CertiBrand.find(teasession._strCommunity,sql.toString(),pos,size);
        int index =pos+1;
         if(!e.hasMoreElements())
        {
          out.print("<tr><td colspan=5 align=center>暂无记录</td></tr>");
        }
        while(e.hasMoreElements())
        {
          int certibrand = ((Integer)e.nextElement()).intValue();
          CertiBrand obj = CertiBrand.find(certibrand);
          Node n = Node.find(obj.getItemid());



          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td align="center"><%= index%></td>
            <td ><a href="/jsp/admin/certificate/ShowBrand.jsp?certibrand=<%=certibrand%>" target="_blank"><%
            if(obj.getItemid()==0)
            {
              out.print(obj.getItemname());
            }else
            {
              out.print(n.getSubject(teasession._nLanguage));
            }
            %></a></td>
            <td align="center" ><%
            String a[]= obj.getCertificate1().split("/");
            for(int i=1;i<a.length;i++)
            {
              Certificate obj1 = Certificate.find(Integer.parseInt(a[i]));
              out.print(obj1.getCardname()+"&nbsp;");
            }
            %></td>
            <td align="center" ><%
            String a2[]= obj.getCertificate2().split("/");
            for(int i2=1;i2<a2.length;i2++)
            {
              Certificate2 obj2 = Certificate2.find(Integer.parseInt(a2[i2]));
              out.print(obj2.getCardname()+"&nbsp;");
            }
            %></td>
            <td align="center">
            <%
               if(obj.getType()==0 || obj.getType()==1 || obj.getType()==2){
                 out.print("等待审核");
               }
               if(obj.getType()<0)
               {
                 out.print("审核失败");
               }
               if(obj.getType() ==3)
               {
                 out.print("审核成功");
               }
            %>            </td>

            <td align="center" ><input  type ="button"  value="编辑" onClick="editimd('<%=certibrand %>');">
              <input type=button value="删除"  onClick="deleteimd('<%=certibrand %>');">
            </td>
          </tr>
          <%
          index++;
        }
        if(count>size){
        %>
        <tr>
          <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
        </tr><%
        }%>
      </table>

      <br>
      <input  type ="button" name="" value="品牌申请" onClick="editimd(0);">

</form>


  <div id="head6"><img height="6" src="about:blank"></div>

  </body>
</html>
