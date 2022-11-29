<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/include/Header.jsp"%>
<%
if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv._strV);
  if (!node.isCreator(teasession._rv)&&!obj_am.isProvider(75))
  {
    response.sendError(403);
    return;
  }
}
r.add("/tea/resource/Environmental");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Environmental")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
	<form name="theform" method="post" action="/servlet/EditEnvironmental" OnSubmit="return( submitText(this.Subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.polyname, '<%=r.getString(teasession._nLanguage, "PolyName")%>')&&submitText(this.Text, '<%=r.getString(teasession._nLanguage, "PloyCon")%>') )" >
<%
          String parameter=teasession.getParameter("nexturl");
          boolean   parambool=(parameter!=null&&!parameter.equals("null"));
          if(parambool)
          out.print("<input type='hidden' name=nexturl value="+parameter+">");
          String text,subject,address,postalcode,phone,fax,polyname,ployadd,ploytime,ploycon,ploy,point,object,vemark[],sponsor,vouchname,vouchcom,vouchduty,vouchtele,comm,comtele,conname,vouch;
          int type=0;
          boolean classes=false;
          java.math.BigDecimal moneycount;
          if(request.getParameter("NewNode")!=null)
          {
            vemark=new String[7];
            java.util.Arrays.fill(vemark,"");
            text=subject=address=postalcode=phone=fax=polyname=ployadd=ploytime=ploycon=ploy=point=object=sponsor=vouchname=vouchcom=vouchduty=vouchtele=comm=comtele=conname=vouch="";
            moneycount=new java.math.BigDecimal(0D);
            out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
          }else
          {
            text=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage));
            subject=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
            tea.entity.node.Environmental obj=tea.entity.node.Environmental.find(teasession._nNode,teasession._nLanguage);
            address=obj.getAddress();
            postalcode=obj.getPostalcode();
            phone=obj.getPhone();
            fax=obj.getFax();
            polyname=obj.getPolyName();
            type=obj.getType();
            ployadd=obj.getPloyAdd();
            ploytime=obj.getPloyTime("yyyy-MM-dd");
            ploycon=tea.html.HtmlElement.htmlToText(obj.getPloyCon());
            ploy=tea.html.HtmlElement.htmlToText(obj.getPloy());
            point=tea.html.HtmlElement.htmlToText(obj.getPoint());
            object=tea.html.HtmlElement.htmlToText(obj.getObject());
            vemark=obj.getVemark();
            sponsor=obj.getSponsor();
            vouchname=obj.getVouchName();
            vouchcom=obj.getVouchCom();
            vouchduty=obj.getVouchDuty();
            vouchtele=obj.getVouchTele();
            comm=obj.getComm();
            comtele=obj.getComTele();
            conname=obj.getConName();
            vouch=obj.getVouch();
            classes=obj.isClasses();
          }
            %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
                         <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                            <tbody>

                                    <tr>
                                      <td><%=r.getString(teasession._nLanguage,"Subject")%>：</td>
                                      <td colspan="3"> <input name="Subject" value="<%=subject%>" type="text" class=text  maxlength="20">
                                        <span class="text2">**</span> </td>
                                    </tr>
                                    <tr>
                                      <td><%=r.getString(teasession._nLanguage,"Classes")%>：</td>
                                      <td colspan="3">
                                        <input  id="radio" type="radio" name="classes" value="false" checked>
                                        <%=r.getString(teasession._nLanguage,"Individual")%>
                                        <input  id="radio" type="radio" name="classes" <%if(classes)out.print(" checked ");%> value="true">
                                        <%=r.getString(teasession._nLanguage,"Collectivity")%> </td>
                                    </tr>
                                    <tr>
                                      <td><%=r.getString(teasession._nLanguage,"Address")%>：</td>
                                      <td> <input name="address" value="<%=address%>" type="text" id="Address2" size="14" maxlength="100">
                                      </td>
                                      <td><%=r.getString(teasession._nLanguage,"Postalcode")%>：</td>
                                      <td><input name="postalcode" value="<%=postalcode%>" type="text" id="Postalcode2" size="6" maxlength="100">
                                      </td>
                                    </tr>
                                    <tr>
                                      <td><%=r.getString(teasession._nLanguage,"Phone")%>：</td>
                                      <td><input name="phone" value="<%=phone%>" type="text" id="Phone2" size="14" maxlength="15">
                                      </td>
                                      <td><%=r.getString(teasession._nLanguage,"Fax")%>：</td>
                                      <td><input name="fax" value="<%=fax%>" type="text" id="Fax2" size="16"></td>
                                    </tr>
                                    <tr>
                                      <td><%=r.getString(teasession._nLanguage,"PolyName")%>：</td>
                                      <td> <input name="polyname" value="<%=polyname%>" type="text" id="Polyname2" size="14" maxlength="50">
                                        <span class="text2">**</span></td>
                                      <td><%=r.getString(teasession._nLanguage,"Type")%>： </td>
                                      <td><select name="type" id="select2">
                                          <option value="0" selected>-----------</option>
