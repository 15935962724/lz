package tea.ui.node.type.stock;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.db.DbAdapter;
import tea.entity.*;
import java.sql.SQLException;

public class InsertStock extends TeaServlet
{

	public InsertStock()
	{
	}

	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			TeaSession teasession = new TeaSession(request);
			String s11 = teasession.getParameter("OpeningPrice_cnoochk");
			String s12 = teasession.getParameter("High_cnoochk");
			String s13 = teasession.getParameter("Low_cnoochk");
			String s14 = teasession.getParameter("ClosingPrice_cnoochk");
			String s15 = teasession.getParameter("PerChange_cnoochk");
			String s16 = teasession.getParameter("Volume_cnoochk");
			String s21 = teasession.getParameter("OpeningPrice_cnoocny");
			String s22 = teasession.getParameter("High_cnoocny");
			String s23 = teasession.getParameter("Low_cnoocny");
			String s24 = teasession.getParameter("ClosingPrice_cnoocny");
			String s25 = teasession.getParameter("PerChange_cnoocny");
			String s26 = teasession.getParameter("Volume_cnoocny");
			String s31 = teasession.getParameter("OpeningPrice_cnoocshk");
			String s32 = teasession.getParameter("High_cnoocshk");
			String s33 = teasession.getParameter("Low_cnoocshk");
			String s34 = teasession.getParameter("ClosingPrice_cnoocshk");
			String s35 = teasession.getParameter("PerChange_cnoocshk");
			String s36 = teasession.getParameter("Volume_cnoocshk");
			String s41 = teasession.getParameter("OpeningPrice_hgcash");
			String s42 = teasession.getParameter("High_hgcash");
			String s43 = teasession.getParameter("Low_hgcash");
			String s44 = teasession.getParameter("ClosingPrice_hgcash");
			String s45 = teasession.getParameter("PerChange_hgcash");
			String s46 = teasession.getParameter("Volume_hgcash");
			float f11 = Float.parseFloat(s11);
			float f12 = Float.parseFloat(s12);
			float f13 = Float.parseFloat(s13);
			float f14 = Float.parseFloat(s14);
			float f15 = Float.parseFloat(s15);
			// int f16=Integer.parseInt(s16);
			float f21 = Float.parseFloat(s21);
			float f22 = Float.parseFloat(s22);
			float f23 = Float.parseFloat(s23);
			float f24 = Float.parseFloat(s24);
			float f25 = Float.parseFloat(s25);
			// int f26=Integer.parseInt(s26);
			float f31 = Float.parseFloat(s31);
			float f32 = Float.parseFloat(s32);
			float f33 = Float.parseFloat(s33);
			float f34 = Float.parseFloat(s34);
			float f35 = Float.parseFloat(s35);
			// int f36=Integer.parseInt(s36);
			float f41 = Float.parseFloat(s41);
			float f42 = Float.parseFloat(s42);
			float f43 = Float.parseFloat(s43);
			float f44 = Float.parseFloat(s44);
			float f45 = Float.parseFloat(s45);
			// int f46=Integer.parseInt(s46);

			/*
			 * Date date1 = TimeSelection.makeTime(teasession.getParameter("Issue1Year"), teasession.getParameter("Issue1Month"), teasession.getParameter("Issue1Day")); Date date2 = TimeSelection.makeTime(teasession.getParameter("Issue2Year"), teasession.getParameter("Issue2Month"), teasession.getParameter("Issue2Day")); Date date3 = TimeSelection.makeTime(teasession.getParameter("Issue3Year"), teasession.getParameter("Issue3Month"), teasession.getParameter("Issue3Day")); Date date4 =
			 * TimeSelection.makeTime(teasession.getParameter("Issue4Year"), teasession.getParameter("Issue4Month"), teasession.getParameter("Issue4Day"));
			 */
			String date1 = teasession.getParameter("date1");
			String date2 = teasession.getParameter("date2");
			String date3 = teasession.getParameter("date3");
			String date4 = teasession.getParameter("date4");
			DbAdapter dbadapter = new DbAdapter();
			try
			{
				dbadapter.executeUpdate("StockInput 'ceon'," + DbAdapter.cite("CEO.N 中海油 纽约") + "," + f21 + "," + DbAdapter.cite(date2) + "," + f22 + "," + f23 + "," + f24 + "," + f25 + ",'" + s26 + "','CEO.N&nbsp;CNOOCLTD.&nbsp;NEWYORK'");
				dbadapter.executeUpdate("StockInput '0883hk'," + DbAdapter.cite("0883.HK 中海油香港") + "," + f11 + "," + DbAdapter.cite(date1) + "," + f12 + "," + f13 + "," + f14 + "," + f15 + ",'" + s16 + "','0883.HK&nbsp;CNOOCLTD.&nbsp;HONGKONG'");
				dbadapter.executeUpdate("StockInput '2883hk'," + DbAdapter.cite("2883.HK 中海油田服务") + "," + f31 + "," + DbAdapter.cite(date3) + "," + f32 + "," + f33 + "," + f34 + "," + f35 + ",'" + s36 + "','2883.HK&nbsp;COSL&nbsp;HONGKONG'");
				dbadapter.executeUpdate("StockInput '600583ss'," + DbAdapter.cite("600583.SS 海油工程A股") + "," + f41 + "," + DbAdapter.cite(date4) + "," + f42 + "," + f43 + "," + f44 + "," + f45 + ",'" + s46 + "','600583.SSCNOOCEngineeringLtd.SHANGHAI'");

			} catch (Exception exception1)
			{
				throw new SQLException(exception1.toString());
			} finally
			{
				dbadapter.close();
			}
			response.sendRedirect("Node?node=" + teasession._nNode + "&stockinput=1&Listing=" + teasession.getParameter("Listing"));

		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
		}
	}

}
