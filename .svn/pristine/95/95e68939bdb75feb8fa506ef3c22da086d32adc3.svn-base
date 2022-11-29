package tea.ui.node.general;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import jxl.write.WriteException;
import java.sql.SQLException;

public class ExportSonNodes extends HttpServlet
{
	private static final String CONTENT_TYPE = "text/html; charset=GBK";

	// Initialize global variables
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("application/x-msdownload");

		try
		{
			tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
			tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
			javax.servlet.ServletOutputStream out = response.getOutputStream();
			jxl.write.WritableWorkbook wwb = jxl.Workbook.createWorkbook(out);
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(node.getSubject(teasession._nLanguage) + ".xls", "UTF-8"));
			jxl.write.WritableSheet ws = wwb.createSheet(node.getSubject(teasession._nLanguage), 0);
			rows = 0;
			tree1(ws, teasession._nNode, 0, teasession._nLanguage, request.getContextPath());
			wwb.write();
			wwb.close();
			out.close();
		} catch (WriteException ex)
		{
			ex.printStackTrace();
		} catch (IOException ex)
		{
			ex.printStackTrace();
		} catch (SQLException ex)
		{
			ex.printStackTrace();
		}
	}

	private int rows = 0;

	private void tree1(jxl.write.WritableSheet ws, int nodecode, int step, int language, String path) throws SQLException, WriteException
	{

		for (Enumeration enumeration = tea.entity.node.Node.findSons(nodecode); enumeration.hasMoreElements();)
		{
			int j = ((Integer) enumeration.nextElement()).intValue();
			tea.entity.node.Node node1 = tea.entity.node.Node.find(j);
			ws.addCell(new jxl.write.Label(step, rows, node1.getSubject(language))); // node1.getAnchor(language, path).toString()
			ws.addCell(new jxl.write.Number(step + 1, rows, j));
			++rows;
			tree1(ws, j, ++step, language, path);
			step--;
		}
	}

	// Clean up resources
	public void destroy()
	{
	}
}
