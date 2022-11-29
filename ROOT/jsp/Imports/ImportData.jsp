
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.site.Html"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@page  import="tea.entity.member.*" %>
<%@page import="tea.entity.*"%>
<%@page import="java.util.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="jxl.*"%><%@page import="java.io.*"%><%@page import="tea.entity.women.Contributions"%><%@page import="tea.entity.custom.jjh.*" %><%@page import="tea.entity.site.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


String nexturl=teasession.getParameter("nexturl");

String act=teasession.getParameter("status");
%>
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
HashMap hm = new HashMap();
//find(hm,new File("D:/红外相机照片2012.10-2013.1"));
Workbook wb;
try
{
    File f = new File("D:/file/20131119.xls"); //"E:/快盘/标本资源/野骆驼数据-添加字段/第一批2010.7-2011.5.xls"
    WorkbookSettings ws = new WorkbookSettings();
    ws.setCellValidationDisabled(true); //禁用数据"有效性"检查
    wb = Workbook.getWorkbook(f,ws);
    //System.out.println("导入：" + f.getPath() + " 用户：" + h.member);
} catch(Throwable ex)
{
    ex.printStackTrace();
    System.out.print("<script>mt.show('上传的文件格式不正确！');</script>");
    return;
}
//byte by[]=teasession.getBytesParameter("file");//获得文件by!=null
if(true)
{ 
	//ByteArrayInputStream bais=new ByteArrayInputStream(by);
	try
	{
		//Workbook wb=Workbook.getWorkbook(bais);

        Sheet s = wb.getSheet(0);
		if(true)//点击 导入执行下面代码teasession.getParameter("imports")!=null&&"2".equals(teasession.getParameter("imports"))
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

			if(true)//导入
			{

				 Node n=Node.find(22);
				 boolean xos=n.getType()==1;
				 int nodeid=1;
				 int failCount=0;
                 int sucCount=0;
         		String[] INFRARED_TYPE =
                    {"","鸟类","兽类","其它动物"};
                String[] GENDER_TYPE =
                    {"","雌","雄","雌雄都有","难以辨认"};
                String tmp;
				for(int i=1;i<s.getRows();i++)
				{
					int j = 0;
	                String sync = "2013-10-23导入_" + s.getCell(8,i).getContents(); //I:picName
	                Enumeration e = Node.find(" AND syncid=" + DbAdapter.cite(sync) + " AND type=107",0,1);
	                int nod = e.hasMoreElements() ? ((Integer) e.nextElement()).intValue() : 0;
	                Infrared t = nod > 0 ? Infrared.find(nod) : new Infrared(0);
	                System.out.println(i + "," + sync + "," + nod);
	                //
	                tmp = s.getCell(j++,i).getContents(); //A
	                t.bswdnum = s.getCell(j++,i).getContents(); //B:positionID
	                t.camnum = s.getCell(j++,i).getContents(); //C:caremaID
	                t.sdnum = s.getCell(j++,i).getContents(); //D:cardID
	                j++;
	                t.fillin = s.getCell(j++,i).getContents(); //F:downloaderName
	                t.participants = s.getCell(j++,i).getContents(); //G:surveyor
	                t.picturesum = Integer.parseInt(s.getCell(j++,i).getContents()); //H
	                t.picture = s.getCell(j++,i).getContents(); //I:picName
	                //
	                DateCell dc = (DateCell) s.getCell(j++,i); //J:shootDate
	                tmp = MT.f(dc.getDate());
	                tmp += " " + s.getCell(j++,i).getContents(); //K:shootTime
	                if(t.pstime == null)
	                {
	                    t.pstime = Entity.sdf3.parse(tmp);
	                }
	                t.wzname = s.getCell(j++,i).getContents(); //L:speciesName
	                t.num = s.getCell(j++,i).getContents(); //M:animalNum
	                tmp = s.getCell(j++,i).getContents(); //N:animalSex
	                t.gender = Arrayx.indexOf(GENDER_TYPE,tmp);
	                if(t.gender == -1)
	                {
	                    System.out.println("动物性别：“" + tmp + "”不是预期值！");
	                    return;
	                }
	                tmp = s.getCell(j++,i).getContents(); //O:objectClass
	                t.type = Arrayx.indexOf(INFRARED_TYPE,tmp);
	                if(t.type == -1)
	                {
	                    System.out.println("对象类别：“" + tmp + "”不是预期值！");
	                    return;
	                }
	                t.placenames = s.getCell(j++,i).getContents(); //P 小地名
	                t.bhqname = s.getCell(j++,i).getContents(); //Q 保护区名称
	                t.reserve = Reserve.conv(t.bhqname);
	                t.sjlx = s.getCell(j++,i).getContents(); //R 生境类型
	                t.eastlongitude = s.getCell(j++,i).getContents(); //S
	                t.northlatitude = s.getCell(j++,i).getContents(); //T
	                tmp = s.getCell(j++,i).getContents(); //U 海拔/米
	                if(tmp.endsWith(" m"))
	                    tmp = tmp.substring(0,tmp.length() - 2);
	                if(tmp.endsWith("m"))
	                    tmp = tmp.substring(0,tmp.length() - 1);
	                if(tmp.length() > 0)
	                    t.poster = Float.parseFloat(tmp);
	                //t.remark = s.getCell(j++,i).getContents(); //V
	                t.node = Node.create(n._nNode,i,n.getCommunity(),n.getCreator(),107,false,n.getOptions(),n.getOptions1(),n.getDefaultLanguage(),t.pstime,null,n.getTime(),n.getStyle(),n.getRoot(),n.getKroot(),n.getKroot(),"xls:" + sync,n.getDefaultLanguage(),t.wzname,null,null,"",null,null,0,null,null,null,null,null,null,null);
	                System.out.print(t.node);
	                t.set();
	                sucCount++;
/* 
					if(i%size==0)
					{
							out.print("<script>c.innerHTML="+(i)+"</script>");
							out.flush();
					} */
	            	
	            }
				
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

			for(int i=0;i<s.getRows()&&i<30;i++)
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
		//bais.close();
	}
}
%>
</body>
</html>