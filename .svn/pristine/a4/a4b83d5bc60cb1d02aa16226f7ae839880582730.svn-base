package tea.ui.node.type.account;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import jxl.Workbook;
import jxl.write.*;
import tea.db.DbAdapter;
import java.io.*;
import jxl.Workbook;
import jxl.write.*;

public class NetPaySave extends HttpServlet
{

	String title[] = { "�˺�", "���", "����" };

	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-disposition", "attachment; filename=/tea/NetPaySave.xls");
		OutputStream out = response.getOutputStream();
		WritableWorkbook wwb = Workbook.createWorkbook(out);
		try
		{

			WritableSheet ws = wwb.createSheet("book1", 0);
			for (int loop = 0; loop < title.length; loop++)
			{
				Label labeld = new Label(loop, 0, title[loop]);
				ws.addCell(labeld);
			}
			String where = request.getParameter("where");
			DbAdapter dbadapter = new DbAdapter();
			dbadapter.executeQuery("select account, money,[date]  from NetPay where " + where);
			for (int loop = 1; dbadapter.next(); loop++)
			{
				Label labeld = new Label(0, loop, dbadapter.getString(1));
				ws.addCell(labeld);
				jxl.write.Number number = new jxl.write.Number(1, loop, dbadapter.getInt(2));
				ws.addCell(number);
				labeld = new Label(2, loop, (new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(3)));
				ws.addCell(labeld);
			}
			wwb.write();
			dbadapter.close();
			wwb.close();

		} catch (Exception ex)
		{
			ex.printStackTrace();
		} finally
		{
			out.close();
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
