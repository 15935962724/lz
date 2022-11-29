<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%

int category=c.getCategory(lang);
String product=c.getProduct(lang),principal=c.getPrincipal(lang),birth=c.getBirth(lang),brand=c.getBrand(lang);

%>

<form name="form1" action="/servlet/EditCompanyWindows" method="post" onsubmit="return submitText(this.category1,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqwq")%>')
&&submitText(this.product,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqws")%>')
&&submitText(this.city1,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqwr")%>')
&&submitText(this.enrol,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqwt")%>')
&&submitText(this.size,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqwu")%>')
&&submitText(this.principal,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqwv")%>')
&&submitText(this.property,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqww")%>')
&&submitText(this.birth,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj0vgqwx")%>')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="act" value="0">

  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj12hq4s")%></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany1')"><%=r.getString(lang,"fj12hq4t")%></a></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany2')"><%=r.getString(lang,"fj12hq4u")%></a></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany3')"><%=r.getString(lang,"fj12hq4v")%></a></span></td></tr>
        </table>
      </div>
    </div>

    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq4s")%></span>
    </div>

<div id="page2_w_r_e_p_style"></div>
 <table cellspacing="0" cellpadding="0" id="page2_w_r_e_Overview">
 <!--所属行业-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwq")%></td>
    <td>
    <%
//    StringBuffer sb=new StringBuffer();
//    Enumeration ec0=Node.findAllSons(2196661);
//    while(ec0.hasMoreElements())
//    {
//      int c0=((Integer)ec0.nextElement()).intValue();
//      out.print("<option value="+c0+">"+Node.find(c0).getSubject(lang));
//
//      Enumeration ec1=Node.findAllSons(c0);
//      while(ec1.hasMoreElements())
//      {
//        int c1=((Integer)ec1.nextElement()).intValue();
//        out.print("<option value="+c1+">"+Node.find(c1).getSubject(lang));
//      }
//    }
    %>
    <script src="/tea/Node_2196661.js" type="text/javascript"></script><script type="">selectnode("category0","category1",null,"<%if(category>0)out.print(Node.find(category).getPath());%>");</script>
    </td>
  </tr>
  <!--所属地区-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwr")%></td>
    <td><script src="/tea/card.js" type="text/javascript"></script><script type="">selectcard("city0","city1",null,"<%=c.getCity(lang)%>");</script></td>
  </tr>
  <!--主营业务-->
  <tr>
    <td width="55"  valign="top"><%=r.getString(lang,"fj0vgqws")%></td>
    <td><textarea name="product" cols="" rows=""><%if(product!=null)out.print(product);%></textarea></td>
  </tr>
  <!--注册资金-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwt")%></td>
    <td>
      <select name="enrol" id="text">
      <%
      for(int index=0;index<Company.ENROL_TYPE.length;index++)
      {
        out.print("<OPTION VALUE="+index);
        if(index==c.getEnrol(lang))
        out.print(" SELECTED ");
        out.print(">"+Company.ENROL_TYPE[index]);
      }
      %>
      </select>
    </td>
  </tr>
  <!--企业规模-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwu")%></td>
    <td>
      <SELECT NAME="scale" id="text">
      <%
      for(int index=0;index<Company.SIZE_TYPE.length;index++)
      {
        out.print("<OPTION VALUE="+index);
        if(index==c.getScale(lang))
        out.print(" SELECTED ");
        out.print(">"+Company.SIZE_TYPE[index]);
      }
      %>
      </SELECT>
    </td>
  </tr>
  <!--法人代表-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwv")%></td>
    <td><input name="principal" type="text" id="text" value="<%if(principal!=null)out.print(principal);%>"></td>
  </tr>
  <!--企业性质-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqww")%></td>
    <td>
      <select name="property" >
      <%
      for(int index=0;index<Company.PROPERTY_TYPE.length;index++)
      {
        out.print("<OPTION VALUE="+index);
        if(index==c.getProperty(lang))
        out.print(" SELECTED ");
        out.print(">"+Company.PROPERTY_TYPE[index]);
      }
      %></select>
    </td>
  </tr>
  <!--建立时间-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqwx")%></td>
    <td><input name="birth" type="text" id="text" value="<%if(birth!=null)out.print(birth);%>"></td>
  </tr>
  <!--经营品牌-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj0vgqxb")%></td>
    <td><input name="brand" type="text" id="text" value="<%if(brand!=null)out.print(brand);%>"></td>
  </tr>
  <tr>
    <td width="55"></td>
    <td align="center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
  </tr>
</table>


</div>
</div>
<div id="edit_page2_bottom"></div>

</form>
