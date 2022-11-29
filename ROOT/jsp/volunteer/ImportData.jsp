<%@page import="tea.entity.util.Spell"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.format.UnderlineStyle"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="tea.entity.volunteer.Volunteer"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.member.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="jxl.*"%><%@page import="java.io.*"%><%@page import="tea.entity.women.Contributions"%>
<%
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

				for(int i=1;i<s.getRows();i++)
				{
					
					
					String name = null;//姓名
					boolean sex = false;//性别
					
					Date birth =null;//出生日期
					String mobile=null;//手机
					String telephone =null;//座机电话
					String email = null;//Email
					String zhiye=null;//职业
					String city=null;//现居住地所在区县
					String way = null;//首选参与意向
					String picture = null;//图片路径
					String xuanyan = null;//申请宣言
					
					for(int j=0;j<s.getColumns();j++)
					{
						switch(j)
						{
						case 0:
							name=cellToString(s.getCell(j,i));
							break;
						case 1:
							if(cellToString(s.getCell(j,i))!=null && "男".equals(cellToString(s.getCell(j,i))))
							{
								sex = true;
							}
							
							break;
						case 2:
							if(cellToString(s.getCell(j,i))!=null && cellToString(s.getCell(j,i)).length()>0)
							{
								birth=Entity.sdf.parse(cellToString(s.getCell(j,i)));
							}
							
							break;
						case 3:
							mobile=cellToString(s.getCell(j,i));
							
							break;
						case 4:
							telephone=cellToString(s.getCell(j,i));
							break;
						case 5:
							email=cellToString(s.getCell(j,i));
							break;
						case 6:
							zhiye=cellToString(s.getCell(j,i));
							break;
						case 7:
							if(cellToString(s.getCell(j,i))!=null && cellToString(s.getCell(j,i)).length()>0)
							{

									city = Volunteer.getCITYS(cellToString(s.getCell(j,i)));
							}
						
							break;
					
						case 8:
							picture=cellToString(s.getCell(j,i));
							break;
					
						}
					}
					
					String member = null;
					SeqTable seq = new SeqTable();
                    final java.text.DecimalFormat df5 = new java.text.DecimalFormat("00000");
                    if(name != null)
                    {
                        member = member = Spell.getSpell(name.replaceAll(" ","").toLowerCase()).replaceAll(" ","") + df5.format(seq.getSeqNo(teasession._strCommunity));
                    }
					
                    if(!Profile.isExisted(member))
                    {
                        Profile.create(member,"",teasession._strCommunity,email,birth,1,teasession._nLanguage,name,"","","",city,"","","",telephone,"","",mobile);
                        Profile pro = Profile.find(member);
                        //pro.setMobile(mobile);
                        pro.setCity(city,teasession._nLanguage);
                     //   pro.setBirth(Entity.sdf.parse(birth));
                       
                        pro.setSex(sex);
                        
                        pro.setPhotopath(picture,teasession._nLanguage);
                        String answer = ",C,D,B,B,B,A,A,A,A,A,";
                        Volunteer.set(member,teasession._strCommunity,answer,xuanyan,zhiye,way,3);
                        //if(tongguo.equals("tongguo"))
                        //{
                            Volunteer.typeIf(member);
                        //}
     
                       // 
                    }
				
					if(i%size==0)
					{
						out.print("<script>c.innerHTML="+(i)+"</script>");
						out.flush();
					}
				}


			}
  
    
			

			out.print("<script>alert('信息导入成功!');window.open('"+nexturl+"','_parent');</script>"); 
			
		}
		else//导入数据预览
		{
			out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");

			for(int i=0;i<s.getRows()&&i<21;i++)
			{
				out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
				for(int j=0;j<s.getColumns();j++)
				{
					String str=s.getCell(j,i).getContents();
					out.print("<td  nowrap>"+("null".equals(str)?"&nbsp;":str));
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
