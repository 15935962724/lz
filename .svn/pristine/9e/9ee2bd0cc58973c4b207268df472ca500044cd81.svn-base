package tea.ui.notices;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import tea.entity.Entity;
import tea.entity.custom.jjh.Voltype;
import tea.entity.custom.jjh.Volunteer;
import tea.entity.node.Category;
import tea.entity.node.Node;
import tea.entity.notices.Notices;
import tea.entity.util.Card;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditNotices  extends TeaServlet{
	public void init(javax.servlet.ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
    }
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
	  request.setCharacterEncoding("UTF-8");
	  TeaSession tea=new TeaSession(request);
	  if(tea._rv==null){
		  response.sendRedirect("/servlet/StartLogin?node=" + tea._nNode);
          return;
	  }
	  String act=tea.getParameter("act");
	  String nexturl=tea.getParameter("nextUrl");
	  String cont="";
	  if("Excel".equals(act)){
			ServletOutputStream s=response.getOutputStream();
			WritableWorkbook ww=Workbook.createWorkbook(s);
		  try{
		  	Enumeration e=Notices.fintList("", 0, Integer.MAX_VALUE);
//			pw.close();
			WritableSheet sheet=ww.createSheet("查询结果", 0);
			response.setContentType("application/x-msdownload");
			String name="标讯信息表.xls";
			response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\"");
			WritableFont wf= new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
			WritableCellFormat cf=new WritableCellFormat(wf);// 单元格定义
			cf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式
			// ws.getSettings().setPrintGridLines(true);//是否打印网格线

			String[] showcol=new String[]{"工程编号","工程名称","工程地址","业主单位名称","总包单位名称","编辑人","内容","发布时间"};
			int cols=showcol.length;
			for(int i=0;i<cols;i++){
				sheet.setColumnView(i, 20); // 设置列的宽度
			}
			for(int i=0;i<cols;i++){
				sheet.addCell(new Label(i,0,showcol[i],cf));
			}
			int j=0;
			while(e.hasMoreElements()){
				int nid=(Integer)e.nextElement();
				Notices nt=Notices.find(nid);
				String noteid="", nname="", address="",ownerName="",generalName="",editname="",content="",time="";
				if(nt.getNoteid()!=null){
					noteid=nt.getNoteid();
				}
				if(nt.getNname()!=null){
					nname=nt.getNname();
				}
				if(nt.getAddress()!=null){
					address=nt.getAddress();
				}
				if(nt.getOwnerName()!=null){
					ownerName=nt.getOwnerName();
				}
				if(nt.getGeneralName()!=null){
					generalName=nt.getGeneralName();
				}
				if(nt.getEditname()!=null){
					editname=nt.getEditname();
				}
				if(nt.getContent()!=null){
					content=nt.getContent();
				}
				if(nt.getTime()!=null){
					time=Notices.sdf2.format(nt.getTime());
				}
				sheet.addCell(new Label(0,j+1,noteid));
				sheet.addCell(new Label(1,j+1,nname));
				sheet.addCell(new Label(2,j+1,address));
				sheet.addCell(new Label(3,j+1,ownerName));
				sheet.addCell(new Label(4,j+1,generalName));
				sheet.addCell(new Label(5,j+1,editname));
				sheet.addCell(new Label(6,j+1,content));
				sheet.addCell(new Label(7,j+1,time));




				j++;
			}
			sheet.addCell(new Label(0,j+1,"合计"));
			ww.write();
			ww.close();
		  }catch(Exception e){

		  }finally{

			s.close();
			return ;
		  }
	  }else{
	  if("edit".equals(act)){
		  if(tea.getParameter("node")!=null&&tea.getParameter("node").length()>0){

				  int nodeid=Integer.parseInt(tea.getParameter("node"));
				  Node node= Node.find(nodeid);
				  String noteid=tea.getParameter("ProjectNumber");
				  String nname=tea.getParameter("ProjectName");
				  String address=tea.getParameter("ProjectAddresss");
				  String ownerName=tea.getParameter("OwnerName");
				  String generalName=tea.getParameter("PackageName");
				  String editname=tea.getParameter("EditPerson");
				  String content=tea.getParameter("content");
				  Date time=null;
				  try{
					  String s=tea.getParameter("vtime");
				  time=Notices.sdf2.parse(tea.getParameter("vtime"));
				  }catch(Exception e){
					  time=null;
				  }

			  try{
				  if(node.getType()==1){
					  int sequence=Node.getMaxSequence(nodeid)+10;
					  long options=node.getOptions();
					  int options1=node.getOptions1();
					  String acce=node.getAccessmembersnode();
					  String com=node.getCommunity();
					  Category cat=Category.find(nodeid);
					  int type=cat.getCategory();
					  tea._nNode=Node.create(nodeid, sequence, com, tea._rv, type, (options1 & 2) != 0, options, options1, tea._nLanguage, null, null, new Date(), node.getStyle(), node.getRoot(), node.getKstyle(), node.getKroot(), null, tea._nLanguage, "", "", "", "", null, "", 0, null, "", "", "", "", "", null);

					  Notices.createNotices(noteid, tea._nNode, nname, address, ownerName, generalName, editname, content, time, new Date());
				  }else  if(node.getType()==99){
					  Enumeration e=Notices.fintList(" and node="+tea._nNode, 0, 10);
					  if(e.hasMoreElements()){
						  int nid=(Integer)e.nextElement();
						  Notices nt=Notices.find(nid);
						  nt.setNoteid(noteid);
						  nt.setNname(nname);
						  nt.setAddress(address);
						  nt.setOwnerName(ownerName);
						  nt.setGeneralName(generalName);
						  nt.setEditname(editname);
						  nt.setContent(content);
						  nt.setTime(time);
						  nt.updateNotices();
					  }

				  }
				  cont="编辑信息成功！";
			  }catch(Exception e){
				  cont="编辑信息失败！";
			  }finally{

			  }

		  }
	  }else if("del".equals(act)){
		  if(tea.getParameter("node")!=null&&tea.getParameter("node").length()>0){

			  int nodeid=Integer.parseInt(tea.getParameter("node"));
			  try{
				  Node node=Node.find(nodeid);
				  node.delete(tea._nLanguage);
		            delete(node);
		           Enumeration e=Notices.fintList(" and node ="+nodeid, 0, Integer.MAX_VALUE);
		           while(e.hasMoreElements()){
		        	   int nid=(Integer)e.nextElement();
		        	   Notices nt=Notices.find(nid);
		        	   nt.delteNotices();
		           }
					  cont="删除信息成功！";
			  }catch(Exception e){
				  cont="删除信息失败！";
			  }
		  }
	  }
	  response.setContentType("text/html;charset=UTF-8");
	  PrintWriter out=response.getWriter();
	  out.print("<script>var pmt=parent.mt,doc=parent.document;");
	  out.print("pmt.show('"+cont+"',1,'" + nexturl + "');</script>");
	return;
	  }
    }
}
