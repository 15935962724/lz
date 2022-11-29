<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="java.io.*"%>
<%@ page import="tea.ui.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

Http h=new Http(request,response);


Resource r=new Resource("/tea/ui/member/community/EditCommunity");

boolean flag = request.getParameter("new")!=null;
if(!flag && !teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(teasession._strCommunity))
{
  response.sendError(403);
  return;
}

///
AccessMember am = AccessMember.find(teasession._nNode, teasession._rv.toString());

Node node = Node.find(teasession._nNode);


int j = 0,state=2;
String s2 = "";
String s4 = "";
String s6 = "";
String css;
String filtrate=null;
int maplen = 0;
String webName=request.getServerName(), email="", smtp="",SmtpName="",SmtpUser="",SmtpPassword="";
boolean regMail=false,regmap=true,publicity=true;
String mailbefore="",mailafter="";
String jspbefore="",jspafter="";
String smallmap="",keywords="",synopsis="";
if(!flag)
{
  Community obj = Community.find(teasession._strCommunity);
  j = obj.getType();
  state=obj.getState();
  s2 = obj.getName(teasession._nLanguage);
  s4 = obj.getTerm(teasession._nLanguage);
  s6 = obj.getWelcome(teasession._nLanguage);
  css="/res/"+teasession._strCommunity+"/cssjs/community.css";
  webName=obj.getWebName();
  email =obj.getEmail();
  smtp=obj.getSmtp();
  SmtpName=obj.getSmtpName();
  SmtpUser=obj.getSmtpUser();
  SmtpPassword=obj.getSmtpPassword();
  filtrate=obj.filtrate;
  regMail=obj.isRegMail();
  regmap=obj.isRegmap();
  publicity=obj.isPublicity();
  mailbefore=obj.getMailBefore(teasession._nLanguage);
  mailafter=obj.getMailAfter(teasession._nLanguage);
  jspbefore=obj.getJspBefore(teasession._nLanguage);
  jspafter=obj.getJspAfter(teasession._nLanguage);
  smallmap = obj.getSmallMap(teasession._nLanguage);
  keywords=obj.getKeywords(teasession._nLanguage);
  synopsis = obj.getSynopsis(teasession._nLanguage);
  if(MT.f(smallmap).length()>0)
  {
    maplen=(int)new java.io.File(application.getRealPath(smallmap)).length();
  }

}else
{
  css="/tea/community.css";
  email="robot@redcome.com";
  smtp="mail.redcome.com";
  SmtpUser="robot@redcome.com";
  SmtpPassword="1234";
  s4 = "您必须接受以下所有协议，才能申请成为我们的注册用户： <br>\r\n" +
  "<div align=left>\r\n" +
  "<br>\r\n" +
  "1．本网站管理提供的服务将完全按其发布的会员服务内容以及双方所签署协议的约定，服务条款和操作规则严格执行。用户必须完全同意所有服务条款并完成注册程序，才能成为本网站管理的正式用户。<br>\r\n" +
  "2．服务简介本网站管理运用自己的操作系统通过国际互联网提供网络服务。同时，用户必须：<br>\r\n" +
  "  （1）自行配备上网的所需设备，包括个人电脑、调制解调器或其他上网装置。<br>\r\n" +
  "  （2）自行负担上网所支付的与此服务有关的电话费用，网络费用等。<br>\r\n" +
  "3．基于本网站管理所提供的网络服务的重要性，用户应同意：<br>\r\n" +
  "  （1）对注册过程中的各项问题，提供真实、准确的回答；<br>\r\n" +
  "  （2）不断更新资料，符合及时、详尽、准确的要求。本网站管理不公开用户的姓名、地址、电子邮件箱和笔名，除以下情况外：<br>\r\n" +
  "  A．用户授权本网站管理公开这些信息。<br>\r\n" +
  "  B．相应的法律程序要求本网站管理提供用户的个人资料。<br>\r\n" +
  "4．用户在本网站管理上发布信息应遵循国家在网络安全方面制定的法律法规及管理条例，由此引发的一切后果将由用户自行承担。<br>\r\n" +
  "5. 如果用户提供资料包含不正确的信息，本网站管理保留结束用户使用本公司所提供的网络服务资格权利。</div>";
  filtrate="李洪志,江泽民,胡锦涛,法轮功,代开发票";
}
//Read CSS/////////////
File f=new File(application.getRealPath(css));
byte by[] = new byte[(int)f.length()];
try
{
  FileInputStream fr = new FileInputStream(f);
  fr.read(by);
  fr.close();
  css = new String(by, "UTF-8");
} catch (IOException ex)
{
  ex.printStackTrace();
}

