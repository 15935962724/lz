<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.entity.node.*" %>
<%
String ids = request.getParameter("id");

int id = Integer.parseInt(ids);
StringBuffer sb = new StringBuffer();

java.util.Enumeration enumer2 = tea.entity.node.Node.findTopSon(id,20);
int counts = Node.countSon(id);

for(int d2 = 1;enumer2.hasMoreElements();d2++) //二级下拉菜单
{
  int sid = ((Integer) enumer2.nextElement()).intValue();

  Node ndd = Node.find(sid);
  if(d2 < 11)
  {
    sb.append("<span id=ds_" + sid + "  onclick=window.open('/servlet/Folder?node=" + sid + "&language=" + 1 + "'); onmouseover=s_color(ds_" + sid + "); onmouseout=l_shid(ds_" + sid + ");>&nbsp;&nbsp;&nbsp;");
    if(ndd.getSubject(1).length() > 26)
    {
      sb.append(ndd.getSubject(1).substring(0,25) + "...");
    } else
    {
      sb.append(ndd.getSubject(1));
    }
    sb.append("</span>");

    if(d2 == counts)
    {
      sb.append("<span id=pic class=cen onclick=window.open('/jsp/general/SonNodes.jsp?node=" + id + "&language=" + 1 + "'); onmouseover=this.className='cenc'; onmouseout=this.className='cen';><img src='/tea/image/editpage/080923193.gif' />更多子级</span>");
      break;
    }
  } else
  {
    sb.append("<span id=pic class=cen onclick=window.open('/jsp/general/SonNodes.jsp?node=" + id + "&language=" + 1 + "'); onmouseover=this.className='cenc'; onmouseout=this.className='cen';><img src='/tea/image/editpage/080923193.gif' />更多子级</span>");
    break;
  }
}

out.print("son_"+ids+".innerHTML=\""+sb.toString()+"\";");

%>
