<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.*" %>
<%@ page  import="tea.resource.Resource"  %>   
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
 // response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  //return;
//}

//显示二级
if(teasession.getParameter("goodstype")!=null && teasession.getParameter("goodstype").length()>0)

{
	int goodstype = Integer.parseInt(teasession.getParameter("goodstype"));
	java.util.Enumeration e2=GoodsType.findByFather(goodstype);
	//int g2 =Integer.parseInt()
	out.print("<select name=goodstype2 onchange=\"showDetail2();\">");
	out.print("<option value=>-----------</option>");
	
		while(e2.hasMoreElements())
		{
		  GoodsType obj2=(GoodsType) e2.nextElement();  
			
			out.print("<option value="+obj2.getGoodstype());
			if(goodstype==obj2.getGoodstype())
				out.print(" selected");
			out.print(">"+obj2.getName(teasession._nLanguage));  
			out.print("</option>");
		}   

	out.print("</select>");
}  
//显示三级 
/*
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
	int goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
	java.util.Enumeration e3=GoodsType.findByFather(goodstype2);
	
	out.print("<select name=goodstype3 onchange=\"showDetail3();\">");  
	out.print("<option value=>-----------</option>");

		while(e3.hasMoreElements())
		{
		  GoodsType obj3=(GoodsType) e3.nextElement();  
		
			out.print("<option value="+obj3.getGoodstype());
			if(goodstype2==obj3.getGoodstype())  
	  			out.print(" selected");
			out.print(">"+obj3.getName(teasession._nLanguage));  
			out.print("</option>");
		}  
	  
	out.print("</select>");  
}
*/
//三级显示品牌
if(teasession.getParameter("goodstype3")!=null && teasession.getParameter("goodstype3").length()>0)
{
	int goodstype3 = Integer.parseInt(teasession.getParameter("goodstype3"));
	
    GoodsType g =GoodsType.find(goodstype3);
    String b[] = g.getBrand().split("/");
 

	
	out.print("品牌:<select name=goodstype4>");    
	out.print("<option value=>-----------</option>");    
  	 for(int i=1;i<b.length;i++)
    {
    	Brand bobj = Brand.find(Integer.parseInt(b[i]));
    	out.print("<option value="+b[i]);
			
			out.print(">"+bobj.getName(teasession._nLanguage));  
			out.print("</option>");  
    }  
	
	out.print("</select>");  
	
	
}

//显示品牌----------------------////////////两级用的
if(teasession.getParameter("goodstype2")!=null && teasession.getParameter("goodstype2").length()>0)
{
	int goodstype2 = Integer.parseInt(teasession.getParameter("goodstype2"));
	
    GoodsType g =GoodsType.find(goodstype2);
    String b[] = g.getBrand().split("/");
 

	
	out.print("品牌:<select name=goodstype4>");     
	out.print("<option value=>-----------</option>");    
  	 for(int i=1;i<b.length;i++)
    {
    	Brand bobj = Brand.find(Integer.parseInt(b[i]));
    	out.print("<option value="+b[i]);
			
			out.print(">"+bobj.getName(teasession._nLanguage));  
			out.print("</option>");  
    }  
	
	out.print("</select>");  
}

////显示 前台品牌

if(teasession.getParameter("brand")!=null && teasession.getParameter("brand").length()>0)
{
	int brand = Integer.parseInt(teasession.getParameter("brand"));
	
    GoodsType g =GoodsType.find(brand);
    String b[] = g.getBrand().split("/");
 

	
	out.print("<select name=brand>");    
	out.print("<option value=>-----------</option>");    
  	 for(int i=1;i<b.length;i++)
    {
    	Brand bobj = Brand.find(Integer.parseInt(b[i]));
    	out.print("<option value="+b[i]);
			
			out.print(">"+bobj.getName(teasession._nLanguage));  
			out.print("</option>");  
    }  
	 
	out.print("</select>");  
}
 
%>
