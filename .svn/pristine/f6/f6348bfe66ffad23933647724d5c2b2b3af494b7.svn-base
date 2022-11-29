<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.member.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="jxl.*"%><%@page import="java.io.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String nexturl=teasession.getParameter("nexturl");
String act=teasession.getParameter("act");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<%!
public String cellToString(Cell c)
{
	String str=c.getContents();
	if(str==null||"null".equals(str))
	{
		str=null;
	}
	return str;
}
public java.util.Date cellToDate(Cell c)
{
	String str=c.getContents();
	if(str==null||"null".equals(str))
	{
		str=null;
	}
	java.util.Date d=null;
	try
	{
		d=Entity.sdf2.parse(str);
	}catch(Exception ex)
	{
		try
		{
			d=Entity.sdf.parse(str);
		}catch(Exception ex2)
		{
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy年MM月dd日");
			try
			{
				d=sdf.parse(str);
			}catch(Exception ex3)
			{
				sdf = new java.text.SimpleDateFormat("MM/dd/yyyy");
				try
				{
					d=sdf.parse(str);
				}catch(Exception ex4)
				{

				}
			}
		}
	}
	return d;
}
%>
<%
byte by[]=teasession.getBytesParameter("file");//获得文件
if(by!=null)
{
	ByteArrayInputStream bais=new ByteArrayInputStream(by);
	try
	{
		Workbook wb=Workbook.getWorkbook(bais);
		Sheet s=wb.getSheet(0);
		if(teasession.getParameter("import")!=null)//点击 导入执行下面代码
		{
			out.println("总行数:"+s.getRows()+" 正在导入:<span id=c >0</span>");
			out.flush();
            int size=s.getRows()/100;
            if(size<1)
            size=1;
            Date time=new Date();
			if("importprofile9000".equals(act))//导入
			{

				String node=null;
				String node2=null;
				node2 = cellToString(s.getCell(0,1));

					Goods gobj = Goods.find(Integer.parseInt(node2),teasession._nLanguage);
                  	String goodtype[] = gobj.getGoodstype().split("/");

                  	String name=null;
                  		int iii=1;//把动态属性导入
                  	for(int ii=1;ii<goodtype.length;ii++)
                  	{



                  		Enumeration e = Attribute.findByGoodstype(Integer.parseInt(goodtype[ii]));

                  		for(int j =0;e.hasMoreElements();j++)
                  		{
                  			name = cellToString(s.getCell(4+iii,0));

                  			int attid = ((Integer)e.nextElement()).intValue();
                  			Attribute obj = Attribute.find(attid);
                  			AttributeValue.set_name(attid,name);
                  			iii++;
                  		}

                  	}

				for(int i=1;i<s.getRows();i++)
				{

					String subject=null;//商品名字
					String brand = null;//品牌
					String price =null;//价格
					String serialnumber=null;//货号
					String attrvalue =null;
					//for(int jj =4;jj<s.getColumns();jj++)
					//{


					//}

					for(int j=0;j<s.getColumns();j++)
					{
						switch(j)
						{
						case 0:
							node=cellToString(s.getCell(j,i));
							break;
						case 1:
							subject=cellToString(s.getCell(j,i));
							break;
						case 2:
							brand=cellToString(s.getCell(j,i));
							break;
						case 3:
							price=cellToString(s.getCell(j,i));
							break;
						case 4:
							serialnumber=cellToString(s.getCell(j,i));
							break;

						}
					}

                    tea.entity.node.Node nodeobj = tea.entity.node.Node.find(Integer.parseInt(node));
                    Enumeration aten = AttributeValue.findByNode(Integer.parseInt(node));
                    for(int at=0;aten.hasMoreElements();at++)
                    {
                    	int attribute = ((Integer)aten.nextElement()).intValue();
                    	AttributeValue atobj = AttributeValue.find(Integer.parseInt(node),attribute);
                    	attrvalue = cellToString(s.getCell(at+5,i));
                    	AttributeValue.set_Value(attrvalue,attribute,Integer.parseInt(node));


                    	System.out.print("attrvalue:"+attrvalue+"-node:="+node+"--"+"--attribute:"+attribute+"\r\n");


                    }
					//if(nodeobj.isExisted(Integer.parseInt(node)))
					//{

						nodeobj.set(subject,brand,price,serialnumber,teasession._nLanguage);
						//System.out.print("导入成功");
					//}//else
					//{
						//Profile9000.create(teasession._strCommunity, null, node, Subject, 0,time);
					//}
					if(i%size==0)
					{
						out.print("<script>c.innerHTML="+(i)+"</script>");
						out.flush();
					}
				}


			}

			out.print("<script>window.open('/jsp/info/Succeed.jsp?nexturl='+encodeURIComponent(\""+nexturl+"\"),'_parent');</script>");
		}else//导入数据预览
		{
			out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");

			for(int i=0;i<s.getRows()&&i<21;i++)
			{
				out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
				for(int j=0;j<s.getColumns();j++)
				{
					String str=s.getCell(j,i).getContents();
					out.print("<td>"+("null".equals(str)?"&nbsp;":str));
				}
				out.print("</tr>");
				if(i==20)
				{
					out.print("<tr><td colspan=8>总行数为:"+s.getRows()+".   只显示前20行.......</td></tr>");
				}
			}
			out.print("</table>");
		}
		wb.close();
	}catch(Exception ex)
	{
		out.print("<table style=color:#FF0000 border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
		out.print("<tr><td>错误:  可能有以下原因导致</td></tr>");
		out.print("<tr><td>1.文件格式错误</td></tr>");
		out.print("<tr><td>2.列没有匹配,请按照预览的格式进行调整.</td></tr>");
		out.print("<tr><td>&nbsp;</td></tr>");
		out.print("<tr><td>描述:</td></tr>");
		out.print("<tr><td>"+ex.getMessage()+"</td></tr>");
		out.print("</table>");
		ex.printStackTrace();
//		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
		return;
	}finally
	{
		bais.close();
	}
}
%>

</body>
</html>
