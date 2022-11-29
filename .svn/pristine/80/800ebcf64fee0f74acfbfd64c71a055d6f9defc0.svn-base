<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
if(request.getMethod().equals("POST"))
{
  int id=0;
  if(request.getParameter("adminunit")!=null)
  id=Integer.parseInt(request.getParameter("adminunit"));

  tea.entity.admin.AdminUnit obj_au=tea.entity.admin.AdminUnit.find(id);
  if("del".equals(request.getParameter("act")))
  {
    obj_au.delete();
  }else
  {
    int pid=0;//Integer.parseInt(request.getParameter("pid"));
    int sequence=0;
    /*try
    {
      sequence=Integer.parseInt(request.getParameter("xh"));
    }catch(Exception e)
    {}*/
    obj_au.set(request.getParameter("mc"),pid,1,request.getParameter("dh"),request.getParameter("cz"),sequence,node.getCommunity(),teasession._rv.toString(),request.getParameter("address"),request.getParameter("zip"),request.getParameter("other"),request.getParameter("other2"));
    boolean other3=Boolean.parseBoolean(request.getParameter("other3"));
    obj_au.setOther3(other3);
  }
  //this.getServletContext().getRequestDispatcher(request.getRequestURI()).forward(request,response);
  response.sendRedirect(request.getParameter("nexturl"));
  return;
}

r.add("/tea/resource/unitlist");
String nexturl=request.getRequestURI()+"?"+request.getQueryString();

%><html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT language="JavaScript" type="">
function CheckForm()
{
  if(document.form1.DEPT_NO.value=="")
  {
    alert("<%=r.getString(teasession._nLanguage, "InvalidSequence")%>");
    return (false);
  }

  if(document.form1.DEPT_NAME.value=="")
  {
    alert("<%=r.getString(teasession._nLanguage, "InvalidName")%>");
    return (false);
  }
}
</SCRIPT>
</head>
<BODY >
<h1>单位管理<%//=r.getString(teasession._nLanguage, "DeptManage")%></h1>
<div id="head6"><img height="6" alt=""></div>
<h2>添加单位<%//=r.getString(teasession._nLanguage, "AddDept")%></h2>
<TABLE cellSpacing="0" cellPadding="0"  border="0" id="tablecenter">
  <FORM name="unitlist" onSubmit="return( submitText(this.mc,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&submitText(this.address,'无效地址')&&submitText(this.zip,'无效邮编')&&submitText(this.other2,'无效-开户行')&&submitText(this.other,'无效-帐号'))" action="" method="post">
    <input type=hidden name="act" value=""/>
    <INPUT id="adminunit" type="hidden" name="adminunit" value="0">
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
    <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
    <%-- TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Sequence")%>：</TD>
      <TD  noWrap ><INPUT class="BigInput" maxLength="25" size="2" value="0" name="xh">

        &nbsp;</TD>
    </TR>
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Code")%>：</TD>
      <TD  noWrap ><INPUT class="BigInput" maxLength="25" value="0" size="25" name="pid">
        *</TD>
    </TR--%>
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Name")%>：</TD>
      <TD  noWrap ><INPUT class="BigInput" maxLength="25" value="" size="25" name="mc">
        &nbsp;*</TD>
    </TR>
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Telephone")%>：</TD>
      <TD  noWrap ><INPUT class="BigInput" maxLength="25" value="" size="25" name="dh">
        &nbsp;</TD>
    </TR>
    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Fax")%>：</TD>
      <TD  noWrap ><INPUT class="BigInput" maxLength="25" value="<%//=cz%>" size="25" name="cz">
        &nbsp;</TD>
    </TR>
	    <TR>
      <TD  noWrap ><%=r.getString(teasession._nLanguage, "Address")%>：</TD>
      <TD  noWrap ><INPUT class="BigInput" maxLength="25" value="" size="25" name="address">
        &nbsp;*</TD>
    </TR>
		    <TR>
      <TD  noWrap >邮编<%//=r.getString(teasession._nLanguage, "Principal")%>：</TD>
      <TD  noWrap ><INPUT class="BigInput" maxLength="6" value="" size="15" name="zip">
        &nbsp;*</TD>
    </TR >
    <TR>
      <TD  noWrap >开户行<%//=r.getString(teasession._nLanguage, "Principal")%>：</TD>
      <TD  noWrap ><INPUT name="other2" class="BigInput" id="other2" value="" size="25" maxLength="50">&nbsp;*</TD>
    </TR >
        <TR>
      <TD  noWrap >帐号<%//=r.getString(teasession._nLanguage, "Principal")%>：</TD>
      <TD  noWrap ><INPUT name="other" class="BigInput" id="other" value="" size="25" maxLength="50">&nbsp;*</TD>
    </TR >
    <TR style="display:none">
      <TD  noWrap >是否编制组名称：</TD>
      <TD  noWrap ><input name="other3" type="radio" checked value="true">是 <input name="other3" type="radio" value="false">否 </TD>
    </TR >
    <TR align="center">
      <TD  colSpan="2" noWrap class="TableControl"><INPUT class="BigButton" title="" type="submit" value="<%=r.getString(teasession._nLanguage, "Add")%>" name="button" id="Submit1"></TD>
    </TR>
  </FORM>
