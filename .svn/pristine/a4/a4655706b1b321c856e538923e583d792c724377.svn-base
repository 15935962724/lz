<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
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
 
int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count = Talkback.count(teasession._nNode);

String member = null;
if(teasession._rv!=null && teasession._rv._strR.length()>0)
{
  member = teasession._rv.toString();
}

String nexturl = request.getRequestURI()+"?node="+teasession._nNode+request.getContextPath();
%>


<script>
function f_submit1()
{
  if('<%=teasession._rv%>'=='null' && <%=( node.getOptions() & 0x8000)%>==0)
  {
     alert('请登录后发帖');
      foLogin.LoginId.focus();
    return false;
  }
  if(form1.subject.value=='')
  {
    alert('请填写主题.');
    form1.subject.focus();
    return false;
  }
  if(form1.content.value=='')
  {
    alert('请填写内容.');
    form1.content.focus();
       return false;
  }
  if(form1.vertify.value=='')
  {
	  alert("请填写验证码.");
	  form1.vertify.focus();
	  return false;
  }
}
function f_submit2()
{
  if(foLogin.LoginId.value=='')
  {
    alert('请填写用户名.');
    foLogin.LoginId.focus();
      return false;
  }
  if(foLogin.Password.value=='')
  {
    alert('请填写密码.');
    foLogin.Password.focus();
       return false;
  }
}
function f_submit_3()
{

  if(foLogin_2.yonghuming.value=='')
  {
    alert('请填写用户名.');
    foLogin_2.yonghuming.focus();
    return false;
  }
  if(foLogin_2.mima.value=='')
  {
    alert('请填写密码.');
    foLogin_2.mima.focus();
    return false;
  }
  sendx("/jsp/talkback/log_ajax.jsp?act=Talkbacks_f_submit_3&yonghuming="+foLogin_2.yonghuming.value+"&mima="+foLogin_2.mima.value,
  function(data)
  {

    if(data.trim()!='' && data.trim().length==18)
    {
       alert(data.trim());
    }else
    {
      document.getElementById("cancels").innerHTML=data.trim();
    }
  }
  );

}

</script>
  
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <%
    if(teasession._rv == null&&(node.getOptions() & 0x8000) == 0)
    {

      %>
      <FORM target="_parent" name="foLogin" METHOD="POST" action="/servlet/Login" onSubmit="return f_submit2();">
        <input type='hidden' name="nexturl" VALUE="<%=nexturl%>"/>
        <input type='hidden' name="community" VALUE="<%=teasession._strCommunity%>"/>
         <input type='hidden' name="Node" VALUE="<%=teasession._nNode%>"/>
      <td colspan="2"><span id="name">用户名：</span>&nbsp;<input type="text" name="LoginId">&nbsp;&nbsp;<span id="name">密码：</span>&nbsp;<input type="password" name="Password">&nbsp;&nbsp;<input type="submit" value="登录"/> </td>
      </form>
   <%
 }else if(teasession._rv!=null)
 {
   out.print("<td colspan=2>"+teasession._rv.toString()+"&nbsp;|&nbsp;<a id=\"cancels\" href=\"/servlet/Logout?community="+teasession._strCommunity+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"&node="+teasession._nNode+"\" target=\"_top\">退出</a></td>");

 }
   %>
    </tr>
    <FORM NAME="form1" METHOD=POST action="/servlet/EditTalkback" onsubmit="return f_submit1();">
    <INPUT type="hidden" name="node" value="<%=teasession._nNode%>">
   <input type='hidden' name='nexturl' value="<%=nexturl%>">
    <tr><td class="right"><%=r.getString(teasession._nLanguage, "Hint")%>:</td>
      <td class="left">
      <%
      for(int i=0;i<12;i++)
      {
        out.print("<input id=radio type=radio name=hint value="+i);
        if(0==i)
        {
          out.print(" checked ");
        }
        out.print("><img src=/tea/image/hint/"+i+".gif>");
      }
      %></td>
      </tr>
      <tr>
        <td class="right"><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
        <td class="left"><INPUT NAME="subject" TYPE=TEXT class="edit_input" VALUE="" SIZE=80 MAXLENGTH=255></td>
      </tr>
      <tr>
        <td class="right"><%=r.getString(teasession._nLanguage, "Content")%>:</td>
        <td class="left"><TEXTAREA id="status"   NAME="content" COLS=60 ROWS=8 class="edit_input" onkeydown='countChar("status","counter");' onkeyup='countChar("status","counter");'></TEXTAREA></td>
      </tr>
      <tr>
        <td class="right" rowspan="2"><%=r.getString(teasession._nLanguage, "验证码")%>:</td>
        <td class="left">您还可以输入<span id="counter">6000</span>个字</td>
      </tr>
       <tr>
        <td>
        <img src="/jsp/user/addValidate.jsp" id="vcodeImg" alt="Validate" align="absmiddle" class="CodeImg" onclick="reloadVcode();">&nbsp;
        <input type="TEXT"  name=vertify value="" size="5" />&nbsp;&nbsp;重新获取验证码 （注：请填入计算结果）
        </td>
      </tr>
      <script language="javascript">
         function reloadVcode()//点击更换验证码
         {
           var vcode = document.getElementById('vcodeImg');
           vcode.setAttribute('src','/jsp/user/addValidate.jsp?r='+Math.random());
         }
         function countChar(textareaName,spanName)//统计剩余字数
         {

           if(document.getElementById(textareaName).value.length > 6000){
             alert("对不起,您的字数已经超过6000");
             document.getElementById(spanName).innerHTML = 0;
           }else{
             document.getElementById(spanName).innerHTML = 6000 - document.getElementById(textareaName).value.length;
           }
         }
      </script>
      <tr>
      <td><input type="submit" value="提交"></td>
      <td>网友评论仅供网友表达个人看法，并不表明网站同意其观点或证实其描述</td>
      </tr>
      </form>
  </table>




