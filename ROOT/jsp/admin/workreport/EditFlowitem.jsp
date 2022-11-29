<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.netdisk.*"%>
<jsp:directive.page import="java.math.BigDecimal"/>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String community = teasession._strCommunity;
String nexturl=teasession.getParameter("nexturl");
String contractnexturl = teasession.getParameter("contractnexturl");
int flowitem = 0;
if (teasession.getParameter("flowitem") != null && teasession.getParameter("flowitem").length() > 0)
flowitem = Integer.parseInt(teasession.getParameter("flowitem"));
int workproject = 0;
if (teasession.getParameter("workproject") != null && teasession.getParameter("workproject").length() > 0)
workproject = Integer.parseInt(teasession.getParameter("workproject"));

//添加项目
 Flowitem obj = Flowitem.find(flowitem);
Resource r = new Resource();
String name = null, content = null, manager = null, member = null, pact = null,pactfile=null,pactfilename=null;
java.util.Date ftime = null;
int itemgenre = 0, cost = 0, overallmoney = 0,period=0,filecenter=0,maplen=0;
BigDecimal vindicate = new BigDecimal(0);
java.util.Date nextcosttime = null,pacttime=null,lastcosttime=null;
//其它成本:otherexpenses
BigDecimal otherexpenses = new BigDecimal(0);
//其它成本说明:otherexplain
String otherexplain =null;
//市场费用:marketcost
BigDecimal marketcost = new BigDecimal(0);
//市场费用说明:marketexplain
String marketexplain =null;
//预计利润:profits
BigDecimal profits = new BigDecimal(0);
//实际收入:profits
BigDecimal realincome= new BigDecimal(0);

