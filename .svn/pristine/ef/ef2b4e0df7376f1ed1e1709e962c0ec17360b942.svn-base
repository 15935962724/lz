<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<style>
#bjpd{border:0px;background-color:#fff;margin-left:30%}

</style>

<form action="/servlet/EditCompanyWindows" method="POST">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="act" value="template">

  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
<table>
  <tr>
    <td id="li_te"><span><%=r.getString(lang,"fj12hq3u")%></span> </td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=Styles');"><%=r.getString(lang,"fj12hq3v")%></a></span></td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=EditDNS');"><%=r.getString(lang,"fj12hq3w")%></a></span></td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=WindowsBoxs')"><%=r.getString(lang,"fj12hq41")%></a></span></td>
  </tr>
</table>

      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq3v")%></span>
    </div>



<div id="page2_w_r_e_p_style"></div>
<table id="huan_yif">
<%
String ss[]=new File(application.getRealPath("/tea/image/eyp/template/")).list();
for(int i=0;i<ss.length;i++)
{
  ss[i]=ss[i].substring(0,ss[i].length()-4);
  if(i%4==0)
  {
    out.print("<tr>");
  }
  out.print("<td><img src=/tea/image/eyp/img_template/"+i+".jpg><br><input type=radio name=radio value="+ss[i]);
  if(i==0||ss[i].equals(et))
  out.print(" checked");
  out.print(">"+ss[i]+"</td>");
}
%>
</table>
<input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" />

</div>
  </div>
  <div id="edit_page2_bottom"></div>

</form>
