<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.Node"%><%@page import="tea.db.DbAdapter"%><%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

//int node=Integer.parseInt(request.getParameter("node"));
int top=20;
if(request.getParameter("top")!=null)
{
  top=Integer.parseInt(request.getParameter("top"));
}
String before,after;
if(request.getParameter("before")!=null)
{
  before=request.getParameter("before");
}else
before="";
if(request.getParameter("after")!=null)
{
  after=request.getParameter("after");
}else
after="";

int quantity=0;
if(request.getParameter("quantity")!=null)
{
  quantity=Integer.parseInt(request.getParameter("quantity"));
}

DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT n.node FROM Node n,BBS b WHERE n.node=b.node AND b.quintessence=1 AND n.type=57 AND n.path LIKE "+db.cite("%/"+teasession._nNode+"/%"));
  for(int i=0;i<top&&db.next();i++)
  {
    int id=db.getInt(1);
    Node obj=Node.find(id);
    String subject=obj.getSubject(teasession._nLanguage);
    if(quantity>0&&subject.length()>quantity)
    {
      subject=subject.substring(0,quantity);
    }
    out.print(before+"<a target=_blank href=/servlet/BBS?node="+id+" >"+subject+"</A>"+after);
  }
}finally
{
  db.close();
}
%>
<!--
参数说明:
node=论坛id  可无,默认当前页面节点
top=显示条数, 可无,默认20条
before=之前  可无
after=之后   可无
quantity=显示字数
-->

