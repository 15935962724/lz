<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%
tmp=request.getParameter("type");
int type=-1;
if(tmp!=null)
{
  type=Integer.parseInt(tmp);
}
StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
sql.append(" AND path LIKE ").append(DbAdapter.cite(h.getPath()+"%"));
par.append("?community=").append(como);
par.append("&url=Search");
if(type!=-1)
{
  sql.append(" AND type=").append(type);
  par.append("&type=").append(type);
}else
{
  sql.append(" AND type>1");
}
sql.append(" AND father>0");
boolean _bQ=q!=null&&q.length()>0;
if(_bQ)
{
  sql.append(" AND EXISTS(SELECT node FROM NodeLayer WHERE node=n.node AND (subject LIKE ").append(DbAdapter.cite("%"+q+"%")).append(" OR content LIKE ").append(DbAdapter.cite("%"+q+"%")).append("))");
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}
par.append("&pos=");

out.print("<!-- "+sql.toString()+" -->");
%>
  <div id="page2">
    <div id="page2_wai_left">
      <div id="page2_left">
        <div id="page2_left_top"><%=r.getString(lang,"fj14p1yl")%></div>
        <form name="formsearch" action="./">
        <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
        <input type="hidden" name="url" value="Search">
        <input type="text" name="q" id="Search_k" value="<%if(_bQ)out.print(q);%>">
        <select name="type">
        <option value="-1">---------------</option>
        <option value="34"><%=wbs[14].getName(lang)%></option>
        <option value="39"><%=wbs[18].getName(lang)%></option>
        <option value="50"><%=wbs[9].getName(lang)%></option>
        <option value="73"><%=wbs[20].getName(lang)%></option>
        </select>
        <script type="">formsearch.type.value="<%=type%>";</script>
        <input type="submit" id="Search_b" value="<%=r.getString(lang,"fj14p1yl")%>">
        </form>
    </div>
  </div>
  <div id="page2_wai_right">
    <div id="page2_right">
      <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=r.getString(lang,"fj14p1yl")%></font>
    </div>
  </div>
  <div id="page2_right_bottom">
  <table>
  <%
  int count=Node.count(sql.toString());
  if(count<1)
  {
    out.print("<tr><td>"+r.getString(lang,"fj14p1ym")+"</td></tr>");
  }else
  {
    out.print("<tr><td>"+r.getString(lang,"fj14p1yn")+":"+count+"</td></tr>");
    Enumeration eq=Node.find(sql.toString(),pos,10);
    while(eq.hasMoreElements())
    {
      int nid=((Integer)eq.nextElement()).intValue();
      n=Node.find(nid);
      String subject=n.getSubject(lang);
      String content=n.getText(lang);
      if(content.length()>200)
      {
        content=content.substring(0,200)+"...";
      }
      if(_bQ)
      {
        subject=subject.replaceAll(q,"<FONT COLOR=RED>"+q+"</FONT>");
        content=content.replaceAll(q,"<FONT COLOR=RED>"+q+"</FONT>");
      }
      out.print("<tr><td><a href=?community="+como+"&url=View"+Node.NODE_TYPE[n.getType()]+"&node="+nid+" target=_blank>"+subject+"</a></td>");
      out.print("<tr><td>"+content+"</td>");
      out.print("<tr><td><script>var as=document.getElementsByTagName('A');document.write(as[as.length-1]);</script></td>");
      out.print("<tr><td>");
    }
    out.print("<tr><td>"+new tea.htmlx.FPNL(lang,par.toString(),pos,count,10));
  }
  %>
  </table>
  </div>
  </div></div>
  <div id="page2_bottom">
  </div>