String title=r.getString(teasession._nLanguage, "CBEditCommunity");
%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onLoad="try{foEdit.community.focus();}catch(e){}">
<%=tea.ui.node.general.NodeServlet.getButton(node,h, am,request)%>
<h1><%=title%></h1>
<div id="head6"><img height="6" alt=""></div>
   <br>
   <FORM name=foEdit METHOD=POST action="/servlet/EditCommunity" enctype="multipart/form-data" target="_ajax" onSubmit="return(submitIdentifier(this.community,'<%=r.getString(teasession._nLanguage, "InvlaidCommunity")%>')&&submitText(this.Name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'));">
   <input type="hidden" name="nexturl" value="/jsp/community/OrganizingCommunities.jsp"/>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Community")%>:</td>
            <td><%
            if(!flag)
            {
              out.println("<input type='hidden' name=community value="+teasession._strCommunity+">"+teasession._strCommunity);
            } else
            {
              out.print("<input type='hidden' name=new value=ON><input name=community size=40 maxlength=40>");

              %> 必须以英文字母开头的字母和数字组合！</td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Template")%>:</td>
            <td><select name="template">
            <option value="">-------------</option>
            <%
            java.util.Enumeration enumer=Template3.find();//ByCommunity(community);
            while(enumer.hasMoreElements())
            {
              Template3 temp_obj= Template3.find(((Integer)enumer.nextElement()).intValue());
              out.print("<option value="+temp_obj.getNode()+">"+temp_obj.getName());
            }
            %>
            </select>            </td>
          </tr>

          <%}%>

          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Type")%>:</td>
            <td><input  id="radio" type="radio" name=type value=0 <%if(j==0)out.print("checked");%>><%=r.getString(teasession._nLanguage, "CommunityTPrivate")%>
                <input  id="radio" type="radio" name=type value=1 <%if(j==1)out.print("checked");%>><%=r.getString(teasession._nLanguage, "CommunityTPublic")%>
                <input  id="radio" type="radio" name=type value=2 <%if(j==2)out.print("checked");%>><%=r.getString(teasession._nLanguage, "CommunityTJoin")%> </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Status")%>:</td>
            <td>
            <select name="state">
            <%
            for(int i=0;i<Community.STATE_TYPE.length;i++)
            {
              out.print("<option value="+i);
              if(i==state)out.print(" selected='true'");
              out.print(">"+Community.STATE_TYPE[i]);
            }
            %>
            </select>            </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Name")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=Name value="<%=s2%>" size=40 maxlength=255>            </td>
          </tr>
          <tr>
            <td><%=r.getString(teasession._nLanguage, "WebName")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=WebName value="<%=webName%>" size=40 maxlength=40></td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Options")%>:</td>
            <td><input type="CHECKBOX" class="edit_input"  name=regmap value="true"  <%if(regmap)out.print(" checked ");%> size=40 maxlength=40><%=r.getString(teasession._nLanguage, "Regmap")%>
            <input type="CHECKBOX" class="edit_input"  name=publicity value="true"  <%if(publicity)out.print(" checked ");%> size=40 maxlength=40><%=r.getString(teasession._nLanguage, "公开")%>
            <input  id="CHECKBOX" type="CHECKBOX" name="regmail" value="checkbox" <%if(regMail)out.print(" checked ");%>><%=r.getString(teasession._nLanguage, "RegMail")%>            </td>
          </tr>
          <tr>
          	<td nowrap><%=r.getString(teasession._nLanguage,"SmallMap") %></td><!--小图 -->
          	<td><input type="file" name="smallmap">
	    	<%
	    		if(maplen>0)
                {System.out.println(smallmap);
                  out.print("<a href="+smallmap+" target=\"_blank\" >");
                  out.print(maplen);
                  out.print("</a>");
                  out.print(r.getString(teasession._nLanguage,"Bytes")+"<input type=CHECKBOX name=clear onClick=foEdit.smallmap.disabled=this.checked;>"+r.getString(teasession._nLanguage,"Clear"));
                }
                %>          	</td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=Email value="<%=email%>" size=40 maxlength=40></td>
              </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "SmtpServer")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=Smtp value="<%=smtp%>" size=40 maxlength=40></td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "SmtpName")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=SmtpName value="<%=SmtpName%>" size=40 maxlength=40></td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "SmtpUser")%>:</td>
            <td><input type="TEXT" class="edit_input"  name=SmtpUser value="<%=SmtpUser%>" size=40 maxlength=40></td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "SmtpPassword")%>:</td>
            <td><input type="Password" class="edit_input"  name=SmtpPassword value="<%=SmtpPassword%>" size=40 maxlength=40></td>
          </tr>

          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Term")%>:</td>
            <td><textarea name="Term" rows=8 cols=70 class="edit_input"><%=HtmlElement.htmlToText(s4)%></textarea>            </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Welcome")%>:</td>
            <td><textarea name="Welcome" rows="8" cols="70" class="edit_input"><%=HtmlElement.htmlToText(s6)%></textarea>            </td>
          </tr>
          <tr>
            <td nowrap>CSS:</td>
            <td><textarea name="css" rows="8" cols="70" class="edit_input"><%=css%></textarea>            </td>
          </tr>
          <tr>
        <td nowrap> </td>
        <td><input type="button" name="Pictureview" id="Pictureview" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/jsp/section/InsertPicture.jsp?community=<%=teasession._strCommunity%>', '_blank');"></td>
      </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Filtrate")%>:</td>
            <td><textarea name="filtrate" rows="8" cols="70" class="edit_input"><%=HtmlElement.htmlToText(filtrate)%></textarea>            </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "MailBefore")%>:</td>
            <td><textarea name="mailbefore" rows="4" cols="70" class="edit_input"><%=HtmlElement.htmlToText(mailbefore)%></textarea>            </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "MailAfter")%>:</td>
            <td><textarea name="mailafter" rows="4" cols="70" class="edit_input"><%=HtmlElement.htmlToText(mailafter)%></textarea>            </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "JspBefore")%>:</td>
            <td><textarea name="jspbefore" rows="4" cols="70" class="edit_input"><%=HtmlElement.htmlToText(jspbefore)%></textarea>            </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "JspAfter")%>:</td>
            <td><textarea name="jspafter" rows="4" cols="70" class="edit_input"><%=HtmlElement.htmlToText(jspafter)%></textarea>            </td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Keywords")%>:</td>
            <td><textarea name="keywords" rows="2" cols="70" class="edit_input"><%=HtmlElement.htmlToText(keywords) %></textarea></td>
          </tr>
          <tr>
            <td nowrap><%=r.getString(teasession._nLanguage, "Synopsis")%>:</td><!-- 简介 -->
            <td><textarea name="synopsis" rows="4" cols="70" class="edit_input"><%=HtmlElement.htmlToText(synopsis) %></textarea></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input name="submit" class="edit_button"  type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
          </tr>
        </table>
