<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.site.Html"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@page  import="tea.entity.member.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.zs.*" %>
<%@page import="jxl.*"%><%@page import="java.io.*"%><%@page import="tea.entity.women.Contributions"%><%@page import="tea.entity.custom.jjh.*" %><%@page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String nexturl=teasession.getParameter("nexturl");

String act=teasession.getParameter("status");
System.out.print("***********"+teasession._strCommunity+"#"+act);
%><html>
<head>
<link href="/res/Home/cssjs/community.css" rel="stylesheet" type="text/css">
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
		str="";
	}
	return str;
}
public  void delete(Node n)
{
    try
    {
        Html t = Html.find(n.getCommunity());
        final String dir = Html.getPath(n.getCommunity());
        if(t.minute > 0)
        {
            String[] arr = n.getPath().split("/");
            int lang = License.getInstance().getWebLanguages();
            for(int i = 1;i < arr.length;i++)
            {
                for(int j = 0;j < Common.LANGUAGE.length;j++)
                {
                    if((lang & 1 << j) != 0)
                        new File(dir,arr[i] + "-0" + j + ".htm").delete();
                }
            }
            return;
        }
        new Thread()
        {
            public void run()
            {
                Filex.delete(new File(dir));
            }
        }.start();
    } catch(Exception ex)
    {
        ex.printStackTrace();
    }
}
public  Date d(double d)
{
    d = (d - 25569.3333333333D) * 1000 * 60 * 60 * 24;
    return new Date((long) d);
}
public java.util.Date cellToDate(Cell c)
{
	if(CellType.DATE.equals(c.getType())){
		DateCell dc=(DateCell)c;
		return dc.getDate();
	}else if(CellType.NUMBER.equals(c.getType())){
		String str=c.getContents();
		Date d=d(Double.parseDouble(str));
		return d;
	}else{
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
					sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
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
		if(teasession.getParameter("imports")!=null&&"2".equals(teasession.getParameter("imports")))//点击 导入执行下面代码
		{
			out.println("总行数:"+s.getRows()+" 正在导入:<span id=c >0</span><br>");
			out.println("<span id=cc></span>"); 
			out.println("<span id=ccc></span><br>"); 
			out.println("<span id=cccc></span><br>"); 
			out.println("<span id=ccccc></span><br>"); 
			out.println("<span id=cccccc></span><br>"); 
			out.flush();
            int size=s.getRows()/100;
            if(size<1)
            size=1;
            Date time=new Date();
            Event eobj = Event.find(teasession._nNode,teasession._nLanguage);
            StringBuffer sp = new StringBuffer();//判断没有的会员编号
            StringBuffer sp2 = new StringBuffer();//判断没有的用户名
            StringBuffer sp3 =new StringBuffer();//有重复的身份证
            StringBuffer sp4 =new StringBuffer();//有重复的手机号
            StringBuffer sp5 =new StringBuffer();//姓名不能为空
			if("importprofile9100".equals(act))//导入
			{

				 Node node=Node.find(teasession._nNode);
				 boolean xos=node.getType()==1;
				 int nodeid=1;
				 int failCount=0;
                 int sucCount=0;
				for(int i=1;i<s.getRows();i++)
				{
					
					 if(xos){
						 int sequence = Node.getMaxSequence(teasession._nNode) + 10;
		                 int  options1 = 0;
		                 long options=node.getOptions();
		                 Category cat=Category.find(teasession._nNode);
		               //  nodeid=Node.create(teasession._nNode,sequence,teasession._strCommunity,teasession._rv,cat.getCategory(),false,options,options1,node.getDefaultLanguage(),null,null,new Date(),0,0,0,0,null,null,teasession._nLanguage,"","","",null,"",null,0,null,"","","","","","");
		                 nodeid=Node.create(teasession._nNode,sequence,teasession._strCommunity,teasession._rv,cat.getCategory(),false,options,options1,node.getDefaultLanguage(),null,null,new Date(),0,0,0,0,null,teasession._nLanguage,"","","",null,"",null,0,null,"","","","","","");
					 }

					
				        String name="";
				        String csex="";
					    String creNum="";
					    String creNumber="";
					    String creName="";
					    String creLv="";
					    String markName1="";
					    String markName2="";
					    String markName3="";
					    String markName4="";
					    String markName5="";
					    String markName6="";
					    String mark1="";
					    String mark2="";
					    String mark3="";
					    String mark4="";
					    String mark5="";
					    String mark6="";
					    Date ctime=null;
					    String danwei="";
					    String gra="";
					    String photo="";
					    String otherName="";
					    String other="";
					
				
					    
					int a =0;
					for(int j=0;j<s.getColumns();j++)
					{
						
						switch(j)
							{
							case 0:
								name=cellToString(s.getCell(j,i));
								break;
							case 1:
								csex=cellToString(s.getCell(j,i));					
								break;
							case 2:
								creNum=cellToString(s.getCell(j,i));
								break;
							case 3:
								creNumber=cellToString(s.getCell(j,i));
								break;
							case 4:
								creName=cellToString(s.getCell(j,i));
								break;
							case 5:
								creLv=cellToString(s.getCell(j,i));
								break;
							case 6:
								markName1=cellToString(s.getCell(j,i));
								break;
							case 7:
								mark1=cellToString(s.getCell(j,i));
								break;
							case 8:
								markName2=cellToString(s.getCell(j,i));
								break;
							case 9:
								mark2=cellToString(s.getCell(j,i));
								break;
							case 10:
								markName3=cellToString(s.getCell(j,i));
								break;
							case 11:
								mark3=cellToString(s.getCell(j,i));
								break;
							case 12:
								markName4=cellToString(s.getCell(j,i));
								break;
							case 13:
								mark4=cellToString(s.getCell(j,i));
								break;
							case 14:
								markName5=cellToString(s.getCell(j,i));
								break;
							case 15:
								mark5=cellToString(s.getCell(j,i));
								break;
							case 16:
								markName6=cellToString(s.getCell(j,i));
								break;
							case 17:
								mark6=cellToString(s.getCell(j,i));
								break;
							case 18:
								danwei=cellToString(s.getCell(j,i));
								break;
							case 19:
								ctime=cellToDate(s.getCell(j,i));
								break;
							case 20:
								otherName=cellToString(s.getCell(j,i));
								break;
							case 21:
								other=cellToString(s.getCell(j,i));
								break;
							
							 default:
								 break;


						} 
						a++;
						
				
					}
					int sex=0;
					if(csex.trim().length()>0){
						if("女".equals(csex.trim())){
							sex=1;
						}else{
							sex=0;
						}
					}
					int id=0;
					
					if((name==null||name=="")||(creNum==null||creNum=="")||(creName==null||creName=="")||(ctime==null)){
						failCount++;
						
					}else{
						String csql=" and name="+DbAdapter.cite(name)+" and cre_number="+DbAdapter.cite(creNumber)+" and cre_num="+DbAdapter.cite(creNum);
						List list=Ctf.findCtf(csql, 0, 1);
						if(list==null||list.size()<=0){
							Ctf ctf=new Ctf();
							ctf.create(name, sex, creNum, creNumber, creName, creLv, markName1, markName2, markName3, markName4, markName5, markName6, mark1, mark2, mark3, mark4, mark5, mark6, danwei, gra, ctime, photo, otherName, other);
							sucCount++;
						}else{
							 for(int k=0;k<list.size();k++){
								Ctf c= (Ctf)list.get(k);
								id=c.getId();
							} 
							Ctf upCtf=new Ctf(id,name, sex, creNum, creNumber, creName, creLv, markName1, markName2, markName3, markName4, markName5, markName6, mark1, mark2, mark3, mark4, mark5, mark6, ctime, danwei, gra, photo, otherName, other);
							upCtf.updateCtf();
							sucCount++;
						}
					}
				    
					
					
					// delete(node);
					 
						
			            	

						if(i%size==0)
						{
							out.print("<script>c.innerHTML="+(i)+"</script>");
							out.flush();
						}
	            	
	            	}
				/*if(sp5.toString()!=null && sp5.toString().length()>0)
				{
					out.print("<script>document.getElementById('cccccc').innerHTML='"+sp5.toString()+"'</script>");
					out.flush(); 
				}
				 
				if(sp4.toString()!=null && sp4.toString().length()>0)
				{
					out.print("<script>document.getElementById('ccccc').innerHTML='重复的手机号用户名：<br>"+sp4.toString()+"'</script>");
					out.flush(); 
				}
				if(sp3.toString()!=null && sp3.toString().length()>0)
				{
					out.print("<script>document.getElementById('cccc').innerHTML='重复的身份证用户名：<br>"+sp3.toString()+"'</script>");
					out.flush(); 
				}
				
				
	            	if(sp2.toString()!=null && sp2.toString().length()>0)
					{
						out.print("<script>document.getElementById('ccc').innerHTML='不存在的用户名：<br>"+sp2.toString()+"'</script>");
						out.flush(); 
					}
	            	if(sp.toString()!=null && sp.toString().length()>0)
					{
						out.print("<script>document.getElementById('cc').innerHTML='不存在的会员编号：<br>"+sp.toString()+"'</script>");
						out.flush();
					}
	            	*/
				if(failCount>0){
			    	out.print("有"+failCount+"条数据未导入，原因：必填项未填写！");
			    }
	            	out.print(sucCount+"条数据成功导入或更新，请点击<a href='###' onclick='window.close();'>这里</a>返回");
					out.flush();

				
					
				
				}
				
				


			
			
		}else//导入数据预览
		{
			out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>");
			int ics = 0;

			for(int i=0;i<s.getRows()&&i<21;i++)
			{
				String membername =null;//姓名
				out.print("<tr onMouseOver=this.bgColor='#BCD1E9' onMouseOut=this.bgColor=''>");
				
				for(int j=0;j<s.getColumns();j++)
				{
					
					String str=s.getCell(j,i).getContents();
					
					out.print("<td nowrap>"+("null".equals(str)?"&nbsp;":str));
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
		out.print("<tr><td>1.文件格式错误,只能导入.xls为后缀的EXCEL文档</td></tr>");
		out.print("<tr><td>2.列没有匹配,请按照预览的格式进行调整.</td></tr>");
		out.print("<tr><td>&nbsp;</td></tr>");
		out.print("<tr><td>描述:</td></tr>");
		out.print("<tr><td>"+ex.getMessage()+"</td></tr>");
		out.print("</table><script>parent.ymPrompt.close();</script>");
		ex.printStackTrace();
//		response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("文件格式错误.","UTF-8"));
		return;
	}finally
	{
		bais.close();
	}
}
%>
<script>parent.ymPrompt.close();</script>
</body>
</html>


