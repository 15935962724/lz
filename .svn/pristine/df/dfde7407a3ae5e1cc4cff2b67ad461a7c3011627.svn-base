<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %> <%
request.setCharacterEncoding("UTF-8");

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
String dibid = teasession.getParameter("dibid");
Complimentary dobj =Complimentary.find(dibid);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff" >
        <script type="">
        function f_p(igd)
        {
          var  rs = window.showModalDialog('/jsp/erp/ComplimentaryPrint.jsp?dibid='+igd,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:927px;dialogHeight:506px;');
          //  window.open('/jsp/erp/PaidinfullPrint.jsp?paid='+igd,'flow_view','status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,width=500,height=350,left=100,top=100');
        }


        </script>
        <div id="lzi_rkd">
          <h1>赠送单详细内容</h1>
          <form action="/servlet/EditComplimentary" method="POST" name="form1" >

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>赠送加盟店：</td>
              <td ><%LeagueShop lsobj = LeagueShop.find(dobj.getLsid());if(lsobj.getLsname()!=null){out.print(lsobj.getLsname());}%></td>
                <td nowrap>赠送仓库：</td>
                <td colspan="2"><% Warehouse warobj = Warehouse.find(dobj.getWarid());out.print(warobj.getWarname()); %> </td>
            </tr>
            <tr>

              <td nowrap>赠送日期：</td>
              <td>
             <%if(dobj.getTime_sToString()!=null && dobj.getTime_sToString().toString().length()>0){out.print(dobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>
              <td width="6%" nowrap>赠送单号：</td>
              <td width="29%"><%if(dibid!=null){out.print(dibid);}else{out.print(trade);}%></td>
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
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>备注</td>
              </tr>
              <%


    java.util.Enumeration e = GoodsDetails.find(teasession._strCommunity," AND paid="+DbAdapter.cite(dibid),0,Integer.MAX_VALUE);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=12 align=center>暂无记录</td></tr>");
    }

    for(int i = 0;e.hasMoreElements();i++)
    {
      int gdid = ((Integer)e.nextElement()).intValue();
      GoodsDetails gdobj = GoodsDetails.find(gdid);
      int nodeid =gdobj.getNode();
      Node nobj = Node.find(nodeid);
      Goods g=Goods.find(nodeid);


      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
        <td align="center" ><%=nobj.getNumber() %></td>
        <td ><%=nobj.getSubject(teasession._nLanguage)%></td>
        <td><%=g.getSpec(teasession._nLanguage) %></td>
        <td><%
        Brand b=null;
        if(g.getBrand()>0&&(b=Brand.find(g.getBrand())).isExists())
        {
          if(b.getNode()>0)
          out.print(b.getName(teasession._nLanguage));
        }
        %></td>
        <td ><%=g.getMeasure(teasession._nLanguage)%></td>


          <!--数量--><td><%=gdobj.getQuantity()%></td>
             <td >
             <%=gdobj.getRemarksarr()%></td>
      </tr>
      <%} %>
       <tr>
        <td colspan="4">&nbsp;</td>

        <td align="right" ><b>合计数量:</b></td>
        <td ><%=dobj.getQuantity()%></td>
      </tr>
            </table>
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td  nowrap>经办人：</td>
              <td id="jin1">
                <%
                  Profile p = Profile.find(dobj.getMember());
                    String mname =p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage);
                    if(mname!=null)
                    {
                      out.print(mname);
                    }else
                    {
                      out.print(dobj.getMember());
                    }
                %></td>
                <td  nowrap>联系人：</td>
                <td><%
                  Profile p2 = Profile.find(dobj.getMember2());
                    String mname2 =p2.getLastName(teasession._nLanguage)+p2.getFirstName(teasession._nLanguage);
                    if(mname2!=null)
                    {
                      out.print(mname2);
                    }else
                    {
                      out.print(dobj.getMember2());
                    }
                %></td>
                <span id="member2show">
                  <td  nowrap>联系电话：</td>
                  <td id="jin1"><%if(dobj.getTelephone()!=null)out.print(dobj.getTelephone()); %></td>


            </tr>
            <tr>
              <td  nowrap >联系地址：</td>
              <td colspan="5" id="jin2"><%if(dobj.getAddress()!=null)out.print(dobj.getAddress()); %></td>
                </span>
            </tr>
            <tr>
              <td   nowrap>备注：</td>
              <td colspan="5" id="jin2"><%if(dobj.getRemarks()!=null)out.print(dobj.getRemarks());%></td>
            </tr>
          </table>


          <br>
        <input type="button" value="关闭"  onClick="javascript:window.close();">&nbsp;
        <input type="button" value="打印"  onclick="f_p('<%=dibid%>');"/>

        </div>

          </form>

        </body>
</html>
