package tea.ui.node;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.*;

import tea.entity.Http;
import tea.entity.node.Mphoto;

/**
 * Servlet implementation class EditMphoto
 */
public class EditMphoto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		Http h=new Http(request,response);
		String act=h.get("act"),nexturl=h.get("nexturl");
//		if(h.member<=0&&(!"add".equals(act))){
//			out.print("<script>alert('验证码输入错误');window.location.href='"+nexturl+"';</script>");
//			return;
//		}
		String txtreturn="";
		if("add".equals(act)){
			PrintWriter out=response.getWriter();
			HttpSession session=request.getSession();
			out.println("<script> var vmt=parent.mt,doc=parent.document;</script>");
			 int type = h.getInt("type");
			 
             String sname = type == 0 ? "sms.vertify" : "verify";
             if(!h.get("verify" + type,"").equalsIgnoreCase((String) session.getAttribute(sname)))
             {
     			out.println("<script>alert('验证码输入错误');window.location.href='"+nexturl+"';</script>");
                 return;
             }
             session.removeAttribute(sname);
             
			String[] a= h.getValues("attach");
			StringBuffer sb=new StringBuffer();
			if(a.length>0){
				sb.append(a[0]);
			}
			String time =h.get("time").length()==0?null:h.get("time");
			Mphoto.set(0, h.get("author"), h.get("phone"), sb.toString(), h.get("introduce"), h.get("place"), time, h.get("parameters"));
			txtreturn="信息提交成功！";
			//out.println("<script>vmt.show('"+txtreturn+"',2,'"+nexturl+"');</script>");
			if(session.getAttribute("author")!=null){
				session.removeAttribute("author");
			}
			if(session.getAttribute("phone")!=null){
				session.removeAttribute("phone");
			}
			session.setAttribute("author",  h.get("author"));
			session.setAttribute("phone",  h.get("phone"));
			out.println("<script>alert('"+txtreturn+"');window.location.href='"+nexturl+"';</script>");
			//response.sendRedirect(nexturl);
			out.close();
			return;
		}else if("excel".equals(act)){
			ServletOutputStream s=response.getOutputStream();
			WritableWorkbook ww=Workbook.createWorkbook(s);
			WritableSheet sheet=ww.createSheet("图片信息表", 0);
		  try{
			String sql=h.get("vid");
			Enumeration e=Mphoto.findMphotos(" order by id desc", 0, Integer.MAX_VALUE);
//			pw.close();
			response.setContentType("application/x-msdownload");
			String name="图片信息表.xls";
			response.setHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("GBK"),"ISO-8859-1") + "\"");
			WritableFont wf= new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
			WritableCellFormat cf=new WritableCellFormat(wf);// 单元格定义
			cf.setAlignment(jxl.format.Alignment.LEFT); // 设置对齐方式
			// ws.getSettings().setPrintGridLines(true);//是否打印网格线
			int cols=7;
			for(int i=0;i<cols;i++){
				sheet.setColumnView(i, 20); // 设置列的宽度
			}
			String[] showcol=new String[]{"作者","联系方式","图片说明","拍摄地点","拍摄时间","拍摄参数","图片路径"};
			for(int i=0;i<cols;i++){
				sheet.addCell(new Label(i,0,showcol[i],cf));
			}
			int j=1;
			while(e.hasMoreElements()){
				int mem=(Integer)e.nextElement();
				Mphoto mp=Mphoto.findPhoto(mem);
				if(mp.isExits()){
					sheet.addCell(new Label(0,j,mp.getAuthor()));
					sheet.addCell(new Label(1,j,mp.getPhone()));
					sheet.addCell(new Label(2,j,mp.getIntroduce()));
					sheet.addCell(new Label(3,j,mp.getPlace()));
					sheet.addCell(new Label(4,j,mp.getTime()));
					sheet.addCell(new Label(5,j,mp.getParameters()));
					sheet.addCell(new Label(6,j,mp.getPath()));
				}
				
				
				
				j++;
			}

			ww.write();
			ww.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			s.close();
			return ;
		}
		}else if("deleteFile".equals(act)){
			String file=h.get("mfiles");
			if(file.length()>0&&(!file.equals("|"))){
		        ServletContext application = getServletContext();
				String[] files=file.split("[|]");
				for(int i=0;i<files.length;i++){
					if(new File(application.getRealPath(files[i])).exists()){
						new File(application.getRealPath(files[i])).delete();
					}
				}
			}
		}
	
	}
}
