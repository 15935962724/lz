<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%Purview purview=Purview.find(teasession._rv.toString());
%>
<%@include file="/jsp/type/job/cnoocjobheader.jsp" %>
<div id="jigouwai" style="width:98%;">
        <div id="jigounei" style="width:100%;">
          <div style="width:100%;">
            <h1 align="left" style="margin-bottom:0px;">反馈信息</h1><%
int i=teasession._nNode;
int j=1;
   RV rv = teasession._rv;
    boolean flag1 = node.isCreator(rv);
Text text4 =new Text();
int j2 = Talkback.count(i);
            if (j2 != 0)
            {
//                text4.add(new Break(2));
                text4.add(new Text("<HR SIZE=1>"));
                Table table2 = new Table();
                table2.setId("TalkbackIndex");
                table2.setCellSpacing(2);
                table2.setTitle(" &nbsp;\n" + r.getString(j, "Subject") + "\n" + "&nbsp;" + "\n" +  r.getString(j, "Time") + "\n" + "&nbsp;" + "\n 发表人\n");
                Row row1;
                for (Enumeration enumeration3 = Talkback.find(i, 0, 25); enumeration3.hasMoreElements(); table2.add(row1))
                {
                    int j4 = ( (Integer) enumeration3.nextElement()).intValue();
                    Talkback talkback = Talkback.find(j4);
                    RV rv1 = talkback.getCreator();
                    Date date = talkback.getTime();
                    talkback.getStatus();
                    row1 = new Row(new Cell(new HintImg(j, talkback.getHint())));
                    row1.add(new Cell(new Text("<A HREF=/jsp/talkback/cnoocjobtalkback.jsp?node=" + teasession._nNode + "&Talkback=" + j4+" >"+talkback.getSubject(1)+"</A>")));
                    row1.add(new Cell(new Text("  ")));
                    row1.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>")));
                    row1.add(new Cell(new Text("  ")));
                    try
                    {
                        row1.add(new Cell(new Text(ts.hrefGlanceWithName(rv1, j))));
                    } catch (Exception exception2)
                    {}
                    if (rv != null && (flag1 || rv1.equals(rv)))
                        row1.add(new Cell(new Button(1, "CB", "CBDeleteTalkback", r.getString(j, "CBDeleteTalkback"),
                            "if(confirm('" + r.getString(j, "ConfirmDelete") + "')){window.open('/servlet/DeleteTalkback?node=" + i +
                            "&Talkback=" + j4 + "&nexturl="+request.getRequestURI()+"?"+request.getQueryString()+"', '_self');}")));
                }
                text4.add(table2);
            }
            out.print(text4);
            %></div></div></div>
  <%@include file="/jsp/type/job/cnoocjobfooter.jsp" %>

