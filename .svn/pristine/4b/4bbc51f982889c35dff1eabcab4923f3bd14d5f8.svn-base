<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String community=request.getParameter("community");

int brand=0,sequence=0,company=0,node=0;
String name=null,logo=null,content=null;
if(request.getParameter("brand")!=null)
{
  brand=Integer.parseInt(request.getParameter("brand"));
  Brand obj=  Brand.find(brand);
  logo=obj.getLogo();
  company=obj.getCompany();
  node=obj.getNode();
  sequence=obj.getSequence();
  name=obj.getName(teasession._nLanguage);
  content=obj.getContent(teasession._nLanguage);
}

Resource r=new Resource();
Community communitys=Community.find(teasession._strCommunity);

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="text/javascript">
function f_find(v)
{
	if(v!=form1.nodex.text)
	{
		var op=form1.nodex.options;
		for(var i=1;i<op.length;i++)
		{
			if(v==op[i].text)
			{
				op[i].selected=true;
				break;
			}
		}
	}
}
</script>
</head>

<body id="bodynone">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=communitys.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>


<h1><%=r.getString(teasession._nLanguage, "添加/编辑 品牌")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<FORM name=form1 action="/servlet/EditBrand" METHOD=POST enctype="multipart/form-data" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&submitText(this.nodex, '<%=r.getString(teasession._nLanguage, "InvalidNode")%>')&&submitInteger(this.sequence, '<%=r.getString(teasession._nLanguage, "InvalidSequence")%>');">
  <input type='hidden' name="Node" VALUE="<%=teasession._nNode%>">
  <input type='hidden' name="brand" VALUE="<%=brand%>">
  <input type='hidden' name="community" VALUE="<%=community%>">
  <input type='hidden' name=Type VALUE="<%=request.getParameter("Type")%>">
  <table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
      <td><input type="TEXT" name="name" value="<%if(name!=null)out.print(name);%>" size="40" onchange="f_find(this.value);"></td>
        <td rowspan="4" valign="middle">
          <img src="<%if(logo!=null)out.print(logo);%>" onerror="this.style.display='none';" style=" float:right " id="logopreview">
        </td>
          </tr>
          <tr>
            <TD>Logo:</TD>
            <td><input type="file"   name="logo" onChange="logopreview.style.display='';logopreview.src=this.value;"><br>
              <input type="text"   name="logopath" value="<%if(logo!=null)out.print(logo);%>" size="40"></td>
          </tr>
          <tr>
            <TD><%=r.getString(teasession._nLanguage, "Company")%>:</TD>
            <td>
              <select name="company">
              <option value="0">-------------</option>
              <%
              java.util.Enumeration e=Node.findByType(21,teasession._strCommunity);
              while(e.hasMoreElements())
              {
                int company_id=((Integer)e.nextElement()).intValue();
                out.print("<option value="+company_id);
                if(company==company_id)
                out.print(" SELECTED ");
                out.print(">"+Node.find(company_id).getSubject(teasession._nLanguage));
              }
              %>
              </select>
              <input type="button" value="..." onClick="window.open('/jsp/type/company/CompanyList.jsp?field=form1.company','','height=250,width=500,left=400,top=300,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes');"/>
            </td>
          </tr>
          <tr>
            <TD><%=r.getString(teasession._nLanguage, "Node")%>:</TD>
            <td>
              <select name="nodex">
              <option value="">---------------------------------------</option>
              <%
              DbAdapter db=new DbAdapter();
              try
              {
              	db.executeQuery("SELECT n.node FROM Node n INNER JOIN Category c ON n.node=c.node WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+" AND n.type=1 AND c.category=34");
	            while(db.next())
	            {
	                int n=db.getInt(1);
                    Node obj=Node.find(n);
	                out.print("<option value="+n);
	                if(node==n)
	                out.print(" SELECTED ");
	                out.print(">"+Node.find(obj.getFather()).getSubject(teasession._nLanguage)+" > "+obj.getSubject(teasession._nLanguage));
	            }
              }finally
              {
            	  db.close();
              }
              %>
              </select>
            </td>
          <tr>
            <TD><%=r.getString(teasession._nLanguage, "Content")%>:</TD>
            <td><textarea  name="content" cols="40" rows="4"  ><%if(content!=null)out.print(content);%></textarea></td>
          </tr>
          <tr>
            <TD><%=r.getString(teasession._nLanguage, "Sequence")%>:</TD>
            <td><input type="TEXT"   name="sequence" value="<%=sequence%>" size="40" onKeyPress="inputInteger();"></td>
          </tr>
        </table>
        <P ALIGN=CENTER>
          <%--
            <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">--%>
          <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBSubmit")%>">

          <input type="button" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBBack")%>" onClick="history.back()">
        </P>
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage, request)%></div>
<script>form1.name.focus();</script>

<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=communitys.getJspAfter(teasession._nLanguage)%>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=communitys.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>

