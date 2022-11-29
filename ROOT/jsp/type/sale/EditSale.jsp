<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditSale")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
      <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>

<form name="form1" action="/servlet/EditSale" method="post" enctype="multipart/form-data"
  onsubmit="return submitText(this.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>');" >
    <%
r.add("/tea/resource/Sale");
    String parameter=teasession.getParameter("nexturl");
    boolean   parambool=(parameter!=null&&!parameter.equals("null"));
            tea.entity.node.Sale sale=tea.entity.node.Sale.find(0,0);
    if(parambool)
    out.print("<input type='hidden' name=nexturl value="+parameter+">");
    String subject="",text="",price="面议";
            if(request.getParameter("NewNode")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
            }else
            if(request.getParameter("NewBrother")!=null)
            {
                out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
        }else
        {
          subject=node.getSubject(teasession._nLanguage);
          text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
          sale=tea.entity.node.Sale.find(teasession._nNode,teasession._nLanguage);
          price=sale.getPrice();
        }
            %>
          <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td nowrap>产品名称</td>
      <td nowrap><input name="subject" type="text" value="<%=subject%>" size="50"></td>
    </tr>
    <tr>
      <td nowrap>功能描述</td>
      <td nowrap><input name="capability" type="text" value="<%=getNull(sale.getCapability())%>" size="50" maxlength="100"></td>
    </tr>
    <tr>
      <td nowrap>图片</td>
      <td nowrap><input type="file" name="picture" ondblclick="window.open('<%=sale.getPicture()%>')"  >
      <%
      if(sale.getPicture()!=null)
      {
        long len=new java.io.File(application.getRealPath(sale.getPicture())).length();
        if(len>0)
        {
          out.print(String.valueOf(len)+r.getString(teasession._nLanguage,"Bytes"));
        }
      }
      %>
        <input  id="CHECKBOX" type="CHECKBOX" name="clear" onclick="form1.picture.disabled=this.checked;" id="clear" value="checkbox"><label for=clear >清空</label></td>
    </tr>
	    <tr>
      <td nowrap>价格</td>
      <td nowrap><input type="text" value="<%=price%>" name="price">
      </td>
            </tr>
    <tr>
      <td nowrap>详细介绍</td>
      <td nowrap><textarea name="text" cols="60" rows="6"><%=text%></textarea></td>
    </tr>
    <tr>
      <td nowrap>范围</td>
      <td nowrap><select name="area">
        <%
for(int index=0;index<        tea.entity.node.Sale.AREA_TYPE.length;index++)
{
%>
<option value="<%=index%>" <%=getSelect(sale.getArea()==index)%>><%=r.getString(teasession._nLanguage,tea.entity.node.Sale.AREA_TYPE[index])%></option>
<%}%>
      </select>
      允许那些人可以查看</td>
    </tr>
  </table>
<input name="" type="reset" value="重置">
<input type="submit" name="Submit" value="提交">
</form>
<%out.print(new tea.html.Script("form1.subject.focus();"));%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
