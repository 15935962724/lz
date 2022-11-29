<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.math.BigDecimal"%>
<%

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String act = teasession.getParameter("act");
//座位设置 中 添加 总排数和总列数
if("form1.right_price".equals(act))
{
	int prsubid2 = 0;
	if(teasession.getParameter("prsubid2")!=null && teasession.getParameter("prsubid2").length()>0)
	{
		prsubid2 = Integer.parseInt(teasession.getParameter("prsubid2"));
	}
	
	PriceSubarea psubobj = PriceSubarea.find(prsubid2);
	
	int psid = Integer.parseInt(teasession.getParameter("psid"));
	String subareaname = teasession.getParameter("subareaname");
	BigDecimal price = new BigDecimal("0");
	if(teasession.getParameter("price")!=null && teasession.getParameter("price").length()>0)
	{
		price = new BigDecimal(teasession.getParameter("price"));
	}
	int picturepath =Integer.parseInt(teasession.getParameter("picturepath"));

	String str = "分区添加成功.";
	if(psubobj.isExist())
	{
		psubobj.set(psid,subareaname,price,null,picturepath,teasession._rv.toString());
		str ="分区修改成功.";
	}else
	{  
		PriceSubarea.create(psid,subareaname,price,null,picturepath,teasession._rv.toString(),teasession._strCommunity);
	} 
	out.print(str);
	return;
	 
}
//选中座位定义分区
if("f_pricesubareaid".equals(act))
{
	int psid = Integer.parseInt(teasession.getParameter("psid"));
	int pricesubareaid = Integer.parseInt(teasession.getParameter("pricesubareaid"));
	String numbers = teasession.getParameter("numbers")+"/";
	String str = "添加成功.";
	if(numbers!=null && numbers.length()>0)
	{
		String addNumbers[] =numbers.split("/");
		for(int i=1;i<addNumbers.length;i++)
		{
			PriceDistrict pdobj = PriceDistrict.find(Integer.parseInt(addNumbers[i]),psid);
			if(pdobj.isExist())
			{
				pdobj.set(pricesubareaid,teasession._rv.toString());
			}else
			{
				PriceDistrict.create(Integer.parseInt(addNumbers[i]),psid,pricesubareaid,teasession._rv.toString(),teasession._strCommunity);
			}
		}
	}
	out.print(str);
	return;
}


%>

