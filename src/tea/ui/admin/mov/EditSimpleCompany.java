package tea.ui.admin.mov;



import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;
import tea.ui.*;
import tea.entity.*;
import tea.entity.admin.*;
import tea.entity.admin.mov.*;
import javax.servlet.http.HttpSession;
import tea.entity.member.*;
import tea.entity.node.*;

public class EditSimpleCompany extends TeaServlet
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

                Node node = Node.find(teasession._nNode);
                 boolean newnode = teasession.getParameter("NewNode") != null;

                String act = teasession.getParameter("act");
                String nexturl = teasession.getParameter("nexturl");
                String subject = teasession.getParameter("Name").trim();
                String text = teasession.getParameter("content");

                try
                {
                    int sequence = 0;
                    try
                    {
                        sequence = Integer.parseInt(teasession.getParameter("sequence"));
                    } catch(NumberFormatException ex1){}
                    boolean hidden = false;
                    if(newnode)
                    {
                        long options = node.getOptions();
                        int options1 = node.getOptions1();
                        hidden = (options1 & 2) != 0;
                        int typealias = 0;
                        String community = node.getCommunity();
                        try
                        {
                            typealias = Integer.parseInt(teasession.getParameter("TypeAlias"));
                        } catch(Exception exception1)
                        {
                        }
                        // options &= 0xffdffbff;
                        int defautllangauge = node.getDefaultLanguage();
                        Category cat = Category.find(teasession._nNode); //21
                        teasession._nNode = Node.create(teasession._nNode,sequence,community,teasession._rv,cat.getCategory(),
                        		hidden,options,options1,defautllangauge,null,null,new java.util.Date(),0,0,0,0,null,
                        		teasession._nLanguage,subject,"",text,null,"",null,0,null,"","","","",null,null);
                        Node n = Node.find(teasession._nNode);
                        n.finished(teasession._nNode);

                    } else
                    {
                        node.setSequence(sequence);
                        node.set(teasession._nLanguage,subject,text);
                    }
                    String contact = teasession.getParameter("Contact");
                    String email = teasession.getParameter("Email");
                    String telephone = teasession.getParameter("Telephone");
                    String fax = teasession.getParameter("Fax");
                     String zip = teasession.getParameter("Zip");
                     String state = teasession.getParameter("State");
                     int city = 0;
                     if(teasession.getParameter("City")!=null && teasession.getParameter("City").length()>0)
                         city = Integer.parseInt(teasession.getParameter("City"));

                     String address = teasession.getParameter("Address");
                    String webpage = teasession.getParameter("WebPage");

                     Company obj = Company.find(teasession._nNode);
                     obj.set(teasession._nLanguage,contact,email,null,address,city,state,zip,null,telephone,fax,webpage,null,null);
                    boolean clear = teasession.getParameter("Clear") != null;

                    // logo
                    clear = teasession.getParameter("logoClear") != null;
                     byte by[]  = teasession.getBytesParameter("logo");
                    if(by != null)
                    {
                        obj.setLogo(write(node.getCommunity(),by,".gif"),teasession._nLanguage);
                    } else if(by == null && clear)
                    {
                        obj.setLogo(null,teasession._nLanguage);
                    }

                    // Picture
                    clear = teasession.getParameter("pictureClear") != null;
                    by = teasession.getBytesParameter("picture");
                    if(by != null)
                    {
                        obj.setPicture(write(node.getCommunity(),by,".gif"),teasession._nLanguage);
                    } else if(by == null && clear)
                    {
                        obj.setPicture(null,teasession._nLanguage);
                    }
                    //上级单位
                    try
                    {
                        obj.setSuperior(Integer.parseInt(teasession.getParameter("superior")),teasession._nLanguage);
                    } catch(NumberFormatException ex4)
                    {
                        obj.setSuperior(0,teasession._nLanguage);
                    } catch(Exception ex4){}

                    super.delete(node);


					response.sendRedirect(nexturl);
                // response.sendRedirect("/jsp/info/Succeed.jsp?nexturl=" + URLEncoder.encode(nexturl,"UTF-8"));
                 return;

                } catch (Exception ex)
                {
                        ex.printStackTrace();
                }

        }

        // Clean up resources
        public void destroy()
        {
        }
}
