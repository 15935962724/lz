package tea.ui;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
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
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import tea.entity.Http;
import tea.entity.custom.jjh.Voltype;
import tea.entity.custom.jjh.Volunteer;
import tea.entity.util.Card;
import tea.entity.zs.Ctf;

public class CtfSeivlet extends TeaServlet{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		response.setContentType("text/html;charset=UTF-8");
		Http h=new Http(request);
		//TeaSession tea=new TeaSession(request);
		String status=null;
		String msg="";
		String path="";
		status=h.get("status");
		String nexturl=h.get("nextUrl");
		if(status!=null&&!("".equals(status))){
			if("add".equals(status)){
				String name=h.get("name");
				int sex=h.getInt("sex");
				String creNum=h.get("creNum");
				String creNumber=h.get("creNumber");
				String creName=h.get("creName");
				String creLv=h.get("creLv");
				String markName1=h.get("markName1");
				String markName2=h.get("markName2");
				String markName3=h.get("markName3");
				String markName4=h.get("markName4");
				String markName5=h.get("markName5");
				String markName6=h.get("markName6");
				String mark1=h.get("mark1");
				String mark2=h.get("mark2");
				String mark3=h.get("mark3");
				String mark4=h.get("mark4");
				String mark5=h.get("mark5");
				String mark6=h.get("mark6");
				Date time=h.getDate("time");
				String danwei=h.get("danwei");
				String gra=h.get("gra");
				String photo=h.get("photo");
				String otherName=h.get("otherName");
				String other=h.get("other");
				
				try {
					
					Ctf certificate= new Ctf();
					certificate.create(name, sex, creNum, creNumber, creName, creLv, markName1, markName2, markName3, markName4,markName5, markName6, mark1, mark2, mark3, mark4,mark5, mark6, danwei, gra,time,photo,otherName,other);
				} catch (Exception e) {
					
					e.printStackTrace();
				}
				
				msg="<script>pmt.show('证书添加成功！',1,'" + nexturl + "');</script>";
			}
			if(status.equals("edit")){
				int id=h.getInt("id");
				String name=h.get("name");
				int sex=h.getInt("sex");
				String creNum=h.get("creNum");
				String creNumber=h.get("creNumber");
				String creName=h.get("creName");
				String creLv=h.get("creLv");
				String markName1=h.get("markName1");
				String markName2=h.get("markName2");
				String markName3=h.get("markName3");
				String markName4=h.get("markName4");
				String markName5=h.get("markName5");
				String markName6=h.get("markName6");
				String mark1=h.get("mark1");
				String mark2=h.get("mark2");
				String mark3=h.get("mark3");
				String mark4=h.get("mark4");
				String mark5=h.get("mark5");
				String mark6=h.get("mark6");
				Date time=h.getDate("time");
				String danwei=h.get("danwei");
				String gra=h.get("gra");
				String photo=h.get("photo");
				String otherName=h.get("otherName");
				String other=h.get("other");
                try {
					
                	Ctf ctf=new Ctf(id,name, sex, creNum, creNumber, creName, creLv, markName1, markName2, markName3, markName4, markName5, markName6, mark1, mark2, mark3, mark4, mark5, mark6, time, danwei, gra, photo, otherName, other);
					ctf.setCtf();
					msg="<script>pmt.show('证书修改成功！',1,'" + nexturl + "');</script>";
				} catch (Exception e) {
					
					e.printStackTrace();
				}
			}
			if(status.equals("del")){
				int id=h.getInt("cid");
                try {
					
                	Ctf ctf=new Ctf(id);
					ctf.delCtf();
					msg="<script>pmt.show('证书删除成功！',1,'" + nexturl + "');</script>";
				} catch (Exception e) {
					
					e.printStackTrace();
				}
				
			}
			if(status.equals("Excel")){
				String sql=h.get("ids");
				String qsql=h.get("sql");
				if(sql==""||sql==null){
					sql=qsql;
				}
				
				List list=null;
				try {
					list = Ctf.findCtf(sql, 0, Integer.MAX_VALUE);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
//				pw.close();
				ServletOutputStream s=response.getOutputStream();
				WritableWorkbook ww=Workbook.createWorkbook(s);
				WritableSheet sheet=ww.createSheet("查询结果", 0);
				response.setContentType("application/x-msdownload");
				String name="证书信息表.xls";
				response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\"");
				WritableFont wf= new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
				WritableCellFormat cf=new WritableCellFormat(wf);// 单元格定义
				try {
					cf.setAlignment(jxl.format.Alignment.LEFT);
				} catch (WriteException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} // 设置对齐方式
				// ws.getSettings().setPrintGridLines(true);//是否打印网格线
				int cols=23;
				for(int i=0;i<cols;i++){
					sheet.setColumnView(i, 20); // 设置列的宽度
				}
				String[] showcol=new String[]{"姓名","性别","证件号码","证书编号","证书名称","证书级别","成绩1","成绩","成绩2","成绩","成绩3","成绩","成绩4","成绩","成绩5","成绩","成绩6","成绩","数据上报单位","评定成绩","发证时间","备注名称","备注内容"};
				for(int i=0;i<cols;i++){
					try {
						sheet.addCell(new Label(i,0,showcol[i],cf));
					} catch (RowsExceededException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (WriteException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				int j=0;
				Iterator it=list.iterator();
				while(it.hasNext()){
					Ctf ctf=(Ctf) it.next();
					String cName=ctf.getName()==null?"":ctf.getName();
					String sex=ctf.getSex()==0?"男":"女";
					String creNum=ctf.getCreNum()==null?"":ctf.getCreNum();
					String creNumber=ctf.getCreNumber()==null?"":ctf.getCreNumber();
					String creName=ctf.getCreName()==null?"":ctf.getCreName();
					String creLv=ctf.getCreLv()==null?"":ctf.getCreLv();
					String markName1=ctf.getMarkName1()==null?"":ctf.getMarkName1();
					String markName2=ctf.getMarkName2()==null?"":ctf.getMarkName2();
					String markName3=ctf.getMarkName3()==null?"":ctf.getMarkName3();
					String markName4=ctf.getMarkName4()==null?"":ctf.getMarkName4();
					String markName5=ctf.getMarkName5()==null?"":ctf.getMarkName5();
					String markName6=ctf.getMarkName6()==null?"":ctf.getMarkName6();
					String mark1=ctf.getMark1()==null?"":ctf.getMark1();
					String mark2=ctf.getMark2()==null?"":ctf.getMark2();
					String mark3=ctf.getMark3()==null?"":ctf.getMark3();
					String mark4=ctf.getMark4()==null?"":ctf.getMark4();
					String mark5=ctf.getMark5()==null?"":ctf.getMark5();
					String mark6=ctf.getMark6()==null?"":ctf.getMark6();
					String danwei=ctf.getDanwei()==null?"":ctf.getDanwei();
					String gra=ctf.getGra()==null?"":ctf.getGra();
					String time=ctf.getTime()==null?"":Ctf.sdf2.format(ctf.getTime());
					String otherName=ctf.getOtherName()==null?"":ctf.getOtherName();
					String other=ctf.getOther()==null?"":ctf.getOther();
					try {
						
						sheet.addCell(new Label(0,j+1,cName));
						sheet.addCell(new Label(1,j+1,sex));
						sheet.addCell(new Label(2,j+1,creNum));
						sheet.addCell(new Label(3,j+1,creNumber));
						sheet.addCell(new Label(4,j+1,creName));
						sheet.addCell(new Label(5,j+1,creLv));
						sheet.addCell(new Label(6,j+1,markName1));
						sheet.addCell(new Label(7,j+1,mark1));
						sheet.addCell(new Label(8,j+1,markName2));
						sheet.addCell(new Label(9,j+1,mark2));
						sheet.addCell(new Label(10,j+1,markName3));
						sheet.addCell(new Label(11,j+1,mark3));
						sheet.addCell(new Label(12,j+1,markName4));
						sheet.addCell(new Label(13,j+1,mark4));
						sheet.addCell(new Label(14,j+1,markName5));
						sheet.addCell(new Label(15,j+1,mark5));
						sheet.addCell(new Label(16,j+1,markName6));
						sheet.addCell(new Label(17,j+1,mark6));
						sheet.addCell(new Label(18,j+1,danwei));
						sheet.addCell(new Label(19,j+1,gra));
						sheet.addCell(new Label(20,j+1,time));
						sheet.addCell(new Label(21,j+1,otherName));
						sheet.addCell(new Label(22,j+1,other));
					
					
					} catch (RowsExceededException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (WriteException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}


					j++;
				}
				ww.write();
				try {
					ww.close();
				} catch (WriteException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				s.close();
				return ;
			}
			if(status.equals("editbz")){
				String otherName=h.get("otherName");
				String other=h.get("other");
				String ids=h.get("ids");
				if(ids!=null&&ids.trim().length()>0&&(!"/".equals(ids.trim()))){
					String[] id=ids.split("/");
					for(int i=0;i<id.length;i++){
						if(id[i]!=null&&id[i].length()>0){
						   int cid=Integer.parseInt(id[i]);	
						   try {
								
			                	Ctf ctf=new Ctf(cid,otherName,other);
								ctf.editbz();
							} catch (Exception e) {
								
								e.printStackTrace();
							}
						}
					}
				}
				msg="<script>pmt.show('备注批量修改成功！',1,'" + nexturl + "');</script>";
				
			}
			if(status.equals("delAll")){
				String ids=h.get("ids");
				if(ids!=null&&ids.trim().length()>0&&(!"/".equals(ids.trim()))){
					String[] id=ids.split("/");
					for(int i=0;i<id.length;i++){
						if(id[i]!=null&&id[i].length()>0){
						   int cid=Integer.parseInt(id[i]);	
						   try {
								
			                	Ctf ctf=new Ctf(cid);
								ctf.delCtf();
							} catch (Exception e) {
								
								e.printStackTrace();
							}
						}
					}
				}
				msg="<script>pmt.show('证书删除成功！',1,'" + nexturl + "');</script>";
				
			}
		}
		PrintWriter pw=response.getWriter();
		pw.println("<script>var pmt=parent.mt,doc=parent.document;</script>");
		if(msg.trim().length()>0){
			pw.print(msg);
		}
		pw.close();
		return;
		
	}
}
