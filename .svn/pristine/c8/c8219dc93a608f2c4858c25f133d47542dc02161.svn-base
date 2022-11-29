<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
            r.add("/tea/ui/node/access/PayAccess0");
            int i = 0;
            try
            {
                i = Integer.parseInt(request.getParameter("Shipping"));
            }
            catch(Exception _ex) { }
            int j = Integer.parseInt(request.getParameter("Currency"));
            String s = r.getString(teasession._nLanguage, Common.CURRENCY[j]);
            BigDecimal bigdecimal = new BigDecimal(request.getParameter("Price"));
            int k = 0;
            String s1 = null;
            if(i != 0)
            {
                Shipping shipping = Shipping.find(i);
                k = shipping.getPayMethod();
                s1 = shipping.getParameters();
            }
            Node node = Node.find(teasession._nNode);
            RV rv = node.getCreator();
            String s2 = request.getParameter("CouponCode");
            int l = 0;
            if(s2.length() != 0)
            {
                l = tea.entity.member.Coupon.find(teasession._strCommunity,rv._strR, j, 32768, s2);
                if(l == 0)
                {
                    out.print(r.getString(teasession._nLanguage, "InvalidCouponCode"));
                    return;
                }
            }
            BigDecimal bigdecimal1 = new BigDecimal(0.0D);
            if(l != 0)
            {
                if(CouponMember.count(l) != 0 && !CouponMember.isExisted(l, teasession._rv._strR))
                {
                    out.print(r.getString(teasession._nLanguage, "InvalidCouponMember"));
                    return;
                }
                Coupon coupon = Coupon.find(l);
                BigDecimal bigdecimal2 = coupon.getMinimum();
                BigDecimal bigdecimal3 = coupon.getDiscount();
                if(bigdecimal2.compareTo(bigdecimal) > 0)
                {
                    out.print(r.getString(teasession._nLanguage, "InvalidCouponMinimum"));
                    return;
                }
                switch(coupon.getType())
                {
                case 0: // '\0'
                    bigdecimal1 = bigdecimal3;
                    break;

                case 1: // '\001'
                case 2: // '\002'
                case 3: // '\003'
                    bigdecimal1 = bigdecimal.multiply(bigdecimal3);
                    break;
                }
                bigdecimal1 = bigdecimal1.negate().setScale(2, 4);
            }

%>

<html>
<head><link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>

