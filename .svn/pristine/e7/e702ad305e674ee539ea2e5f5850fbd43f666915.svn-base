<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.DbAdapter" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
//if(teasession._rv == null)
//{
//  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
//  return;
//}

Resource r=new Resource();

String _strId=request.getParameter("id");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?id=").append(_strId);
param.append("&node=").append(teasession._nNode);
param.append("&community=").append(teasession._strCommunity);

int father=0;
int bbs=0;
String _strBbs=request.getParameter("bbs");
if(_strBbs!=null&&_strBbs.length()>0)
{
  father=bbs=Integer.parseInt(_strBbs);
}else
{
  String _strFather=request.getParameter("father");
  if(_strFather!=null&&_strFather.length()>0)
  {
    father=Integer.parseInt(_strFather);
  }
}
if(father>0)
{
  sql.append(" AND father=").append(father);
  param.append("&father=").append(father);
}

String from=request.getParameter("from");
if(from!=null&&from.length()>0)
{
  sql.append(" AND time>="+DbAdapter.cite(from));
  param.append("&from="+from);
}

String to=request.getParameter("to");
if(to!=null&&to.length()>0)
{
  sql.append(" AND time<"+DbAdapter.cite(to));
  param.append("&to="+to);
}

String subject=request.getParameter("subject");
if(subject!=null&&(subject=subject.trim()).length()>0)
{
  sql.append(" AND node IN (SELECT node FROM NodeLayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject="+java.net.URLEncoder.encode(subject,"UTF-8"));
}
param.append("&pos=");

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
String nexturl=request.getRequestURI()+"?"+request.getQueryString();
%>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
  int count=0;
  DbAdapter db=new DbAdapter();
  try
  {
    count=db.getInt("SELECT COUNT(node) FROM Node WHERE type=84  and node in (select node from Interlocution where nodestatic !=1 )  AND community="+DbAdapter.cite(teasession._strCommunity)+sql.toString());
    db.executeQuery("SELECT node FROM Node WHERE type=84 AND community="+DbAdapter.cite(teasession._strCommunity)+sql.toString()+"  and node in (select node from Interlocution where nodestatic !=1 )  ORDER BY node DESC",0,5);
    for (int l = 0; l < pos + 25 && db.next(); l++)
    {
      if (l >= pos)
      {
        int id=db.getInt(1);
        Node n=Node.find(id);
        Interlocution interobj = Interlocution.find(id,teasession._nLanguage);
      

        InterlocutionType typeobj = InterlocutionType.find(interobj.getTypes());
        int reply_count=InterlocutionReply.count(id,teasession._nLanguage);

        out.print("<tr><td id=inter_types_o>");
       
        if(typeobj.getTypes()!=null && typeobj.getTypes().length()>0)
        {
        	out.print(typeobj.getTypes());
        }
        int aa = interobj.getTypes();
        if(n.isHidden())
        out.print("</td><td id=inter_cont_o><STRIKE>");
        out.print("<a href=/servlet/Node?node="+id+"&Language="+teasession._nLanguage+" target=_blank >");

        String longstr = n.getSubject(teasession._nLanguage).toString();
        if(longstr.length()>28)
        {
          out.print(longstr.substring(0,28)+"...");
        }
        else
        {
          out.print(longstr);
        }
        if ((System.currentTimeMillis() - n.getTime().getTime() - 1000 * 60 * 60 * 24L) < 0 ||(reply_count > 0 && (System.currentTimeMillis() - InterlocutionReply.find(InterlocutionReply.findLast(n._nNode, teasession._nLanguage)).getTime().getTime() - 1000 * 60 * 60 * 24L) < 0))
        out.print("<img src=/tea/image/public/new.gif >");
        out.print("</a></STRIKE></td></tr>");
     }
    }
  }finally
  {
    db.close();
  }
 // out.print("<script>document.getElementById('count').innerHTML='"+count+"';</script>");
  %>
<!--tr><td colspan="3"><input type="checkbox" onclick="if(form2.nodes){form2.nodes.checked=this.checked;for(var i=form2.nodes.length;i>0;i )form2.nodes[i-1].checked=this.checked; }" /><%=r.getString(teasession._nLanguage,"全选")%></td ><td colspan="5" align="center">
  <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count)%></td></tr-->
</table>


