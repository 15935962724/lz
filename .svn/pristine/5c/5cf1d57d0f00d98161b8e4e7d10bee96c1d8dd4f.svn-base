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
Distribution dobj =Distribution.find(dibid);
int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}
LeagueShop lsobj = LeagueShop.find(dobj.getLsid());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <body bgcolor="#ffffff" onload="f_show('<%=dobj.getLsid()%>','<%=dibid%>');" >
        <script type="">

        function f_show(suppid,purchase)
        {
          sendx('/jsp/erp/Goods_ajax.jsp?act=EditDistribution&suppid='+suppid+'&purchase='+purchase,
          function(data)
          {
            if(data.trim().indexOf('/')==0)//如果余额不足
            {
              document.getElementById('f_shows').innerHTML='您的配送金额：<font color=red>'+data.trim().split('/')[1]+'</font>,您的配送余额不足,不能提交配送单.';
              alert('您的配送金额：'+data.trim().split('/')[1]+',配送余额不足,不能提交配送单.');
              form1.submitx.disabled=true;
              return;
            }else
            {
              document.getElementById('f_shows').innerHTML=data;
              form1.submitx.disabled=false;
            }
          }
          );
        }

        function f_submit()
        {
          if(form1.city.value=='')
          {
            alert('省(州)不能为空');
            form1.city.focus();
            return false;
          }
          if(form1.address2.value=='')
          {
            alert('收货地址不能为空');
            form1.address2.focus();
            return false;
          }
          if(form1.consignee.value=='')
          {
            alert('收货人不能为空');
            form1.consignee.focus();
            return false;
          }
          if(form1.zip.value=='')
          {
            alert('邮编不能为空');
            form1.zip.focus();
            return false;
          }
          if(form1.telephone2.value=='')
          {
            alert('电话不能为空');
            form1.telephone2.focus();
            return false;
          }
        }
        </script>
        <div id="lzi_rkd">
          <h1><%
          if(type==2)
          {
            out.print("配送单库房备货");
          }else if(type==3)
          {
            out.print("配送单库房发货");
          }else if(type==4)
          {
            out.print("配送单完成发货信息");
          }
          %></h1>
          <form action="/servlet/EditDistribution" method="POST" name="form1" onsubmit="return f_submit();" >
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <input type="hidden" name="purchase" value="<%=dibid%>"/>
          <input type="hidden" name="act" value="DisButprepara"/>
          <input type="hidden" name="type" value="<%=type%>"/>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>配送加盟店：</td>
              <td ><%if(lsobj.getLsname()!=null){out.print(lsobj.getLsname());}%></td>
                <td nowrap>配送仓库：</td>
                <td colspan="2"><% Warehouse warobj = Warehouse.find(dobj.getWarid());out.print(warobj.getWarname()); %> </td>
            </tr>
            <tr>

              <td nowrap>配送日期：</td>
              <td>
             <%if(dobj.getTime_sToString()!=null && dobj.getTime_sToString().toString().length()>0){out.print(dobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>
              <td width="6%" nowrap>配送单号：</td>
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
                <td align="center" nowrap>单价</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>
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
        <!--选择的价格-->
        <td ><%out.print(gdobj.getSupply());%>&nbsp;元</td>

          <!--数量--><td><%=gdobj.getQuantity()%></td>

            <!--折扣乘以数量的价格总计-->
            <td >  <%=gdobj.getTotal()%>&nbsp;元</td>
             <td >
             <%=gdobj.getRemarksarr()%></td>
      </tr>
      <%} %>
       <tr>
        <td colspan="5">&nbsp;</td>

        <td align="right" ><b>合计数量和金额:</b></td>
        <td ><%=dobj.getQuantity()%></td>
          <td><%=dobj.getTotal()%>&nbsp;元</td>
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
                  <td  nowrap>联系电话：</td>
                  <td id="jin1"><%if(dobj.getTelephone()!=null)out.print(dobj.getTelephone()); %></td>
            </tr>

              <tr>
                <td  nowrap >联系地址：</td>
                <td colspan="5" id="jin2"><%if(dobj.getAddress()!=null)out.print(dobj.getAddress()); %></td>
              </tr>

            <tr>
              <td   nowrap>备注：</td>
              <td colspan="5" id="jin2"><%if(dobj.getRemarks()!=null)out.print(dobj.getRemarks());%></td>
            </tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td id="f_shows">&nbsp;</td>
            </tr>
          </table>
          <%
          if(type==3){
          %>
           <%
          tea.entity.util.Card  c1 =tea.entity.util.Card.find(lsobj.getProvince());//省
          tea.entity.util.Card  c2 =tea.entity.util.Card.find(lsobj.getCity());//市
          %>
          <h2>收货地址</h2>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;省(州)：</td>
              <td  id="jin1"><input type="text" name="city" value="<%if(dobj.getCity()!=null){out.print(dobj.getCity());}else{out.print(c1.getAddress()+c2.getAddress());}%>" ></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货地址</td>
              <td  id="jin1"><input type="text" name="address2" value="<%if(dobj.getAddress2()!=null){out.print(dobj.getAddress2());}
              else if(lsobj.getRegion()!=null){out.print(lsobj.getRegion());}
              else if(lsobj.getPort()!=null){out.print(lsobj.getPort());}
              else if(lsobj.getNumber()!=null){out.print(lsobj.getNumber());}
              %>" size="70"></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货人</td>
              <td  id="jin2"><input type="text" name="consignee" value="<%if(dobj.getConsignee()!=null){out.print(dobj.getConsignee());}else  if(dobj.getMember2()!=null){ Profile pobj2 = Profile.find(dobj.getMember2());String m = pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage);
                if(m!=null){
                  out.print(m);
                }else {
                  out.print(dobj.getMember2());
                }
              }
                %>" ></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;邮编：</td>
              <td  id="jin2"><input type="text" name="zip" value="<%if(dobj.getZip()!=null)out.print(dobj.getZip());%>" size="6"></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;电话：</td>
              <td  id="jin2"><input type="text" name="telephone2" value="<% if(dobj.getTelephone2()!=null&&dobj.getTelephone2().length()>0){out.print(dobj.getTelephone2());}else{out.print(dobj.getTelephone());}%>" ></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;发货时间：</td>
              <td  id="jin2"><%
              Date stime = new Date();
              if(dobj.getStime()!=null)
              {
                stime = dobj.getStime();
              }
             out.print(new tea.htmlx.TimeSelection("stime", stime));
              %></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;预计到达时间：</td>
              <td  id="jin2"><%
              Date ftime=new Date(System.currentTimeMillis()+(1000*60*60*24*3));//*3L三天的
              if(dobj.getFtime()!=null)
              {
                ftime = dobj.getFtime();
              }
              out.print(new tea.htmlx.TimeSelection("ftime", ftime));
              %></td>
              </tr>
          </table>
          <%}else if(type==4){ %>
           <%
          tea.entity.util.Card  c1 =tea.entity.util.Card.find(lsobj.getProvince());//省
          tea.entity.util.Card  c2 =tea.entity.util.Card.find(lsobj.getCity());//市
          %>
          <h2>收货地址</h2>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;省(州)：</td>
              <td  id="jin1"><%if(dobj.getCity()!=null){out.print(dobj.getCity());}else{out.print(c1.getAddress()+c2.getAddress());}%></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货地址</td>
              <td  id="jin1"><%if(dobj.getAddress2()!=null){out.print(dobj.getAddress2());}
              else if(lsobj.getRegion()!=null){out.print(lsobj.getRegion());}
              else if(lsobj.getPort()!=null){out.print(lsobj.getPort());}
              else if(lsobj.getNumber()!=null){out.print(lsobj.getNumber());}%></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;收货人</td>
              <td  id="jin2"><%if(dobj.getConsignee()!=null){out.print(dobj.getConsignee());}else  if(dobj.getMember2()!=null){ Profile pobj2 = Profile.find(dobj.getMember2());String m = pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage);
                if(m!=null){
                  out.print(m);
                }else {
                  out.print(dobj.getMember2());
                }
              }
                %></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;邮编：</td>
              <td  id="jin2"><%if(dobj.getZip()!=null)out.print(dobj.getZip());%></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;电话：</td>
              <td  id="jin2"><% if(dobj.getTelephone2()!=null&&dobj.getTelephone2().length()>0){out.print(dobj.getTelephone2());}else{out.print(dobj.getTelephone());}%></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;发货时间：</td>
              <td  id="jin2"><%=dobj.getStimeToString()%></td>
            </tr>
            <tr>
              <td nowrap><font color="red">*</font>&nbsp;预计到达时间：</td>
              <td  id="jin2"><%=dobj.getFtimeToString()%></td>
              </tr>
          </table>

          <%} %>

          <br />
          <%
          if(type==2)
          {
            out.print("<input type=submit value=备货完成>");
          }else if(type==3)
          {
            out.print("<input type=submit value=发货完成>");
          }
          %>

          <input type=button value="返回" onClick="javascript:history.back()">
          </form>

        </body>
</html>
