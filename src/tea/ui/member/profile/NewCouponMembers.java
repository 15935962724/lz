package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.html.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class NewCouponMembers extends TeaServlet
{

    public NewCouponMembers()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int i = Integer.parseInt(request.getParameter("Coupon"));
            Coupon coupon = Coupon.find(i);
            if (!coupon.getMember().equals(teasession._rv._strR) || !teasession._rv.isAccountant())
            {
                response.sendError(403);
                return;
            }
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/profile/NewCouponMembers.jsp" + qs);
                /*
                 Form form = new Form("foNew", "POST", "NewCouponMembers");
                 form.setOnSubmit("return(submitText(this.Members,'" + super.r.getString(teasession._nLanguage, "InvalidCouponMembers") + "'));");
                 form.add(new HiddenField("Coupon", i));
                 form.add(new Text(super.r.getString(teasession._nLanguage, "MemberIds") + ":"));
                 form.add(new TextField("Members"));
                 form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                 form.add(new Script("document.foNew.Members.focus();"));
                 PrintWriter printwriter = response.getWriter();
                 printwriter.print(form);
                 printwriter.close();
                 */
            } else
            {
                String community = request.getParameter("community");
                for (StringTokenizer stringtokenizer = new StringTokenizer(request.getParameter("Members"), " ,"); stringtokenizer.hasMoreTokens(); )
                {
                    String s = stringtokenizer.nextToken();
                    if (Profile.isExisted(s))
                    {
                        CouponMember.create(i, s);
                    }
                }

                response.sendRedirect("CouponMembers?Coupon=" + i);
            }
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/profile/NewCouponMembers");
    }
}
