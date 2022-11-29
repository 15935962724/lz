package tea.ui.admin.sales;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import tea.ui.*;
import tea.entity.admin.cebbank.*;
import java.math.*;
import jxl.write.*;
import tea.entity.admin.sales.*;
import tea.entity.admin.*;

public class SaleschanceExcel extends TeaServlet
{
	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("/tea/resource/Annuity");
	}
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		TeaSession teasession = new TeaSession(request);
		String sql = request.getParameter("sql"); 
		String files =request.getParameter("files");
		
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(files + ".xls", "UTF-8"));
		javax.servlet.ServletOutputStream os = response.getOutputStream();		
		try
		{
			jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(os);
			jxl.write.WritableSheet ws = wwb.createSheet(files, 0);
			int i=0;
			if ("saleschance".equals(files))//我的任务 
			{
				ws.addCell(new jxl.write.Label(0, 0, "业务机会名称"));
				ws.addCell(new jxl.write.Label(1, 0, "客户名称"));
				ws.addCell(new jxl.write.Label(2, 0, "结束时间"));
		
				java.util.Enumeration tame = Saleschance.findByCommunity(teasession._strCommunity, sql);
			
				while(tame.hasMoreElements())
				{				
					int taid = ((Integer)tame.nextElement()).intValue();
					Saleschance taobj = Saleschance.find(taid);
					ws.addCell(new jxl.write.Label( 0, i + 1, taobj.getbscname()));
					String name;
					if(taobj.getClienttype())
						name=Workproject.find(taobj.getClientname()).getName(teasession._nLanguage);
					else
						name=Latency.find(taobj.getClientname()).getFamily();
						
					ws.addCell(new jxl.write.Label( 1, i + 1, name));
					ws.addCell(new jxl.write.Label( 2, i + 1, taobj.getDatesToString()));
					i++;

				}
			}
			wwb.write();
			wwb.close();
			os.close();
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	} 


}