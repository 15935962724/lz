<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.admin.*"%><%@ page import="tea.entity.util.*"%><%@ page import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %><%@page import="java.net.URLEncoder"%><%@page import="tea.entity.member.*"%><%@page import="java.util.*"%><%request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");

int supplier=0;
String _strSupplier=request.getParameter("supplier");
if(_strSupplier!=null && _strSupplier.length()>0)
    supplier=Integer.parseInt(_strSupplier);

if(request.getMethod().equals("POST"))
{
  int card=0;
  String _strCard=request.getParameter("card1");
  if(_strCard!=null&&_strCard.length()>0)
	card=Integer.parseInt(_strCard);

  String tel=request.getParameter("tel");
  String fax=request.getParameter("fax");
  String name=request.getParameter("name");
  String address=request.getParameter("address");
  String member=request.getParameter("member");
  if(supplier==0)
  {
    Supplier.create(teasession._strCommunity,tel,fax,card,member,teasession._nLanguage,name,address);
  }else
  {
    Supplier obj=Supplier.find(supplier);
    if("del".equals(request.getParameter("act")))
    {
      obj.delete();
    }else
    {
      obj.set(tel,fax,card,member,teasession._nLanguage,name,address);
    }
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

String _strId=request.getParameter("id");

Resource r=new Resource("/tea/ui/node/type/buy/EditCommodity");
//r.add("/tea/resource/unitlist");
Community communitys=Community.find(teasession._strCommunity);

int card=0;
String name=null,tel=null,fax=null,address=null,member=null;
if(supplier>0)
{
  Supplier obj=Supplier.find(supplier);
  tel=obj.getTel();
  fax=obj.getFax();
  card=obj.getCard();
  member=obj.getMember();
  name=obj.getName(teasession._nLanguage);
  address=obj.getAddress(teasession._nLanguage);
}

%><html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type=""></SCRIPT>
<script>
function f_edit(v)
{
  form1.supplier.value=v;
  form1.method='GET';
  form1.submit();
}
function f_delete(v)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form1.supplier.value=v;
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
  form1.member.value=v;
  return(submitText(form1.name,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Name")%>')
  &&submitText(form1.card1,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "City")%>'));
}
function f_load()
{
  if(form1.nexturl.value=="null")
  form1.nexturl.value=location;
  form1.name.focus();
}
</script>
</head>
<BODY onLoad="f_load();"  id="bodynone">

<script src="<%=communitys.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></script>

<h1><%=r.getString(teasession._nLanguage, "Supplier")%></h1>
<div id="head6"><img height="6" alt=""></div>
  <FORM name="form1" action="?" method="post" >
    <input type=hidden name="act" value=""/>
    <input type=hidden name="supplier" value="<%=supplier%>"/>
    <input type=hidden name="id" value="<%=_strId%>"/>
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="member" value="<%=member%>"/>
    <input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<TABLE cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Name")%>：</TD>
      <TD  noWrap ><INPUT size="40" name="name" value="<%if(name!=null)out.print(name);%>">
        &nbsp;*</TD>
    </TR>
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Telephone")%>：</TD>
      <TD  noWrap ><INPUT value="<%if(tel!=null)out.print(tel);%>" size="40" name="tel">
        &nbsp;</TD>
    </TR>
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Fax")%>：</TD>
      <TD  noWrap ><INPUT value="<%if(fax!=null)out.print(fax);%>" size="40" name="fax">
        &nbsp;</TD>
    </TR>
	    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "City")%>：</TD>
      <TD  noWrap ><script>selectcard("card0","card1",null,"<%=String.valueOf(card)%>");</script></TD>
    </TR>
	    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Address")%>：</TD>
      <TD  noWrap ><INPUT name="address" maxLength="25" value="<%if(address!=null)out.print(address);%>" size="40" >
        &nbsp;</TD>
    </TR>
    </table>
<TABLE cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>&nbsp;</td>
    <TD nowrap>选定管理员</TD>
    <td>&nbsp;</td>
    <TD nowrap>备选管理员</TD>
  </tr>
  <TR>
    <TD  noWrap ><%=r.getString(teasession._nLanguage, "管理员")%>：</TD>
    <TD  noWrap ><select name="toList"  size="10" multiple style="WIDTH: 180px; " ondblclick="move(form1.toList,form1.fromList,true);" >
                  <%
                  if(member!=null)
                  {
                    java.util.StringTokenizer tokenizer_obj=new java.util.StringTokenizer(member,"/");
                    while(tokenizer_obj.hasMoreTokens())
                    {
                      member=(String)tokenizer_obj.nextElement();
                      Profile p=Profile.find(member);
                      out.print("<option value="+member+" >"+member+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )");
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
                <select ondblclick="move(form1.fromList,form1.toList,true);" multiple style="WIDTH: 180px; " size="10" name="fromList" >
                  <%
                  java.util.Enumeration enumer=AdminUsrRole.findByCommunity(teasession._strCommunity,"");
                  while(enumer.hasMoreElements())
                  {
                    member=(String)enumer.nextElement();
                    Profile p=Profile.find(member);
 		    out.print("<option value="+member+" >"+member+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )");
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
    <TD  noWrap><%=r.getString(teasession._nLanguage, "Telephone")%></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "Fax")%></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "City")%></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "operation")%></TD>
  </TR>
  <%
enumer=Supplier.findByCommunity(teasession._strCommunity);
for(int i=1;enumer.hasMoreElements();i++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Supplier obj=Supplier.find(id);
  card=obj.getCard();
%>
  <TR>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td width="1"><%=i%></td>
    <TD noWrap><%=obj.getName(teasession._nLanguage)%></TD>
    <TD noWrap><%=obj.getTel()%>　</TD>
    <TD noWrap><%=obj.getFax()%>　</TD>
    <TD noWrap><%=Card.find(card).toString()%>　</TD>
    <TD noWrap><input type=button onClick="f_edit(<%=id%>); " value="<%=r.getString(teasession._nLanguage, "CBEdit")%>"><input type="button" onClick="f_delete(<%=id%>);" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>"></TD>
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

<script src="<%=communitys.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></script>

</BODY>
</html>
