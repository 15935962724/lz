package tea.ui.provincecity;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

/**
 * Servlet implementation class CityServlet
 */
public class CityServlet extends TeaServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public CityServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		// String provincename = request.getParameter("provincename");
		
		TeaSession teasession = new TeaSession(request);
		//当前语言  0英语 1 中文
		int lan=teasession._nLanguage;
		
		DbAdapter db = new DbAdapter();
		// 获取省id
		String provinceid = request.getParameter("provinceid");
		// 获取市id
		String cityid = request.getParameter("cityid");
		StringBuilder sbsql = new StringBuilder();
		sbsql.append("select cityid,cityName_CN ,cityName_EN from CityList where 1=1 ");
		// 如果传省的参数
		if (!provinceid.equals("0")&&!provinceid.equals("null")) {
			// 如果不传市的参数，则查询省下所有市
			sbsql.append(" and fatherId='" + provinceid+"'");
		} else if (!cityid.equals("0")) {
			// 如果传市的参数，则查询指定 的市
			sbsql.append(" and cityid='" + cityid+"'");
		}

		String json = "";
		StringBuffer sb = new StringBuffer();
		sb.append("{\"lan\":" + lan + ",\"datas\":[");
		
		
		try {
			if (!provinceid.equals("0")&&!provinceid.equals("null")) {
				db.executeQuery(sbsql.toString());
				while (db.next()) {
					sb.append("{");
					sb.append("\"cityid\":");
					sb.append("\"" + db.getInt(1) + "\",");
					sb.append("\"cityname\":");
					sb.append("\"" + db.getString(2) + "\",");
					sb.append("\"cityen\":");
					sb.append("\"" + db.getString(3) + "\"");
					sb.append("},");
				}
			}
			
			sb.append("]}");
			json = sb.toString().replaceFirst("},]}", "}]}");
		} catch (SQLException e) {
			e.printStackTrace();
			json = "{}";
		}finally {
			db.close();
		}
		// if (provincename.equals("")) {
		// json = "[]";
		// }
		PrintWriter out = response.getWriter();
		out.write(json);
		// out.print(sb.toString());
		out.flush();
		out.close();

	}
}
