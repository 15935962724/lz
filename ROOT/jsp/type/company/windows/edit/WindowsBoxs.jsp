<%@page contentType="text/html;charset=UTF-8" %>
<%


%>
<style>
#bjpd input{background-color:#fff;border:0px;float:left;}
#tu img{border:1px solid #a3a3a3;}
#kong{padding-left:12px;}
#mingz{margin-top:3px;width:110px;}
#nav_edit{display:none;}
</style>

<form name="form1" action="/servlet/EditCompanyWindows" method="post" >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="nexturl" value="<%=nu%>">
  <input type="hidden" name="act" value="windowsbox">
  <div id="edit_page2" width="100%">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr>
            <td><span><a href="javascript:f_open('?url=Templates');"><%=r.getString(lang,"fj12hq3u")%></a></span> </td>
          </tr>
          <tr>
            <td><span><a href="javascript:f_open('?url=Styles');"><%=r.getString(lang,"fj12hq3v")%></a></span></td>
          </tr>
          <tr>
            <td><span><a href="javascript:f_open('?url=EditDNS');"><%=r.getString(lang,"fj12hq3w")%></a></span></td>
          </tr>
          <tr>
            <td id="li_te"><span><%=r.getString(lang,"fj12hq41")%></span></td>
          </tr>
        </table>
      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq41")%></span> </div>
      <div id="page2_w_r_e_p_style"></div>
      <table  cellspacing="0" cellpadding="0" width="90%" style="margin-left:7%;margin-top:10px;margin-bottom:10px;" id="bjpd">
        <tr> </tr>
        <tr>
          <td width="200" id="tu"><img src="/res/lib/u/0806/080625468.jpg" /></td>
          <td width="200" id="tu"><img src="/res/lib/u/0806/080625475.jpg" /></td>
          <td width="200" id="tu"><img src="/res/lib/u/0806/080625476.jpg" /></td>
        </tr>
        <tr><td colspan="3" height="10"></td></tr>
        <tr>
  <td><input name="hidden18" type="checkbox" value="" />
          <input name="name18" type="text" value="<%=wbs[18].getName(lang)%>" id="mingz"/></td>
      <td><input type="checkbox" name="hidden14" value="checkbox" />
          <input name="name14" type="text" value="<%=wbs[14].getName(lang)%>" id="mingz"/></td>
    <td><input name="hidden19" type="checkbox" value="" />
          <input name="name19" type="text" value="<%=wbs[19].getName(lang)%>" id="mingz"/></td>
  </tr>
  <tr>
    <td id="kong"><input name="hidden5" type="checkbox" value="" />
        <input name="name5" type="text" value="<%=wbs[5].getName(lang)%>" id="mingz"/></td>
    <td id="kong"><input type="checkbox" name="hidden0" value="checkbox" />
        <input name="name0" type="text" value="<%=wbs[0].getName(lang)%>" id="mingz"/></td>
    <td id="kong"><input name="hidden3" type="checkbox" value="" />
        <input name="name3" type="text" value="<%=wbs[3].getName(lang)%>" id="mingz"/></td>
  </tr>
  <tr>
    <td id="kong"><input name="hidden6" type="checkbox" value="" />
        <input name="name6" type="text" value="<%=wbs[6].getName(lang)%>" id="mingz"/></td>
    <td id="kong">&nbsp;</td>
    <td id="kong"><input name="hidden1" type="checkbox" value="" /><input name="name1" type="text" value="<%=wbs[1].getName(lang)%>" id="mingz"/></td>
  </tr>
  <tr>
    <td id="kong"></td>
    <td id="kong">&nbsp;</td>
    <td id="kong"><input name="hidden2" type="checkbox" value="" />
        <input name="name2" type="text" value="<%=wbs[2].getName(lang)%>" id="mingz"/></td>
  </tr>


  <tr>
    <td>&nbsp;&nbsp;</td>
    <td>&nbsp;</td>
    <td id="kong"><input name="hidden7" type="checkbox" value="" />
        <input name="name7" type="text" value="<%=wbs[7].getName(lang)%>" id="mingz"/></td>
  </tr>
  <tr>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td id="tu"><img src="/res/lib/u/0806/080625477.jpg" /></td>
    <td id="tu"><img src="/res/lib/u/0806/080626147.jpg" /></td>
    <td id="tu"><img src="/res/lib/u/0806/080626150.jpg" /></td>
  </tr>
  <tr><td colspan="3" height="10"></td></tr>
  <tr>
    <td><input type="checkbox" name="hidden9" value="checkbox" />
      <input name="name9" type="text" value="<%=wbs[9].getName(lang)%>" id="mingz"/></td>
      <td><input type="checkbox" name="hidden20" value="checkbox" />
        <input name="name20" type="text" value="<%=wbs[20].getName(lang)%>" id="mingz"/></td>
        <td><input name="hidden4" type="checkbox" value="" />
          <input name="name4" type="text" value="<%=wbs[4].getName(lang)%>" id="mingz"/></td>
  </tr>
  <tr>
    <td></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="200" id="tu"><img src="/res/lib/u/0806/080637577.jpg" /></td>
    <td width="200" id="tu"><img src="/res/lib/u/0806/080637578.jpg" /></td>
    <td width="200" id="tu"><img src="/res/lib/u/0806/080637579.jpg" /></td>
  </tr>
  <tr><td colspan="3" height="10"></td></tr>
  <tr>
    <td height="20"><input type="checkbox" name="hidden15" value="checkbox" />
      <input name="name15" type="text" value="<%=wbs[15].getName(lang)%>" id="mingz"/>
    </td>

    <!--    <td><input type="checkbox" name="hidden16" value="checkbox" />
      <input name="name16" type="text" value="<%=wbs[16].getName(lang)%>" id="mingz"/>
</td>
-->
<td><input type="checkbox" name="hidden17" value="checkbox" />
  <input name="name17" type="text" value="<%=wbs[17].getName(lang)%>" id="mingz"/>
</td>
  </tr>
  <tr>
    <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
  </tr>
  <tr>
     <td>&nbsp;</td><td align="center" style="clear:both;"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td> <td>&nbsp;</td>
  </tr>
</table>
    </div>
  </div>
  <div id="edit_page2_bottom"></div>
</form>
<script>
<%
for(int i=0;i<wbs.length;i++)
{
  out.print("try{form1.hidden"+i+".checked=!"+wbs[i].isHidden()+";}catch(e){}");
}
%>
</script>
