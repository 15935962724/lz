<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/TradeServlet").add("/tea/ui/member/offer/Offers");

            int i = Integer.parseInt(request.getParameter("Trade"));
            Trade trade = Trade.find(i);
            RV rv = trade.getVendor();
            RV rv1 = trade.getCustomer();
            java.util.Date date = trade.getTime();
            int j = trade.getType();
            int k = trade.getStatus();
            String s = trade.getbEmail();
            String s1 = trade.getbFirstName(teasession._nLanguage);
            String s2 = trade.getbLastName(teasession._nLanguage);
            String s3 = RequestHelper.makeName(teasession._nLanguage, s1, s2);
            String s4 = trade.getbOrganization(teasession._nLanguage);
            String s5 = trade.getbAddress(teasession._nLanguage);
            String s6 = trade.getbCity(teasession._nLanguage);
            String s7 = trade.getbState(teasession._nLanguage);
            String s8 = trade.getbZip();
            String s9 = trade.getbCountry(teasession._nLanguage);
            String s10 = trade.getbTelephone(teasession._nLanguage);
            String s11 = trade.getbFax(teasession._nLanguage);
            String s12 = trade.getsEmail();
            String s13 = trade.getsFirstName(teasession._nLanguage);
            String s14 = trade.getsLastName(teasession._nLanguage);
            String s15 = RequestHelper.makeName(teasession._nLanguage, s13, s14);
            String s16 = trade.getsOrganization(teasession._nLanguage);
            String s17 = trade.getsAddress(teasession._nLanguage);
            String s18 = trade.getsCity(teasession._nLanguage);
            String s19 = trade.getsState(teasession._nLanguage);
            String s20 = trade.getsZip();
            String s21 = trade.getsCountry(teasession._nLanguage);
            String s22 = trade.getsTelephone(teasession._nLanguage);
            String s23 = trade.getsFax(teasession._nLanguage);
            int l = trade.getCurrency();
            int i1 = trade.getShipping();
            String s24 = trade.getShippingText(teasession._nLanguage);
            BigDecimal bigdecimal = trade.getSh();
            BigDecimal bigdecimal1 = trade.getTax();
            int j1 = trade.getCoupon();
            String s25 = trade.getCouponText(teasession._nLanguage);
            BigDecimal bigdecimal2 = trade.getDiscount();
            String s26 = trade.getCText(teasession._nLanguage);
            boolean flag = trade.getCVoiceFlag();
            String s27 = trade.getVText(teasession._nLanguage);
            boolean flag1 = trade.getVVoiceFlag();
            BigDecimal bigdecimal3 = new BigDecimal(0.0D);
            String s28 = r.getString(teasession._nLanguage, Common.CURRENCY[l]);
            String s29 = r.getString(teasession._nLanguage, Common.CURRENCY[1]);
            boolean flag2 = trade.isCustomer(teasession._rv);
            boolean flag3 = trade.isVendor(teasession._rv);
            boolean flag4 = flag2 && (k == 0 || k == 3 || k == 5);
            boolean flag5 = flag3 && k != 1 && k != 5 && k != 9 && k != 8;
            if (flag2)
            {
                trade.customerRead();
            }
            if (flag3)
            {
                trade.vendorRead();
            }
            Table table = new Table(r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j]));
            table.setCellSpacing(2);
            table.setTitle(r.getString(teasession._nLanguage, "Time") + "\n" + " &nbsp; " + "\n" + r.getString(teasession._nLanguage, "TradeSubject") + "\n" + " &nbsp; " + "\n" + r.getString(teasession._nLanguage, "Price") + "\n" + r.getString(teasession._nLanguage, "OQuantity") + "\n" + r.getString(teasession._nLanguage, "SQuantity") + "\n" + r.getString(teasession._nLanguage, "Total") + "\n");
            boolean flag6 = true;
            int k1 = 0;
            for (Enumeration enumeration = TradeItem.findByTrade(i); enumeration.hasMoreElements(); )
            {
                int l1 = ((Integer) enumeration.nextElement()).intValue();
                TradeItem tradeitem = TradeItem.find(l1);
                java.util.Date date1 = tradeitem.getTime();
                int i2 = tradeitem.getSubject();
                int k2 = tradeitem.getSubjectx();
                BigDecimal bigdecimal4 = tradeitem.getPrice();
                int i3 = tradeitem.getOQuantity();
                int j3 = tradeitem.getSQuantity();
                BigDecimal bigdecimal5 = bigdecimal4.multiply(new BigDecimal(j3));
                bigdecimal3 = bigdecimal3.add(bigdecimal5);
                Row row16 = new Row(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date1) + "</font>")));
                StringBuffer stringbuffer = new StringBuffer();
                if (j == 1 || j == 2 || j == 3)
                {
                    Node node = Node.find(i2);
                    Node node2 = Node.find(k2);
                    int l3 = node.getFather();
                    int j4 = Node.find(l3).getFather();
                    Node node3 = Node.find(j4);
                    if (node3.getType() == 12)
                    {
                        Book book = Book.find(j4);
                        String s42 = book.getPublisher(teasession._nLanguage);
                        try
                        {
                            int k4 = Integer.parseInt(s42);
                            stringbuffer.append(Node.find(k4).getSubject(teasession._nLanguage));
                        } catch (Exception _ex)
                        {
                            stringbuffer.append(s42);
                        }
                        stringbuffer.append("<br/>" + node3.getAnchor(teasession._nLanguage));
                        stringbuffer.append("<br/>" + book.getISBN());
                    } else
                    {
                        stringbuffer.append(node.getAnchor(teasession._nLanguage));
                        stringbuffer.append(node2.getAnchor(teasession._nLanguage));
                    }
                } else
                if (j == 7)
                {
                    Aded aded = Aded.find(i2);
                    int k3 = aded.getNode();
                    int i4 = aded.getAding();
                    Ading ading = Ading.find(i4);
                    stringbuffer.append(ading.getName(teasession._nLanguage));
                    stringbuffer.append(" (" + new Anchor("Adeds?node=" + k3, Node.find(k3).getSubject(teasession._nLanguage)) + ")");
                } else
                if (j == 4)
                {
                    Node node1 = Node.find(i2);
                    stringbuffer.append(node1.getAnchor(teasession._nLanguage));
                }
                row16.add(new Cell(new Text(" &nbsp;")));
                row16.add(new Cell(new Text(stringbuffer.toString())));
                row16.add(new Cell(new Text(" &nbsp;")));
                row16.add(new Cell(new Text(s28 + bigdecimal4)));
                Cell cell26 = new Cell(new Text(Integer.toString(i3)));
                cell26.setAlign(2);
                row16.add(cell26);
                Cell cell27 = new Cell(new Text(Integer.toString(j3)));
                cell27.setAlign(2);
                row16.add(cell27);
                Cell cell28 = new Cell(new Text(s28 + bigdecimal5));
                cell28.setAlign(3);
                row16.add(cell28);
                row16.setId(flag6 ? "OddRow" : "EvenRow");
                flag6 = !flag6;
                table.add(row16);
                k1++;
            }

            if (flag2 || flag3)
            {
                if (j == 1 || j == 2 || j == 3)
                {
                    if (bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
                    {
                        Row row = new Row();
                        Cell cell1 = new Cell(new Text(r.getString(teasession._nLanguage, "Shipping") + ":"), 7);
                        cell1.setAlign(3);
                        row.add(cell1);
                        Cell cell6 = new Cell(new Text(s28 + bigdecimal));
                        cell6.setAlign(3);
                        row.add(cell6);
                        table.add(row);
                    }
                    if (bigdecimal1.compareTo(new BigDecimal(0.0D)) != 0)
                    {
                        Row row1 = new Row();
                        Cell cell2 = new Cell(new Text(r.getString(teasession._nLanguage, "Tax") + ":"), 7);
                        cell2.setAlign(3);
                        row1.add(cell2);
                        Cell cell7 = new Cell(new Text(s28 + bigdecimal1));
                        cell7.setAlign(3);
                        row1.add(cell7);
                        table.add(row1);
                    }
                }
                if (j1 != 0 && bigdecimal2.compareTo(new BigDecimal(0.0D)) != 0)
                {
                    Row row2 = new Row();
                    Cell cell3 = new Cell(new Text(r.getString(teasession._nLanguage, "Discount") + ":"), 7);
                    cell3.setAlign(3);
                    row2.add(cell3);
                    Cell cell8 = new Cell(new Text(s28 + bigdecimal2));
                    cell8.setAlign(3);
                    row2.add(cell8);
                    table.add(row2);
                }
            } else
            if (flag3 && (k == 0 || k == 3 || k == 4 || k == 10))
            {
                if (i1 != 0 && (j == 1 || j == 2 || j == 3))
                {
                    Cell cell = new Cell(new Text(r.getString(teasession._nLanguage, "Shipping") + ":"), 7);
                    cell.setAlign(3);
                    Row row5 = new Row(cell);
                    row5.add(new Cell(new Text(s28 + new TextField("Sh", bigdecimal.toString(), 5))));
                    table.add(row5);
                    Row row6 = new Row();
                    Cell cell10 = new Cell(new Text(r.getString(teasession._nLanguage, "Tax") + ":"), 7);
                    cell10.setAlign(3);
                    row6.add(cell10);
                    row6.add(new Cell(new Text(s28 + new TextField("Tax", bigdecimal1.toString(), 5))));
                    table.add(row6);
                } else
                {
                    table.add(new HiddenField("Sh", bigdecimal));
                    table.add(new HiddenField("Tax", bigdecimal1));
                }
                if (j1 != 0)
                {
                    Row row3 = new Row();
                    Cell cell4 = new Cell(new Text(r.getString(teasession._nLanguage, "Discount") + ":"), 7);
                    cell4.setAlign(3);
                    row3.add(cell4);
                    row3.add(new Cell(new Text(s28 + new TextField("Discount", bigdecimal2.toString(), 5))));
                    table.add(row3);
                } else
                {
                    table.add(new HiddenField("Discount", bigdecimal2));
                }
            }
            Row row4 = new Row();
            Cell cell5 = new Cell(new Text(r.getString(teasession._nLanguage, "Total") + ":"), 7);
            cell5.setAlign(3);
            row4.add(cell5);
            Cell cell9 = new Cell(new Text(s28 + bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2)));
            cell9.setAlign(3);
            row4.add(cell9);
            table.add(row4);
            if (trade.getPayByPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {
                Row row7 = new Row();
                Cell cell11 = new Cell(new Text(r.getString(teasession._nLanguage, "Use") + s28 + r.getString(teasession._nLanguage, "PayByPoint") + ":"), 7);
                cell11.setAlign(3);
                row7.add(cell11);
                Cell cell13 = new Cell(new Text(" " + trade.getPayByPoint()));
                cell13.setAlign(3);
                row7.add(cell13);
                table.add(row7);
                Row row12 = new Row();
                Cell cell23 = new Cell(new Text(r.getString(teasession._nLanguage, "Balance") + ":"), 7);
                cell23.setAlign(3);
                row12.add(cell23);
                Cell cell25 = new Cell();
                if (l == 6)
                {
                    cell25.add(new Text(s29 + bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2).add(trade.getPayByPoint().negate())));
                } else
                {
                    cell25.add(new Text(s28 + bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2).add(trade.getPayByPoint().negate())));
                }
                cell25.setAlign(3);
                row12.add(cell25);
                table.add(row12);
            }
            if (trade.getConvertedPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {
                Row row8 = new Row();
                Cell cell12 = new Cell(new Text(r.getString(teasession._nLanguage, "NewObtainPoint") + s28 + r.getString(teasession._nLanguage, "Point") + ":"), 7);
                cell12.setAlign(3);
                row8.add(cell12);
                row8.add(new Cell(new Text(" " + trade.getConvertedPoint())));
                table.add(row8);
            }
            for (int j2 = 0; j2 < Common.CURRENCY.length; j2++)
            {
                if (trade.isExisted(j2) && trade.getBuyPoint(j2).compareTo(new BigDecimal(0.0D)) == 1)
                {
                    String s30 = r.getString(teasession._nLanguage, Common.CURRENCY[j2]);
                    Row row11 = new Row();
                    Cell cell20 = new Cell(new Text(r.getString(teasession._nLanguage, "NewObtainPoint") + s30 + r.getString(teasession._nLanguage, "Point") + ":"), 7);
                    cell20.setAlign(3);
                    row11.add(cell20);
                    row11.add(new Cell(new Text(" " + trade.getBuyPoint(j2))));
                    table.add(row11);
                }
            }

            if (trade.getRefundedPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {
                Row row9 = new Row();
                Cell cell14 = new Cell(new Text(r.getString(teasession._nLanguage, "RefundedPoint") + s28 + r.getString(teasession._nLanguage, "Point") + ":"), 7);
                cell14.setAlign(3);
                row9.add(cell14);
                Cell cell21 = new Cell(new Text(" " + trade.getRefundedPoint()));
                cell21.setAlign(3);
                row9.add(cell21);
                table.add(row9);
            }
            if (trade.getRefund().compareTo(new BigDecimal(0.0D)) == 1)
            {
                Row row10 = new Row();
                Cell cell15 = new Cell(new Text(r.getString(teasession._nLanguage, "Refund") + ":"), 7);
                cell15.setAlign(3);
                row10.add(cell15);
                Cell cell22 = new Cell(new Text(s28 + trade.getRefund()));
                cell22.setAlign(3);
                row10.add(cell22);
                table.add(row10);
            }
            for (int l2 = 0; l2 < Common.CURRENCY.length; l2++)
            {
                if (trade.isExisted(l2) && trade.getReclaimedBuyPoint(l2).compareTo(new BigDecimal(0.0D)) == 1)
                {
                    String s31 = r.getString(teasession._nLanguage, Common.CURRENCY[l2]);
                    Row row13 = new Row();
                    Cell cell24 = new Cell(new Text(r.getString(teasession._nLanguage, "ReclaimedPoint") + s31 + r.getString(teasession._nLanguage, "Point") + ":"), 7);
                    cell24.setAlign(3);
                    row13.add(cell24);
                    row13.add(new Cell(new Text(" " + trade.getReclaimedBuyPoint(l2))));
                    table.add(row13);
                }
            }

            if (k == 2)
            {
                if ((trade.getOptions() & 4) != 0)
                {
                    Cell cell16 = new Cell(new CheckBox("Paid", true, String.valueOf(i)));
                    cell16.add(new Text(r.getString(teasession._nLanguage, "PaymentReceived")));
                    cell16.setColSpan(6);
                    table.add(new Row(cell16));
                } else
                {
                    Cell cell17 = new Cell(new CheckBox("Unpaid", true, String.valueOf(i)));
                    cell17.add(new Text(r.getString(teasession._nLanguage, "PaymentUnpaid")));
                    cell17.setColSpan(6);
                    table.add(new Row(cell17));
                }
            }
            if (i1 != 0)
            {
                Cell cell18 = new Cell(new Text("<font>" + s24 + "</font>"));
                cell18.setColSpan(6);
                table.add(new Row(cell18));
            }
            if (j1 != 0)
            {
                Cell cell19 = new Cell(new Text("<font>" + s25 + "</font>"));
                cell19.setColSpan(6);
                table.add(new Row(cell19));
            }
            Table table1 = new Table(r.getString(teasession._nLanguage, "VendorAddress"));
            if (flag2)
            {
                Profile profile = Profile.find(rv._strR,teasession._strCommunity);
                String s32 = profile.getEmail();
                String s33 = profile.getFirstName(teasession._nLanguage);
                String s34 = profile.getLastName(teasession._nLanguage);
                String s35 = RequestHelper.makeName(teasession._nLanguage, s33, s34);
                String s36 = profile.getOrganization(teasession._nLanguage);
                String s37 = profile.getAddress(teasession._nLanguage);
                String s38 = profile.getCity(teasession._nLanguage);
                String s39 = profile.getState(teasession._nLanguage);
                String s40 = profile.getZip(teasession._nLanguage);
                String s41 = profile.getCountry(teasession._nLanguage);
                String s43 = profile.getTelephone(teasession._nLanguage);
                String s44 = profile.getFax(teasession._nLanguage);
                Row row35 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Vendor") + ":"), true));
                row35.add(new Cell(ts.hrefGlance(rv), 3));
                table1.add(row35);
                Row row37 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
                row37.add(new Cell(ts.hrefNewMessage(s32), 3));
                table1.add(row37);
                Row row39 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Name") + ":"), true));
                row39.add(new Cell(ts.hrefNewMessage(rv.toString(), s35), 3));
                table1.add(row39);
                Row row41 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
                row41.add(new Cell(new Text(s36), 3));
                table1.add(row41);
                Row row43 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
                row43.add(new Cell(new Text(s37), 3));
                table1.add(row43);
                Row row44 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
                row44.add(new Cell(new Text(s38)));
                row44.add(new Cell(new Text(r.getString(teasession._nLanguage, "State") + ":"), true));
                row44.add(new Cell(new Text(s39)));
                table1.add(row44);
                Row row45 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
                row45.add(new Cell(new Text(s40)));
                row45.add(new Cell(new Text(r.getString(teasession._nLanguage, "Country") + ":"), true));
                row45.add(new Cell(new Text(s41)));
                table1.add(row45);
                Row row46 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
                row46.add(new Cell(new Text(s43)));
                row46.add(new Cell(new Text(r.getString(teasession._nLanguage, "Fax") + ":"), true));
                row46.add(new Cell(new Text(s44)));
                table1.add(row46);
            }
            Table table2 = new Table(r.getString(teasession._nLanguage, "BillingAddress"));
            Table table3 = new Table(r.getString(teasession._nLanguage, "ShippingAddress"));
            if (flag2 && (k == 0 || k == 3 || k == 5))
            {
                Row row14 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Customer") + ":"), true));
                row14.add(new Cell(new Text(rv1.toString()), 3));
                table2.add(row14);
                Row row17 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
                row17.add(new Cell(new TextField("bEmail", s, 40, 40), 3));
                table2.add(row17);
                Row row19 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "FirstName") + ":"), true));
                row19.add(new Cell(new TextField("bFirstName", s1, 20, 20)));
                row19.add(new Cell(new Text(r.getString(teasession._nLanguage, "LastName") + ":"), true));
                row19.add(new Cell(new TextField("bLastName", s2, 20, 20)));
                table2.add(row19);
                Row row21 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
                row21.add(new Cell(new TextField("bOrganization", s4, 40, 40), 3));
                table2.add(row21);
                Row row23 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
                row23.add(new Cell(new TextArea("bAddress", s5, 2, 40), 3));
                table2.add(row23);
                Row row25 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
                row25.add(new Cell(new TextField("bCity", s6, 20, 20)));
                row25.add(new Cell(new Text(r.getString(teasession._nLanguage, "State") + ":"), true));

                row25.add(new Cell(new TextField("bState", s7, 20, 20)));

                table2.add(row25);
                Row row27 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
                row27.add(new Cell(new TextField("bZip", s8, 20, 20)));
                row27.add(new Cell(new Text(r.getString(teasession._nLanguage, "Country") + ":"), true));
                row27.add(new Cell(new TextField("bCountry", s9, 20, 20)));
                table2.add(row27);
                Row row30 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
                row30.add(new Cell(new TextField("bTelephone", s10, 20, 20)));
                row30.add(new Cell(new Text(r.getString(teasession._nLanguage, "Fax") + ":"), true));
                row30.add(new Cell(new TextField("bFax", s11, 20, 20)));
                table2.add(row30);
                row14 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
                row14.add(new Cell(new TextField("sEmail", s12, 40, 40), 3));
                table3.add(row14);
                row17 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "FirstName") + ":"), true));
                row17.add(new Cell(new TextField("sFirstName", s13, 20, 20)));
                row17.add(new Cell(new Text(r.getString(teasession._nLanguage, "LastName") + ":"), true));
                row17.add(new Cell(new TextField("sLastName", s14, 20, 20)));
                table3.add(row17);
                row19 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
                row19.add(new Cell(new TextField("sOrganization", s16, 40, 40), 3));
                table3.add(row19);
                row21 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
                row21.add(new Cell(new TextArea("sAddress", s17, 2, 40), 3));
                table3.add(row21);
                row23 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
                row23.add(new Cell(new TextField("sCity", s18, 20, 20)));
                row23.add(new Cell(new Text(r.getString(teasession._nLanguage, "State") + ":"), true));
                row23.add(new Cell(new TextField("sState", s19, 20, 20)));
                table3.add(row23);
                row25 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
                row25.add(new Cell(new TextField("sZip", s20, 20, 20)));
                row25.add(new Cell(new Text(r.getString(teasession._nLanguage, "Country") + ":"), true));
                row25.add(new Cell(new TextField("sCountry", s21, 20, 20)));
                table3.add(row25);
                row27 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
                row27.add(new Cell(new TextField("sTelephone", s22, 20, 20)));
                row27.add(new Cell(new Text(r.getString(teasession._nLanguage, "Fax") + ":"), true));
                row27.add(new Cell(new TextField("sFax", s23, 20, 20)));
                table3.add(row27);
            } else
            {
                Row row15 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Customer") + ":"), true));
                row15.add(new Cell(new Text(rv1.toString()), 3));
                table2.add(row15);
                Row row18 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
                row18.add(new Cell(ts.hrefNewMessage(s), 3));
                table2.add(row18);
                Row row20 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Name") + ":"), true));
                row20.add(new Cell(ts.hrefNewMessage(rv1.toString(), s3), 3));
                table2.add(row20);
                Row row22 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
                row22.add(new Cell(new Text(s4), 3));
                table2.add(row22);
                Row row24 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
                row24.add(new Cell(new Text(s5), 3));
                table2.add(row24);
                Row row26 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
                row26.add(new Cell(new Text(s6)));
                row26.add(new Cell(new Text(r.getString(teasession._nLanguage, "State") + ":"), true));
                row26.add(new Cell(new Text(s7)));
                table2.add(row26);
                Row row28 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
                row28.add(new Cell(new Text(s8)));
                row28.add(new Cell(new Text(r.getString(teasession._nLanguage, "Country") + ":"), true));
                row28.add(new Cell(new Text(s9)));
                table2.add(row28);
                Row row31 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
                row31.add(new Cell(new Text(s10)));
                row31.add(new Cell(new Text(r.getString(teasession._nLanguage, "Fax") + ":"), true));
                row31.add(new Cell(new Text(s11)));
                table2.add(row31);
                Row row32 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "EmailAddress") + ":"), true));
                row32.add(new Cell(new Text(s12), 3));
                table3.add(row32);
                Row row33 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Name") + ":"), true));
                row33.add(new Cell(new Text(s15), 3));
                table3.add(row33);
                Row row34 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Organization") + ":"), true));
                row34.add(new Cell(new Text(s16), 3));
                table3.add(row34);
                Row row36 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Address") + ":"), true));
                row36.add(new Cell(new Text(s17), 3));
                table3.add(row36);
                Row row38 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "City") + ":"), true));
                row38.add(new Cell(new Text(s18)));
                row38.add(new Cell(new Text(r.getString(teasession._nLanguage, "State") + ":"), true));
                row38.add(new Cell(new Text(s19)));
                table3.add(row38);
                Row row40 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Zip") + ":"), true));
                row40.add(new Cell(new Text(s20)));
                row40.add(new Cell(new Text(r.getString(teasession._nLanguage, "Country") + ":"), true));
                row40.add(new Cell(new Text(s21)));
                table3.add(row40);
                Row row42 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Telephone") + ":"), true));
                row42.add(new Cell(new Text(s22)));
                row42.add(new Cell(new Text(r.getString(teasession._nLanguage, "Fax") + ":"), true));
                row42.add(new Cell(new Text(s23)));
                table3.add(row42);
            }
            Table table4 = new Table(r.getString(teasession._nLanguage, "CText"));
            if (flag4)
            {
                table4.add(new FileInput(teasession._nLanguage, "Voice"));
                table4.add(new Row(new Cell(new TextArea("CText", s26, 8, 60), 2)));
            } else
            if (s26.length() != 0 || flag)
            {
                table4.add(new Row(new Cell(new Text(s26), 2)));
                if (flag)
                {
                    table4.add(new Row(new Cell(new Button(1, "CB", "CBPlay", r.getString(teasession._nLanguage, "CBPlay"), "window.open('TradeCVoice?Trade=" + i + "', '_self');"))));
                }
            }
            Table table5 = new Table(r.getString(teasession._nLanguage, "VText"));
            if (flag5)
            {
                table5.add(new FileInput(teasession._nLanguage, "Voice"));
                table5.add(new Row(new Cell(new TextArea("VText", s27, 8, 60), 2)));
            } else
            if (s27.length() != 0 || flag1)
            {
                table5.add(new Row(new Cell(new Text(s27), 2)));
                if (flag1)
                {
                    table5.add(new Row(new Cell(new Button(1, "CB", "CBPlay", r.getString(teasession._nLanguage, "CBPlay"), "window.open('TradeVVoice?Trade=" + i + "', '_self');"))));
                }
            }
            StringBuffer stringbuffer1 = new StringBuffer(ts.hrefGlance(teasession._rv) + ">");
            if (flag2)
            {
                stringbuffer1.append(new Anchor("PurchaseOrders", r.getString(teasession._nLanguage, "PurchaseOrders")) + ">" + new Anchor("PurchaseOrders?Type=" + j, r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])) + ">" + new Anchor("PurchaseOrders?Type=" + j + "&Status=" + k, r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])) + ">");
            } else
            {
                stringbuffer1.append(new Anchor("SaleOrders", r.getString(teasession._nLanguage, "SaleOrders")) + ">" + new Anchor("SaleOrders?Type=" + j, r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])) + ">" + new Anchor("SaleOrders?Type=" + j + "&Status=" + k, r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k])) + ">");
            }
            stringbuffer1.append("#" + i);
            Text text = new Text(stringbuffer1.toString());
            text.setId("PathDiv");
            PrintWriter printwriter = response.getWriter();//ts.beginOut(response, teasession);
            printwriter.print(text);
            if (flag2)
            {
                printwriter.print(table1);
                if (flag4)
                {
                    Form form = new Form("foEdit", "POST", "EditPurchaseOrder");
                    form.setMultiPart(true);
                    form.setOnSubmit("return(submitEmail(this.bEmail,'" + r.getString(teasession._nLanguage, "InvalidEmailAddress") + "')" + "&&submitText(this.bFirstName,'" + r.getString(teasession._nLanguage, "InvalidFirstName") + "')" + "&&submitText(this.bLastName,'" + r.getString(teasession._nLanguage, "InvalidLastName") + "')" + "&&submitText(this.bAddress,'" + r.getString(teasession._nLanguage, "InvalidAddress") + "')" + "&&submitText(this.bCity,'" +
                                     r.getString(teasession._nLanguage, "InvalidCity") + "')" + "&&submitText(this.bState,'" + r.getString(teasession._nLanguage, "InvalidState") + "')" + "&&submitText(this.bCountry,'" + r.getString(teasession._nLanguage, "InvalidCountry") + "')" + "&&submitText(this.bTelephone,'" + r.getString(teasession._nLanguage, "InvalidTelephone") + "')" + "&&confirm('" + r.getString(teasession._nLanguage, "ConfirmProcessOrder") + "')" + ");");
                    form.add(new HiddenField("Trade", i));
                    form.add(new HiddenField("Shipping", i1));
                    form.add(table2);
                    form.add(new CheckBox("ShipToBilling", false));
                    form.add(new Text(r.getString(teasession._nLanguage, "TradeOShipToBilling")));
                    form.add(new CheckBox("UpdateProfile", false));
                    form.add(new Text(r.getString(teasession._nLanguage, "TradeOUpdateProfile")));
                    form.add(table3);
                    form.add(new HiddenField("Currency", l));
                    form.add(table);
                    form.add(table4);
                    form.add(table5);
                    form.add(new CheckBox("SendEmail", true));
                    form.add(new Text(r.getString(teasession._nLanguage, "MsgOSendEmail")));
                    form.add(new Break());
                    switch (k)
                    {
                    case 0: // '\0'
                        form.add(new Radio("Status", 0, true));
                        form.add(new Text(r.getString(teasession._nLanguage, "NewOrder")));
                        form.add(new Radio("Status", 1, false));
                        form.add(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
                        break;

                    case 3: // '\003'
                        form.add(new Radio("Status", 4, true));
                        form.add(new Text(r.getString(teasession._nLanguage, "Confirmed")));
                        form.add(new Radio("Status", 1, false));
                        form.add(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
                        break;

                    case 10: // '\n'
                        form.add(new Radio("Status", 1, false));
                        form.add(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
                        break;

                    case 5: // '\005'
                        form.add(new Radio("Status", 6, false));
                        form.add(new Text(r.getString(teasession._nLanguage, "Refund")));
                        break;
                    }
                    form.add(new Button(r.getString(teasession._nLanguage, "Submit")));
                    printwriter.print(form);
                } else
                {
                    printwriter.print(table2);
                    if (table3 != null)
                    {
                        printwriter.print(table3);
                    }
                    printwriter.print(table);
                    printwriter.print(table4);
                    printwriter.print(table5);
                }
            } else
            if (flag5)
            {
                printwriter.print(table2);
                if (table3 != null)
                {
                    printwriter.print(table3);
                }
                Form form1 = new Form("foProcess", "POST", "ProcessSaleOrder");
                form1.setMultiPart(true);
                form1.setOnSubmit("return(confirm('" + r.getString(teasession._nLanguage, "ConfirmProcessOrder") + "')" + ");");
                form1.add(new HiddenField("Trade", i));
                form1.add(table);
                form1.add(table4);
                form1.add(table5);
                form1.add(new CheckBox("SendEmail", true));
                form1.add(new Text(r.getString(teasession._nLanguage, "MsgOSendEmail")));
                form1.add(new Break());
                switch (k)
                {
                case 0: // '\0'
                case 4: // '\004'
                    form1.add(new Radio("Status", 10, true));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Pending")));
                    form1.add(new Radio("Status", 3, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Reconfirm")));
                    form1.add(new Radio("Status", 2, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Unshipped")));
                    form1.add(new Radio("Status", 1, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
                    break;

                case 3: // '\003'
                    form1.add(new Radio("Status", 10, true));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Pending")));
                    form1.add(new Radio("Status", 2, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Unshipped")));
                    form1.add(new Radio("Status", 1, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
                    break;

                case 10: // '\n'
                    form1.add(new Radio("Status", 3, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Reconfirm")));
                    form1.add(new Radio("Status", 2, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Unshipped")));
                    form1.add(new Radio("Status", 1, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
                    break;

                case 2: // '\002'
                    form1.add(new Radio("Status", 5, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "ApprovedShipped")));
                    form1.add(new Radio("Status", 1, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "CancelOrder")));
                    form1.add(new Radio("Status", 6, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Refund")));
                    break;

                case 5: // '\005'
                    form1.add(new Radio("Status", 6, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "Refund")));
                    break;

                case 6: // '\006'
                    form1.add(new Radio("Status", 7, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "PendingRefund")));
                    form1.add(new Radio("Status", 8, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "IgnoredRefund")));
                    form1.add(new Radio("Status", 9, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "ApprovedRefund")));
                    break;

                case 7: // '\007'
                    form1.add(new Radio("Status", 8, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "IgnoredRefund")));
                    form1.add(new Radio("Status", 9, false));
                    form1.add(new Text(r.getString(teasession._nLanguage, "ApprovedRefund")));
                    break;

                case 1: // '\001'
                case 8: // '\b'
                case 9: // '\t'
                default:
                    form1.add(new HiddenField("Status", k));
                    break;
                }
                form1.add(new Button(r.getString(teasession._nLanguage, "Submit")));
                printwriter.print(form1);
            } else
            {
                printwriter.print(table2);
                if (table3 != null)
                {
                    printwriter.print(table3);
                }
                printwriter.print(table);
                printwriter.print(table4);
                printwriter.print(table5);
            }
            printwriter.print(r.getString(teasession._nLanguage, "LastUpdate") + "<font>:" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>");
            Table table6 = new Table();
            Row row29 = new Row();
            if (flag3 && (k == 2 || k == 5))
            {
                Cell cell29 = new Cell();
                Form form2 = new Form("foDataOutput", "POST", "TradeDataOutput");
                form2.add(new HiddenField("Trade", i));
                form2.add(new Button(0, "CB", "CBDataOutput", r.getString(teasession._nLanguage, "CBDataOutput"), ""));
                DropDown dropdown = new DropDown("Method", r.getString(teasession._nLanguage, "TradeDataOutputMethodDefault"));
                dropdown.addOption("-1", r.getString(teasession._nLanguage, "None"));
                for (int l4 = 0; l4 < TradeDataOutput.TRADEDATAOUTPUT_METHOD.length; l4++)
                {
                    dropdown.addOption(l4, r.getString(teasession._nLanguage, TradeDataOutput.TRADEDATAOUTPUT_METHOD[l4]));
                }

                form2.add(dropdown);
                cell29.add(form2);
                row29.add(cell29);
            }
            Cell cell30 = new Cell();
            Form form3 = new Form("foInvoice", "POST", "TradeInvoice");
            form3.setTarget("_blank");
            form3.add(new HiddenField("Trade", i));
            form3.add(new Button(0, "CB", "CBInvoice", r.getString(teasession._nLanguage, "CBInvoice"), ""));
            DropDown dropdown1 = new DropDown("InvoiceFormat", r.getString(teasession._nLanguage, "TradeInvoiceFormatDefault"));
            for (int i5 = 0; i5 < TradeInvoice.TRADEINVOICE_FORMAT.length; i5++)
            {
                dropdown1.addOption(i5, r.getString(teasession._nLanguage, TradeInvoice.TRADEINVOICE_FORMAT[i5]));
            }

            form3.add(dropdown1);
            cell30.add(form3);
            row29.add(cell30);
            table6.add(row29);
            printwriter.println(table6);
            int j5 = trade.getPrev(flag2, teasession._rv, j, k,teasession._strCommunity);
            if (j5 != 0)
            {
                printwriter.print(new Button(1, "CB", "CBPrevious", r.getString(teasession._nLanguage, "CBPrevious"), "window.open('Trade?Trade=" + j5 + "', '_self');"));
            }
            int k5 = trade.getNext(flag2, teasession._rv, j, k,teasession._strCommunity);
            if (k5 != 0)
            {
                printwriter.print(new Button(1, "CB", "CBNext", r.getString(teasession._nLanguage, "CBNext"), "window.open('Trade?Trade=" + k5 + "', '_self');"));
            }
            printwriter.print(new Languages(teasession._nLanguage, request));
           // ts.endOut(printwriter, teasession);


%>

