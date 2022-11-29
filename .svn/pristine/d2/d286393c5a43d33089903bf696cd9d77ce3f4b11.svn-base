<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node=Node.find(teasession._nNode);

int lang=0;
if(teasession.getParameter("lang")!=null)
lang=Integer.parseInt(teasession.getParameter("lang"));

String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
Lang obj=Lang.find(lang);
if(!node.isCreator(teasession._rv)||(lang!=0&&obj.getNode()!=teasession._nNode))
{
  response.sendError(403);
  return;
}

String nexturl=request.getParameter("nexturl");


if(request.getMethod().equals("POST"))
{
  if(request.getParameter("delete")!=null)
  {
    obj.delete();
  }else
  {
    String sprsl=request.getParameter("sprsl");
    String ztlnl=request.getParameter("ztlnl");
    String zkynl=request.getParameter("zkynl");
    String zxznl=request.getParameter("zxznl");
    String zydnl=request.getParameter("zydnl");
    String zdzdj=request.getParameter("zdzdj");
    String zbz=request.getParameter("zbz");
    if(lang==0)
    {
      Lang.create(teasession._nNode,teasession._nLanguage,    sprsl,    ztlnl,    zkynl,    zxznl,    zydnl,    zdzdj,    zbz);
    }else
    {
      obj.set( sprsl,    ztlnl,    zkynl,    zxznl,    zydnl,    zdzdj,    zbz);
    }
  }
  response.sendRedirect(request.getRequestURI()+"?node="+teasession._nNode+"&community="+community+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function submitSelect(obj,text)
{
  if(obj.selectedIndex==0)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
  </HEAD>
  <body >

<h1><%=r.getString(teasession._nLanguage,"1167538183812")%><!--语言能力--></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <form name="form1" method="post" action="<%=request.getRequestURI()%>"  onsubmit="" id="form1">
    <input type="hidden" name="lang" value="<%=lang%>" />
    <input type="hidden" name="Node" value="<%=teasession._nNode%>" />
    <input type="hidden" name="community" value="<%=community%>" />
    <input type="hidden" name="nexturl" value="<%=nexturl%>" />


<h2><%=r.getString(teasession._nLanguage,"1167443831593")%><!--列表--></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr ID=tableonetr>
         <td><%=r.getString(teasession._nLanguage,"1167538234343")%><!--语种--></td>
         <td><%=r.getString(teasession._nLanguage,"1167538271796")%><!--听力能力--></td>
         <td><%=r.getString(teasession._nLanguage,"1167538291406")%><!--口语能力--></td>
         <td></td>
         </tr>
          <%java.util.Enumeration enumeration=Lang.find(teasession._nNode,teasession._nLanguage);
          while(enumeration.hasMoreElements())
          {
            int id=((Integer)enumeration.nextElement()).intValue();
            Lang langobj=Lang.find(id);

                %>
	<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td>
              <%
    for(int index=0;index<Lang.SPRSL_TYPE.length;index++)
    {
      if(Lang.SPRSL_TYPE[index][0].equals(langobj.getSprsl()))
      {
        out.print(Lang.SPRSL_TYPE[index][1]);
        break;
      }
    }
    %>
          </td>
          <td><%
    for(int index=0;index<Lang.TYPE.length;index++)
    {
      if(Lang.TYPE[index][0].equals(langobj.getZtlnl()))
      {
        out.print(Lang.TYPE[index][1]);
        break;
      }
    }
          %></td>
          <td><%
          for(int index=0;index<Lang.TYPE.length;index++)
          {
            if(Lang.TYPE[index][0].equals(langobj.getZkynl()))
            {
              out.print(Lang.TYPE[index][1]);
              break;
            }
          }
          %></td>
        <td><input class="edit_button" type=button  value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('<%=request.getRequestURI()%>?lang=<%=id%>&node=<%=teasession._nNode%>&community=<%=community%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self')"/>
            <input  class="edit_button" type=submit name=delete value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){document.form1.lang.value=<%=id%>;return true;}else return false;"/>
        </td>
	</tr>

    <%} %>
</table>

      <br>
      <!--添加/编辑-->
      <h2><%=r.getString(teasession._nLanguage,"1167471137156")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td width="140" align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167538234343")%><!--语种--></strong></td>
    <td>    <select name="sprsl" >
    <%
    for(int index=0;index<Lang.SPRSL_TYPE.length;index++)
    {
      out.print("<option value="+Lang.SPRSL_TYPE[index][0]);
      if(Lang.SPRSL_TYPE[index][0].equals(obj.getSprsl()))
      out.print(" SELECTED");
      out.print(" >"+Lang.SPRSL_TYPE[index][1]);
    }
    %>
    </select></td>
              </tr>

              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167538271796")%><!--听力能力--></strong></td>
                <td><font size="2">
 <select name="ztlnl">
    <%
    for(int index=0;index<Lang.TYPE.length;index++)
    {
      out.print("<option value="+Lang.TYPE[index][0]);
      if(Lang.TYPE[index][0].equals(obj.getZtlnl()))
      out.print(" SELECTED");
      out.print(" >"+Lang.TYPE[index][1]);
    }
    %>
    </select>
                </font></td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167538291406")%><!--口语能力--></strong></td>
                <td> <select name="zkynl" >
    <%
    for(int index=0;index<Lang.TYPE.length;index++)
    {
      out.print("<option value="+Lang.TYPE[index][0]);
      if(Lang.TYPE[index][0].equals(obj.getZkynl()))
      out.print(" SELECTED");
      out.print(" >"+Lang.TYPE[index][1]);
    }
    %>
    </select></td>
              </tr>

              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167538458312")%><!--写作能力--></strong></td>
                <td>
				<select name="zxznl" >
    <%
    for(int index=0;index<Lang.TYPE.length;index++)
    {
      out.print("<option value="+Lang.TYPE[index][0]);
      if(Lang.TYPE[index][0].equals(obj.getZxznl()))
      out.print(" SELECTED");
      out.print(" >"+Lang.TYPE[index][1]);
    }
    %>
    </select>
				</td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><strong><%=r.getString(teasession._nLanguage,"1167538511671")%><!--阅读能力--></strong></td>
                <td>
				<select name="zydnl" >
    <%
    for(int index=0;index<Lang.TYPE.length;index++)
    {
      out.print("<option value="+Lang.TYPE[index][0]);
      if(Lang.TYPE[index][0].equals(obj.getZydnl()))
      out.print(" SELECTED");
      out.print(" >"+Lang.TYPE[index][1]);
    }
    %>
    </select>
				</td>
              </tr>
              <tr>
                <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong><%=r.getString(teasession._nLanguage,"1167538536625")%><!--对照国家等级--></strong></td>
                <td>
				<select name="zdzdj" >
    <%
    for(int index=0;index<Lang.ZDZDJ_TYPE.length;index++)
    {
      out.print("<option value="+Lang.ZDZDJ_TYPE[index][0]);
      if(Lang.ZDZDJ_TYPE[index][0].equals(obj.getZdzdj()))
      out.print(" SELECTED");
      out.print(" >"+Lang.ZDZDJ_TYPE[index][1]);
    }
    %>
    </select>
				</td>
              </tr>
              <tr>
                <td valign="top" align="right"><strong><B><%=r.getString(teasession._nLanguage,"1167536241906")%><!--备注--></B>&nbsp;&nbsp;
                </strong></td>
                <td><input class="edit_input" name="zbz" id="zbz" type="text" maxlength="60" size="40"  value="<%if(obj.getZbz()!=null)out.print(obj.getZbz());%>"/></td></tr>

	<tr>
		<td colspan="2"><div align="center"><br>
<!--保存&amp;新增-->
                  <input  class="edit_button" type="submit"  value="<%=r.getString(teasession._nLanguage,"1167532473640")%>" onClick=""  />



        </div></td>
	</tr>
</table>



  <br>
<!--上一步-->
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"1167472219140")%>" onClick="window.open('/jsp/type/resume/EditProfessional.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button" class="edit_button" name="btnSaveAndNext2" value="<%=r.getString(teasession._nLanguage,"CBNext")%>" onClick="window.open('/jsp/type/resume/EditFamily.jsp?node=<%=teasession._nNode%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');"/>
<input type="button" class="edit_button" name="btnSaveAndNext" value="<%=r.getString(teasession._nLanguage,"GoFinish")%>" onClick="window.open('<%=nexturl%>','_self');"   />



  </form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</HTML>