</TABLE>
<h2>单位列表<%//=r.getString(teasession._nLanguage, "DeptManage")%> </h2>
<TABLE  cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <TR id="tableonetr">
    <TD  noWrap width="1"><script type="">var index=0;</script></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "Name")%></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "Telephone")%></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "Fax")%></TD>
    <TD  noWrap><%=r.getString(teasession._nLanguage, "operation")%></TD>
  </TR>
  <%
StringBuffer sb=new StringBuffer("SELECT id FROM AdminUnit WHERE other3=1 AND community=" + DbAdapter.cite(node.getCommunity()));
/*
if(!tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
  sb.append(" AND creator="+DbAdapter.cite(teasession._rv.toString()));
}*/
DbAdapter dbadapter=new DbAdapter();
try
{
  dbadapter.executeQuery(sb.toString());
  while (dbadapter.next())
  {
    int id=(dbadapter.getInt(1));
    tea.entity.admin.AdminUnit obj_au=tea.entity.admin.AdminUnit.find(id);


    //  java.util.Enumeration enumer                 =       tea.entity.admin.AdminUnit.findByCommunity(node.getCommunity());
    //while(enumer.hasMoreElements())
    //{
      //  int id=((Integer)enumer.nextElement()).intValue();
      //tea.entity.admin.AdminUnit obj_au=  tea.entity.admin.AdminUnit.find(id);
      %>
      <TR>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';">
          <TD  noWrap  width="1"><script type="">document.write(++index);</script></TD>
          <TD  noWrap ><%=obj_au.getName()%></TD>
          <TD  noWrap ><%=obj_au.getTel()%>　</TD>
          <TD  noWrap ><%=obj_au.getFax()%>　</TD>
          <TD noWrap  ><A href="#" onClick="unitlist.adminunit.value='<%=id%>';unitlist.mc.value='<%=HtmlElement.htmlToText(obj_au.getName())%>';unitlist.dh.value='<%=obj_au.getTel()%>'; unitlist.cz.value='<%=obj_au.getFax()%>';unitlist.address.value='<%=HtmlElement.htmlToText(obj_au.getAddress())%>';unitlist.zip.value='<%=obj_au.getZip()%>';unitlist.other.value='<%=obj_au.getOther()%>';unitlist.other2.value='<%=obj_au.getOther2()%>';unitlist.other3[<%=obj_au.isOther3()?0:1%>].checked=true;unitlist.mc.focus(); "><%=r.getString(teasession._nLanguage, "Edit")%></A>　<A href="#" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){unitlist.adminunit.value='<%=id%>';unitlist.act.value='del';unitlist.submit();}"><%=r.getString(teasession._nLanguage, "Delete")%></A> </TD>
      </TR>
      <%
    }
  }catch(Exception e)
  {
    e.printStackTrace();
  }finally
  {
    dbadapter.close();
  }

%>
</TABLE>
<br>
<div id="head6"><img height="6" alt=""></div>
<br>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

