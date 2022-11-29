<%@page contentType="text/html;charset=UTF-8" %>
<%

String subject="",content="";
String goodstype=null,picture=null,no=null,spec=null,capability=null,email=null;
java.math.BigDecimal price=null;
if(n.getType()!=34)
{
  node=father34;
}else
{
  subject=n.getSubject(lang);
  content=n.getText(lang);

  Goods goods=Goods.find(node);
  goodstype=goods.getGoodstype();
  no=goods.getNo();
  price=goods.getPrice();
  spec=goods.getSpec(lang);
  picture=goods.getSmallpicture(lang);
  capability=goods.getCapability(lang);
}

%>
<script src="/tea/GoodsType.js"></script>
<script>
function f_submit()
{
  form34.goodstype.value="/"+form34.goodstype0.value+"/"+form34.goodstype1.value+"/";
  return submitText(form34.subject,'<%=r.getString(lang, "InvalidSubject")%>')
  &&submitText(form34.father,'<%=r.getString(lang, "fj12hq4w")+"-"+r.getString(lang, "fj12hq4m")%>')
  &&submitText(form34.goodstype,'<%=r.getString(lang, "fj12hq4w")+"-"+r.getString(lang, "fj0vgqwq")%>');
}
</script>
<form name="form34" action="/servlet/EditGoods" method="post" enctype="multipart/form-data" onsubmit="return f_submit()">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="goodstype">

  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

<table>
  <tr>
    <td><span><a href="javascript:f_open('?url=Goodss')"><%=r.getString(lang,"fj0vgqxc")%></a></span> </td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=GoodsCategory')"><%=r.getString(lang,"fj0vgqxd")%></a></span> </td>
  </tr>
  <tr>
    <td id="li_te"><span><%=r.getString(lang,"fj0vgqxe")%></span> </td>
  </tr>
</table>

      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj0vgqxe")%></span>
    </div>

    <div id="page2_w_r_e_p_style"></div>


<table  cellspacing="0" cellpadding="0" id="page2_w_r_e_P_table2">
<!--产品名称-->
  <tr>
    <td width="67" id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4k")%></td>
    <td><input id="input_text" name="subject" type="text" value="<%if(subject!=null)out.print(subject);%>"></td>
  </tr>
  <!--产品图片-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4l")%></td>
    <td><input id="input_text" name="smallpicture" type="file"></td>
  </tr>
  <!--自定义类别-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4m")%></td>
    <td>
      <select id="input_text" name="father">
      <option value="">-----------------------------------</option>
      <%
      Enumeration e34=Node.find(" AND father="+folder34+" AND type=1",0,200);
      while(e34.hasMoreElements())
      {
        int id34=((Integer)e34.nextElement()).intValue();
        out.print("<option value="+id34);
        if(id34==n.getFather())
        out.print(" selected");
        out.print(">"+Node.find(id34).getSubject(lang));
      }
      %>
      </select>
    </td>
  </tr>
  <!--所属行业-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj0vgqwq")%></td>
    <td><script>selectgt("goodstype0","goodstype1",null,"<%=goodstype%>");</script></td>
  </tr>
  <!--产品编号-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4n")%></td>
    <td><input id="input_text"  name="no" type="text" value="<%if(no!=null)out.print(no);%>"></td>
  </tr>
  <!--规　　格-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4o")%></td>
    <td><input  id="input_text" name="spec" type="text" value="<%if(spec!=null)out.print(spec);%>"></td>
  </tr>
  <!--定　　价-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4p")%></td>
    <td><input  id="input_text" name="price" type="text" value="<%if(price!=null)out.print(price);%>"></td>
  </tr>
  <!--供货能力-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4q")%></td>
    <td><input  id="input_text" name="capability" type="text" value="<%if(capability!=null)out.print(capability);%>"></td>
  </tr>
  <!--产品说明-->
  <tr>
    <td id="page2_w_r_e_P_table2_left"><%=r.getString(lang,"fj12hq4r")%></td>
    <td>
      <textarea name="content" cols="" rows="" style="display:none"><%if(content!=null)out.print(content.replaceAll("</","&lt;/"));%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=Home" width="400" height="300" frameborder="no" scrolling="no"></iframe>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
  </tr>
</table>


<div id="page2_w_r_e_P_div"></div>


</div>
  </div>
  <div id="edit_page2_bottom"></div>

</form>
<script>
form34.subject.focus();
</script>
