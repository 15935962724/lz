<%@page contentType="text/html;charset=UTF-8" %><%


String product=c.getProduct(lang),principal=c.getPrincipal(lang),birth=c.getBirth(lang),brand=c.getBrand(lang);
int category=c.getCategory(lang);
int city=c.getCity(lang);
%>

<div id="page2">
  <div id="page2_wai_left">
    <div id="page2_left">

<div id="page2_left_top"><%=wbs[19].getName(lang)%></div>
<ul>
  <li><a href="?community=<%=como%>&url=ViewCompany0" style="color:#0C419A"><%=wbs[2].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany1"><%=wbs[1].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany2"><%=wbs[3].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany3"><%=wbs[7].getName(lang)%></a></li>
</ul>
</div>
</div>

<div id="page2_wai_right">
  <div id="page2_right">
    <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[2].getName(lang)%></font></div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=r.getString(lang,"fj0vgqw8")%><!--公司概况--></font></div>
  </div>


 <table cellspacing="0" cellpadding="0" id="page2_w_r_e_Overview">
 <!--所属行业-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwq")%></td>
    <td><%if(category>0)out.print(Node.find(category).getSubject(lang));%></td>
  </tr>
  <!--所属地区-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwr")%></td>
    <td><%if(city!=0)out.print(Card.find(city).toString());%></td>
  </tr>
  <!--主营业务-->
  <tr>
    <td width="55"  valign="top"><%=r.getString(lang,"fj0vgqws")%></td>
    <td><%if(product!=null)out.print(product);%></td>
  </tr>
  <!--注册资金-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwt")%></td>
    <td><%=Company.ENROL_TYPE[c.getEnrol(lang)]%></td>
  </tr>
  <!--企业规模-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwu")%></td>
    <td><%=Company.SIZE_TYPE[c.getScale(lang)]%></td>
  </tr>
  <!--法人代表-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwv")%></td>
    <td><%if(principal!=null)out.print(principal);%></td>
  </tr>
  <!--企业性质-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqww")%></td>
    <td><%=Company.PROPERTY_TYPE[c.getProperty(lang)]%></td>
  </tr>
  <!--建立时间-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwx")%></td>
    <td><%if(birth!=null)out.print(birth);%></td>
  </tr>
  <!--经营品牌-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqxb")%></td>
    <td><%if(brand!=null)out.print(brand);%></td>
  </tr>
</table>


</div>
</div>
<div id="page2_bottom"></div>


