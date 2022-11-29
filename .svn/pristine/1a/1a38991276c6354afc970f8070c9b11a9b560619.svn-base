package tea.ui.node.type.account;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import jxl.Workbook;
import jxl.write.*;
import tea.db.DbAdapter;
import java.io.*;
import jxl.Workbook;
import jxl.write.*;

public class BargainingSave extends HttpServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	String title[] = { "账号", "日期", "支出", "收入", "余额", "说明" };

	// Process the HTTP Get request
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-disposition", "attachment; filename=/tea/TransferSave.xls");
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
			DbAdapter db = new DbAdapter();
			db.executeQuery("select account,[date],adopt,memory,balance,explain from Bargaining where " + where);
			for (int loop = 1; db.next(); loop++)
			{
				Label labeld = new Label(0, loop, db.getString(1));
				ws.addCell(labeld);
				labeld = new Label(1, loop, (new java.text.SimpleDateFormat("yyyy-MM-dd")).format(db.getDate(2)));
				ws.addCell(labeld);
				jxl.write.Number number = new jxl.write.Number(2, loop, db.getInt(3));
				ws.addCell(number);
				number = new jxl.write.Number(3, loop, db.getInt(4));
				ws.addCell(number);
				number = new jxl.write.Number(4, loop, db.getInt(5));
				ws.addCell(number);
				labeld = new Label(5, loop, new String(db.getVarchar(1, 1, 6)));
				ws.addCell(labeld);
			}
			db.close();
			wwb.write();
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
