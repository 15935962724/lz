<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%@page import="java.net.URLEncoder"%>
<%!
 private Row getBuy(Node node, int i, int j)  throws java.sql.SQLException
    {
        Row row = new Row();
        Commodity.find(i);
        if((node.getOptions() & 0x40000) != 0)
        {
            int k = Node.find(node.getFather()).getFather();
            Node node1 = Node.find(k);
            String pic=node1.getPicture(teasession._nLanguage);
            if(pic!=null&&pic.length()>0)
                row.add(new Cell(new Anchor("/servlet/Node?node=" + k,pic)));
            else
                row.add(new Cell());
            Cell cell2 = new Cell(node1.getAnchor(j));
            if(node1.getType() == 12)
            {
                cell2.add(new Break());
                cell2.add(getAuthor(node1, k, 0, j));
                cell2.add(new Break());
                Book book = Book.find(k);
                //cell2.add(new Text(ts.mapNode(book.getPublisher(j), 23, j)));
            }
            row.add(cell2);
        } else
        {
        	String pic=node.getPicture(teasession._nLanguage);
            if(pic!=null&&pic.length()>0)
                row.add(new Cell(new Anchor("Node?node=" + i, new Image("NodePicture?node=" + i))));
            else
                row.add(new Cell());
            Cell cell = new Cell(node.getAnchor(j));
            row.add(cell);
        }
        Cell cell1 = new Cell();
        int l = 0;
        for(Enumeration enumeration = BuyPrice.find(i); enumeration.hasMoreElements();)
        {
            int i1 = ((Integer)enumeration.nextElement()).intValue();
            String s = r.getString(j, Common.CURRENCY[i1]);
            BuyPrice buyprice = BuyPrice.find(i, i1);
            BigDecimal bigdecimal = buyprice.getList();
            BigDecimal bigdecimal1 = buyprice.getPrice();
            if(l == 0)
                cell1.add(new Text("" + r.getString(j, "BuyPList") + ":" + s + bigdecimal + ""));
            else
                cell1.add(new Text("<br/>" + r.getString(j, "BuyPList") + ":" + s + bigdecimal + ""));
            cell1.add(new Text(" " + r.getString(j, "BuyPPrice") + ":" + s + bigdecimal1 + ""));
            if(bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
                cell1.add(new Text(" " + r.getString(j, "YouSave") + ":" + bigdecimal.subtract(bigdecimal1).divide(bigdecimal, 4).multiply(new BigDecimal(100D)) + "% "));
            l++;
        }

        row.add(cell1);
        return row;
    }

    private Row getBook(Node node, int i, int j)
        throws java.sql.SQLException
    {
        Row row = new Row();
        String pic=node.getPicture(teasession._nLanguage);
        if(pic!=null&&pic.length()>0)
            row.add(new Cell(new Anchor("Node?node=" + i, new Image(pic))));
        else
            row.add(new Cell());
        Cell cell = new Cell(node.getAnchor(j));
        cell.add(new Break());
        cell.add(getAuthor(node, i, 0, j));
        cell.add(new Break());
        Book book = Book.find(i);
        //cell.add(new Text(ts.mapNode(book.getPublisher(j), 23, j)));
        row.add(cell);
        Cell cell1 = new Cell();
        for(Enumeration enumeration = Node.findSons(i, null, 0, 10); enumeration.hasMoreElements(); cell1.add(new Break()))
        {
            int k = ((Integer)enumeration.nextElement()).intValue();
            Node node1 = Node.find(k);
            cell1.add(node1.getAnchor(j));
        }

        row.add(cell1);
        return row;
    }



    private Text getAuthor(Node node, int i, int j, int k)
        throws java.sql.SQLException
    {
        Text text = new Text();
//        Author author;
//        for(Enumeration enumeration = Author.findByNodeType(i, j); enumeration.hasMoreElements(); text.add(new Text(ts.mapNode(author.getName(k), j, k))))
//        {
//            int l = ((Integer)enumeration.nextElement()).intValue();
//            author = Author.find(l);
//        }

        return text;
    }
%>
<%
            String s =  request.getParameter("SearchFor");
            String s1 = s;
            if(s == null)
                s = "";
            else
                try
                {
                    s1 = new String(s.getBytes("ISO-8859-1"));
                } catch(Exception exception1) { }
            int i = 0;
            int j = 0;
            String s2 =  request.getParameter("MatchStyle");
            if(s2 != null)
                i = Integer.parseInt(s2);
            if( request.getParameter("MatchField1") != null)
                j |= 1;
            if( request.getParameter("MatchField2") != null)
                j |= 2;
            if( request.getParameter("MatchField4") != null)
                j |= 4;
            if( request.getParameter("MatchField16") != null)
                j |= 0x10;
            if( request.getParameter("MatchField32") != null)
                j |= 0x20;
            if( request.getParameter("MatchField64") != null)
                j |= 0x40;
            if( request.getParameter("MatchField8") != null)
                j |= 8;
            String s3 =  request.getParameter("MatchField");
            if(s3 != null)
                j = Integer.parseInt(s3);
            String s4 =  request.getParameter("Type");
            if(s4 == null)
                s4 = "255";
            int k = TypeSelection.getType(s4);
            int l = TypeSelection.getTypeAlias(s4);
            int i1 = 0;
            String s5 =  request.getParameter("CreatorStyle");
            if(s5 != null)
                i1 = Integer.parseInt(s5);
            String s6 =  request.getParameter("Creator");
            if(s6 == null)
                s6 = node.getCreator()._strR;
            int j1 = 1;
            String s7 =  request.getParameter("Area");
            if(s7 != null)
                j1 = Integer.parseInt(s7);
            int k1 = teasession._nNode;
            String s8 =  request.getParameter("ThisTree");
            if(s8 != null)
                k1 = Integer.parseInt(s8);
            String s9 =  request.getParameter("ThisCommunity");
            if(s9 == null)
                s9 = node.getCommunity();
            int l1 = 0;
            String s10 =  request.getParameter("ByStyle");
            if(s10 != null)
                l1 = Integer.parseInt(s10);
            String s11 =  request.getParameter("By");
            String s12 =  request.getParameter("ByText");
            String s13 = "/servlet/Search?SearchFor=" + URLEncoder.encode(s) + "&type=" + s4 + "&CreatorStyle=" + i1 + "&Creator=" + s6 + "&Area=" + j1 + "&ThisTree=" + k1 + "&ThisCommunity=" + s9 + "&ByStyle=" + l1;
            if(s11 != null)
                s13 = s13 + "&By=" + s11;
            if(s12 != null)
                s13 = s13 + "&ByText=" + s12;
            s13 = s13 + "&MatchStyle=" + i;
            s13 = s13 + "&MatchField=" + j;
            long l2 = System.currentTimeMillis() - 0x757b12c00L;
            String s14 =  request.getParameter("StartTime");
            if(s14 != null)
                l2 = Long.parseLong(s14);
            else
                try
                {
                    Date date = TimeSelection.makeTime(teasession.getParameter("StartYear"), teasession.getParameter("StartMonth"), teasession.getParameter("StartDay"), teasession.getParameter("StartHour"), teasession.getParameter("StartMinute"));
                    l2 = date.getTime();
                }
                catch(Exception exception2) { }
            Date date1 = new Date(l2);
            long l3 = System.currentTimeMillis() + 0x757b12c00L;
            String s15 =  request.getParameter("StopTime");
            if(s15 != null)
                l3 = Long.parseLong(s15);
            else
                try
                {
                    Date date2 = TimeSelection.makeTime(teasession.getParameter("StopYear"), teasession.getParameter("StopMonth"), teasession.getParameter("StopDay"), teasession.getParameter("StopHour"), teasession.getParameter("StopMinute"));
                    l3 = date2.getTime();
                }
                catch(Exception exception3) { }
            Date date3 = new Date(l3);
            s13 = s13 + "&StartTime=" + l2;
            s13 = s13 + "&StopTime=" + l3;
            String s16 =  request.getParameter("Pos");
            int i2 = s16 == null ? 0 : Integer.parseInt(s16);
            String s17 =  request.getParameter("TimeType");
            int j2 = s17 == null ? -1 : Integer.parseInt(s17);
            s13 = s13 + "&Timetype=" + j2;
            String s18 =  request.getParameter("CreatorType");
            int k2 = s18 == null ? 0 : Integer.parseInt(s18);
            s13 = s13 + "&Creatortype=" + k2;
%>
<%
r.add("tea.ui.node.general.Search");
if(s1==null)s1="";
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Search")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM name=foSearch METHOD=POST action="/jsp/general/Search.jsp">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<h2 colspan="2"><%=r.getString(teasession._nLanguage, "Search")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
        <td><%=r.getString(teasession._nLanguage, "Search")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=SearchFor SIZE=50 MAXLENGTH=255 value=<%=s1%>>
          <SELECT name=MatchStyle>
            <OPTION <%=getSelect(i==0)%> VALUE="0"><%=r.getString(teasession._nLanguage, "MatchOnAllWords")%></OPTION>
            <OPTION <%=getSelect(i==1)%>  VALUE="1"><%=r.getString(teasession._nLanguage, "MatchOnAnyWords")%></OPTION>
            <OPTION  <%=getSelect(i==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, "MatchExactPhase")%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name=MatchField1 value=null <%=getCheck((j & 1) != 0)%>>
          <%=r.getString(teasession._nLanguage, "Subject")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=MatchField2 value=null <%=getCheck((j & 2) != 0)%>>
          <%=r.getString(teasession._nLanguage, "Keywords")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=MatchField4 value=null <%=getCheck((j & 4) != 0)%>>
          <%=r.getString(teasession._nLanguage, "Briefing")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=MatchField16 value=null <%=getCheck((j & 0x10) != 0)%>>
          <%=r.getString(teasession._nLanguage, "Section")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=MatchField32 value=null <%=getCheck((j & 0x20) != 0)%>>
          <%=r.getString(teasession._nLanguage, "Talkback")%>
          <input  id="CHECKBOX" type="CHECKBOX" name=MatchField64 value=null <%=getCheck((j & 0x40) != 0)%>>
          <%=r.getString(teasession._nLanguage, "ChatRoom")%> &nbsp;(
          <input  id="CHECKBOX" type="CHECKBOX" name=MatchField8 value=null <%=getCheck((j & 8) != 0)%>>
          <%=r.getString(teasession._nLanguage, "FullTextSearch")%>)</td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
        <td><%=new TypeSelection(teasession._nLanguage, k, l)%>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Creator")%>:</td>
        <td><SELECT name=CreatorStyle>
            <OPTION <%=getSelect(i1==0)%> VALUE="0"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[0])%></OPTION>
            <OPTION  <%=getSelect(i1==1)%>  VALUE="1"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[1])%></OPTION>
            <OPTION <%=getSelect(i1==2)%>  VALUE="2"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[2])%></OPTION>
            <OPTION  <%=getSelect(i1==3)%> VALUE="3"><%=r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[3])%></OPTION>
          </SELECT>
          <input type="TEXT" class="edit_input"  name=Creator VALUE="<%=s6%>">
          <SELECT name=CreatorType>
            <OPTION  <%=getSelect(k2==0)%>  VALUE="0"><%=r.getString(teasession._nLanguage, "NodeCreator")%></OPTION>
            <OPTION  <%=getSelect(k2==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, "Talkbacker")%></OPTION>
            <OPTION  <%=getSelect(k2==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, "Chater")%></OPTION>
          </SELECT></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "From")%>:</td>
        <td><SELECT name=Area>
            <OPTION  <%=getSelect(j1==0)%> VALUE="0"><%=r.getString(teasession._nLanguage, "ThisTree")%></OPTION>
            <OPTION <%=getSelect(j1==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, "ThisCommunity")%></OPTION>
            <OPTION  <%=getSelect(j1==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, "AllCommunities")%></OPTION>
          </SELECT>
          <input type="TEXT" class="edit_input"  name=ThisCommunity VALUE="<%=s9%>">
          <input type="TEXT" class="edit_input"  name=ThisTree VALUE="<%=k1%>"></td>
      </tr>
      <%          if(l1 != 0 && s11 != null && s12 != null)
            {%>
      <input type='hidden' name=ByStyle VALUE="<%=l1%>">
      <input type='hidden' name=By VALUE="<%=s11%>">
      <input type='hidden' name=ByText VALUE="<%=s12%>">
      <tr>
        <td><%=r.getString(teasession._nLanguage, Node.SEARCH_BY[l1])%>: <%=s12%></td>
      </tr>
      <%           }%>
      <tr>
        <td> <%=r.getString(teasession._nLanguage, "StartTime")%>:</td>
        <td><%=new TimeSelection("Start", date1)%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "StopTime")%>:</td>
        <td><%=new TimeSelection("Stop", date3)%> </td>
      </tr>
      <tr>
        <td> </td>
        <td><SELECT name=TimeType>
            <OPTION <%=getSelect(j2==-1)%> VALUE="-1"><%=r.getString(teasession._nLanguage, "NoTimeLimit")%></OPTION>
            <OPTION  <%=getSelect(j2==0)%> VALUE="0"><%=r.getString(teasession._nLanguage, "NodeCreateTime")%></OPTION>
            <OPTION  <%=getSelect(j2==1)%> VALUE="1"><%=r.getString(teasession._nLanguage, "NewsIssueTime")%></OPTION>
            <OPTION  <%=getSelect(j2==2)%> VALUE="2"><%=r.getString(teasession._nLanguage, "TalkbackTime")%></OPTION>
            <OPTION  <%=getSelect(j2==3)%> VALUE="3"><%=r.getString(teasession._nLanguage, "ChatTime")%></OPTION>
          </SELECT></td>
      </tr>
    </table>
    <input type=SUBMIT class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Search")%>">
  </FORM>
  <%            int j3 = Node.countSearchx(s, teasession._nLanguage, k, l, i1, s6, j1, k1, s9, l1, s11, i, j, date1, date3, j2, k2);