<DIV ID="edit_BodyDiv">



  <%

            if(j == 0 && k == Shipping.PAYMETHOD_ITRANSACT)
            {
                Profile profile = Profile.find(rv._strR);
                Profile profile2 = Profile.find(teasession._rv._strR);
                Form form1 = new Form("foPay", "POST", "https://secure.itransact.com/cgi-bin/mas/split.cgi");
                form1.setOnSubmit("return(submitEmail(this.email,'" + r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + r.getString(teasession._nLanguage, "InvalidCity") + "')" + "&&submitText(this.state,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
                form1.add(new HiddenField("vendor_id", s1));
                form1.add(new HiddenField("home_page", "http://" + request.getServerName() + "/servlet/Node?node=" + teasession._nNode));
                form1.add(new HiddenField("mername", RequestHelper.makeName(teasession._nLanguage, profile.getFirstName(teasession._nLanguage), profile.getLastName(teasession._nLanguage))));
                form1.add(new HiddenField("acceptcards", "1"));
                form1.add(new HiddenField("altaddr", "0"));
                form1.add(new HiddenField("nonum", "1"));
                form1.add(new HiddenField("1-desc", RequestHelper.format(r.getString(teasession._nLanguage, "InfAccessRequest"), node.getSubject(teasession._nLanguage))));
                form1.add(new HiddenField("1-cost", bigdecimal.add(bigdecimal1)));
                form1.add(new HiddenField("1-qty", "1"));
                Table table = new Table("Billing Address");
                Row row1 = new Row(new Cell(new Text("First Name:"), true));
                Cell cell = new Cell(new TextField("first_name", profile2.getFirstName(teasession._nLanguage), 15));
                cell.add(new Text("Last Name:"));
                cell.add(new TextField("last_name", profile2.getLastName(teasession._nLanguage), 15));
                row1.add(cell);
                table.add(row1);
                Row row4 = new Row(new Cell(new Text("Address:"), true));
                row4.add(new Cell(new TextField("address", profile2.getAddress(teasession._nLanguage), 30)));
                table.add(row4);
                Row row5 = new Row(new Cell(new Text("City:"), true));
                Cell cell3 = new Cell(new TextField("city", profile2.getCity(teasession._nLanguage), 15));
                cell3.add(new Text("State:"));
                cell3.add(new TextField("state", profile2.getState(teasession._nLanguage), 2));
                cell3.add(new Text("Zip:"));
                cell3.add(new TextField("zip", profile2.getZip(teasession._nLanguage), 5));
                row5.add(cell3);
                table.add(row5);
                Row row9 = new Row(new Cell(new Text("Country:"), true));
                row9.add(new Cell(new TextField("country", profile2.getCountry(teasession._nLanguage), 15)));
                table.add(row9);
                Row row11 = new Row(new Cell(new Text("Phone Number:"), true));
                row11.add(new Cell(new TextField("phone", profile2.getTelephone(teasession._nLanguage), 15)));
                table.add(row11);
                Row row12 = new Row(new Cell(new Text("E-Mail Address:"), true));
                row12.add(new Cell(new TextField("email", profile2.getEmail(), 30)));
                table.add(row12);
                form1.add(table);
                form1.add(new HiddenField("ret_addr", "http://" + request.getServerName() + "/servlet/PayAccess1"));
                form1.add(new HiddenField("passback", "Shipping"));
                form1.add(new HiddenField("Shipping", i));
                form1.add(new HiddenField("passback", "Node"));
                form1.add(new HiddenField("Node", teasession._nNode));
                form1.add(new HiddenField("passback", "Currency"));
                form1.add(new HiddenField("Currency", j));
                form1.add(new HiddenField("passback", "Price"));
                form1.add(new HiddenField("Price", bigdecimal));
                form1.add(new HiddenField("passback", "Coupon"));
                form1.add(new HiddenField("Coupon", l));
                form1.add(new HiddenField("passback", "Discount"));
                form1.add(new HiddenField("Discount", bigdecimal1));
                form1.add(new HiddenField("lookup", "first_name"));
                form1.add(new HiddenField("lookup", "last_name"));
                form1.add(new HiddenField("lookup", "address"));
                form1.add(new HiddenField("lookup", "city"));
                form1.add(new HiddenField("lookup", "state"));
                form1.add(new HiddenField("lookup", "zip"));
                form1.add(new HiddenField("lookup", "country"));
                form1.add(new HiddenField("lookup", "phone"));
                form1.add(new HiddenField("lookup", "email"));
                form1.add(new Button(r.getString(teasession._nLanguage, "Continue")));
                out.print(form1);
//                PrintWriter printwriter = beginOut(response, teasession);
//                printwriter.print(form1);
//                endOut(printwriter, teasession);
            } else
            {
                //Profile.find(rv._strR);
                Profile profile1 = Profile.find(teasession._rv._strR);
                /*
                Form form = new Form("foPay", "POST", "PayAccess1");
                form.setOnSubmit("return(submitEmail(this.email,'" + r.getString(teasession._nLanguage, "InvalidEmail") + "')" + "&&submitText(this.first_name,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.last_name,'" + r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.address,'" + r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.city,'" + r.getString(teasession._nLanguage, "InvalidCity") + "')" + "&&submitText(this.state,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.zip,'" + r.getString(teasession._nLanguage, "InvalidZip") + "')" + "&&submitText(this.country,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.phone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + ");");
                form.add(new HiddenField("Node", teasession._nNode));
                form.add(new HiddenField("Currency", j));
                form.add(new HiddenField("Price", bigdecimal));
                form.add(new HiddenField("Shipping", i));
                Object obj = new Table();
                Row row = new Row();
                Object obj1 = new Cell(new Text(r.getString(teasession._nLanguage, "AccessFee") + " : "));
                ((TableElement) (obj1)).setAlign(3);
                row.add(((HtmlElement) (obj1)));
                row.add(new Cell(new Text(bigdecimal.toString())));
                ((HtmlElement) (obj)).add(row);
                if(l != 0)
                {
                    Row row2 = new Row();
                    row2.setFGColor("RED");
                    Cell cell1 = new Cell(new Text(r.getString(teasession._nLanguage, "Coupon") + " : " + s2));
                    cell1.setAlign(3);
                    row2.add(cell1);
                    row2.add(new Cell(new Text(bigdecimal1.toString())));
                    ((HtmlElement) (obj)).add(row2);
                    Coupon coupon1 = Coupon.find(l);
                    Row row7 = new Row();
                    Cell cell4 = new Cell(new Text(coupon1.getName(teasession._nLanguage)));
                    cell4.setAlign(3);
                    row7.add(cell4);
                    row7.add(new Cell(new Text(coupon1.getText(teasession._nLanguage))));
                    ((HtmlElement) (obj)).add(row7);
                }
                form.add(new HiddenField("Coupon", l));
                form.add(new HiddenField("Discount", bigdecimal1));
                Row row3 = new Row();
                Cell cell2 = new Cell(new Text(r.getString(teasession._nLanguage, "Total") + ":"));
                cell2.setAlign(3);
                row3.add(cell2);
                row3.add(new Cell(new Text(s + bigdecimal.add(bigdecimal1))));
                ((HtmlElement) (obj)).add(row3);
                form.add(((HtmlElement) (obj)));
                obj = new Table(r.getString(teasession._nLanguage, "BillingAddress"));
                row = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Customer") + ":"), true));
                row.add(new Cell(new Text(teasession._rv.toString())));
                ((HtmlElement) (obj)).add(row);
                obj1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
                ((HtmlElement) (obj1)).add(new Cell(new TextField("bEmail", profile1.getEmail(), 40, 40)));
                ((HtmlElement) (obj)).add(((HtmlElement) (obj1)));
                row3 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "FirstName") + ":"), true));
                cell2 = new Cell(new TextField("bFirstName", profile1.getFirstName(teasession._nLanguage), 20, 20));
                cell2.add(new Text(r.getString(teasession._nLanguage, "LastName") + ":"));
                cell2.add(new TextField("bLastName", profile1.getLastName(teasession._nLanguage), 20, 20));
                row3.add(cell2);
                ((HtmlElement) (obj)).add(row3);
                Row row6 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
                row6.add(new Cell(new TextField("bOrganization", profile1.getOrganization(teasession._nLanguage), 40, 40)));
                ((HtmlElement) (obj)).add(row6);
                Row row8 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
                row8.add(new Cell(new TextArea("bAddress", profile1.getAddress(teasession._nLanguage), 2, 40)));
                ((HtmlElement) (obj)).add(row8);
                Row row10 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
                Cell cell5 = new Cell(new TextField("bCity", profile1.getCity(teasession._nLanguage), 20, 20));
                cell5.add(new Text(r.getString(teasession._nLanguage, "State") + ":"));
                cell5.add(new TextField("bState", profile1.getState(teasession._nLanguage), 20, 20));
                row10.add(cell5);
                ((HtmlElement) (obj)).add(row10);
                Row row13 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
                Cell cell6 = new Cell(new TextField("bZip", profile1.getZip(teasession._nLanguage), 20, 20));
                cell6.add(new Text(r.getString(teasession._nLanguage, "Country") + ":"));
                cell6.add(new TextField("bCountry", profile1.getCountry(teasession._nLanguage)));
                row13.add(cell6);
                ((HtmlElement) (obj)).add(row13);
                Row row14 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
                Cell cell7 = new Cell(new TextField("bTelephone", profile1.getTelephone(teasession._nLanguage), 20, 20));
                cell7.add(new Text(r.getString(teasession._nLanguage, "Fax") + ":"));
                cell7.add(new TextField("bFax", profile1.getFax(teasession._nLanguage), 20, 20));
                row14.add(cell7);
                ((HtmlElement) (obj)).add(row14);
                form.add(((HtmlElement) (obj)));
                form.add(new Button(r.getString(teasession._nLanguage, "Continue")));
               out.print(form);*/
               %>

   <FORM NAME=foPay METHOD=POST ACTION="/servlet/PayAccess1" onSubmit="return(submitEmail(this.email,'无效电子邮件地址')&&submitText(this.first_name,'无效名')&&submitText(this.last_name,'无效姓')&&submitText(this.address,'无效地址')&&submitText(this.city,'无效城市')&&submitText(this.state,'无效省(洲)')&&submitText(this.zip,'InvalidZip')&&submitText(this.country,'无效国家')&&submitText(this.phone,'无效电话'));">
    <INPUT TYPE="HIDDEN" NAME="Node" VALUE="<%=teasession._nNode%>"/>
    <INPUT TYPE="HIDDEN" NAME="Currency" VALUE="<%=j%>"/>
    <INPUT TYPE="HIDDEN" NAME="Price" VALUE="<%=bigdecimal%>"/>
    <INPUT TYPE="HIDDEN" NAME="Shipping" VALUE="<%=i%>"/>
    <INPUT TYPE="HIDDEN" NAME="Coupon" VALUE="<%=l%>"/>
    <INPUT TYPE="HIDDEN" NAME="Discount" VALUE="<%=bigdecimal1%>"/>
    <TABLE CELLSPACING=0 CELLPADDING=0>
      <TR>
        <TD ALIGN=RIGHT><%=r.getString(teasession._nLanguage, "AccessFee")%> : </TD>
        <TD><%=bigdecimal.toString()%></TD>
      </TR>
      <TR>
        <TD ALIGN=RIGHT><%=r.getString(teasession._nLanguage, "Total")%>:</TD>
        <TD><%=s + bigdecimal.add(bigdecimal1)%></TD>
      </TR>
    </TABLE>
    <TABLE CELLSPACING=0 CELLPADDING=0>
      <TR ID=TableCaption>
        <TD COLSPAN=10><%=r.getString(teasession._nLanguage, "BillingAddress")%></TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Customer")%>:</TD>
        <TD><%=teasession._rv.toString()%></TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
        <TD><INPUT TYPE=TEXT NAME=bEmail value="<%if(profile1.getEmail()!=null)out.print(profile1.getEmail());%>" SIZE=40 MAXLENGTH=40></TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
        <TD><INPUT TYPE=TEXT NAME=bFirstName SIZE=20 value="<%if(profile1.getFirstName(teasession._nLanguage)!=null)out.print(profile1.getFirstName(teasession._nLanguage));%>" MAXLENGTH=20>
          <%=r.getString(teasession._nLanguage, "LastName")%>:
          <INPUT TYPE=TEXT NAME=bLastName value="<%if(profile1.getLastName(teasession._nLanguage)!=null)out.print(profile1.getLastName(teasession._nLanguage));%>" SIZE=20 MAXLENGTH=20></TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
        <TD><INPUT TYPE=TEXT NAME=bOrganization value="<%if(profile1.getOrganization(teasession._nLanguage)!=null)out.print(profile1.getOrganization(teasession._nLanguage));%>" SIZE=40 MAXLENGTH=40></TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
        <TD><TEXTAREA NAME="bAddress" ROWS="2"  COLS="40"><%if(profile1.getAddress(teasession._nLanguage)!=null)out.print(profile1.getAddress(teasession._nLanguage));%></TEXTAREA></TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "City") %>:</TD>
        <TD><INPUT TYPE=TEXT NAME=bCity value="<%if(profile1.getCity(teasession._nLanguage)!=null)out.print(profile1.getCity(teasession._nLanguage));%>" SIZE=20 MAXLENGTH=20>
         <%=r.getString(teasession._nLanguage, "State")%>:
                    <select name="bState">
             <option value="">--------------</option>
             <%
             String bstate=profile1.getState(teasession._nLanguage);
             for(int bstate_i=0;bstate_i<Common.PROVINCE.length;bstate_i++)
             {
               out.print("<option value="+Common.PROVINCE[bstate_i]);
               if(Common.PROVINCE[bstate_i].equals(bstate))
               {
                 out.print(" SELECTED ");
               }
               out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[bstate_i]));
             }
             %>
             </select>
        </TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
        <TD><INPUT TYPE=TEXT NAME=bZip value="<%if(profile1.getZip(teasession._nLanguage)!=null)out.print(profile1.getZip(teasession._nLanguage));%>" SIZE=20 MAXLENGTH=20>
          <%=r.getString(teasession._nLanguage, "Country")%>:
          <%=new CountrySelection("bCountry",teasession._nLanguage,profile1.getCountry(teasession._nLanguage))%></TD>
      </TR>
      <TR>
        <td ID=RowHeader><%=r.getString(teasession._nLanguage, "Telephone") %>:</TD>
        <TD><INPUT TYPE=TEXT NAME=bTelephone value="<%if(profile1.getTelephone(teasession._nLanguage)!=null)out.print(profile1.getTelephone(teasession._nLanguage));%>" SIZE=20 MAXLENGTH=20>
          <%=r.getString(teasession._nLanguage, "Fax")%>:
          <INPUT TYPE=TEXT NAME=bFax value="<%if(profile1.getFax(teasession._nLanguage)!=null)out.print(profile1.getFax(teasession._nLanguage));%>" SIZE=20 MAXLENGTH=20></TD>
      </TR>
    </TABLE>
    <INPUT TYPE="SUBMIT" VALUE="<%=r.getString(teasession._nLanguage, "Continue")%>"/>
  </FORM>


               <%
            }
  %>
  </div>
</body>
</html>



