<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
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
SimpleDateFormat sdf1 = new  SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd");
Date timestring = new Date();
String trade = sdf.format(timestring) + SeqTable.getSeqNo("trade");
String nexturl = teasession.getParameter("nexturl");
String purid = teasession.getParameter("purid");
Purchase pobj = Purchase.find(purid);

int flowtype = 0;
if(teasession.getParameter("flowtype")!=null&&teasession.getParameter("flowtype").length()>0)
{
  flowtype = Integer.parseInt(teasession.getParameter("flowtype"));
}
GoodsDetails.delete2(purid);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/erp.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff"  <%if(purid!=null){out.print(" onload=l_ajax_pur()");}%> >
        <script type="text/javascript">
    
       
        function f_submit() 
        {
          if(form1.supplname.value==0)
          {
            alert('请选择供货商!');
            form1.supplname.focus();
            return false;
          }
          if(form1.waridname.value==0)
          {
            alert('请选择仓库!');
            form1.waridname.focus();
            return false;
          }
          if(form1.member.value=='')
          {
            alert('请选择经办人!');
            form1.member.focus();
            return false;
          }

          if(window.document.getElementById('quantity')==null)
          {
            alert('请选择商品');
            return false;
          }
        }
        </script>
        <div id="lzi_rkd">
          <h1><% 
          if(flowtype==0)
          {
            out.print("添加采购单");
          }else if(flowtype==1)
          {
            out.print("审核采购单");
          }else if(flowtype==2)
          {
            out.print("已审核未到货");
          }else if(flowtype==3)
          {
            out.print("部分到货");
          }
          else if(flowtype==4)
          {
            out.print("已经到货");
          }
          %></h1>
          <form action="/servlet/EditPurchase" method="POST" name="form1" onsubmit="return f_submit();">
          <input type="hidden" name="act" value="EditPurchase"/>
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <input type="hidden" name="rsgoods" value=""/>
          <input type="hidden" name="flowtype"  value="<%=flowtype%>"/>
          <input type="hidden" name="purid" value="<%=purid%>"/>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td width="9%">供货商：</td>
              <td width="24%">
                <select name="supplname"  class="lzj_huo" onchange="f_supp();">
                  <option value="0">---------------</option>
                  <%
                  java.util.Enumeration e1=Supplier.findByCommunity(teasession._strCommunity);
                  while(e1.hasMoreElements()){
                    int sid=((Integer)e1.nextElement()).intValue();
                    Supplier sobj=Supplier.find(sid);
                    out.print("<option value= "+sid);
                    if(pobj.getSupplname()==sid)
                    {
                      out.print(" SELECTED");
                    }
                    out.print(">"+sobj.getName(teasession._nLanguage));
                    out.print("</option>");
                  }
                  %>
                  </select>      </td>
                  <td nowrap>仓库名称：</td>
                  <td colspan="2"><select name="waridname" class="lzj_huo">

                    <option value="0">---------------</option>
                    <%
                    java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                    while (e2.hasMoreElements())
                    {
                      int warid = ((Integer)e2.nextElement()).intValue();
                      Warehouse warobj = Warehouse.find(warid);
                      out.print("<option value= "+warid);
                      if(pobj.getWaridname()==warid)
                      {
                        out.print(" selected");
                      }
                      out.print(">"+warobj.getWarname());
                      out.print("</option>");
                    }
                    %>
</select>      </td>
            </tr>
            <tr>

              <td nowrap>采购日期：</td>
              <td>



        <input id="time_s" name="time_s" size="7" value="<%if(pobj.getTime_sToString()!=null && pobj.getTime_sToString().toString().length()>0){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_s');" />



              </td>
              <td width="6%" nowrap>采购单号：</td>
              <td width="29%"><input type="text" name="purchase" id="ruku" value="<%if(purid!=null){out.print(purid);}else{out.print(trade);}%>" readonly="readonly" style="background:#cccccc"></td>
            </tr>
          </table>
          <span id="show">
            <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr id="tableonetr">
                <td align="center" nowrap>条形码或编号</td>
                <td align="center" nowrap>商品名称</td>
                <td align="center" nowrap>规格型号</td>
                <td align="center" nowrap>品牌</td>
                <td align="center" nowrap>单位</td>
                <td align="center" nowrap>进货价</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>
              </tr>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_xuanze_pur();" title="点击表格可以添加商品"  style="cursor:pointer">
                <td align="center" colspan="12" ><span id="tdids">暂无记录，请点击表格，来添加商品。</span></td>
              </tr>
            </table> 
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td width="5%" nowrap>经办人：</td>
              <td width="11%" id="jin1"><select name="member" class="lzj_huo">
                <option value="">---------------</option>
                <%
                java.util.Enumeration e3 = AdminUsrRole.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                while(e3.hasMoreElements())
                {
                  String member = ((String)e3.nextElement());
                  Profile p = Profile.find(member);
                  out.print("<option value="+member);
                  if(member.equals(pobj.getMember()))
                  {
                    out.print(" SELECTED ");
                  }
                  else if(teasession._rv.toString().equals(member))
                  out.print(" SELECTED ");
                  out.print(">");
                  String fl = p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage);

                  if(fl!=null&&fl.length()>0)
                  {
                    out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage));
                  }else
                  {
                    out.print(member);
                  }
                  out.print("</option>");
                }

                %>
                </select>    </td>
                <td width="4%" nowrap>备注：</td>
                <td width="80%" id="jin2"><input type="text" name="remarks" value="<%if(pobj.getRemarks()!=null)out.print(pobj.getRemarks());%>"  size="80"/></td>
            </tr>
            <%
            if(flowtype==1){
              %>
              <tr>
                <td colspan="4">是否同意此采购单:&nbsp;&nbsp;
                  <input type="radio" name="noyestype" value="1" checked>&nbsp;同意&nbsp;
                  <input type="radio" name="noyestype" value="0">&nbsp;不同意&nbsp;(注:如果选择不同意,此次采购单会自动删除.)
                </td>
              </tr>
              <%}%>
          </table>
          <br>
          <%
          if(flowtype==0)
          {
            out.print(" <input type=\"submit\" value=\"保存采购订单\"/>");
          }else if(flowtype==1)
          {
            out.print(" <input type=\"submit\" value=\"审核采购订单\"/>");
          }else if(flowtype==2 || flowtype==3)
          {
            out.print(" <input type=\"submit\" value=\"审核入库\"/>");
          }
          %>
          &nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>
          </form>
          <%if(pobj.isExists()){ %>
<script>
 document.getElementById('tdids').innerHTML='<b>数据加载中，请稍后...</b>';
</script><%} %>
        </body>
</html>
