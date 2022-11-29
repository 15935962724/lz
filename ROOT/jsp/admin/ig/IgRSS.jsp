<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.util.*"%>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

int showcount=Integer.parseInt(request.getParameter("showcount"));
int igd=Integer.parseInt(request.getParameter("menuid"));
String url=request.getParameter("url");

//out.print("<script>var FEED"+igd+"={has_entries : false,is_fetching: false,url:\""+url+"\",num_items:3};</script>");

if(url==null)
{
  int sum=Node.countSons(teasession._nNode,null);
  java.util.Enumeration enumer = Node.findSons(teasession._nNode, null, 0, showcount);
  for(int j=1;enumer.hasMoreElements();j++)
  {
    int node_id =((Integer) enumer.nextElement()).intValue();
    Node obj = Node.find(node_id);
    String text = obj.getText(teasession._nLanguage);
    int start = text.indexOf("<");
    while (start != -1 && start <= 200)
    {
      int end = text.indexOf(">", start);
      if (end != -1)
      {
        text = text.substring(0, start) + text.substring(end + 1);
      } else
      {
        text = text.substring(0, start);
      }
      start = text.indexOf("<");
    }
    if (text.length() > 200)
    {
      text = text.substring(0, 200) + " ...";
    }
    out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
    out.print("  <a target=_blank href=/servlet/Node?node="+node_id+"&language="+teasession._nLanguage+">"+obj.getSubject(teasession._nLanguage)+"</a><br>");
    out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
    out.print(text);
    out.print("  </div>");
    out.print("</div>");
  }
  if(sum>showcount)
  {
    out.print("<a target=_blank href=/servlet/Node?node="+teasession._nNode+">更多...</a>");
  }
}else
{
  try
  {
    String content = (String)Entity.open(url);
    javax.xml.parsers.DocumentBuilderFactory dbf = javax.xml.parsers.DocumentBuilderFactory.newInstance();
    javax.xml.parsers.DocumentBuilder db = dbf.newDocumentBuilder();
    java.io.ByteArrayInputStream bais = new java.io.ByteArrayInputStream(content.getBytes("UTF-8"));
    org.w3c.dom.Document d = db.parse(bais);
    org.w3c.dom.NodeList nl = d.getElementsByTagName("channel").item(0).getChildNodes();
    for(int i=1,j=0;j<showcount&&i<nl.getLength();i++)
    {
      org.w3c.dom.Node n=nl.item(i);
      if(n.getNodeType()==n.ELEMENT_NODE)
      {
        String title="<No Subject>",link="",description="暂无信息...";
        org.w3c.dom.NodeList nl2=n.getChildNodes();
        for(int z=0;z<nl2.getLength();z++)
        {
          n=nl2.item(z);
          if(n.getFirstChild()!=null)
          {
            if("title".equals(n.getNodeName()))
            {
              title=n.getFirstChild().getNodeValue();
            }else
            if("link".equals(n.getNodeName()))
            {
              link=n.getFirstChild().getNodeValue();
            }else if("description".equals(n.getNodeName()))
            {
              description=n.getFirstChild().getNodeValue();
            }
          }
        }
        out.print("<div id=ftl_"+igd+"_"+j+" class=uftl><a href='javascript:void(0)' id='ft_"+igd+"_"+j+"' class='fmaxbox' onclick='_IG_FR_toggle("+igd+","+j+")'></a>");
        out.print("  <a target=_blank href="+link+" >"+title+"</a><br>");
        out.print("  <div id=fb_"+igd+"_"+j+" class='fpad fb' style='display:none'>");
        out.print(description);
        out.print("  </div>");
        out.print("</div>");
        j++;
      }
    }
  }catch(Exception e)
  {
    out.print("读RSS出现错误:"+e.getMessage());
  }
}

%>