if (flowitem != 0) {

  name = obj.getName(teasession._nLanguage);
  workproject = obj.getWorkproject();
  content = obj.getContent(teasession._nLanguage);
  manager = obj.getManager();
  member = obj.getMember();
  ftime = obj.getFtime();
  itemgenre = obj.getItemgenre();
  cost = obj.getCost();
  overallmoney = obj.getOverallmoney();
  pact = obj.getPact();
  vindicate = obj.getVindicate();
  nextcosttime = obj.getNextcosttime();
  lastcosttime = obj.getLastcosttime();
  pacttime= obj.getPacttime();
  pactfile=obj.getPactfile();
  pactfilename=obj.getPactfilename();
  if(obj.getPactfile()!=null)
  {
    maplen=(int)new java.io.File(application.getRealPath(obj.getPactfile())).length();
  }
  period = obj.getPeriod();

  filecenter=obj.getFilecenter();
  otherexpenses=obj.getOtherexpenses();
  otherexplain=obj.getOtherexplain(teasession._nLanguage);

  marketcost=Already.getAmountTotalSum(flowitem," and atype=1 ");
  realincome=Already.getAmountTotalSum(flowitem," and atype=0 ");
  otherexpenses=Already.getAmountTotalSum(flowitem," and atype=2 ");


  marketexplain=obj.getMarketexplain(teasession._nLanguage);
  profits=obj.getProfits();

}
else {
  name = content = manager = member = "";
}
Workproject worobj = Workproject.find(workproject);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <script>
        function defaultfocus()
        {
          form1.name.focus();
        }

        function f_add(s1,s2)
        {
          if(s1.selectedIndex!=-1)
          {
            var s1_op=s1.options[s1.selectedIndex];
            var s2_o=s2.options;
            for(var i=0;i<s2_o.length;i++)
            {
              if(s2_o[i].value==s1_op.value)
              return;
            }
            s2_o[s2_o.length]=new Option(s1_op.text,s1_op.value);
          }
        }
        function f_del(s1)
        {
          if(s1.selectedIndex!=-1)
          {
            s1.options[s1.selectedIndex]=null;
          }
        }
        function f_submit()
        {

          if(form1.itemgenre.value==0)
          {
            alert("无效项目类型！");
            return false;
          }


          var s1_o=form1.manager1.options;
          for(var i=0;i<s1_o.length;i++)
          {
            form1.manager.value=form1.manager.value+s1_o[i].value+"/";
          }

          var s2_o=form1.member1.options;
          for(var i=0;i<s2_o.length;i++)
          {
            form1.member.value=form1.member.value+s2_o[i].value+"/";
          }
          return submitText(form1.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-项目名称')&&submitText(form1.workproject, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-客户');
        }
        //项目收款弹出框
        function f_c(igd)
        {
          var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:857px;dialogHeight:605px;';
          var url = '/jsp/admin/workreport/Already.jsp?flowitem='+igd;
          window.showModalDialog(url,self,y);
        }
        </script>
        </head>
        <body >
        <h1>创建项目</h1>
        <form name="form1" action="/servlet/EditFlowitem" method="post"  enctype="multipart/form-data"  onSubmit="return f_submit();">
        <input type=hidden name="flowitem" value="<%=flowitem%>"/>
        <input type=hidden name="nexturl" value="<%=nexturl%>"/>
        <input type="hidden" name="act" value="<%=teasession.getParameter("act")%>"/>
        <input type="hidden" name="act2" value="EditFlowitem"/>
        <input type="hidden" name="repository" value="pactfile"/>
        <input type="hidden" name="contractnexturl" value="<%=contractnexturl%>"/>
        <!--input type=hidden name="workproject" value="<%=workproject%>"-->
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td>客户：</td>
            <td nowrap><select name="workproject">  　
            <%
            Enumeration e_wp=Workproject.find(teasession._strCommunity,"",0,200);
            while(e_wp.hasMoreElements())
            {
              int id=((Integer)e_wp.nextElement()).intValue();
              Workproject wobj=Workproject.find(id);
              out.print("<option value="+id);
              if(workproject==id)
              out.print(" SELECTED ");
              out.print(">"+wobj.getName(teasession._nLanguage));
            }
            %></select>
            </td>
          </tr>
          <tr>
            <td>项目名称：</td>
            <td nowrap><input name="name" type="text" value="<%=name%>" size="40"></td>
          </tr>
          <tr>
            <td>项目说明：</td>
            <td nowrap><textarea name="content" cols="50" rows="5"><%=content%></textarea></td>
          </tr>
          <tr>
            <td>项目经理：</td>
            <td nowrap>
              <input type=hidden name=manager value="/">
              <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td>
                    <select name="manager1" size="5" style="width:180px" onDblClick="f_del(form1.manager1);">
                    <%
                    String str[] = manager.split("/");
                    for (int i = 1; i < str.length; i++) {
                      Profile p = Profile.find(str[i]);
                      out.print("<option value=\"" + str[i] + "\" >　" + str[i] + " ( " + p.getLastName(teasession._nLanguage) + p.getFirstName(teasession._nLanguage) + " )");
                    }
                    %>
                    </select>
                    <td>
                      <input type=button value="←" onClick="f_add(form1.manager2,form1.manager1);">
                      <br>
                      <input type=button value="→" onClick="f_del(form1.manager1);">

                      <td>
                        <select name="manager2" size="5" style="width:180px" onDblClick="f_add(form1.manager2,form1.manager1);">
                        <%
                        StringBuffer sb = new StringBuffer();
                        java.util.Enumeration e = AdminUnit.findByCommunity(teasession._strCommunity, "");
                        for (int intCount = 1; e.hasMoreElements(); intCount++)
                        {
                          AdminUnit au_obj=(AdminUnit)e.nextElement();
                          int unltid=au_obj.getId();
                          java.util.Enumeration e2 = AdminUsrRole.findByUnit(unltid, teasession._strCommunity);
                          if (e2.hasMoreElements())
                          {
                            sb.append("<OPTGROUP label=").append(au_obj.getName()).append("></OPTGROUP>");
                            while (e2.hasMoreElements())
                            {
                              String _member = (String) e2.nextElement();
                              //AdminUsrRole obj=AdminUsrRole.find(teasession._strCommunity,member);
                              Profile p = Profile.find(_member);
                              if (p != null) {
                                sb.append("<option value=\"" + _member).append("\" >　").append(_member).append(" ( ").append(p.getLastName(teasession._nLanguage)).append(p.getFirstName(teasession._nLanguage)).append(" )</option>");
                              }
                            }
                          }
                        }
                        out.print(sb.toString());
                        %>
                        </select>

                </tr>
              </table>
              <%--<input type=button value=添加 onclick="window.showModalDialog('/jsp/sms/psmanagement/FrameGU.jsp?type=1&field=member&index=form1.manager','','edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;');" >--%>
                      </td>
          </tr>
          <tr>
            <td>项目参与者：</td>
            <td nowrap>
              <input type=hidden name=member value="/">
              <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td>
                    <select name="member1" size="7" style="width:180px" onDblClick="f_del(form1.member1);">
                    <%
                    String str2[] = member.split("/");
                    for (int i = 1; i < str2.length; i++) {
                      Profile p = Profile.find(str2[i]);
                      out.print("<option value=\"" + str2[i] + "\" >　" + str2[i] + " ( " + p.getLastName(teasession._nLanguage) + p.getFirstName(teasession._nLanguage) + " )");
                    }
                    %>
                    </select>

                    <td>
                      <input type=button value="←" onClick="f_add(form1.member2,form1.member1);">
                      <br>
                      <input type=button value="→" onClick="f_del(form1.member1);">

                      <td>
                        <select name="member2" size="7" style="width:180px" onDblClick="f_add(form1.member2,form1.member1);"><%=sb.toString()%>            </select>

                </tr>
              </table>
                      </td>
          </tr>
          <tr>
            <td>预计完成时间：</td>
            <td nowrap><%=new tea.htmlx.TimeSelection("ftime", ftime)%></td>
          </tr>
          <!--项目类型-->
          <tr>
            <td><%=r.getString(teasession._nLanguage,"项目进展")%>    </td>
            <td nowrap><select name="itemgenre">
              <%
              for (int i = 0; i < Flowitem.ITEMGENRE_TYPE.length; i++) {
                out.print("<option value=" + i);
                if (itemgenre == i)
                out.print(" SELECTED ");
                out.print(" >" + r.getString(teasession._nLanguage,Flowitem.ITEMGENRE_TYPE[i]));
              }
              %>
              </select>
            </td>
          </tr>
          <tr>
            <td>预计成本：</td>
            <td nowrap><input type="text" name="cost" size="20" value="<%if(cost!=0)out.print(cost); %>">&nbsp;元 </td>
          </tr>
          <tr>
            <td>项目总金额:</td>
            <td nowrap><input type="text" name="overallmoney" size="20" value="<%if(overallmoney!=0)out.print(overallmoney); %>">&nbsp;元</td>
          </tr>
          <tr>
            <td>合同号：</td>
            <td nowrap><input type="text" name="pact" size="20" value="<%if(pact!=null)out.print(pact); %>">&nbsp;&nbsp;
              合同截止时间： <%=new tea.htmlx.TimeSelection("pacttime", pacttime)%>&nbsp;&nbsp;
            </td>
          </tr>
          <tr>
          <td>合同附件：</td>
          <td nowrap><input type="file" name="pactfile" value="" >&nbsp;&nbsp;
          <%
          if(maplen>0){
            out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(pactfile,"UTF-8")+"&name="+java.net.URLEncoder.encode(pactfilename,"UTF-8")+">"+pactfilename+"</a>");
            %>
            <input  id="CHECKBOX" type="CHECKBOX" name="clear1" onClick="form1.pactfile.disabled=this.checked;"/> 清空
            <%} %>
            合同归档目录：
            <select name="filecenter">
            <option value="0">请选择合同归档目录</option>
            <%
            int father = FileCenter.getRootId(teasession._strCommunity);
            java.util.Enumeration fe = FileCenter.find(teasession._strCommunity," AND type = 0",null,true);
            while(fe.hasMoreElements())
            {
              int fcid=((Integer)fe.nextElement()).intValue();
              FileCenter fcobj=FileCenter.find(fcid);
              out.print("<option value="+fcid);
              if(filecenter==fcid)
              {
                out.print(" SELECTED ");
              }
              out.print(">"+fcobj.getSubject());
              out.print("</option>");
            }
            %>
            </select>
          </td>
          </tr>
          <tr>
            <td>维护费：</td>
            <td nowrap><input type="text" name="vindicate" size="20" value="<%if(vindicate!=null)out.print(vindicate); %>">&nbsp;元&nbsp;&nbsp;
              维护交费周期：&nbsp;<input type="radio" name="period" value="0" <%if(period==0)out.print(" checked=checked");%> >&nbsp;年&nbsp;
              <input type="radio" name="period" value="1" <%if(period==1)out.print(" checked=checked");%>>&nbsp;月&nbsp;
              <input type="radio" name="period" value="2" <%if(period==2)out.print(" checked=checked");%>>&nbsp;一次性
            </td>
          </tr>
          <tr>
            <td>交费日期（首次）：</td>
            <td nowrap><%=new tea.htmlx.TimeSelection("nextcosttime", nextcosttime)%>    </td>
          </tr>
           <tr>
            <td>最后交费日期：</td>
            <td nowrap><%=new tea.htmlx.TimeSelection("lastcosttime", lastcosttime)%>    </td>
          </tr>
          <tr>
            <td>实际收入：</td>
            <td nowrap><input type="text" name="realincome" value="<%=realincome%>">&nbsp;元&nbsp;&nbsp;
              <!--市场费用说明:&nbsp;<textarea cols="40" rows="1" name="marketexplain"><%out.print(realincome);%></textarea>-->
            </td>
          </tr>
          <tr>
            <td>其它成本：</td>
            <td nowrap><input type="text" name="otherexpenses" value="<%=otherexpenses%>">&nbsp;元&nbsp;&nbsp;
              <!--其它成本说明:&nbsp;<textarea cols="40" rows="1" name="otherexplain"><%if(otherexplain!=null)out.print(otherexplain); %></textarea>-->
            </td>
          </tr>
          <tr>
            <td>市场费用：</td>
            <td nowrap><input type="text" name="marketcost" value="<%=marketcost%>">&nbsp;元&nbsp;&nbsp;
              <!--市场费用说明:&nbsp;<textarea cols="40" rows="1" name="marketexplain"><%if(marketexplain!=null)out.print(marketexplain);%></textarea>-->
            </td>
          </tr>
          <tr>
            <td>预计利润：</td>
            <td><input type="text" name="profits" value="<%=profits%>"/>&nbsp;元</td>
          </tr>
          </table>
        <br>
        <input type="submit" value="提交">&nbsp;
           <input type="button" value="项目收支记录" onclick="f_c('<%=flowitem%>');">&nbsp;
        <input type="reset" value="重置" onClick="defaultfocus();">&nbsp;
        <input type="button" value="返回" onClick="history.back();">
        </form>
        <br>
        <div id="head6">
          <img height="6" src="about:blank">
        </div>
        </body>
</html>



