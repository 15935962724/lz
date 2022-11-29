<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Date"%>
<%@page import ="java.sql.SQLException" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.admin.mov.*" %>

<% 


Enumeration e = Section.find(" and 1=1 ",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
	int sid = ((Integer)e.nextElement()).intValue();
	Section sobj = Section.find(sid);
	
	String t = sobj.getText(1);
	if(t!=null && t.length()>0)
	{
	
		if(t.indexOf("<a")!=-1)
		{
			t = t.replaceAll("<a","<a target=_blank  ");  
		}if(t.indexOf("<A")!=-1)
		{
			t = t.replaceAll("<a","<a target=_blank ");  
		}
		
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("update SectionLayer set text ="+db.cite(t)+" where section= "+sid);
		}finally
		{
			db.close();
		}
	}
}
out.println("段落替换成功<br>");

Enumeration e2 = Listing.find(" ",0,Integer.MAX_VALUE);
while(e2.hasMoreElements())
{
	int lid = ((Integer)e2.nextElement()).intValue();
	Listing lobj = Listing.find(lid);
	
	//之前
	String tb = lobj.getBeforeListing(1);
	if(tb!=null && tb.length()>0)
	{
	
		if(tb.indexOf("<a")!=-1)
		{
			tb = tb.replaceAll("<a","<a target=_blank  ");  
		}if(tb.indexOf("<A")!=-1)
		{
			tb = tb.replaceAll("<a","<a target=_blank ");  
		}
		
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("update ListingLayer set beforeListing ="+db.cite(tb)+" where listing= "+lid);
		}finally
		{
			db.close(); 
		}
	}
	System.out.println("替换后的列举之前："+tb);
	//之后
	String ta = lobj.getAfterListing(1);
	if(ta!=null && ta.length()>0)
	{
	
		if(ta.indexOf("<a")!=-1)
		{
			ta = ta.replaceAll("<a","<a target=_blank  ");  
		}if(ta.indexOf("<A")!=-1)
		{
			ta = ta.replaceAll("<a","<a target=_blank ");  
		}
		
		DbAdapter db = new DbAdapter();
		try
		{
			db.executeUpdate("update ListingLayer set afterListing ="+db.cite(ta)+" where listing= "+lid);
		}finally
		{
			db.close();
		}
	} 
	
}  
out.println("列举替换成功<br>");


%> 
