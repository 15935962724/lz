<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.semi.*" %>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();



int sgid =0;
if(teasession.getParameter("sgid")!=null && teasession.getParameter("sgid").length()>0)
{
  sgid = Integer.parseInt(teasession.getParameter("sgid"));
}

int ids =0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
int deleteid =0;
if(teasession.getParameter("deleteid")!=null && teasession.getParameter("deleteid").length()>0)
{
  deleteid = Integer.parseInt(teasession.getParameter("deleteid"));
  SemiSupplier.delete(deleteid);

}


SemiGoods sgobj = SemiGoods.find(sgid);
SemiSupplier ssobjbj = SemiSupplier.find(ids);
sql.append("  and sgid="+sgid);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <script type="">
  function find_sub()
  {
    if(form1.goodsnumber.value=="")
    {
      alert("商品编号不能为空，请重新填写！");
      return false;
    }
    if(form1.subject.value=="")
    {
      alert("商品名称不能为空，请重新填写！");
      return false;
    }
    if(form1.spec.value=="")
    {
      alert("商品规格不能为空，请重新填写！");
      return false;
    }
    if(form1.measure.value=="")
    {
      alert("单位不能为空，请重新填写！");
      return false;
    }
    if(form1.supply.value=="")
    {
      alert("进价不能为空，请重新填写！");
      return false;
    }
  }
  </script>
  <body>
  <h1>半成品管理</h1>
  <form name="form1" action="/servlet/EditSemiGoods" method="POST" >
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="sgid" value="<%=sgid%>"/>
    <input type="hidden" name="ids" value="<%=ids%>"/>
  <input type="hidden" name="act" value="EditSemiGoodsSupplier"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
  <h2>半成品管理</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap align="right">供应商：&nbsp;</td>
      <td>
        <select name="Supplier">
          <%
          java.util.Enumeration enumer=tea.entity.admin.Supplier.findByCommunity(teasession._strCommunity);
          while(enumer.hasMoreElements())
          {
            int id=((Integer)enumer.nextElement()).intValue();
            tea.entity.admin.Supplier obj=tea.entity.admin.Supplier.find(id);
            out.print("<OPTION VALUE="+id);
            if(id==ssobjbj.getSid())
            out.print(" SELECTED ");
            out.print(">"+obj.getName(teasession._nLanguage));
          }
          %>
          </select>
      </td>
    </tr>
    <tr>
      <td nowrap align="right">商品编号：&nbsp;</td><td><%if(sgobj.getGoodsnumber()!=null)out.print(sgobj.getGoodsnumber());%></td>
    </tr>
    <tr>
      <td nowrap align="right">商品名称：&nbsp;</td><td><%if(sgobj.getSubject()!=null)out.print(sgobj.getSubject());%></td>
    </tr>
    <tr>
      <td nowrap align="right">计量单位：&nbsp;</td><td><input type="text" name="measure" value="<%if(ssobjbj.getMeasure()!=null){out.print(ssobjbj.getMeasure());}else if(sgobj.getMeasure()!=null){out.print(sgobj.getMeasure());}%>"/></td>
    </tr>
    <tr>
      <td nowrap align="right">规格：&nbsp;</td><td><input type="text" name="spec" value="<%if(ssobjbj.getSpec()!=null){out.print(ssobjbj.getSpec());}else if(sgobj.getSpec()!=null)out.print(sgobj.getSpec());%>"/></td>
    </tr>
    <tr>
      <td nowrap align="right">进价：&nbsp;</td><td><input type="text" name="supply" value="<%if(ssobjbj.getSupply()!=null){out.print(ssobjbj.getSupply());}else if(sgobj.getSupply()!=null)out.print(sgobj.getSupply());%>" mask="float"/></td>
    </tr>

      <tr>
      <td nowrap align="right">最小进货数量：&nbsp;</td><td><input type="text" name="num" value="<%if(ssobjbj.getNum()!=0){out.print(ssobjbj.getNum());}else{out.print("0");}%>" mask="float"/></td>
    </tr>
    <tr>
      <td nowrap align="right">备注：&nbsp;</td><td><textarea name="info" cols="18" rows="3"><%if(ssobjbj.getInfo()!=null){out.print(ssobjbj.getInfo());}else if(sgobj.getInfo()!=null)out.print(sgobj.getInfo());%></textarea></td>
    </tr>
    <tr>
      <td nowrap colspan="2" align="center"><input type="submit" name="spec" value="提交" onclick="return find_sub()"/></td>
    </tr>
  </table>
  <h2>商品供货商列表</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td>供应商</td><td>商品编号</td><td>商品名称</td><td>计量单位</td><td>规格</td><td>进价</td><td>最小进货数量</td><td>备注</td><td>操作</td>
    </tr>
    <%
    java.util.Enumeration eu = SemiSupplier.findByCommunity(teasession._strCommunity,sql.toString(),0,20);
    if(!eu.hasMoreElements())
    {
      %>
      <tr><td colspan="8">暂无信息</td></tr>
      <%
      }
      for(int i =0;eu.hasMoreElements();i++)
      {
        int ssid = Integer.parseInt(String.valueOf(eu.nextElement()));
        SemiSupplier ssobj = SemiSupplier.find(ssid);
        tea.entity.admin.Supplier obj=tea.entity.admin.Supplier.find(ssobj.getSid());
        SemiGoods sgobjl = SemiGoods.find(ssobj.getSgid());
        %>
        <tr>
          <td><%=obj.getName(teasession._nLanguage)%></td>
          <td><%=sgobjl.getGoodsnumber()%></td>
          <td><%=sgobjl.getSubject()%></td>
          <td><%=ssobj.getMeasure()%></td>
          <td><%=ssobj.getSpec()%></td>
          <td><%=ssobj.getSupply()%></td>
          <td><%=ssobj.getNum()%></td>
          <td><%=ssobj.getInfo()%></td>
          <td>
            　<input type="button" value="编辑"  onclick="window.open('/jsp/erp/semi/EditSemiGoodsSupplier.jsp?sgid=<%=ssobj.getSgid()%>&ids=<%=ssid%>','_self')" />
            <input name="按钮" type="button" value="删除" onClick="if(confirm('确认删除')){window.open('/jsp/erp/semi/EditSemiGoodsSupplier.jsp?deleteid=<%=ssid%>', '_self');this.disabled=true;};" >
          </td>
        </tr>
        <%
        }
        %>
        </table>
  </form>
  </body>
</html>
