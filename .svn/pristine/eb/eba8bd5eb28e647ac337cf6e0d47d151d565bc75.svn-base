package tea.ui.member.profile;

import java.io.*;
import java.util.StringTokenizer;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Associate;
import tea.entity.member.Profile;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.admin.AdminUsrRole;

public class EditAssociate extends TeaServlet
{

    public EditAssociate()
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

            if (!teasession._rv.isHR())
            {
                response.sendError(403);
                return;
            }

            if (request.getMethod().equals("GET"))
            {

                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/profile/EditAssociate.jsp" + qs);

                /*
                 * String s = request.getParameter("Associate"); boolean flag = s == null; int k = 0; int i1 = 0; int k1 = 0; int j2 = 0; String s2 = ""; if(!flag) { Associate associate = Associate.find(teasession._rv._strR, s); k = associate.getPositions(); i1 = associate.getManagers(); k1 = associate.getProviders0(); j2 = associate.getProviders1(); s2 = associate.getStartUrl(); } Form form = new Form("foEdit", "POST", "EditAssociate");
                 * form.setOnSubmit("return(submitText(this.Associates,'" + super.r.getString(teasession._nLanguage, "InvalidMemberIds") + "'));"); Table table = new Table(); Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "MemberIds") + ":"), true)); if(!flag) { Cell cell = new Cell(new HiddenField("Associates", s)); cell.add(new Text(s)); row.add(cell); } else { row.add(new Cell(new TextField("Associates"))); } table.add(row); Row row1 = new Row(new Cell(new
                 * Text(super.r.getString(teasession._nLanguage, "Positions") + ":"), true)); Cell cell1 = new Cell(); for(int k2 = 0; k2 < Associate.ASSOCIATE.length; k2++) { cell1.add(new CheckBox("P" + Associate.ASSOCIATE[k2], (k & 1 << k2) != 0)); cell1.add(new Text(super.r.getString(teasession._nLanguage, Associate.ASSOCIATE[k2]) + " ")); }
                 *
                 * row1.add(cell1); table.add(row1); Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Managers") + ":"), true)); Cell cell2 = new Cell(); for(int l2 = 0; l2 < Associate.ASSOCIATE.length; l2++) { cell2.add(new CheckBox("M" + Associate.ASSOCIATE[l2], (i1 & 1 << l2) != 0)); cell2.add(new Text(super.r.getString(teasession._nLanguage, Associate.ASSOCIATE[l2]) + " ")); }
                 *
                 * row2.add(cell2); table.add(row2); Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Type") + ":"), true)); Cell cell3 = new Cell(); for(int i3 = 0; i3 < Node.NODE_TYPE.length; i3++) { cell3.add(new CheckBox(Node.NODE_TYPE[i3], ((i3 >= 32 ? j2 : k1) & 1 << i3 % 32) != 0)); cell3.add(new Text(super.r.getString(teasession._nLanguage, Node.NODE_TYPE[i3]) + " ")); }
                 *
                 * row3.add(cell3); table.add(row3); Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StartUrl") + ":"), true)); row4.add(new Cell(new TextField("StartUrl", s2, 60, 255))); table.add(row4); form.add(table); form.add(new Button(super.r.getString(teasession._nLanguage, "Submit"))); PrintWriter printwriter = response.getWriter(); printwriter.print(form); if(flag) printwriter.print(new Script("document.foEdit.Associates.focus();"));
                 * printwriter.print(new Languages(teasession._nLanguage, request)); printwriter.close();
                 */
            } else
            {
                int i = 0;
                int j = 0;
                int l = 0;
                int j1 = 0;
                for (int l1 = 0; l1 < Associate.ASSOCIATE.length; l1++)
                {
                    if (request.getParameter("P" + Associate.ASSOCIATE[l1]) != null)
                    {
                        i |= 1 << l1;
                    }
                    if (request.getParameter("M" + Associate.ASSOCIATE[l1]) != null)
                    {
                        i |= 1 << l1;
                        j |= 1 << l1;
                    }
                }

                for (int i2 = 0; i2 < Node.NODE_TYPE.length; i2++)
                {
                    if (request.getParameter(Node.NODE_TYPE[i2]) != null)
                    {
                        if (i2 < 32)
                        {
                            l |= 1 << i2;
                        } else
                        {
                            j1 |= 1 << i2 % 32;
                        }
                    }
                }
                StringBuilder role_sb = new StringBuilder("/");
                String role[] = request.getParameterValues("Role");
                if (role != null)
                {
                    for (int index = 0; index < role.length; index++)
                    {
                        role_sb.append(role[index] + "/");
                    }
                }
                String s1 = request.getParameter("StartUrl");
                String s3;
                String community = request.getParameter("community");

                for (StringTokenizer stringtokenizer = new StringTokenizer(request.getParameter("Associates"), " ,"); stringtokenizer.hasMoreTokens(); Associate.create(teasession._rv._strR, s3, i, j, l, j1, s1))
                {
                    s3 = stringtokenizer.nextToken();
                    if (!Profile.isExisted(s3))
                    {
                        outText(teasession, response, RequestHelper.format(super.r.getString(teasession._nLanguage, "AlertNotExist"), s3));
                        return;
                    }
                    AdminUsrRole aur_obj = AdminUsrRole.find(community, s3);
                    if (aur_obj.isExists())
                    {
                        aur_obj.setRole(role_sb.toString());
                    } else
                    {
                        AdminUsrRole.create(community, s3, role_sb.toString(), "/", 0, "/", "/");
                    }
                }
                response.sendRedirect("Associates");
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
        super.r.add("tea/ui/member/profile/EditAssociate");
    }
}
