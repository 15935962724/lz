package tea.ui.member.email;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.mail.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.RV;
import tea.entity.member.EmailBox;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Emails extends TeaServlet
{

    public Emails()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            response.setContentType("text/html;charset=UTF-8");

            String s = request.getParameter("EmailBox");
            Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("EmailBoxs",super.r.getString(teasession._nLanguage,"EmailBoxs")) + ">" + new Anchor("Emails?EmailBox=" + s,super.r.getString(teasession._nLanguage,s)));
            text.setId("PathDiv");
            EmailBox emailbox = EmailBox.find(Integer.parseInt(s));
            String s1 = request.getParameter("Pop3User");
            if(s1 == null)
            {
                s1 = emailbox.getPop3User();
            }
            String s2 = request.getParameter("Pop3Passwd");
            if(s2 == null)
            {
                s2 = emailbox.getPop3Passwd();
            }
            HttpSession httpsession = request.getSession(true);
            if(s1 != null)
            {
                httpsession.setAttribute("tea." + teasession._rv._strR + "." + s + ".User",s1);
            }
            if(s2 != null)
            {
                httpsession.setAttribute("tea." + teasession._rv._strR + "." + s + ".Passwd",s2);
            }

            Form form = new Form("foDelete","GET","DeleteEmails");
            form.add(new HiddenField("EmailBox",s));
            Table table = new Table();
            table.setCellPadding(5);
            int i = -1;
            try
            {
                Folder folder = emailbox.openFolder();
                if(folder != null)
                {
                    System.out.println("文件夹不为空");
                    i = folder.getMessageCount();
                    System.out.println(i);
                    Message amessage[] = folder.getMessages();
                    FetchProfile fetchprofile = new FetchProfile();
                    fetchprofile.add(javax.mail.FetchProfile.Item.ENVELOPE);
                    folder.fetch(amessage,fetchprofile);
                    boolean flag = true;
                    for(int j = amessage.length - 1;j >= 0;j--)
                    {
                        Row row = new Row(new Cell(new CheckBox(Integer.toString(j + 1),false)));
                        Address aaddress[];
                        if((aaddress = amessage[j].getFrom()) != null)
                        {
                            for(int k = 0;k < aaddress.length;k++)
                            {
                                row.add(new Cell(new Anchor("NewMessage?Receiver=" + aaddress[k].toString(),aaddress[k].toString(),"_blank")));
                            }

                        } else
                        {
                            row.add(new Cell(" "));
                        }
                        java.util.Date date = amessage[j].getSentDate();
                        if(date != null)
                        {
                            row.add(new Cell(new Text((new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date))));
                        } else
                        {
                            row.add(new Cell(" "));
                        }
                        String s3 = amessage[j].getSubject();
                        if(s3 == null || s3.length() == 0)
                        {
                            s3 = super.r.getString(teasession._nLanguage,"NoSubject");
                        }
                        row.add(new Cell(new Anchor("Email?EmailBox=" + s + "&EmailNo=" + (j + 1),new Text(s3))));
                        row.add(new HiddenField("Emails",Integer.toString(j + 1)));
                        row.setId(flag ? "OddRow" : "EvenRow");
                        flag = !flag;
                        table.add(row);
                    }

                    emailbox.closeFolder();
                } else
                {
                    System.out.println("文件夹为空");
                }
            } catch(Exception exception1)
            {
                exception1.printStackTrace();
            }
            form.add(table);
            PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
            printwriter.print(text);
            printwriter.println(form);
            if(i == -1)
            {
                Form form1 = new Form("foEmailBox","POST","Emails");
                form1.add(new HiddenField("EmailBox",s));
                form1.add(new Text(super.r.getString(teasession._nLanguage,"InfEnterPop3Password") + ":"));
                form1.add(new PasswordField("Pop3Passwd"));
                form1.add(new Button(super.r.getString(teasession._nLanguage,"Submit")));
                printwriter.print(form1);
                printwriter.print(new Script("document.foEmailBox.Pop3Passwd.focus();"));
            }
            if(i == 0)
            {
                printwriter.print(new Text(super.r.getString(teasession._nLanguage,"0MessageInMailBox") + "<br><br>"));
            }
            printwriter.print(new Button(1,"CB","CBNewMessage",super.r.getString(teasession._nLanguage,"CBNewMessage"),"window.open('NewMessage', '_blank');"));
            if(i > 0)
            {
                printwriter.print(new Button(1,"CB","CBDelete",super.r.getString(teasession._nLanguage,"CBDelete"),"if(confirm('" + super.r.getString(teasession._nLanguage,"ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                printwriter.print(new Button(1,"CB","CBDeleteAll",super.r.getString(teasession._nLanguage,"CBDeleteAll"),"if(confirm('" + super.r.getString(teasession._nLanguage,"ConfirmDeleteAll") + "')){window.open('DeleteAllEmails?EmailBox=" + s + "', '_self');}"));
            }
            printwriter.print(new Languages(teasession._nLanguage,request));
            printwriter.close(); //   printwriter.close();
            return;
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/email/EmailBoxs").add("tea/ui/member/email/Emails");
    }
}
