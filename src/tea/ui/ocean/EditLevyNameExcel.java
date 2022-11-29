package tea.ui.ocean;

import java.io.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import java.math.*;
import jxl.write.*;
import tea.entity.ocean.*;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.resource.*;


public class EditLevyNameExcel extends TeaServlet
{
//	public void init(ServletConfig servletconfig) throws ServletException
//	{
//		super.init(servletconfig);
//		super.r.add("/tea/resource/Annuity");
//	} 

	protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);
		String sql = request.getParameter("sql");
		String files = request.getParameter("files");
		String action = request.getParameter("act");
		int count = 0;
		if(teasession.getParameter("count") != null && teasession.getParameter("count").length() > 0)
		{
			count = Integer.parseInt(teasession.getParameter("count"));
		}

		System.out.println("38---------");
		response.setHeader("Content-Disposition","attachment; filename=" + java.net.URLEncoder.encode(files + ".xls","UTF-8"));
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try
		{

			jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(baos);
			jxl.write.WritableSheet ws = wwb.createSheet(files,0);
			int pos = 0;
			if(teasession.getParameter("pos") != null && teasession.getParameter("pos").length() > 0)
			{
				pos = Integer.parseInt(teasession.getParameter("pos"));
			}
			int i = 0;

			if("Levyname".equals(action))
			{
				WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
				WritableCellFormat wff = new WritableCellFormat(wf);
				wff.setAlignment(jxl.format.Alignment.CENTRE);

				ws.addCell(new jxl.write.Label(0,0,"白鲸男宝宝的名字",wff));
				ws.addCell(new jxl.write.Label(1,0,"白鲸女宝宝的名称",wff));
				//ws.addCell(new jxl.write.Label(2,0,"小公主的名称",wff));
				ws.addCell(new jxl.write.Label(2,0,"姓名",wff));
				ws.addCell(new jxl.write.Label(3,0,"性别",wff));
				ws.addCell(new jxl.write.Label(4,0,"身份证号码",wff));
				ws.addCell(new jxl.write.Label(5,0,"联系电话",wff));
				ws.addCell(new jxl.write.Label(6,0,"名字寓意",wff));



				java.util.Enumeration dome = LevyName.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
				if(!dome.hasMoreElements())
				{

				} while(dome.hasMoreElements())
				{
					int lid = Integer.parseInt(String.valueOf(dome.nextElement()));
					LevyName obj = LevyName.find(lid);
					String sex = obj.getSex()!=0 ? "男" : "女";

					ws.addCell(new jxl.write.Label(0,i + 1,obj.getDolphin()));
					ws.addCell(new jxl.write.Label(1,i + 1,obj.getBigprincess()));
					//ws.addCell(new jxl.write.Label(2,i + 1,obj.getLittleprincess()));
					ws.addCell(new jxl.write.Label(2,i + 1,obj.getFirstname(),wff));
					ws.addCell(new jxl.write.Label(3,i + 1,sex));
					ws.addCell(new jxl.write.Label(4,i + 1,obj.getCard()));
					ws.addCell(new jxl.write.Label(5,i + 1,obj.getTel()));
					ws.addCell(new jxl.write.Label(6,i + 1,obj.getMoral()));

					i++;
				} 
			} else if(action.equals("LevyPicture"))
			{
				WritableFont wf = new WritableFont(WritableFont.createFont("宋体"),10,WritableFont.BOLD,false);
				WritableCellFormat wff = new WritableCellFormat(wf);
				wff.setAlignment(jxl.format.Alignment.CENTRE);

				ws.addCell(new jxl.write.Label(0,0,"姓名",wff));
				ws.addCell(new jxl.write.Label(1,0,"身份证号",wff));
				ws.addCell(new jxl.write.Label(2,0,"联系电话",wff));
				ws.addCell(new jxl.write.Label(3,0,"图片",wff));


				java.util.Enumeration dome = LevyPicture.findByCommunity(teasession._strCommunity,sql.toString(),pos,count);
				if(!dome.hasMoreElements())
				{

				} while(dome.hasMoreElements())
				{
					int oid = Integer.parseInt(String.valueOf(dome.nextElement()));
					LevyPicture obj = LevyPicture.find(oid);

                    ws.addCell(new jxl.write.Label(0,i + 1,obj.getFirstname(),wff));
                    ws.addCell(new jxl.write.Label(1,i + 1,obj.getCard(),wff));
                    ws.addCell(new jxl.write.Label(2,i + 1,obj.getTel(),wff));
                    ws.addImage(new jxl.write.WritableImage(3,i + 1,4,i+2,new File(getServletContext().getRealPath(obj.getPath()))));

					i++;
				}

			}

			System.out.println("ok");
			wwb.write();
			wwb.close();

		} catch(Exception ex)
		{
			ex.printStackTrace();
		}
		byte by[] = baos.toByteArray();
		response.setContentLength(by.length);
		OutputStream os = response.getOutputStream();
		os.write(by);
		os.close();
		System.out.println("ok2:" + by.length);

	}


	public EditLevyNameExcel()
	{
	}
}

