<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
 

TeaSession teasession = new TeaSession(request);

Node node=Node.find(teasession._nNode); 
   

Resource r = new Resource("/tea/ui/node/talkback/Talkbacks");
boolean flag1 = node.isCreator(teasession._rv);
boolean bool2=(teasession._rv != null && (flag1 || teasession._rv.isOrganizer(node.getCommunity()) || teasession._rv.isWebMaster()||teasession._rv.isManager(node.getCommunity())));

String member = "";
if(teasession._rv!=null && teasession._rv._strR.length()>0)
{
  member = teasession._rv.toString();
}

 

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = request.getRequestURI()+"?node="+teasession._nNode+request.getContextPath();

%><html>

<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">


<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body>
<script>
function f_submit1()
{

  if(form1.content.value=='')
  {
    alert('请填写内容.');
    form1.content.focus();
       return false;
  }
}
</script>
<h1><%=r.getString(teasession._nLanguage,"评论话题:<a href=\"/html/report/"+teasession._nNode+"-"+teasession._nLanguage+".htm\" target=\"top\">"+node.getSubject(teasession._nLanguage))%></a></h1>

 

  
    
    <FORM NAME="form1" METHOD=POST action="/servlet/EditTalkback" onSubmit="return f_submit1();">
    <INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
   <input type='hidden' name='nexturl' value="<%=nexturl%>">
   <input type='hidden' name='act' value="TalkbackAdmin">
   
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
    <tr><td align="right" nowrap="nowrap"><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
      <td>
      <%
      for(int i=1;i<7;i++)
      {
        out.print("<input id=radio type=radio name=hint value="+i);
        if(1==i)
        { 
          out.print(" checked ");
        }
    	out.print(">");
        out.print("<img src=/tea/image/hint/"+i+".gif");
        out.print(" style=cursor:pointer title="+Talkback.getHintString(i,teasession._nLanguage));
        out.print(">");
      }
      %></td>
      </tr>
      <tr id="table_main" style="display:none">
        <td align="right"><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
        <td><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="主题" SIZE=80 MAXLENGTH=255></td>
      </tr>
      <tr>
        <td align="right"><%=r.getString(teasession._nLanguage, "Content")%>:</td>
        <td><TEXTAREA id="status"   NAME="content" COLS=60 ROWS=8 class="edit_input" onkeydown='countChar("status","counter");' onkeyup='countChar("status","counter");'></TEXTAREA></td>
      </tr>
      
      <tr>
      <td colspan="2" align="center"><input type="submit" value="提交"></td>

      </tr>
      </form>
  </table>

</body>

</html>
