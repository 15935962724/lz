<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>

<marquee onMouseOver=this.stop() onMouseOut=this.start() scrollamount=1 scrolldelay=0 direction=left width=300 height=1>
<span id="zhiban">
    <%
TeaSession teasession =new TeaSession(request);

    int pos = 0;
    int size = 10;
    Enumeration e = Attenddance.selAttend(teasession._strCommunity,pos,size);
    while(e.hasMoreElements()){
      int id = ((Integer)e.nextElement()).intValue();
      Attenddance ad = Attenddance.find(id);
      String timek = Attenddance.dateFormat(ad.getTimek());
      String timej = Attenddance.dateFormat(ad.getTimej());
      Date nowdate = new Date();
      int wk = ad.getWeek();
      int wkday = nowdate.getDay();
      String ndate = Attenddance.dateFormat(nowdate);


      if(Attenddance.compareDate(ad.getTimek(),ad.getTimej())|| (ndate.equals(timek)||ndate.equals(timej))){
        if(wkday == wk || wk == 0){
        String member = ad.getAttPer();
          String newmember = member.replaceAll(";"," ");
          out.print(Attenddance.findTname(ad.getType(),teasession._strCommunity)+"："+newmember+"　");
        }
        }
}
      %>
      </span>

</marquee>
