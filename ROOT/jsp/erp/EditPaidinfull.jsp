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
String purid = teasession.getParameter("purid");
Paidinfull pobj =Paidinfull.find(purid);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/erp.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>添加销售单</title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">

        <body bgcolor="#ffffff"   <%if(purid!=null){out.print(" onload=l_ajax()");}%> >
        <script>
        //选择加盟店
        function f_c()
        {
          rs = window.showModalDialog('/jsp/erp/LookClient.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
          if(rs!=null){
            form1.supplnamehidden.value= rs.split('/')[1];
            form1.supplname.value= rs.split('/')[2];
            sendx("/jsp/erp/Goods_ajax.jsp?act=supplshow&supplnamehidden="+form1.supplnamehidden.value,
            function(data)
            {
              document.getElementById('supplshow').innerHTML=data;
            }
            );
            form1.telephone.value=='';
            form1.address.value=='';

            f_show(rs.split('/')[1],form1.purchase.value);
          }
        }
        //选择商品
        function f_xuanze()
        {
          if(form1.supplname.value==0)
          {
            alert('请先选择加盟店！');
            form1.supplname.focus();
            return false;
          }
          if(form1.waridname.value==0)
          {
            alert("请先选择仓库！");
            form1.waridname.focus();
            return false;
          }
          var rs = window.showModalDialog('/jsp/erp/CalloutGoods2.jsp?supplname='+form1.supplnamehidden.value+'&waridname='+form1.waridname.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
          if(rs!=null){
            gd_ajax(rs,0);
          // f_show(form1.supplnamehidden.value,form1.purchase.value);

          }
        }
        function f_submit()
        {
          if(form1.supplname.value==0)
          {
            alert('请选择加盟店!');
            form1.supplname.focus();
            return false;
          }
          if(form1.waridname.value==0)
          {
            alert('请选择仓库!');
            form1.waridname.focus();
            return false;
          }
        }

        </script>

        <div id="lzi_rkd">
          <h1>添加销售单</h1>
          <form action="/servlet/EditPaidinfull" method="POST" name="form1" onsubmit="return f_submit();">
          <input type="hidden" name="supplnamehidden" value="<%=pobj.getSupplname() %>"/>
          <input type="hidden" name="purid" value="<%=purid%>"/>
          <input type="hidden" name="act" value="EditPaidinfull"/>
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>加盟店名称：</td>
              <td ><input type="text" name="supplname" value="<%  LeagueShop lsobj = LeagueShop.find(pobj.getSupplname());if(lsobj.getLsname()!=null){out.print(lsobj.getLsname());}%>"   style="background:#cccccc"  readonly> &nbsp;<input type="button" value="查找" onclick="f_c();"/></td>
                <td nowrap>仓库名称：</td>
                <td colspan="2"><select name="waridname">
                  <option value="0">请选择仓库</option>
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
                  </select>
                </td>
            </tr>
            <tr>

              <td nowrap>销售日期：</td>
              <td>

                 <input  id="time_s" name="time_s" size="7" readonly="readonly"   value="<%if(pobj.getTime_sToString()!=null && pobj.getTime_sToString().toString().length()>0){out.print(pobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>">
            <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_s');" />

              </td>
              <td width="6%" nowrap>销售单号：</td>
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
                <td align="center" nowrap>&nbsp;</td>
              </tr>
              <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''"  onclick="f_xuanze();" title="点击表格可以添加商品"  style="cursor:pointer">
                <td align="center" colspan="12">暂无记录，请点击这里，来添加商品。</td>
              </tr>
            </table>
          </span>
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td  nowrap>经办人：</td>
              <td id="jin1"><select name="member">
                <option value="">---------------</option>
                <%
                java.util.Enumeration e3 = AdminUsrRole.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                while(e3.hasMoreElements())
                {
                  String member = ((String)e3.nextElement());
                  Profile p = Profile.find(member);
                  String mname =p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage);
                  out.print("<option value="+member);
                  if(member.equals(pobj.getMember()))
                  {
                    out.print(" SELECTED ");
                  } else if(teasession._rv.toString().equals(member)){
                    out.print(" SELECTED ");
                  }
                  out.print(">");
                  if(mname!=null && mname.length()>0)
                  {
                    out.print(mname);
                  }else
                  {
                    out.print(member);
                  }
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


            </tr>
            <tr>
              <td  nowrap >联系地址：</td>
              <td colspan="5" id="jin2"><input type="text" name="address" value="<%if(pobj.getAddress()!=null)out.print(pobj.getAddress()); %>"  size="80"/></td>
                </span>
            </tr>
            <tr>  <td   nowrap>备注：</td>
              <td colspan="5" id="jin2">
                <textarea cols="51" rows="1" name="remarks"><%if(pobj.getRemarks()!=null)out.print(pobj.getRemarks());%></textarea>
              </td></tr>
          </table>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td id="f_shows">&nbsp;</td>
            </tr>
          </table>


          <br>
          <input type="submit" name="subimt1" value="保存销售单"/>&nbsp;
          <input type="submit" name="subimt1" value="生成销售单"/>&nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
