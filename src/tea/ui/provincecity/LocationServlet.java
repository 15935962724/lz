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
import tea.entity.Http;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.ui.member.profile.newcaller;

/**
 * Servlet implementation class LocationServlet
 */
public class LocationServlet extends TeaServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public LocationServlet() {
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
		/**
		 * 1.区0，2 ，商圈1 3，地标 2
		 */
		String json1 = getLocationByCondition(request, 0);
		String json2 = getLocationByCondition(request, 1);
		String json3 = getLocationByCondition(request, 2);
		Http h=new Http(request);
		//当前语言  0英语 1 中文
		int lan=h.language;
		String json = "{\"lan\":" + lan + ",\"district\":" + json1 + ",\"commericial\":" + json2 + ",\"landmark\":" + json3 + "}";
		PrintWriter out = response.getWriter();
		out.write(json);
		// out.print(sb.toString());
		out.flush();
		out.close();

	}

	/**
	 * 根据市id 返回区 或地标或商圈 ，并根据当前语言返回中文或英文 (当前语言  0英语 1 中文)
	 * @param request
	 * @param flag
	 * @return
	 * @throws IOException 
	 */
	private String getLocationByCondition(HttpServletRequest request, int flag) throws IOException {
		
		
		String cityid = request.getParameter("cityid");
		DbAdapter db = new DbAdapter();
		String sql = "select cityid,cityName_CN , cityName_EN from CityList where fatherId='" + cityid + "' and areaType= '" + flag + "'";
		String json = "";
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		
//		sb.append("{");
//		sb.append("\"locationid\":");
//		sb.append("\"\",");
//		sb.append("\"locationname\":");
//		if(lan==0){
//			index=3;
//			sb.append("\"------select------\"");
//		}else{
//			sb.append("\"-------请选择-------\"");
//		}
//		sb.append("},");
		
		try {
			if(!cityid.equals("")){
				db.executeQuery(sql);
				while (db.next()) {
					sb.append("{");
					sb.append("\"locationid\":");
					sb.append("\"" + db.getInt(1) + "\",");
					sb.append("\"locationname\":");
					sb.append("\"" + db.getString(2) + "\",");
					sb.append("\"locationen\":");
					sb.append("\"" + db.getString(3) + "\"");
					sb.append("},");
				}
			}
			
			sb.append("]");
			json = sb.toString().replaceFirst("},]", "}]");
		} catch (SQLException e) {
			e.printStackTrace();
			json = "[]";
		} finally {
			db.close();
		}
		return json;
	}
}
