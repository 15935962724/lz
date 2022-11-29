package tea.ui.node.type.expert;

import java.io.*;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.*;
import javax.servlet.http.*;

import tea.entity.Http;
import tea.entity.RV;
import tea.entity.node.*;
import tea.ui.*;

public class EditExpert extends TeaServlet
{

    public EditExpert()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
//        	Http h=new Http(request);
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
//                outLogin(request, response, h);
            	 response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if (!node.isCreator(teasession._rv) && !AccessMember.find(teasession._nNode, teasession._rv._strV).isProvider(28) && ((node.getOptions1() & 1) == 0))
            {
                response.sendError(403);
                return;
            }

            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/expert/EditExpert.jsp" + qs);
                /*
                 * Form form = new Form("foEdit", "POST", request.getRequestURI()); form.add(new HiddenField("Node", teasession._nNode)); Table table = new Table(); Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Contact") + ":"), true)); row.add(new Cell(new TextField("Contact", classified.getContact(teasession._nLanguage)))); table.add(row); Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "EmailAddress") + ":"), true)); row1.add(new
                 * Cell(new TextField("Email", classified.getEmail(teasession._nLanguage)))); table.add(row1); Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Organization") + ":"), true)); row2.add(new Cell(new TextField("Organization", classified.getOrganization(teasession._nLanguage), 40, 40))); table.add(row2); Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Address") + ":"), true)); row3.add(new Cell(new TextArea("Address",
                 * classified.getAddress(teasession._nLanguage), 2, 60))); table.add(row3); Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "City") + ":"), true)); row4.add(new Cell(new TextField("City", classified.getCity(teasession._nLanguage), 20, 20))); table.add(row4); Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "State") + ":"), true)); row5.add(new Cell(new TextField("State", classified.getState(teasession._nLanguage), 20,
                 * 20))); table.add(row5); Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Zip") + ":"), true)); row6.add(new Cell(new TextField("Zip", classified.getZip(teasession._nLanguage), 20, 20))); table.add(row6); Row row7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Country") + ":"), true)); row7.add(new Cell(new TextField("Country", classified.getCountry(teasession._nLanguage), 20, 20))); table.add(row7); Row row8 = new Row(new
                 * Cell(new Text(super.r.getString(teasession._nLanguage, "Telephone") + ":"), true)); row8.add(new Cell(new TextField("Telephone", classified.getTelephone(teasession._nLanguage), 20, 20))); table.add(row8); Row row9 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Fax") + ":"), true)); row9.add(new Cell(new TextField("Fax", classified.getFax(teasession._nLanguage), 20, 20))); table.add(row9); Row row10 = new Row(new Cell(new
                 * Text(super.r.getString(teasession._nLanguage, "WebPage") + ":"), true)); row10.add(new Cell(new TextField("WebPage", classified.getWebPage(teasession._nLanguage), 60, 255))); table.add(row10); Row row11 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "WebLanguage") + ":"), true)); DropDown dropdown = new DropDown("WebLanguage", classified.getWebLanguage(teasession._nLanguage)); for(int j = 0; j < Common.LANGUAGE.length; j++) dropdown.addOption(j,
                 * super.r.getString(teasession._nLanguage, Common.LANGUAGE[j]));
                 *
                 * row11.add(new Cell(dropdown)); table.add(row11); form.add(table); form.add(new Go(teasession._nLanguage, 1)); PrintWriter printwriter = response.getWriter(); printwriter.print(node.getAncestor(teasession._nLanguage, "Path")); printwriter.print(form); printwriter.print(new Languages(teasession._nLanguage, request)); printwriter.close();
                 */
                return;
            } else 
            {
                String text = teasession.getParameter("content");

				boolean srccopy = teasession.getParameter("srccopy") != null;//源网站的图片贴入本地
				if(srccopy)
				{
					text = copy(teasession._strCommunity,text);
				}
				boolean textorhtml = "1".equals(teasession.getParameter("TextOrHtml"));//使用HTML

                String Keywords = teasession.getParameter("Keywords");
                String subject = teasession.getParameter("Name");
                if (teasession.getParameter("NewNode") != null)
                {
                    int sequence = Node.getMaxSequence(teasession._nNode) + 10;
                    long options = node.getOptions();
                    int options1 = node.getOptions1();
                    Category cat = Category.find(teasession._nNode);
                    teasession._nNode = Node.create(teasession._nNode, sequence, node.getCommunity(), teasession._rv, cat.getCategory(), (options1 & 2) != 0, 
                    		options, options1, node.getDefaultLanguage(), null, null, new java.util.Date(), 0, 0, 0, 0, 
                    		null, teasession._nLanguage, subject, Keywords,"", text, null, "", 0, null, "", "", "", "", null, null);
                    
                    
					node=Node.find(teasession._nNode);
				} else
                { 
                    node.set(teasession._nLanguage, subject, text);
                }
                Expert classified = Expert.find(teasession._nNode, teasession._nLanguage);
                String s = teasession.getParameter("Contact");
                String s1 = teasession.getParameter("Email");
                String s2 = teasession.getParameter("Organization");
                String s3 = teasession.getParameter("Address");
                String s4 = teasession.getParameter("City");
                String s5 = teasession.getParameter("State");
                String s6 = teasession.getParameter("Zip");
                String s7 = teasession.getParameter("Country");
                String s8 = teasession.getParameter("Telephone");
                String s9 = teasession.getParameter("Fax");
                String s10 = teasession.getParameter("WebPage");
                int i = Integer.parseInt(teasession.getParameter("WebLanguage"));
                java.util.Date date = null;
                try
                {
                    String birthday = teasession.getParameter("birthday");
                    if (birthday.length() > 0)
                    {
                        date = tea.htmlx.TimeSelection.makeTime(birthday);
                    }
                } catch (Exception ex)
                {
                }
                byte by[] = teasession.getBytesParameter("photo");
                String photo = null;
                if (by != null)
                {
                    photo = request.getContextPath() + super.write(node.getCommunity(), by, ".gif");
                } else if (teasession.getParameter("clear") != null)
                {
                    photo = null;
                } else
                {
                    photo = classified.getPhoto();
                }

                by = teasession.getBytesParameter("photobig");
                String photobig = null;
                if (by != null)
                {
                    photobig = request.getContextPath() + super.write(node.getCommunity(), by, ".gif");
                } else if (teasession.getParameter("clearphotobig") != null)
                {
                    photobig = null;
                } else
                {
                    photobig = classified.getPhotoBig();
                }

                String alias = teasession.getParameter("alias");
                java.util.Date matriculation = null;
                try
                {
                    String birthday = teasession.getParameter("matriculation");
                    if (birthday.length() > 0)
                    {
                        matriculation = tea.htmlx.TimeSelection.makeTime(birthday);
                    }
                } catch (Exception ex)
                {
                }

                String folk = teasession.getParameter("folk");
                String classes = teasession.getParameter("class");
                int graduate = Integer.parseInt(teasession.getParameter("graduate"));
                String aim = teasession.getParameter("aim");
                String duty = teasession.getParameter("duty");
                String technical = teasession.getParameter("technical");
                String homephone = teasession.getParameter("homephone");
                String handset = teasession.getParameter("handset");
                String msn = teasession.getParameter("msn");
                String qq = teasession.getParameter("qq");
                String leaveword = teasession.getParameter("leaveword");
                String place = teasession.getParameter("place");
                String languageClass = teasession.getParameter("languageclass");
                String rfield = teasession.getParameter("rfield");
                String mrr = teasession.getParameter("mrr");
                String mrrs = teasession.getParameter("mrrs");
                String oci = teasession.getParameter("oci");
                classified.set(teasession._nLanguage, s, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, i, "1".equals(teasession.getParameter("sex")), date, photo, photobig, alias, matriculation, folk, classes, graduate, aim, duty, technical, homephone, handset, msn, qq, leaveword, place, languageClass,rfield,mrr,mrrs,oci);

                delete(node);

                if (teasession.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditNode?node=" + teasession._nNode);
					return;
				}else if(teasession.getParameter("GoBackSuper")!=null)
				{
					  response.sendRedirect("/jsp/general/EditNode.jsp?node=" + teasession._nNode);
					  return;
				}
				else
                {
                    node.finished(teasession._nNode);
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
					return;
                }
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
        // super.r.add("tea/ui/node/type/classified/EditClassified");
    }
}
