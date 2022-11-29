package tea.ui.node.type.Application;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.entity.node.*;
import tea.db.DbAdapter;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import java.util.Vector;
import javax.servlet.http.*;
import java.io.*;
import jxl.*;
import jxl.write.*;
import common.*;
import java.text.SimpleDateFormat;
import java.text.MessageFormat;
import java.util.Date;
import java.io.*;

public class AppOut extends TeaServlet
{

	public AppOut()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Vector v_stock = null;
		int c_stock = 0;
		response.setContentType("application/ms-excel;charset=GB2312");
		response.setHeader("Content-disposition", "attachment; filename=Application.xls");

		jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(response.getOutputStream()); // new File(picture1));
		jxl.write.WritableSheet ws = wwb.createSheet("Test Sheet 1", 0);
		try
		{
			TeaSession teasession = new TeaSession(request);

			HttpSession httpsession = request.getSession(true);

			c_stock = ((Integer) httpsession.getAttribute("tea.c_app")).intValue();
			v_stock = (Vector) httpsession.getAttribute("tea.app");
			jxl.write.Label labeld = new jxl.write.Label(0, 0, r.getString(teasession._nLanguage, "xm1"));
			ws.addCell(labeld);
			jxl.write.Label labeld1 = new jxl.write.Label(1, 0, r.getString(teasession._nLanguage, "xb1"));
			ws.addCell(labeld1);
			jxl.write.Label labeld2 = new jxl.write.Label(2, 0, r.getString(teasession._nLanguage, "csny1"));
			ws.addCell(labeld2);
			jxl.write.Label labeld3 = new jxl.write.Label(3, 0, r.getString(teasession._nLanguage, "xl1"));
			ws.addCell(labeld3);
			jxl.write.Label labeld4 = new jxl.write.Label(4, 0, r.getString(teasession._nLanguage, "xw1"));
			ws.addCell(labeld4);
			jxl.write.Label labeld5 = new jxl.write.Label(5, 0, r.getString(teasession._nLanguage, "zw1"));
			ws.addCell(labeld5);
			jxl.write.Label labeld6 = new jxl.write.Label(6, 0, r.getString(teasession._nLanguage, "cjgzsj1"));
			ws.addCell(labeld6);
			jxl.write.Label labeld7 = new jxl.write.Label(7, 0, r.getString(teasession._nLanguage, "xdw1"));
			ws.addCell(labeld7);
			jxl.write.Label labeld8 = new jxl.write.Label(8, 0, r.getString(teasession._nLanguage, "xbw1"));
			ws.addCell(labeld8);
			jxl.write.Label labeld9 = new jxl.write.Label(9, 0, r.getString(teasession._nLanguage, "xgw1"));
			ws.addCell(labeld9);
			jxl.write.Label labeld10 = new jxl.write.Label(10, 0, r.getString(teasession._nLanguage, "phone1"));
			ws.addCell(labeld10);
			jxl.write.Label labeld11 = new jxl.write.Label(11, 0, r.getString(teasession._nLanguage, "mobile1"));
			ws.addCell(labeld11);
			jxl.write.Label labeld12 = new jxl.write.Label(12, 0, r.getString(teasession._nLanguage, "email1"));
			ws.addCell(labeld12);
			jxl.write.Label labeld13 = new jxl.write.Label(13, 0, r.getString(teasession._nLanguage, "sqrq1"));
			ws.addCell(labeld13);
			java.text.SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			for (int k3 = 0; k3 < c_stock; k3++)
			{
				int id = ((Integer) v_stock.elementAt(k3)).intValue();
				DbAdapter dbadapter = new DbAdapter();
				try
				{
					dbadapter.executeQuery("SELECT xm,xb,csny,xl,xw,zw,cjgzsj,xdw,xbm,xgw,phone,mobile,email,sqrq FROM Application where node =" + id);
					if (dbadapter.next())
					{
						jxl.write.Label labelC = new jxl.write.Label(0, k3 + 1, dbadapter.getVarchar(1, 1, 1));
						ws.addCell(labelC);
						jxl.write.Label labelC1 = new jxl.write.Label(1, k3 + 1, dbadapter.getVarchar(1, 1, 2));
						ws.addCell(labelC1);
						jxl.write.Label labelC2 = new jxl.write.Label(2, k3 + 1, sdf.format(dbadapter.getDate(3)));
						ws.addCell(labelC2);
						jxl.write.Label labelC3 = new jxl.write.Label(3, k3 + 1, dbadapter.getVarchar(1, 1, 4));
						ws.addCell(labelC3);
						jxl.write.Label labelC4 = new jxl.write.Label(4, k3 + 1, dbadapter.getVarchar(1, 1, 5));
						ws.addCell(labelC4);
						jxl.write.Label labelC5 = new jxl.write.Label(5, k3 + 1, dbadapter.getVarchar(1, 1, 6));
						ws.addCell(labelC5);
						jxl.write.Label labelC6 = new jxl.write.Label(6, k3 + 1, sdf.format(dbadapter.getDate(7)));
						ws.addCell(labelC6);
						jxl.write.Label labelC7 = new jxl.write.Label(7, k3 + 1, dbadapter.getVarchar(1, 1, 8));
						ws.addCell(labelC7);
						jxl.write.Label labelC8 = new jxl.write.Label(8, k3 + 1, dbadapter.getVarchar(1, 1, 9));
						ws.addCell(labelC8);
						jxl.write.Label labelC9 = new jxl.write.Label(9, k3 + 1, dbadapter.getVarchar(1, 1, 10));
						ws.addCell(labelC9);
						jxl.write.Label labelC10 = new jxl.write.Label(10, k3 + 1, dbadapter.getVarchar(1, 1, 11));
						ws.addCell(labelC10);
						jxl.write.Label labelC11 = new jxl.write.Label(11, k3 + 1, dbadapter.getVarchar(1, 1, 12));
						ws.addCell(labelC11);
						jxl.write.Label labelC12 = new jxl.write.Label(12, k3 + 1, dbadapter.getVarchar(1, 1, 13));
						ws.addCell(labelC12);
						jxl.write.Label labelC13 = new jxl.write.Label(13, k3 + 1, sdf.format(dbadapter.getDate(14)));
						ws.addCell(labelC13);
					}
					// response.sendRedirect("/tea/gongxi.htm");
				} catch (Exception exception)
				{
				} finally
				{
					dbadapter.close();
				}
			}
			wwb.write();
			wwb.close();
		} catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
} finally
		{
		}
	}
}
