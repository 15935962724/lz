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

public class TransferSave extends HttpServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	String title[] = { "��������", "�տ�������", "�տ����˺�", "�տ��˿�����", " ���", " �����", " ������� ", "״̬", " �������", "��;" };

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
			DbAdapter dbadapter = new DbAdapter();
			dbadapter.executeQuery("select [date],chamberlain,acceptaddress,acceptbank,acceptaccount,money,capital,remark, purpose,type,state,poundage  from Transfer where " + where);
			for (int loop = 1; dbadapter.next(); loop++)
			{
				Label labeld = new Label(0, loop, (new java.text.SimpleDateFormat("yyyy-MM-dd")).format(dbadapter.getDate(1)));
				ws.addCell(labeld);
				labeld = new Label(1, loop, dbadapter.getVarchar(1, 1, 2));
				ws.addCell(labeld);
				labeld = new Label(2, loop, dbadapter.getString(5));
				ws.addCell(labeld);
				labeld = new Label(3, loop, dbadapter.getVarchar(1, 1, 4));
				ws.addCell(labeld);
				jxl.write.Number number = new jxl.write.Number(4, loop, dbadapter.getInt(6));
				ws.addCell(number);
				number = new jxl.write.Number(5, loop, dbadapter.getInt(12));
				ws.addCell(number);
				labeld = new Label(6, loop, dbadapter.getVarchar(1, 1, 10));
				ws.addCell(labeld);
				labeld = new Label(7, loop, dbadapter.getVarchar(1, 1, 11));
				ws.addCell(labeld);
				labeld = new Label(8, loop, dbadapter.getVarchar(1, 1, 9));
				ws.addCell(labeld);
				// jxl.write.Number number=new jxl.write.Number(6,loop,12132);
				// ws.addCell(number);
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
