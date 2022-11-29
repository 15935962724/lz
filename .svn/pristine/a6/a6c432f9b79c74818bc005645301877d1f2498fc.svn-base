package tea.ui.cluster;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.cluster.*;

public class Clusters extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		Http h = new Http(request,response);
		String act = h.get("act"),nexturl = h.get("nexturl");
		PrintWriter out = response.getWriter();
		try
		{
			if("sync".equals(act))
			{
				int no = h.getInt("no");
				String sql = " AND state NOT LIKE " + DbAdapter.cite("%|" + no + "|%");
				DbAdapter db = new DbAdapter();
				try
				{
					String dmls = h.get("dmls");
					if(dmls != null)
						db.executeUpdate("UPDATE dml   SET state=" + DbAdapter.concat("state","'" + no + "|'") + " WHERE dml   IN(" + dmls + "  )" + sql); //sql:传输中出错,会导致重复+no

					String attchs = h.get("attchs");
					if(attchs != null)
						db.executeUpdate("UPDATE attch SET state=" + DbAdapter.concat("state","'" + no + "|'") + " WHERE attch IN(" + attchs + ")" + sql);

					String errs = h.get("errs");
					if(errs != null)
						db.executeUpdate("UPDATE attch SET length=-1 WHERE attch IN(" + errs + ")"); //同步时，文件已丢失！
				} finally
				{
					db.close();
				}
				out.print("{code:0");
				boolean flag = false;
				out.print(",dml:[");
				Iterator it = DML.find(sql + " ORDER BY dml",0,100).iterator();
				while(it.hasNext())
				{
					if(flag)
						out.print(",");
					else
						flag = true;
					out.print(it.next());
				}
				out.print("]");
				flag = false;
				out.print(",attch:[");
				it = Attch.find(sql + " AND length!=-1 ORDER BY attch",0,100).iterator();
				while(it.hasNext())
				{
					if(flag)
						out.print(",");
					else
						flag = true;
					out.print(it.next());
				}
				out.print("]");
				out.print("}");
			}
		} catch(Throwable ex)
		{
			Filex.logs("Clusters.log",ex);
		} finally
		{
			out.close();
		}
	}

}
