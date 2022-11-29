package tea.ui.node.type.dynamicvalue;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import jxl.write.*;
import tea.db.*;
import java.sql.SQLException;

public class DynamicValueExport extends HttpServlet
{
	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition", "attachment; filename=" + "Export.xls");

		java.io.OutputStream out = response.getOutputStream();
		jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(out);
		try
		{
			tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
			if (teasession._rv == null)
			{
				response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
				return;
			}

			String community = (request.getParameter("community"));
			String state = (request.getParameter("state"));
			DbAdapter db = new DbAdapter();
			try
			{
				db.executeQuery("SELECT n.type FROM Node n WHERE n.hidden=0 AND n.type>=1024 AND n.community=" + DbAdapter.cite(community) + " GROUP BY n.type");
				while (db.next())
				{
					int type = db.getInt(1);
					tea.entity.site.Dynamic d = tea.entity.site.Dynamic.find(type);
					jxl.write.WritableSheet ws = wwb.createSheet(d.getName(teasession._nLanguage), 0);

					int rows = 1; // 行

					int step = 0; // 列
					// 标题
					Enumeration enumer_code = tea.entity.site.DynamicType.findByDynamic(type);
					for (; enumer_code.hasMoreElements(); step++)
					{
						int id = ((Integer) enumer_code.nextElement()).intValue();
						tea.entity.site.DynamicType obj = tea.entity.site.DynamicType.find(id);
						ws.addCell(new jxl.write.Label(step, 0, obj.getName(teasession._nLanguage)));
					}
					// 内容
					Enumeration enumer = findByCommunity(community, state); // tea.entity.node.DynamicValue.findByCommunity(community);
					while (enumer.hasMoreElements())
					{
						int node = ((Integer) enumer.nextElement()).intValue();
						enumer_code = tea.entity.site.DynamicType.findByDynamic(type);

						for (step = 0; enumer_code.hasMoreElements(); step++)
						{
							int id = ((Integer) enumer_code.nextElement()).intValue();

							tea.entity.node.DynamicValue dv = tea.entity.node.DynamicValue.find(node, teasession._nLanguage, id);

							ws.addCell(new jxl.write.Label(step, rows, dv.getValue()));
						}
						rows++;
					}
				}
			} catch (Exception e)
			{
				e.printStackTrace();
			} finally
			{
				db.close();
			}
			wwb.write();
			wwb.close();
		} catch (Exception e)
		{
			e.printStackTrace();
			response.sendError(500);
		} finally
		{
			out.close();
		}
	}

	public static Enumeration findByCommunity(String community, String state) throws java.sql.SQLException
	{
		Vector v = new Vector();
		DbAdapter db = new DbAdapter();
		try
		{
			StringBuilder sql = new StringBuilder();
			if (state != null && state.length() > 0)
			{
				sql.append(" AND n.node IN (SELECT dv.node FROM DynamicType dt,DynamicValue dv WHERE dv.dynamictype=dt.dynamictype AND dt.type='code' AND " + ("1".equals(state) ? (db.length("dv.value") + ">1") : "(dv.value IS NULL OR " + db.length("dv.value") + "<1)") + ")");
			}
			db.executeQuery("SELECT n.node FROM Node n WHERE n.hidden=0 AND n.type>=1024 AND n.community=" + DbAdapter.cite(community) + sql.toString());
			while (db.next())
			{
				v.addElement(new Integer(db.getInt(1)));
			}
		} finally
		{
			db.close();
		}
		return v.elements();
	}

	// Clean up resources
	public void destroy()
	{
	}
}
