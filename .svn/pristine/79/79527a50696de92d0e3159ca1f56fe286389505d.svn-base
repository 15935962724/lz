<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int refundtype = 0;
if(teasession.getParameter("refundtype")!=null && teasession.getParameter("refundtype").length()>0)
{
  refundtype = Integer.parseInt(teasession.getParameter("refundtype"));
}


SimpleDateFormat sdf1 = new  SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf = new  SimpleDateFormat("yyyyMMdd");
Date timestring = new Date();
String trade = sdf.format(timestring) + SeqTable.getSeqNo("trade");
String nexturl = teasession.getParameter("nexturl");
String purid = teasession.getParameter("purid");
ReturnedShop pobj =ReturnedShop.find(purid);


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

        <body bgcolor="#ffffff"   <%if(purid!=null){out.print(" onload=f_aaaa();");}%> >
        <script type="">
        function f_aaaa()
        {
          l_ajax_rs();
          f_c();
        }
        function f_c()//选择加盟店
        {
          sendx("/jsp/erp/Goods_ajax.jsp?act=supplshow&supplnamehidden="+form1.supplnamehidden.value,
          function(data)
          {
            document.getElementById('supplshow').innerHTML=data;
          //  f_show(form1.supplnamehidden.value,form1.purchase.value);
          }
          );
        }
        function f_submit()
        {
          if(form1.supplnamehidden.value==0)
          {
            alert('请选择加盟店！');
            form1.supplnamehidden.focus();
            return false;
          }
        }
        </script>
        <div id="lzi_rkd">
          <h1><%if(refundtype==1){out.print("审核加盟店退货单");}else{out.print("添加加盟店退货单");}%></h1>
          <form action="/servlet/EditReturnedShop" method="POST" name="form1" onsubmit="return f_submit();">
          <input type="hidden" name="rsgoods" value=""/>
          <input type="hidden" name="purid" value="<%=purid%>"/>
          <input type="hidden" name="act" value="EditReturnedShop"/>
           <input type="hidden" name="w"/>
            <input type="hidden" name="refundtype" value="<%=refundtype%>"/>
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

            <tr>
              <td nowrap>加盟店名称：</td>
              <td >
             
              
              <select name="supplnamehidden" onchange="f_c();">
                <option value="0">请选择加盟店</option>
                <%
                
                AdminUsrRole arobj = AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
                /*
                LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());
                if(lsobj.getId()!=0){
                  out.print("<option value="+lsobj.getId());
                  if(pobj.getSupplname()==lsobj.getId())
                  {
                    out.print(" SELECTED");
                  }
                  out.print(">"+lsobj.getLsname());
                  out.print("</option>");
                }*/
                
                Enumeration e = LeagueShop.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                while(e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    LeagueShop lsobj = LeagueShop.find(id);
                    out.print("<option value="+lsobj.getId());
                    if(pobj.getSupplname()==lsobj.getId())
                    {
                    	 out.print(" SELECTED ");
                    }
                    out.print(">"+lsobj.getLsname());
                    out.print("</option>");
                }
               
                %>
                </select>
              </td>
              <td nowrap>退货日期：</td>

              <td>

                <input id="time_s" name="time_s" size="7" readonly="readonly" value="<%if(pobj.getTime_sToString()!=null && pobj.getTime_sToString().toString().length()>0){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>">
                <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_s');" />

              </td>
              <td width="6%" nowrap>退货单号：</td>
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
                <td align="center" nowrap>单价</td>
                <td align="center" nowrap>折扣</td>
                <td align="center" nowrap>活动折扣</td>
                <td align="center" nowrap>折后单价</td>
                <td align="center" nowrap>数量</td>
                <td align="center" nowrap>金额</td>
                <td align="center" nowrap>备注</td>

              </tr>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" style="cursor:pointer" onclick="f_xuanze_rs('0');" title="点击表格可以添加商品">
                <td align="center" colspan="12">暂无记录，请点击这里，来添加商品。</td>
              </tr>
            </table>
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td  nowrap>经办人：</td>
              <td id="jin1"><select name="member" class="lzj_huo">
                <option value="">---------------</option>
                <%
                java.util.Enumeration e3 = AdminUsrRole.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                while(e3.hasMoreElements())
                {
                  String member = ((String)e3.nextElement());
                  Profile p = Profile.find(member);
                  String s = p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage);
                  if(s!=null && s.length()>0)
                  {

                  }else
                  {
                    s = member;
                  }
                  out.print("<option value="+member);
                  if(member.equals(pobj.getMember()))
                  {
                    out.print(" SELECTED ");
                  } else if(teasession._rv.toString().equals(member)){
                    out.print(" SELECTED ");
                  }
                  out.print(">"+s);
                  out.print("</option>");
                }

                %>
                </select> </td>
                <td  nowrap>联系人：</td>
                <td>
                  <span id="supplshow">
                    <select name="member2"  onchange=f_member2();>
                      <option value="0">---------------</option>
                      <%
                      LeagueShop lsobj2 = LeagueShop.find(pobj.getSupplname());
                      if(lsobj2.getBumen()>0){
                        java.util.Enumeration emember = AdminUsrRole.find(teasession._strCommunity,"AND unit="+lsobj2.getBumen(),0,Integer.MAX_VALUE);
                        while(emember.hasMoreElements())
                        {
                          String armember = ((String)emember.nextElement());
                          tea.entity.member.Profile pobj2 = tea.entity.member.Profile.find(armember);
                          String memberall="/"+armember+"/"+pobj2.getTelephone(teasession._nLanguage)+"/"+pobj2.getAddress(teasession._nLanguage)+"/";
                          out.print("<option value="+memberall);
                          if(armember.equals(pobj.getMember2()))
                          {
                            out.print(" selected");
                          }
                          out.print(">"+pobj2.getLastName(teasession._nLanguage)+pobj2.getFirstName(teasession._nLanguage));
                          out.print("</option>");
                        }
                      }
                      %>
                      </select>
                  </span>
                </td>
                <span id="member2show">
                  <td  nowrap>联系电话：</td>
                  <td id="jin1"><input type="text" name="telephone" value="<%if(pobj.getTelephone()!=null)out.print(pobj.getTelephone()); %>" size="11"></td>
                </span>
            </tr>
            <tr>

              <td  nowrap>联系地址：</td>
              <td  id="jin2" colspan="5"><input type="text" name="address" value="<%if(pobj.getAddress()!=null)out.print(pobj.getAddress()); %>"  size="80"/></td>

            </tr>
            <tr>

              <td  nowrap >备注：</td>
              <td  id="jin2" colspan="5"><input type="text" name="remarks" value="<%if(pobj.getRemarks()!=null)out.print(pobj.getRemarks());%>"  size="80"/></td>
            </tr>
            <%if(refundtype==1){ %>
            <tr>
              <td  nowrap>是否接受退货：</td>
              <td><input type="radio" value="1" name="type" checked="checked"/>&nbsp;接受退货&nbsp;&nbsp;<input type="radio" value="2" name="type"/>&nbsp;不接受退货</td>
            </tr>
            <% }%>


          </table>

          <br>
          <input type="submit" value="<%if(refundtype==1){out.print("审核加盟店退货单");}else{out.print("生成加盟店退货单");}%>"/>&nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
