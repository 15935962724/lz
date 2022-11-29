<%@page contentType="text/html;charset=UTF-8" %>
<script type="">
alert('<%
if(tea.entity.member.Profile.isExisted(request.getParameter("member")))
{
  out.print("对不起，已经存在.");
}else
  out.print("恭喜，不存在.");
%>');
</script>


<form action="" name="form1" method="POST" >
  <input type="hidden" name="member" value=""/>
  </form>

