<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.admin.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

teasession = new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));

sn=request.getServerName()+":"+request.getServerPort();
jsessionid=request.getParameter("jsessionid");
if(jsessionid!=null)
	jsessionid="&jsessionid="+jsessionid;
else
	jsessionid="";

Resource r = new Resource("/tea/resource/fun");

String popedom=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR).getAdminfunction(request.getRemoteAddr());

//System.out.println(popedom);
tree1(out,igd,0,popedom);

%>
<%!
TeaSession teasession;
String sn,jsessionid;
private void  tree1(java.io.Writer jw,int nodecode,int step,String popedom)throws Exception
{
  for(java.util.Enumeration enumeration = AdminFunction.findByFather(nodecode); enumeration.hasMoreElements(); )
  {
    int j = ((Integer)enumeration.nextElement()).intValue();
    if(popedom.indexOf("/"+j+"/")!=-1)
    {
      AdminFunction node1 = AdminFunction.find(j);
      if(node1.isHidden())
      {
        for(int loop=1;loop<step;jw.write("<img src=/tea/image/tree/tree_line.gif align=absmiddle>"),loop++);
        if(step>0)jw.write("<img src=/tea/image/tree/tree_line.gif align=absmiddle>");//
        jw.write("<SPAN id=leftuptree"+step+" >");
        if(!node1.isType())
        {
          tea.html.Anchor a=new tea.html.Anchor("javascript:func_click("+j+");","<IMG SRC=/tea/image/tree/tree_plus.gif align=absmiddle ID=img"+j+" /> "+ node1.getName(teasession._nLanguage));
          jw.write(a.toString());
        }else//功能菜单
        {
          jw.write("<IMG SRC=/tea/image/tree/tree_blank.gif align=absmiddle ID=img"+j+" /> ");
          tea.html.Anchor a= new tea.html.Anchor("http://"+sn+"/jsp/admin/right.jsp?id="+j+"&node="+teasession._nNode+"&community="+teasession._strCommunity+jsessionid+"&info="+java.net.URLEncoder.encode(node1.getName(teasession._nLanguage),"UTF-8"),node1.getName(teasession._nLanguage));
          a.setTarget("_blank");//a.setTarget("m");
          jw.write(a.toString());
        }
        jw.write("<br></SPAN>");

        if(!node1.isType())
        {
	        jw.write("<Div id=divid"+j+" style=display:none>");
	        tree1(jw,j,++step, popedom);
	        jw.write("</Div>");
	        step--;
        }
      }
    }
  }
}
%>