%>

<h2><%=j3%> <%=r.getString(teasession._nLanguage, "Results")%> &nbsp;<%=r.getString(teasession._nLanguage, "CurrentPosition")%>: <%=i2%></h2>


	 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <%          for(Enumeration enumeration = Node.findSearchx(s, teasession._nLanguage, k, l, i1, s6, j1, k1, s9, l1, s11, i2, 25, i, j, date1, date3, j2, k2); enumeration.hasMoreElements();)
            {
                int k3 = ((Integer)enumeration.nextElement()).intValue();
                Node node1 = Node.find(k3);
                switch(node1.getType())
                {
                case 4: // '\004'%>
          <tr>
            <td><%=getBuy(node1, k3, teasession._nLanguage)%>
              <%                  break;
                case 12: // '\f'%>
          <tr>
            <td><%=getBook(node1, k3, teasession._nLanguage)%>
              <%                  break;
                default:%>
          <tr>
            <%
            String pic=node1.getPicture(teasession._nLanguage);
            if(pic!=null&&pic.length()>0)
         {%>
            <td><A href="/servlet/Node?node=<%=k3%>"><%=new Image("/servlet/NodePicture?node=" + k3)%></A></td>
            <%}else{%>
            <td></td><%}%>
               <td><%=node1.getAnchor(teasession._nLanguage)%></td>
          </tr>
          <%                  break;
                }
            }
%>
        </table>
  <%=new FPNL(teasession._nLanguage, s13 + "&Pos=", i2, j3)%>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