<%
for(int index=1;index<=tea.entity.node.Environmental.ENVIRONMENTAL_TYPE.length;index++)
{
  out.print("<option value="+index);
  if(type==index)
  out.print(" selected ");
  out.print(">"+tea.entity.node.Environmental.ENVIRONMENTAL_TYPE[index-1]+"</option>");
}
%>                                        </select> </td>
                                    </tr>
                                    <tr>
                                      <td><%=r.getString(teasession._nLanguage,"PloyAdd")%> </td>
                                      <td><input name="ployadd" value="<%=ployadd%>" type="text" id="Ployadd2" size="14" maxlength="100">
                                      </td>
                                      <td><%=r.getString(teasession._nLanguage,"PloyTime")%><br>
                                        如：2003-03-03 </td>
                                      <td><input name="ploytime" value="<%=ploytime%>" type="text" id="Ploytime2" size="16">
                                      </td>
                                    </tr>
                                    <tr valign="top">
                                      <td colspan="4"> <p><font size=2>1.</font><%=r.getString(teasession._nLanguage,"PloyCon")%><br>

                                          <textarea name="Text" cols="50" rows="3" id="textarea22"><%=text%></textarea>
                                          <span class="text2">**</span></p></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4" valign="top">
                                        <p><font size=2></font>2.<%=r.getString(teasession._nLanguage,"Ploy")%><br>

                                          <textarea name="ploy" cols="50" rows="3" id="textarea23"><%=ploy%></textarea>
                                        </p></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4" valign="top">
                                        <p><font size=2></font>3.<%=r.getString(teasession._nLanguage,"Point")%>：<font size=2><br>

                                          <textarea name="point" cols="50" rows="3" id="textarea24"><%=point%></textarea>
                                          </font></p></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"> <p><font size=2></font>4.<%=r.getString(teasession._nLanguage,"Object")%><font size=2><br>

                                          <textarea name="object" cols="50" rows="3" id="textarea25"><%=object%></textarea>
                                          </font></p></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"><font size=2></font>5.<%=r.getString(teasession._nLanguage,"Vemark")%>：<font size=2><br>

                                        <textarea name="vemark" cols="50" rows="3" id="textarea26"><%=vemark[0]%></textarea>
                                        </font></td>
                                    </tr>
                                    <tr>
                                      <td rowspan="2"><font size=2></font>6.<%=r.getString(teasession._nLanguage,"Sponsor")%></td>
                                      <td colspan="3" valign="top"><input  id="radio" type="radio" name="alass" value="1" checked>
                                        <%=r.getString(teasession._nLanguage,"None")%></td>
                                    </tr>

                                    <tr>
                                      <td colspan="3" valign="top">
                                        <input  id="radio" type="radio" name="alass" value="0" <%if(sponsor.length()>0)out.print(" checked");%>>
                                        <%=r.getString(teasession._nLanguage,"Have")%> <%=r.getString(teasession._nLanguage,"Name")%>
                                        <input name="sponsor" value="<%=sponsor%>" type="text" id="sponsorname3" size="10">

										</td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"> <p><font size=2></font>7.<%=r.getString(teasession._nLanguage,"Vemark2")%><font size=2><br>

                                          <textarea name="vemark" cols="50" rows="3" id="textarea27"><%=vemark[1]%></textarea>
                                           </font></p></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"><font size=2></font>8.<%=r.getString(teasession._nLanguage,"Vemark3")%><font size=2><br>

                                        <textarea name="vemark" cols="50" rows="3" id="textarea28"><%=vemark[2]%></textarea>
                                        </font></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"><font size=2></font>9.<%=r.getString(teasession._nLanguage,"Vemark4")%>
                                        <br> <font size=2>&nbsp; </font><font size=2>

                                        <textarea name="vemark" cols="50" rows="3" id="textarea29"><%=vemark[3]%></textarea>
                                        </font><font size=2>&nbsp; </font></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"><div align="left"><font size=2></font>10.<%=r.getString(teasession._nLanguage,"Vemark5")%><font size=2><br>

                                          <textarea name="vemark" cols="50" rows="3" id="textarea30"><%=vemark[4]%></textarea>
                                          </font></div></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"><font
                  size=2></font>11.<%=r.getString(teasession._nLanguage,"Vemark6")%><font
                  size=2><br>

                                        <textarea name="vemark" cols="50" rows="3" id="textarea31"><%=vemark[5]%></textarea>
                                        </font></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4"> <p><font size=2></font>12.<%=r.getString(teasession._nLanguage,"Vemark7")%><font size=2><br>

                                          <textarea name="vemark" cols="50" rows="3" id="textarea32"><%=vemark[6]%></textarea>
                                           </font></p></td>
                                    </tr>
                                    <tr>
                                      <td colspan="4" class="border_color">推荐者情况：</td>
                                    </tr>
                                    <tr align="center" valign="top">
                                      <td colspan="4"> <table width="100%" border="1" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td align="left"> <%=r.getString(teasession._nLanguage,"Name")%>：　</td>
                                            <td>
                                              <input name="vouchname" value="<%=vouchname%>" type="text" id="Vouchname2" size="15">
                                            </td>
                                            <td width="67"><div align="left"><%=r.getString(teasession._nLanguage,"VouchCom")%>：</div></td>
                                            <td width="210"> <div align="left">
                                                <input name="vouchcom" value="<%=vouchcom%>" type="text" id="Vouchcom2" size="15">
                                              </div></td>
                                          </tr>
                                          <tr>
                                            <td><div align="left"><%=r.getString(teasession._nLanguage,"VouchDuty")%>：</div></td>
                                            <td><input name="vouchduty" value="<%=vouchduty%>" type="text" id="Vouchduty2" size="15"></td>
                                            <td><div align="left"><%=r.getString(teasession._nLanguage,"VouchTele")%>：</div></td>
                                            <td> <div align="left">
                                                <input name="vouchtele" value="<%=vouchtele%>" type="text" id="Vouchtele2" size="15">
                                              </div></td>
                                          </tr>
                                          <tr>
                                            <td><%=r.getString(teasession._nLanguage,"Comm")%>：</td>
                                            <td><input name="comm" value="<%=comm%>" type="text" id="Comm3" size="15"></td>
                                            <td><%=r.getString(teasession._nLanguage,"Phone")%>：</td>
                                            <td><input name="comtele" value="<%=comtele%>" type="text" id="Comtele3" size="15"></td>
                                          </tr>
                                          <tr>
                                            <td><%=r.getString(teasession._nLanguage,"Linkman")%>：</td>
                                            <td><input name="conname" value="<%=conname%>" type="text" id="Conname3" size="15"></td>
                                            <td></td>
                                            <td></td>
                                          </tr>
                                          <tr>
                                            <td><%=r.getString(teasession._nLanguage,"Vouch")%>：</td>
                                            <td><input name="vouch" value="<%=vouch%>" type="text" id="Vouch3" size="15"></td>
                                            <td></td>
                                            <td></td>
                                          </tr>

                                        </table></td>
                                    </tr>
                                  </table>
                              <tr>
                                <p align=center>
                                <td align=center valign="bottom" class="text">
                                  <input class="text" name=regin type=submit value=<%=r.getString(teasession._nLanguage,"Submit")%>>
                                  &nbsp;&nbsp;&nbsp;&nbsp; <input class="text" button name=B2 type=reset value=<%=r.getString(teasession._nLanguage,"Reset")%>>
                                  &nbsp;&nbsp;&nbsp;&nbsp;</td>
                                <p></p>
                              </tr>
                            </tbody>
                          </table>
                        </form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script>theform.Subject.focus();</script>

</body>
</html>

