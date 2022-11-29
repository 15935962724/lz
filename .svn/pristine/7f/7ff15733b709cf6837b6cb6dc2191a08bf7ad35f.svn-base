<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%

TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String act = teasession.getParameter("act");
 

//显示所有的版面信息
if("f_suoyou".equals(act))
{
	int igd = Integer.parseInt(teasession.getParameter("igd"));
	
	String typestr = teasession.getParameter("typestr");
	int tid = 0; 
	if(teasession.getParameter("tid")!=null && teasession.getParameter("tid").length()>0)
	{
		tid = Integer.parseInt(teasession.getParameter("tid"));
	}
	ReadRight rrobj = ReadRight.find(ReadRight.getRRid(teasession._nNode,tid,typestr,igd));
	
		//Enumeration e = Pageinform.find(teasession._strCommunity," and node = "+teasession._nNode,0,Integer.MAX_VALUE);
		int pfid = Pageinform.getPfid(teasession._nNode,teasession._strCommunity);
		Pageinform pfobj = Pageinform.find(pfid);
		StringBuffer sb = new StringBuffer();
		for(int i =1;i<=pfobj.getPagenumber();i++)
		{
			
			String pname = "";
			if(i<=9)
			{
				pname=String.valueOf("0")+i;
			}else
			{
				pname= String.valueOf(i);
			}
			sb.append("<span style=word-break:keep-all;white-space:nowrap;><input type=checkbox name=banci_"+igd+" id = banci_"+igd+" value=");
			sb.append(i);
			if(rrobj.getBanci()!=null && rrobj.getBanci().length()>0&& rrobj.getBanci().indexOf("/"+String.valueOf(i)+"/")!=-1)
			{
				sb.append(" checked = true ");
			}
			sb.append(">"+pname+"&nbsp;&nbsp;</span>");
		}
		out.print(sb.toString());
		return;
}else if("rrdelete".equals(act))
{
	int tid = 0; 
	if(teasession.getParameter("tid")!=null && teasession.getParameter("tid").length()>0)
	{
		tid = Integer.parseInt(teasession.getParameter("tid"));
	}
	String typestr = teasession.getParameter("typestr");
	int rnum = Integer.parseInt(teasession.getParameter("rnum"));
	ReadRight rrobj = ReadRight.find(ReadRight.getRRid(teasession._nNode,tid,typestr,rnum));
	rrobj.delete();
	return;
}else if("_Determine".equals(act))//手动付款
{
	String porders = teasession.getParameter("porders");//订单号
	int paymanner = Integer.parseInt(teasession.getParameter("paymanner"));//选择的支付方式
	String str = "手动付款设置成功";
	for(int i = 1;i<porders.split("/").length;i++)
	{
		String pid = porders.split("/")[i];
		PackageOrder pobj = PackageOrder.find(pid);
		if(pobj.getType()==1)
		{
			str="您手动付款订单中有【已付款】的订单\n系统只能修改【未付款】的状态";
			continue;
		}
		//修改是否支付成功
		pobj.set("type",1);
		//修改支付方式
		pobj.set("paymanner",paymanner);
		//修改支付名称
		pobj.setPayname(pobj.PAYNAME_TYPE[paymanner]);
		//修改付款时间
		pobj.setPaytime(new Date());
		//修改手动付款操作人 手动付款操作时间 
		pobj.set(teasession._rv.toString(),new Date());
		
	}
	out.print(str);
	return;
}else if("revocation".equals(act))//撤销手动付款
{
	String porders = teasession.getParameter("porders");//订单号
	
	String str = "撤销手动付款设置成功";
	for(int i = 1;i<porders.split("/").length;i++)
	{
		String pid = porders.split("/")[i];
		PackageOrder pobj = PackageOrder.find(pid);
		if(pobj.getType()==0)
		{ 
			str="您撤销手动付款订单中有【未付款】的订单\n系统只能撤销【已付款】的状态";
			continue;
		}
		//修改是否支付成功
		pobj.set("type",0);
		//修改支付方式
		pobj.set("paymanner",0);
		//修改支付名称
		pobj.setPayname("");
		//修改付款时间
		pobj.setPaytime(null);
		//修改手动付款操作人 手动付款操作时间 
		pobj.set("",null);
		
		//添加撤销人，时间
		pobj.setRevocation(teasession._rv.toString(),new Date());
		
	}
	out.print(str);
	return;
}else if("_Determine_fp".equals(act))//修改开具状态
{
	String porders = teasession.getParameter("porders");//订单号
	int issued = Integer.parseInt(teasession.getParameter("issued"));//发票开具状态
	String str = "发票开具状态设置成功";
	for(int i = 1;i<porders.split("/").length;i++)
	{
		String pid = porders.split("/")[i];
		PackageOrder pobj = PackageOrder.find(pid);
		
		if(pobj.getWhethermail()==0)//不需要开发票的
		{
			str="您修改的开具发票状态订单中有【不需要开发票】的订单\n系统只能修改【开发票】的状态订单";
			continue;
		}
		
		pobj.set("issued",issued);

	}
	out.print(str);
	return;
}else if("_Setshoudong2".equals(act))//手动生效
{
	String porders = teasession.getParameter("porders");//订单号
	String str = "手动生效设置成功";
	for(int i = 1;i<porders.split("/").length;i++)
	{
		String pid = porders.split("/")[i];
		PackageOrder pobj = PackageOrder.find(pid);
		
		if(pobj.getEffect()==1)//
		{
			str="您修改的订单中有【已生效】的订单\n系统只能修改【未生效】的状态订单";
			continue;
		}
		
		pobj.set("effect",1);//修改生效状态
		pobj.setEffect(teasession._rv.toString(),new Date()); //修改生效时间
		//修改激活时间 
		pobj.setActivatimet(new Date());//修改激活时间
		
		//添加套餐阅读状态和阅读开始结束时间
		pobj.setSubtime(pid);//修改套餐阅读有效期
		

	}
	out.print(str);
	return;
}else if("f_cx2effect".equals(act))//撤销手动生效
{

	String porders = teasession.getParameter("porders");//订单号
	String str = "撤销手动生效设置成功";
	for(int i = 1;i<porders.split("/").length;i++)
	{
		String pid = porders.split("/")[i];
		PackageOrder pobj = PackageOrder.find(pid);
		
		if(pobj.getEffect()==0)//
		{
			str="您修改的订单中有【未生效】的订单\n系统只能撤销【已生效】的状态订单";
			continue;
		}
		
		pobj.set("effect",0);//修改生效状态
		pobj.setEffect("",null); //修改生效时间
		pobj.set(0,null,null);//修改套餐阅读有效期
		pobj.setActivatimet(null);//修改激活时间

	} 
	out.print(str);
	return;
}


%>
