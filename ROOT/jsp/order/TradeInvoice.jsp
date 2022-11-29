<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/TradeServlet");
%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "TradeInvoice")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">


<%
            boolean flag = false;
            Object obj = null;
            try
            {
                String s = request.getParameter("Batch");
                if(s != null && s.equalsIgnoreCase("true"))
                    flag = true;
            }
            catch(Exception _ex) { }
            if(!flag)
            {
                int i = Integer.parseInt(request.getParameter("Trade"));
                int k = Integer.parseInt(request.getParameter("InvoiceFormat"));
               // PrintWriter out = beginOut(response, teasession);
                out.println("<div style=\"page-break-before:always\">  </div>");
                String s1;
                switch(k)
                {
                case 0: // '\0'
//                    out = originalInvoice(out, i, teasession._nLanguage, teasession._rv);
                    // fall through
%>
<jsp:include page="TradeInvoiceInc.jsp">
<jsp:param name="Trade" value="<%=i%>"/>
</jsp:include>

 <%               case -1:
                case 1: // '\001'
                case 2: // '\002'
                case 3: // '\003'
                default:
                    s1 = "Trade=" + i + "&" + "InvoiceFormat=" + k;
                    break;
                }
                String s2 = request.getQueryString();
                if(s2 != null && s2.indexOf(s1) >= 0)
                    out.print(new Languages(teasession._nLanguage, request));
                else
                    out.print(new Languages(teasession._nLanguage, request, s1));
                out.println("<div style=\"page-break-after:always\">  </div>");
               // endOut(out, teasession);

            }else
{           int j = Integer.parseInt(request.getParameter("InvoiceFormat"));
            //PrintWriter out = beginOut(response, teasession);
            String as[] = request.getParameterValues("Trades");
            if(as != null)
            {
                for(int l = 0; l < as.length; l++)
                    if(as[l] != null)
                    {
                        int i1 = (new Integer(as[l])).intValue();
                        out.println("<div style=\"page-break-before:always\">  </div>");
                        switch(j)
                        {
                        case 0: // '\0'
                           // out = originalInvoice(out, i1, teasession._nLanguage, teasession._rv);
                            // fall through
/*StringBuffer sb=new StringBuffer("?");
java.util.Enumeration enumeration= request.getParameterNames() ;
while(enumeration.hasMoreElements())
{
   String str=enumeration.nextElement().toString();
//   sb.append(str+"="+httpservletrequest.getParameterValues(str) getParameter(str)+"&" );
  String ss[]=request.getParameterValues(str);
  if(ss!=null)
  {for(int len=0;len<ss.length ;len++)
   {//out.print("<input type='hidden' name=>");
       //form2.add(new HiddenField("Trades", k3))
       // sb.append(str+"="+ss[len]+"&" );
   System.out.println(str+":"+ss[len].toString());
   }
  }
  System.out.println("------------------------------");

}*/
%>
<jsp:include page="TradeInvoiceInc.jsp">
<jsp:param name="Trade" value="<%=i1%>"/>
</jsp:include>

<%
                        case -1:
                        case 1: // '\001'
                        case 2: // '\002'
                        case 3: // '\003'
                        default:
                            out.println("<div style=\"page-break-after:always\">  </div>");
                            break;
                        }
                    }

            }
}

%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

