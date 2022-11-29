<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
int ch=Integer.parseInt(request.getParameter("clickhistory"));
ClickHistory obj_ch=ClickHistory.find(ch);
int count=obj_ch.getQuantity();
int type=obj_ch.getType();

String name="tea.history";
String value=null;
Cookie cookie[]=request.getCookies();
if(cookie!=null)
{
  for(int i=0;i<cookie.length;i++)
  {
    if(name.equals(cookie[i].getName()))
    {
      value=cookie[i].getValue();
      break;
    }
  }
}
//System.out.println(value);
if(value!=null&&value.length()>0)
{
  String ns[]=value.split("/");
  for(int i=2,j=0;j<count&&i<ns.length;i++)
  {
    int node=Integer.parseInt(ns[i]);
    Node n=Node.find(node);
    if(n.getCreator()!=null&&n.getType()==type)//节点必须存在&&类型必须相等
    {
      StringBuffer sb=new StringBuffer();
      Enumeration e=ClickHistoryDetail.findByClickHistory(ch);
      while(e.hasMoreElements())
      {
        int chd=((Integer)e.nextElement()).intValue();
        ClickHistoryDetail obj=ClickHistoryDetail.find(chd);
        sb.append(obj.getBefore(teasession._nLanguage));
        String field=obj.getField();
        String v=null;
        if("subject".equals(field))
        {
          v=n.getSubject(teasession._nLanguage);
        }else if("content".equals(field))
        {
          v=n.getText(teasession._nLanguage);
        }
        if(v!=null)
        {
          int q=obj.getQuantity();
          if(q>0&&v.length()>q)
          v=v.substring(0,q)+"...";
          if(obj.getAnchor()>0)
          sb.append("<a href='/servlet/Node?node=").append(ns[i]).append("&language=").append(teasession._nLanguage).append("'>").append(v).append("</a>");
          else
          sb.append(v);
        }
        sb.append(obj.getAfter(teasession._nLanguage));
      }
      out.print("document.write(\"<LI>");
      out.print(sb.toString().replace('\"','\'').replaceAll("\r\n"," "));
      out.println("</LI>\");");
      j++;
    }
  }
}
%>

