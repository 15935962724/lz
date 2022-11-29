<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%!
public String write(byte byDate[])
    {
        ByteArrayOutputStream bytestream = new ByteArrayOutputStream();
        OutputStream file = null;
        java.io.File f = new java.io.File(getServletContext().getRealPath("/tea/image/type/"+ String.valueOf(System.currentTimeMillis()) + ".gif"));
        while (f.exists())
        {
            f = new java.io.File(getServletContext().getRealPath("/tea/image/type/"+ String.valueOf(System.currentTimeMillis()) + ".gif"));
        }
        try
        {
            bytestream.write(byDate);
            file = new FileOutputStream(f);
            bytestream.writeTo(file);
            return "/tea/image/type/" + f.getName();
        } catch (Exception e)
        {
            e.printStackTrace();
        } finally
        {
            try
            {
                if (file != null)
                {
                    file.close();
                }
                bytestream.close();
            } catch (IOException ex)
            {
            }
        }
        return "";
    }
%>
<%
String member=null;
if(teasession.getParameter("member")!=null&&tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv._strR))
member=teasession.getParameter("member");
else
member=teasession._rv._strR;
tea.entity.member.YellowPageInfo ypi_obj=tea.entity.member.YellowPageInfo.find(member);
member=new String(member.getBytes("ISO-8859-1"));
if(request.getMethod().equals("POST"))
{
  String logo=null;
  byte by[]=teasession.getBytesParameter("logo");
  if(by!=null)
  logo=write(by);
  else
  if(teasession.getParameter("clear")!=null)
  {
    logo=ypi_obj.getLogo();
  }
  String domain[]={teasession.getParameter("domain"),
  teasession.getParameter("domain2"),
  teasession.getParameter("domain3")};

  String   consult[]={
    teasession.getParameter("consult"),
    teasession.getParameter("consult2"),
    teasession.getParameter("consult3")};
    ypi_obj.set(domain,
    teasession.getParameter("name"),
    teasession.getParameter("catchword"),
    logo,
    teasession.getParameter("hue"),
    teasession.getParameter("style"),
    teasession.getParameter("function"),
    teasession.getParameter("lang"),
    teasession.getParameter("request"),
    consult,
    teasession.getParameter("mailbox"),
    teasession.getParameter("item"),
    teasession.getParameter("linkman")
    );
    response.sendRedirect(request.getRequestURI()+"?member="+java.net.URLEncoder.encode(member,"gb2312"));
    return;
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head><body>
<h1><%=r.getString(teasession._nLanguage, "MemberInfo")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form action="" method="post" enctype="multipart/form-data" name="form1">
  <input type="hidden" name="member" value="<%=member%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan="4" id="TableCaption" style="background-color: #3775CA; padding:4px; padding-left:10px;font-weight:bold;color:#ffffff;text-align:left; ">网络上传资料</TD>
  </tr>
  <tr>
    <td nowrap>域名</TD>
    <td align="left">
      <input name="domain" type="text" value="<%=getNull(ypi_obj.getDomain()[0])%>" size="15">
    </td>
    <td><input name="domain2" type="text" value="<%=getNull(ypi_obj.getDomain()[1])%>" size="15"></td>
    <td><input name="domain3" type="text" value="<%=getNull(ypi_obj.getDomain()[2])%>" size="15"></td>
    </tr>
  <tr>
    <td nowrap>企业名称(中英文)</TD>
    <td colspan="2" align="left"><input name="name" type="text" size="40" value="<%=getNull(ypi_obj.getName())%>"></td>
    <TD>&nbsp;</TD>
    </tr>
  <tr>
    <td nowrap>企业口号</TD>
    <td colspan="2" align="left"><input name="catchword" type="text" size="40" value="<%=getNull(ypi_obj.getCatchword())%>"></td>
    <td align="left">&nbsp;</td>
    </tr>
  <tr>
    <td nowrap>企业标志(logo)</TD>
    <td colspan="3" align="left"><input name="logo" type="file" size="30" ondblclick="window.open('<%=getNull(ypi_obj.getLogo())%>')">
      <%
      if(ypi_obj.getLogo()!=null&&ypi_obj.getLogo().length()>0)
      {
        out.print(new java.io.File(application.getRealPath(ypi_obj.getLogo())).length()+"字节");
      }
      %><input  id="CHECKBOX" type="CHECKBOX" name="clear" value="checkbox">
      清空</td>
    </tr>
  <tr>
    <td nowrap>主色调说明</TD>
    <td colspan="3" align="left"><textarea name="hue" cols="60" rows="3"><%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getHue()))%></textarea></td>
    </tr>
  <tr>
    <td nowrap>风格说明</TD>
    <td colspan="3" align="left"><textarea name="style" cols="60" rows="3"><%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getStyle()))%></textarea></td>
    </tr>
  <tr>
    <td nowrap>功能要求说明</TD>
    <td colspan="3" align="left"><textarea name="function" cols="60" rows="3"><%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getFunction()))%></textarea></td>
    </tr>
  <tr>
    <td nowrap>语言说明</TD>
    <td colspan="3" align="left"><textarea name="lang" cols="60" rows="3"><%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getLang()))%></textarea></td>
    </tr>
  <tr>
    <td nowrap>网站特殊要求</TD>
    <td colspan="3" align="left"><textarea name="request" cols="60" rows="3"><%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getRequest()))%></textarea></td>
    </tr>
  <tr>
    <td nowrap>参考站点(改版请输入旧网址)</TD>
    <td align="left"><input name="consult" type="text" value="<%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getConsult()[0]))%>" size="15"></td>
    <td><input name="consult2" type="text" value="<%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getConsult()[1]))%>" size="15"></td>
    <td><input name="consult3" type="text" value="<%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getConsult()[2]))%>" size="15"></td>
    </tr>
  <tr>
    <td nowrap>企业邮箱账号</TD>
    <td align="left"><input name="mailbox" type="text" value="<%=getNull(ypi_obj.getMailbox())%>" size="15"></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td nowrap>网站建设栏目说明</TD>
    <td colspan="3" align="left"><textarea name="item" cols="60" rows="6"><%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getItem()))%></textarea></td>
    </tr>
  <tr>
    <td nowrap>联系人信息</TD>
    <td colspan="3" align="left"><textarea name="linkman" cols="60" rows="6"><%=tea.html.HtmlElement.htmlToText(getNull(ypi_obj.getLinkman()))%></textarea></td>
    </tr>
  <tr>
    <td nowrap>&nbsp;</TD>
    <td><input type="submit" name="Submit" value="提交" class="edit_button" ></td>
    <td><input type="button"  onclick="window.location='/jsp/netdisk/EditNetDiskMember.jsp?url=/<%=member%>/&node=<%=teasession._nNode%>'" name="button" value="文件管理" class="edit_button" ></td>
    <td>&nbsp;</td>
    </tr>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

