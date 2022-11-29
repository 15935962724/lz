package tea.ui.member.sms;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.member.*;
import tea.entity.*;
import tea.ui.*;
import java.sql.SQLException;

public class EditSMSProfile extends TeaServlet
{
    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if (teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        try
        {
            String community = request.getParameter("community");
            String member = request.getParameter("member");
            if (request.getParameter("setsignature") != null)
            {
                // 更改签名和短信服务状态
                boolean flag2 = teasession._rv.isOrganizer(community);
                boolean flag3 = teasession._rv.isWebMaster();
                if (!flag2 && !flag3)
                {
                    response.sendError(403);
                    return;
                }
                boolean states = new Boolean(request.getParameter("states")).booleanValue();
                String signature = request.getParameter("signature");

                SMSProfile sp = SMSProfile.find(member, community);
                sp.set(states, signature, sp.getCode(), sp.getPassword());

                response.sendRedirect("/jsp/sms/EditSMSMoney.jsp?node=" + teasession._nNode + "&member=" + member);
            } else if (request.getParameter("assigncode") != null) // 指定子号
            {
                boolean flag2 = teasession._rv.isOrganizer(community);
                boolean flag3 = teasession._rv.isWebMaster();
                if (!flag2 && !flag3)
                {
                    response.sendError(403);
                    return;
                }
                int subcode = Integer.parseInt(request.getParameter("subcode"));
                SMSProfile sp = SMSProfile.find(member, community);
                Profile p = Profile.find(member);

                tea.entity.site.SMSEnterCode sec = tea.entity.site.SMSEnterCode.find(community);

                java.net.URL url = new java.net.URL("http://sms.redcome.com/servlet/GetSubNumber?fincode=" + sec.getCode() + "&password=" + sec.getPassword() + "&tonumber=" + p.getMobile() + "&assigncode=" + subcode);
                java.io.InputStream is = url.openStream();
                StringBuilder sb = new StringBuilder();
                int value = 0;
                while ((value = is.read()) != -1)
                {
                    sb.append((char) value);
                }
                is.close();
                String content = new String(sb.toString().getBytes("ISO-8859-1"), "UTF-8");
                if ("3".equals(content))
                {
                    response.sendRedirect("/jsp/info/Alert.jsp?community=" + community + "&info=" + java.net.URLEncoder.encode("对不起,此号已存在.", "UTF-8"));
                } else
                {
                    String password = content.substring(content.indexOf(",") + 1);
                    sp.set(subcode, password);
                    response.sendRedirect("/jsp/sms/EditSMSMoney.jsp?node=" + teasession._nNode + "&member=" + member);
                }
            } else if (request.getParameter("SetAutor") != null) // 编辑是否自动回复
            {
                if (member == null)
                {
                    member = teasession._rv.toString();
                }
                boolean autor = "true".equals(request.getParameter("autor"));
                SMSProfile sp = SMSProfile.find(member, community);
                sp.setAutor(autor);
                response.sendRedirect("/jsp/info/Succeed.jsp?community=" + community); // "/jsp/sms/EditSMSProfile.jsp?node=" + teasession._nNode);
            } else if (request.getParameter("SetMobile") != null) // 手机号及子号设置
            {
                member = teasession._rv.toString();
                HttpSession session = request.getSession(true);
                if (request.getParameter("GoNext") != null)
                {
                    SMSProfile sp = SMSProfile.find(member, community);
                    tea.entity.site.SMSEnterCode sec = tea.entity.site.SMSEnterCode.find(community);
                    String mobile = request.getParameter("mobile");
                    // 取得子号
                    StringBuilder param = new StringBuilder("http://sms.redcome.com/servlet/GetSubNumber?fincode=");
                    param.append(sec.getCode()); // 企业号
                    param.append("&password=").append(sec.getPassword()); // 企业号的密码
                    param.append("&tonumber=").append(mobile); // 注册手机
                    param.append("&subcode="); // 会员的子号
                    if (sp.getCode() > 0)
                    {
                        param.append(sp.getCode());
                    }
                    java.net.URL url = new java.net.URL(param.toString());
                    java.io.InputStream is = url.openStream();
                    StringBuilder sb = new StringBuilder();
                    int value = 0;
                    while ((value = is.read()) != -1)
                    {
                        sb.append((char) value);
                    }
                    is.close();
                    // 判断值
                    if (sb.length() < 4)
                    {
                        if (sb.toString().startsWith("1"))
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("余额不足", "UTF-8"));
                            return;
                        }
                        if (sb.toString().startsWith("2"))
                        {
                            response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("密码错误", "UTF-8"));
                            return;
                        }
                    }
                    Profile profile = Profile.find(member);
                    profile.setMobile(mobile);
                    profile.setValidate(false);
                    // 把"子号,密码"存入会话
                    session.setAttribute("validate", sb.toString());

                    response.sendRedirect("/jsp/sms/EditSMSProfile2.jsp?node=" + teasession._nNode + "&community=" + community);
                } else if (request.getParameter("GoFinish") != null)
                {
                    int subnumber = 0;
                    try
                    {
                        subnumber = Integer.parseInt(teasession.getParameter("subnumber"));
                    } catch (NumberFormatException ex)
                    {
                    }
                    String password = teasession.getParameter("password");
                    if (!(subnumber + "," + password).equals(session.getAttribute("validate")))
                    {
                        response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode("子号或密码错误", "UTF-8"));
                        return;
                    }
                    Profile profile = Profile.find(teasession._rv.toString());
                    profile.setValidate(true);

                    SMSProfile sp = SMSProfile.find(member, community);
                    sp.set(subnumber, password);

                    response.sendRedirect("/jsp/info/Succeed.jsp");
                }
            }
        } catch (SQLException ex)
        {
            response.sendRedirect("/jsp/info/Alert.jsp?info=" + ex.getMessage());
        }

    }

    // Clean up resources
    public void destroy()
    {
    }
}
/*
 * //社区,卡号和密码编辑:http://127.0.0.1/jsp/sms/EditSMSEnterCode.jsp
 *
 */
