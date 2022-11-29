package tea.ui.Consultant;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.Attch;
import tea.entity.Err;
import tea.entity.Http;
import tea.entity.pm.PoSingleRelease;

/**
 * 拍马网-个人中心-套单解套
 * @author guodh
 * @version v1 2014-09-25
 * */
public class EditSingleRelease extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		Http h = new Http(req,resp);
		String act = h.get("act"),nexturl = h.get("nexturl","");
		
		PrintWriter out = resp.getWriter();
		try {
			out.print("<script>var mt=parent.mt;</script>");
			int psrid = h.getInt("psrid");
			PoSingleRelease psr = PoSingleRelease.find(psrid);
			if("edit".equals(act)){
				psr.setName(h.get("name"));
				psr.setContactway(h.get("contactway"));
				if(h.getInt("uploadFile.attch")>0)
					psr.setUploadFile(h.getInt("uploadFile.attch"));
				psr.setMember(h.member);
				psr.setType(h.getInt("type"));
				psr.setApplyTime(new Date());
				psr.set();
			}else if("del".equals(act)){
				psr.delete();
			}
			
			if("".equals(nexturl))
				nexturl = req.getContextPath();
			out.print("<script>mt.show('操作执行成功！',1,'" + nexturl + "');</script>");
		} catch (SQLException e) {
			//out.print("<textarea id='ta'>" + Err.get(h,e) + "</textarea><script>mt.show(document.getElementById('ta').value,1,'出现未知错误！');</script>");
			e.printStackTrace();
		}finally{
			out.close();
		}
	}
		
}
