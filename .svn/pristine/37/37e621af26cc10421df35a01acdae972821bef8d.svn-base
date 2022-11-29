<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.admin.*"%><%@ page import="tea.entity.util.*"%><%@ page import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.db.*" %>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.member.*"%><%@page import="java.util.*"%><%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");
String member=request.getParameter("member");

if(request.getMethod().equals("POST"))
{
  String company=request.getParameter("company");
  SupplierMember sm=SupplierMember.find(teasession._strCommunity,member);
  if(!sm.isExists())
  {
//    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("您已经添加了该用户，不能重复添加!", "UTF-8") + "&nexturl=" + nexturl);
//    return ;
     SupplierMember.create(teasession._strCommunity,member,company);
  }else
  {
    if("del".equals(request.getParameter("act")))
    {
      sm.delete();
    }else
    {
      sm.set(company);
    }
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

int nodepath = 8739;
if(teasession.getParameter("nodepath")!=null && teasession.getParameter("nodepath").length()>0)
{
  nodepath = Integer.parseInt(teasession.getParameter("nodepath"));
}

String _strId=request.getParameter("id");

Resource r=new Resource("/tea/ui/node/type/buy/EditCommodity");
//r.add("tea/resource/unitlist");
Community communitys=Community.find(teasession._strCommunity);

String company=null;
if(member!=null)
{
  SupplierMember sm=SupplierMember.find(teasession._strCommunity,member);
  company=sm.getCompany();
}

%><HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type=""></SCRIPT>
<script>
function f_edit(v)
{
  form1.member.value=v;
  form1.method='GET';
  form1.submit();
}
function f_delete(v)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form1.member.value=v;
    form1.act.value='del';
    disabled=true;
    form1.submit();
  }
}
function f_submit()
{
  var v="/";
  var op=form1.toList.options;
  for(var i=0;i<op.length;i++)
  {
    v=v+op[i].value+"/";
  }
  form1.company.value=v;
  return(submitText(form1.member,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Name")%>')
  &&submitText(form1.company,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "供货商")%>'));
}
function f_load()
{
  if(form1.nexturl.value=="null")
  form1.nexturl.value=location;
  form1.member.focus();
}
</script>
</HEAD>
<BODY onLoad="f_load();" >



<h1><%=r.getString(teasession._nLanguage, "Supplier")%></h1>
<div id="head6"><img height="6" alt=""></div>
  <FORM name="form2" action="?" method="GET" >
    <input type=hidden name="id" value="<%=_strId%>"/>
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="company" value="<%=company%>"/>
    <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
    <TABLE cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
      <TR>
        <TD> 填写要查找的备选供货商的位置即 节点号：<input type="text" name="nodepath" value="<%=nodepath%>"/><input type="submit" value="提交"/></TD>
      </TR>
    </TABLE>
</form>

  <FORM name="form1" action="?" method="post" >
    <input type=hidden name="act" value=""/>
    <input type=hidden name="id" value="<%=_strId%>"/>
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="company" value="<%=company%>"/>
    <input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<TABLE cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "会员")%>：</TD>
      <TD  noWrap ><INPUT size="40" name="member" value="<%if(member!=null)out.print(member);%>">
       <input type="button" value="添加" onClick="window.open('/jsp/type/goods/SelMembers.jsp?text=member&hidden=member&members=<%=member%>','newwindow','width=500,height=500,scrollbars=1');">
            <input type="button" value="清空" onClick="form1.member.value='';">
        &nbsp;*</TD>
    </TR>
    </table>
<TABLE cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>&nbsp;</td>
    <TD nowrap>选定供货商</TD>
    <td>&nbsp;</td>
    <TD nowrap>备选供货商</TD>
  </tr>
  <TR>
    <TD  noWrap ><%=r.getString(teasession._nLanguage, "供货商")%>：</TD>
    <TD  noWrap ><select name="toList"  size="20" multiple style="WIDTH: 300px; " ondblclick="move(form1.toList,form1.fromList,true);" >
                  <%
                  if(company!=null)
                  {
                    java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(company,"/");
                    while(tokenizer_obj.hasMoreTokens())
                    {
                      member=(String)tokenizer_obj.nextElement();
                      Node on = Node.find(Integer.parseInt(member));
                      out.print("<option value="+member+" >"+on.getSubject(teasession._nLanguage)+"</option>");
                    }
                  }


                  %>
                </select></td>
              <td><input onClick="move(form1.fromList,form1.toList,true);" type="button" value=" ← " id=button1 name=button1>
                <br>
                <input  onClick="move(form1.toList,form1.fromList,true);" type="button" value=" → " id=button2 name=button2>
                <br>
                <input onClick="func_up(form1.fromList,form1.toList);" type="button" value=" ↑ " id=button3 name=button3>
                <br>
                <input onClick="func_down(form1.fromList,form1.toList);" type="button" value=" ↓ " id=button4 name=button4>
              </td>
              <td>
                <select ondblclick="move(form1.fromList,form1.toList,true);" multiple style="WIDTH: 300px; " size="20" name="fromList" >
                <%
                //                  java.util.Enumeration enumer=AdminUsrRole.findByCommunity(teasession._strCommunity,"");
                //                  while(enumer.hasMoreElements())
                //                  {
                  //                    member=(String)enumer.nextElement();
                  //                    Profile p=Profile.find(member);
                  // 		    out.print("<option value="+member+" >"+member+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )");
                  //                  }

                  java.util.Enumeration es = Node.find(" and hidden = 0 and type =21 and path like "+DbAdapter.cite("%/"+nodepath+"/%"),0,Integer.MAX_VALUE);//8739 //8633  22310
                  while(es.hasMoreElements())
                  {
                    int nodeid = ((Integer)es.nextElement()).intValue();
                    Node n = Node.find(nodeid);
                    out.print("<option value="+nodeid+">"+n.getSubject(teasession._nLanguage)+"</option>");
                  }
                  %>
                </select>
                <script type="">
                for(index=0;index<form1.toList.length;index++)
                {
                  for(i=0;i<form1.fromList.length;i++)
                  {
                    if( form1.toList[index].value==form1.fromList[i].value)
                    {
                      form1.fromList.remove(i);
                    }
                  }
                }
                </script>

      </TD>
    </TR>
</TABLE>
<INPUT type="submit" value="<%=r.getString(teasession._nLanguage, "Add")%>" onClick="return f_submit();">
<br>

<h2>列表</h2>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <TR id="tableonetr">
  <td width="1">&nbsp;</td>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "Name")%></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "供货商")%></TD>
    <td noWrap>&nbsp;</td>
  </TR>
  <%
java.util.Enumeration enumer =SupplierMember.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
 if(!enumer.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
for(int i=1;enumer.hasMoreElements();i++)
{
  member=(String)enumer.nextElement();
  SupplierMember obj=SupplierMember.find(teasession._strCommunity,member);

%>
  <TR>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><%=i%></td>
    <TD noWrap><%=obj.getMember()%></TD>
    <td><%=obj.getCompanyToHtml(teasession._nLanguage)%></td>
    <TD noWrap><input type=button onClick="f_edit('<%=member%>'); " value="<%=r.getString(teasession._nLanguage, "CBEdit")%>">
      <input type="button" onClick="f_delete('<%=member%>');" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"></TD>
  </TR>
<%
}
%>
</TABLE>
</FORM>
<br>
<div id="head6"><img height="6" alt=""></div>
<br>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>



</BODY>
</HTML>

