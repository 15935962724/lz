<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl = teasession.getParameter("nexturl");
String community = teasession.getParameter("community");
int membertype=0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype= Integer.parseInt(teasession.getParameter("membertype"));
}
 MemberType obj = MemberType.find(membertype);


%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff">
<script type="text/javascript">
function f_avove(obj,i)
{
    if(form1.above.checked&&form1.lowers.checked)
    {
      obj.checked=false;
      alert('不能重复选择同一个选项！');
      return false;
    }
    if(form1.above[i].checked&&form1.lowers[i].checked)
    {
      obj.checked=false;
      alert('不能重复选择同一个选项！');
      return false;
    }
}

function f_sbumit()
{
  if(form1.membername.value=='')
  {
    alert("请填写会员类型名称");
    return false;
  }
  if(form1.role.value==0)
  {
    alert("请选择对应角色！");
    return false;
  }

}
</script>
<h1>会员类型创建</h1>
<form action="/servlet/EditMemberType" name="form1" onsubmit="return f_sbumit(this);" >
<input type="hidden" name="act" value="EidtMemberType"/>
<input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl")%>">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td>会员类型名称</td>
    <td><input type="text" name="membername" value="<%if(obj.getMembername()!=null)out.print(obj.getMembername());%>"/></td>
  </tr>

  <tr>
    <td>对应角色</td>
    <td>
      <select name="role" >
      <option value="0">------------------</option>
       <%
       java.util.Enumeration ar_enumer= AdminRole.find1ByCommunity(teasession._strCommunity,teasession._nStatus);
       for(int intCount=1;ar_enumer.hasMoreElements();intCount++)
       {
         int id=((Integer)ar_enumer.nextElement()).intValue();
         AdminRole ar_obj=AdminRole.find(id);
            out.print("<option value="+id);
            if(String.valueOf(id).equals(obj.getRole()))
               out.print(" selected");
            out.print(">"+ar_obj.getName());
            out.print("</option>");
          }
       %>
      </select>&nbsp;&nbsp;
      <input type="checkbox" name="roletype" value="1"  <%if( obj.getRoleType()==1)out.print(" checked");%>>&nbsp;&nbsp; 审核时候是否选择角色
    </td>
  </tr>
  <tr>
    <td>基于此会员</td>
    <td>
   <%
      java.util.Enumeration e2 = MemberType.find(teasession._strCommunity," and membertype!="+membertype,0,Integer.MAX_VALUE);
       out.print("  <input name=\"above\" type=\"radio\" value=0 >不给予会员" );
      for(int i=0;e2.hasMoreElements();i++)
      {
         int myid =((Integer)e2.nextElement()).intValue();
         MemberType myobj = MemberType.find(myid);
        out.print("  <input name=\"above\" type=\"radio\" value="+myid+" onclick=f_avove(this,"+i+");" );
        if(obj.getAbove()== myid)
        {
          out.print(" checked = true ");
        }

         out.print(" />"+myobj.getMembername()+"&nbsp;&nbsp;");
      }
   %>
    </td>
  </tr>
  <tr>
    <td>包含于此会员</td>
    <td>
       <%
      java.util.Enumeration e3 = MemberType.find(teasession._strCommunity," and membertype!="+membertype,0,Integer.MAX_VALUE);
      if(!e3.hasMoreElements())
      {
        out.print("暂没有记录");
      }
      for(int i=0;e3.hasMoreElements();i++)
      {
         int myid3 =((Integer)e3.nextElement()).intValue();
         MemberType myobj3 = MemberType.find(myid3);


          out.print("  <input name=\"lowers\" type=\"checkbox\" value="+myid3+" onclick=f_avove(this,"+i+");");
         if(obj.getLowers()!=null && obj.getLowers().length()>0){
           if(obj.getLowers().indexOf("/"+myid3+"/")!=-1){
             out.print(" checked=true");
           }
         }
         out.print(" />"+myobj3.getMembername()+"&nbsp;&nbsp;");
      }
   %>
  </td>
  </tr>
  <tr>
    <td>注册成功后台跳转路径</td>
    <td><input name="fileurl" type="text" value="<%if(obj.getFileurl()!=null && obj.getFileurl().length()>0){out.print(obj.getFileurl());}%>" size="40"  /> </td>
  </tr>

  <tr>
    <td>说明文字</td>
    <td>
      <textarea cols="60" rows="4" name="caption"> <%if( obj.getCaption()!=null)out.print( obj.getCaption());%></textarea>
      </td>
  </tr>

  <tr>
    <td>是否邮件认证</td>
    <td><input type="checkbox" name="appemail" value="1" <%if(obj.getAppemail()==1)out.print("  checked=\"checked\" ");%>></td>
  </tr>

  <tr>
    <td>是否自动跳转</td>
    <td>
      <input name="skips" type="radio" value="0" <%if(obj.getSkips()==0)out.print(" checked=\"checked\"");%> />否&nbsp;
      <input name="skips" type="radio" value="1" <%if(obj.getSkips()==1)out.print(" checked=\"checked\"");%>/>是
    </td>
  </tr>
  <tr>
    <td colspan="2"><input type="submit" value="提交"/>&nbsp;&nbsp; <input type=button value="返回" onClick="javascript:history.back()"></td>

  </tr>
</table>

</form>


</body>
</html>
