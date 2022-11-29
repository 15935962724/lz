<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%


%>
<style>
ul, li{list-style-type:disc;margin-top:10px;margin-bottom:2px;}
#tabletext td{font-size:12px;}
</style>

 <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
<table>
  <tr>
    <td><span><a href="javascript:f_open('?url=Templates');"><%=r.getString(lang,"fj12hq3u")%></a></span></td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=Styles');"><%=r.getString(lang,"fj12hq3v")%></a></span></td>
  </tr>
  <tr>
    <td id="li_te"><span><%=r.getString(lang,"fj12hq3w")%></span></td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=WindowsBoxs')"><%=r.getString(lang,"fj12hq41")%></a></span></td>
  </tr>
</table>

		</div>
		</div>
		<div id="edit_page2_wai_right">
		  <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq3w")%></span>
		  </div>



<div id="page2_w_r_e_p_style"></div>

<form name="form1" action="/servlet/EditCompanyWindows" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>" />
<input type="hidden" name="act" value="dns" />

<table width="600" border="0" cellpadding="0" cellspacing="0" id="tabletext">
  <tr>
    <td width="9%" height="30" align="center"><img src="/tea/image/eyp/images/ico_2.jpg" width="29" height="25" /></td>
    <td width="91%" align="left" style="border-bottom:1px solid #65A4D7;"><strong><%=r.getString(lang,"fj14p1y7")%>：</strong><font color="red"><%=r.getString(lang,"fj14p1y8")%></font></td>
  </tr>
  <tr>
    <td height="10" colspan="2" align="center"></td>
  </tr>
  <tr>
    <td colspan="2" align="right"><table width="100%" border="0" cellpadding="0" cellspacing="1" id="tablecenter">
      <tr>
        <td height="25" align="left"><%=r.getString(lang,"fj14p1y9")%>：</td>
        <td height="25" align="left"><%=community.getStartTimeToString()%> - <%=community.getStopTimeToString()%></td>
      </tr>
      <tr>
      <td align="left"><%=r.getString(lang,"fj14p1ya")%>：</td>
        <td align="left" style="padding-top:8px;padding-bottom:8px;"><font color="#FF0000"><%=r.getString(lang,"fj14p1yb")%></font> <br />
            <input name="year" type="text" size="3" style="height:15px;width:20px;" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"/><%=r.getString(lang,"fj14p1yk")%>&nbsp;<input type="submit" value="<%=r.getString(lang,"fj14p1yj")%>" />
        </td>
      </tr>
      <tr>
        <td height="45" align="left" bgcolor="#FFFFFF"><%=r.getString(lang,"fj14p1yc")%>：</td>
        <td align="left" bgcolor="#FFFFFF" style="padding-top:8px;padding-bottom:8px;line-height:150%;"><%=r.getString(lang,"fj14p1yd")%></td>
      </tr>
</table>

  <table width="600" border="0" cellpadding="0" cellspacing="0" id="tabletext">
    <tr>
      <td width="9%" height="30" align="center"><img src="/tea/image/eyp/images/ico_3.jpg" width="24" height="24" /></td>
      <td width="91%" align="left" style="border-bottom:1px solid #65A4D7;"><strong><%=r.getString(lang,"fj14p1ye")%></strong></td>
    </tr>
    <tr>
      <td height="10" colspan="2" align="center"></td>
    </tr>
    <tr>
      <td height="30" colspan="2" align="left"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="5%">&nbsp;</td>
          <td width="95%" style="padding:5px;"><%=r.getString(lang,"fj14p1yf")%></td>
        </tr>
      </table></td>
    </tr>
      <tr>
        <td colspan="2" align="right"><table width="100%" border="0" cellpadding="0" cellspacing="1" id="tablecenter">
          <tr>
            <td width="70%" height="25" align="center"><%=r.getString(lang,"fj14p1yg")%></td>
            <td width="30%" align="center"><%=r.getString(lang,"fj12hq4b")%></td>
          </tr>
          <%
          Enumeration e_dns=DNS.findByCommunity(teasession._strCommunity,teasession._nStatus);
          for(int j=1;e_dns.hasMoreElements();j++)
          {
            String dn=(String)e_dns.nextElement();
            //DNS dns=DNS.find(dn);
            out.print("<tr><td height=25 align=center>http://"+dn+"</td><td align=center>");
            if(j>1)
            {
              out.print("<a href=### onclick=\"f_open('?act=dns&domain="+java.net.URLEncoder.encode(dn,"UTF-8")+"&del=','"+r.getString(lang,"ConfirmDelete")+"');\"><img src=/tea/image/eyp/images/delet.jpg></a>");
            }
          }
          %>
        </table>
        </td>
    </tr>
    <tr>
      <td colspan="2" align="right">
          <table width="98%" border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td width="91%" height="30" align="center" bgcolor="#EEEEEE"><%=r.getString(lang,"fj14p1yh")%>：http://
                <input name="domain" type="text" size="25"/>
                  <input type="submit" name="add" value="<%=r.getString(lang,"fj14p1yi")%>" /></td>
            </tr>
          </table></td>
      </tr>
    </table>

</form>

</div>
  </div>
  <div id="edit_page2_bottom"></div>
