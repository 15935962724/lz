package tea.ui.provincecity;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.db.DbAdapter;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

/**
 * Servlet implementation class ProvinceServlet
 */
public class ProvinceServlet extends TeaServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}

	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		DbAdapter db = new DbAdapter();
		// 获取省id
		String provinceid = request.getParameter("provinceid");

		StringBuilder sbsql = new StringBuilder();
		sbsql.append("select cityid,cityName_CN , cityName_EN from CityList where fatherId=0");
		if (provinceid != null) {
			if (!provinceid.equals("0")) {
				sbsql.append(" and cityid='" + provinceid+"'");
			}
		}

		TeaSession teasession = new TeaSession(request);
		//当前语言  0英语 1 中文
		int lan=teasession._nLanguage;
		
		String json = "";
		StringBuffer sb = new StringBuffer();
		sb.append("{\"lan\":" + lan + ",\"datas\":[");
		
		
		try {
			db.executeQuery(sbsql.toString());
			while (db.next()) {
				sb.append("{");
				sb.append("\"provinceid\":");
				sb.append("\"" + db.getInt(1) + "\",");
				sb.append("\"provincename\":");
				sb.append("\"" + db.getString(2) + "\",");
				sb.append("\"provinceen\":");
				sb.append("\"" + db.getString(3) + "\"");
				sb.append("},");
			}
			sb.append("]}");
			json = sb.toString().replaceFirst("},]}", "}]}");
		} catch (SQLException e) {
			e.printStackTrace();
			json = "{}";
		}finally {
			db.close();
		}

		PrintWriter out = response.getWriter();
		out.write(json);
		// out.print(sb.toString());
		out.flush();
		out.close();
	}

	@Override
	public void destroy() {
	}
}
