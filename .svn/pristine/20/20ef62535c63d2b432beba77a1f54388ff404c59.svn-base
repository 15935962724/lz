<%@page contentType="text/html;charset=UTF-8" %><%@include file="/jsp/Header.jsp"%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<DIV ID="edit_Bodydiv">
<%         r.add("/tea/ui/node/access/PayAccess1");
int i1=Integer.parseInt(request.getParameter("Trade"));
int i=Integer.parseInt(request.getParameter("Currency"));
int k=Integer.parseInt(request.getParameter("Shipping"));
String s=request.getParameter("Parameters");

String s13 = RequestHelper.format(r.getString(teasession._nLanguage, "InfViewOrder"), (new Anchor("http://" + request.getServerName() +"/servlet/Trade?Trade=" + i1, r.getString(teasession._nLanguage, "ClickHere"))).toString());
                String s14 = RequestHelper.format(r.getString(teasession._nLanguage, "InfAfterRequestGranted"), (new Anchor("http://" + request.getServerName()+ "/servlet/Node?node=" + teasession._nNode, new Text(r.getString(teasession._nLanguage, "ClickHere")))).toString());
                // Message.create(rv, null, teasession._rv, null, null, null, 8, 8, 4, 0, 2, teasession._nLanguage, RequestHelper.format(r.getString(teasession._nLanguage, "InfAccessNotification"), node.getSubject(teasession._nLanguage)), "<html>" + s13 + s14 + "</html>", null, null, null, null);
                // Message.create(teasession._rv, null, rv, null, null, null, 8, 8, 4, 0, 2, teasession._nLanguage, RequestHelper.format(r.getString(teasession._nLanguage, "InfAccessRequest"), node.getSubject(teasession._nLanguage)), "<html>" + s13 + "</html>", null, null, null, null);
                out.print(s13);
                if (i == 1 && k == Shipping.PAYMETHOD_CYBERBJ)
                {
                    int j1 = s.indexOf(' ');
                    if (j1 == -1)
                    {
                        out.print(r.getString(teasession._nLanguage, "InfVendorShippingParameters"));
                    } else
                    {/*
                        Form form = new Form("foCyberBJ", "POST", "http://paymentweb.cyberbj.com.cn/prs/spmode.main");
                        form.setTarget("_blank");
                        String s15 = s.substring(0, j1);
                        String s16 = s.substring(j1 + 1);
                        String s17 = "0";
                        String s18 = (new SimpleDateFormat("yyyyMMdd")).format(new Date(System.currentTimeMillis()));
                        String s19 = bigdecimal.add(bigdecimal1).toString();
                        String s20 = s3 + s2;
                        String s21 = s18 + "-" + s15 + "-" + i1;
                        String s22 = RequestHelper.hmac_md5("0" + s18 + s19 + s20 + s21 + s15, s16);
                        form.add(new Button(r.getString(teasession._nLanguage, "PayInCyberBJ")));
                        form.add(new HiddenField("v_action", "\312\327\266\274\265\347\327\323\311\314\263\307\315\370\311\317\260\262\310\253\326\247\270\266\306\275\314\250"));
                        form.add(new HiddenField("v_mid", s15));
                        form.add(new HiddenField("v_oid", s21));
                        form.add(new HiddenField("v_rcvname", s20));
                        form.add(new HiddenField("v_vrcvaddr", s9 + " " + s7 + " " + s6 + " " + s5));
                        form.add(new HiddenField("v_rcvtel", s10));
                        form.add(new HiddenField("v_rcvpost", s8));
                        form.add(new HiddenField("v_amount", s19));
                        form.add(new HiddenField("v_ymd", s18));
                        form.add(new HiddenField("v_orderstatus", "1"));
                        form.add(new HiddenField("v_ordername", s3 + s2));
                        form.add(new HiddenField("v_moneytype", s17));
                        form.add(new HiddenField("v_md5info", s22));
                        out.print(form);*/
                    }
                } else
out.print(RequestHelper.format(r.getString(teasession._nLanguage, "InfContinue"), (new Anchor("/servlet/Node?node=" + teasession._nNode, new Text(r.getString(teasession._nLanguage, "ClickHere")))).toString()));
%>



