package tea.ui.alisoft;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import tea.entity.member.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.alisoft.sip.sdk.isv.SignatureUtil;
import javax.servlet.http.HttpSession;
import tea.entity.member.OnlineList;
import tea.entity.RV;
import java.sql.*;
import tea.entity.alisoft.AliCompany;
import tea.entity.site.Community;


/**
 * Servlet implementation class for Servlet: ValidateUserServlet
 *
 */
/**
 * @author shuijing.linshj
 *2008-10-22
 */
public class GetSubscCtrl extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet
{
    static final long serialVersionUID = 1L;
    public static java.text.SimpleDateFormat SIP_TIMESTAMP_FORMATER = new SimpleDateFormat(
            "yyyy-MM-dd HH:mm:ss"); // 时间格式

    /*
     * (non-Java-doc)
     *
     * @see javax.servlet.http.HttpServlet#HttpServlet()
     */
    public GetSubscCtrl()
    {
        super();
    }

    /*
     * (non-Java-doc)
     *
     * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request,
     *      HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException,IOException
    {
        this.doPost(request,response);
    }

    /*
     * (non-Java-doc)
     *
     * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request,
     *      HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException,IOException
    {
		HttpSession session = request.getSession(true);
        String userId = request.getParameter("user_id"); //最终用户在ASSP上的唯一用户身份ID
        String appInstanceId = request.getParameter("app_instance_id"); //最终用户订购ISV软件生成的唯一编码
		String role = request.getParameter("role");
		String member = "";
        String userole = "";
        if("1".equals(role))
        {
            member = "admin" + userId;
            userole = "/358/361/";
        } else
        {
            member = "member" + userId;
            userole = "/";
        }
        String act = "";
        if(request.getParameter("act") != null)
        {
            act = request.getParameter("act");
        }
        try
        {
            if("company".equals(act))
            {
                String companyName = request.getParameter("companyname");
                String comEmail = request.getParameter("comemail");
                int comUserCount = 100;
                Date initDate = new Date();
                AliCompany.create(appInstanceId,userId,companyName,comEmail,comUserCount,initDate);
				Community.create(appInstanceId,2,0,member,1,"EDN-OA","","","http://alisoftoa.redcome.com","robot@redcome.com","mail.redcome.com","怡康科技/EDN-Redcome.com","robot@redcome.com","1234","","李洪志江泽民金涛	法轮功代开发票",false,false,true,"","","","","","","");
				session.setAttribute("tea.Community",appInstanceId);

				if(!Profile.isExisted(member))
				{
					response.sendRedirect("/jsp/alisoft/CompanyInit.jsp?initType=0&role="+role+"&user_id=" + userId + "&appInstanceId=" + appInstanceId);
				} else
				{

					OnlineList ol_obj = OnlineList.find(session.getId()); //添加到用户临时表中
					Profile p = Profile.find(member);
					RV rv = new RV(member);
					ol_obj.setMember(member);
					session.setAttribute("tea.RV",rv); //创建用户登陆 session
					session.setAttribute("LoginId",member);
					session.setAttribute("password",p.getPassword());

					response.sendRedirect("/jsp/admin/index.jsp");
					return;
				}
            }
            if("profile".equals(act))
            {

                String proname = request.getParameter("proname");
                String proemail = request.getParameter("proemail");
                Profile.createProfileAndRole(member,"Home",proname,proemail,userole,"1234",true);

                OnlineList ol_obj = OnlineList.find(session.getId()); //添加到用户临时表中
                Profile p = Profile.find(member);
                RV rv = new RV(member);
                ol_obj.setMember(member);
                session.setAttribute("tea.RV",rv); //创建用户登陆 session
                session.setAttribute("LoginId",member);
                session.setAttribute("password",p.getPassword());

                response.sendRedirect("/jsp/admin/index.jsp");
                return;
            }
        } catch(SQLException ex1)
        {
            ex1.getStackTrace();
        }
    }
}