</FORM>
<%
if(!flag)
{
   %>
   <table>
     <tr>
       <td><input onClick="window.open('/jsp/community/Attributes.jsp?community=<%=teasession._strCommunity%>');" name="submit" type="Button"  value="<%=r.getString(teasession._nLanguage, "EditAttribute")%>"></td>
       <td><input onClick="window.open('/jsp/community/CommunitySetSubscriber.jsp?community=<%=teasession._strCommunity%>');" name="submit" type="Button"  value="<%=r.getString(teasession._nLanguage, "CBSubscribers")%>"></td>
       <td><input onClick="window.open('/jsp/community/CommunitySetWeather.jsp?community=<%=teasession._strCommunity%>');" name="submit" type="Button"  value="<%=r.getString(teasession._nLanguage, "Weather")%>"></td>
       <td><input onClick="window.open('/jsp/community/EditCommunityjob.jsp?community=<%=teasession._strCommunity%>');" name="submit" type="Button"  value="<%=r.getString(teasession._nLanguage, "SetJob")%>"></td>
       <td><input onClick="window.open('/jsp/community/CommunitySetWeblog.jsp?community=<%=teasession._strCommunity%>');" name="submit" type="Button"  value="<%=r.getString(teasession._nLanguage, "SetBlog")%>"></td>
       <td><input onClick="window.open('/jsp/community/CommunitySetOther.jsp?community=<%=teasession._strCommunity%>');" name="submit" type="Button"  value="<%=r.getString(teasession._nLanguage, "SetOther")%>"></td>
       <td><input onClick="window.open('/jsp/netdisk/EditNetdiskEnterprise.jsp?community=<%=teasession._strCommunity%>');" name="submit" type="Button"  value="网盘设置"></td>
       <td><input onClick="window.open('/jsp/admin/popedom/AdminFunctions.jsp');" type="button"  value="<%=r.getString(teasession._nLanguage, "SetMenu")%>"></td>
       <td><input onClick="window.open('/jsp/admin/popedom/functionicon.jsp?community=<%=teasession._strCommunity%>');" type="button"  value="菜单图标管理"></td>
       <td><input onClick="window.open('/jsp/community/EditCLicense.jsp?community=<%=teasession._strCommunity%>');" type="button"  value="站点类别"></td>
       <td><input onClick="window.open('/jsp/template/Templates3.jsp?community=<%=teasession._strCommunity%>');" type="button"  value="站点模板设置"></td>
        <td><input onClick="window.open('/jsp/community/CommunityXml.jsp?community=<%=teasession._strCommunity%>');" type="button"  value="站点xml设置"></td>
        <td><input onClick="window.open('/jsp/integral/Integral.jsp?community=<%=teasession._strCommunity%>');" type="button"  value="站点积分设置"></td>
              <td><input onClick="window.open('/jsp/type/report/contributors/ContributorsIntegral.jsp?community=<%=teasession._strCommunity%>');" type="button"  value="投稿积分设置"></td>

     </tr>
   </table>
<%}%>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
