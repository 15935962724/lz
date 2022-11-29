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
int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title><%if(type==1){out.print("审核赠送单");}else {out.print("添加赠送单");} %></title>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">

        <body bgcolor="#ffffff"   <%if(dibid!=null){out.print(" onload=f_body()");}%> >
        <script type="">
        function f_body()
        {
          l_ajax();
          f_c_ajax();
        }
         //选择加盟店
        function f_c()
        {
          rs = window.showModalDialog('/jsp/erp/LookClient.jsp',self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
          if(rs!=null){
            form1.supplnamehidden.value= rs.split('/')[1];
            form1.supplname.value= rs.split('/')[2];
            f_c_ajax();
          }
        }
        function f_c_ajax()
        {
          sendx("/jsp/erp/Goods_ajax.jsp?act=supplshow&supplnamehidden="+form1.supplnamehidden.value+"&member2=<%=dobj.getMember2()%>",
          function(data)
          {
            document.getElementById('supplshow').innerHTML=data;
          }
          );
          form1.telephone.value=='';
          form1.address.value=='';
        }
        function f_xuanze()
        {
          if(form1.supplname.value=='')
          {
            alert("请选择加盟店!");
            form1.supplname.focus();
            return false;
          }

         if(form1.warid.value==0)
          {
            alert("请先选择仓库!");
            form1.warid.focus();
            return false;
          }
          var rs = window.showModalDialog('/jsp/erp/CalloutGoods2.jsp?waridname='+form1.warid.value,self,'edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;');
          if(rs!=null){
            gd_ajax(rs);
          }
        }
         //给商品细节表添加记录
        function gd_ajax(igd)
        {
          sendx("/jsp/erp/Goods_ajax.jsp?act=gDetails&type=7&node="+igd+"&purchase="+form1.purchase.value,
          function(data)
          {
            if(data!=''&&data.length>1)
            {
              alert(data);
              return false;
            }
            l_ajax();
          }
          );
        }
        //选择商品中的ajax
        function l_ajax(){
          sendx("/jsp/erp/compl_ajax.jsp?purid="+form1.purchase.value,
          function(data)
          {
            document.getElementById('show').innerHTML=data;
          }
          );
        }
        //删除一个商品
        function f_delete(igd)
        {
          sendx("/jsp/erp/Goods_ajax.jsp?act=Gdelete&gdid="+igd,
          function(data)
          {
            if(data!=''&&data.length>0){
              alert(data);
              l_ajax();
            }
          }
          );
        }
        function f_quantity(igd,igd2,igd3)
        {
          var quantity =  document.all('quantity'+igd2).value;      //数量quantity1获取的单个商品的数量
          var cs=0;
          //修改商品中的供货价
          sendx("/jsp/erp/Goods_ajax.jsp?act=distri_ajax&list=0&quantity="+quantity+"&gdid="+igd,
          function(data){
          }
          );
          for(var i = 0;i<igd3;i++)
          {
            cs =  parseInt(document.all('quantity'+i).value)+parseInt(cs);//数量
          }
          document.form1.quantity.value=cs;//数量
        }
        //修改备注文字
        function f_rem(gdid,i)
        {
          var remarksarr = document.all('remarksarr'+i).value;
          sendx("/jsp/erp/Goods_ajax.jsp?act=remarksarr&gdid="+gdid+"&remarksarr="+encodeURIComponent(remarksarr),
          function(data){}
          );
        }
        //选择联系人 可以得到联系电话和地址
        function f_member2()
        {
          var a =form1.member2.value;
          if(a.split("/")[2]!=null){
            form1.telephone.value=a.split("/")[2];
          }
          if(a.split("/")[3]!=null){
            form1.address.value =a.split("/")[3];
          }
        }

        function f_submit()
        {
          if(form1.supplname.value=='')
          {
            alert("赠送加盟店不能为空");
            form1.supplname.focus();
            return false;
          }
          if(form1.warid.value==0)
          {
            alert("赠送仓库不能为空");
            form1.warid.focus();
            return false;
          }

        }



        </script>
        <div id="lzi_rkd">
          <h1><%if(type==1){out.print("审核赠送单");}else {out.print("添加赠送单");} %></h1>
          <form action="/servlet/EditComplimentary" method="POST" name="form1" onsubmit="return f_submit();">
          <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
          <input type="hidden" name="supplnamehidden" value="<%=dobj.getLsid() %>"/>
          <input type="hidden" name="act" value="EditComplimentary"/>
          <input type="hidden" name="type" value="<%=type%>"/>

          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td nowrap>赠送加盟店：</td>
              <td ><input type="text" name="supplname" value="<%LeagueShop lsobj = LeagueShop.find(dobj.getLsid());if(lsobj.getLsname()!=null){out.print(lsobj.getLsname());}%>"   style="background:#cccccc"  readonly> &nbsp;<input type="button" value="查找" onclick="f_c();"/></td>
                <td nowrap>赠送仓库：</td>
                <td colspan="2"><select name="warid">
                  <option value="0">请选择仓库</option>
                  <%

                  java.util.Enumeration e2 = Warehouse.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
                  while (e2.hasMoreElements())
                  {
                    int waridsa = ((Integer)e2.nextElement()).intValue();
                    Warehouse warobj = Warehouse.find(waridsa);
                    out.print("<option value= "+waridsa);
                    if(dobj.getWarid()==waridsa)
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

              <td nowrap>赠送日期：</td>
              <td>

                <input id="time_s" name="time_s" size="7"  value="<%if(dobj.getTime_sToString()!=null && dobj.getTime_sToString().toString().length()>0){out.print(dobj.getTime_sToString());}else{out.print(sdf1.format(timestring));}%>">
                 <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_s');" />

              </td>
              <td width="6%" nowrap>赠送单号：</td>
              <td width="29%"><input type="text" name="purchase" id="ruku" value="<%if(dibid!=null){out.print(dibid);}else{out.print(trade);}%>" readonly="readonly" style="background:#cccccc"></td>
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
                  if(member.equals(dobj.getMember()))
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
                      LeagueShop lsobj2 = LeagueShop.find(dobj.getWarid());
                      if(lsobj2.getBumen()>0){
                        java.util.Enumeration emember = AdminUsrRole.find(teasession._strCommunity,"AND unit="+lsobj2.getBumen(),0,Integer.MAX_VALUE);
                        while(emember.hasMoreElements())
                        {
                          String armember = ((String)emember.nextElement());
                          tea.entity.member.Profile pobj2 = tea.entity.member.Profile.find(armember);
                          String memberall="/"+armember+"/"+pobj2.getTelephone(teasession._nLanguage)+"/"+pobj2.getAddress(teasession._nLanguage)+"/";
                          out.print("<option value="+memberall);

                          if(memberall.equals(dobj.getMember2()))
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
                  <td id="jin1"><input type="text" name="telephone" value="<%if(dobj.getTelephone()!=null)out.print(dobj.getTelephone()); %>" size="11"></td>


            </tr>
            <tr>
              <td  nowrap >联系地址：</td>
              <td colspan="5" id="jin2"><input type="text" name="address" value="<%if(dobj.getAddress()!=null)out.print(dobj.getAddress()); %>"  size="80"/></td>
                </span>
            </tr>
            <tr>
              <td   nowrap>备注：</td>
              <td colspan="5" id="jin2">
                <textarea cols="51" rows="1" name="remarks"><%if(dobj.getRemarks()!=null)out.print(dobj.getRemarks());%></textarea>
              </td>
            </tr>

            <%
               if(type==1){
           %>
              <tr>
                <td colspan="4">是否同意此赠送单:&nbsp;&nbsp;
                  <input type="radio" name="noyestype" value="1" checked>&nbsp;同意&nbsp;
                  <input type="radio" name="noyestype" value="-1">&nbsp;不同意&nbsp;(<font color="red">注:如果选择不同意,此次赠送单会自动删除.</font>)
                </td>
              </tr>
           <%
              }
           %>
          </table>



          <br>
          <input type="submit" name="submitx" value="<%if(type==1){out.print("审核赠送单");}else {out.print("生成赠送单");} %>"/>&nbsp;
          <input type=button value="返回" onClick="javascript:history.back()">
        </div>

          </form>

        </body>
</html>
