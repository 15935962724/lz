// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-24 16:20:51
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   ProfileServlet.java

package tea.ui.member.profile;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.site.Subscriber;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.RequestHelper;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ProfileServlet extends TeaServlet
{

    public ProfileServlet()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            String s = request.getParameter("Member");
            if (s == null)
            {
                if (teasession._rv != null)
                {
                    s = teasession._rv._strR;
                } else
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
            }

            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/profile/Profile.jsp" + qs);
            return; /*
                Text text = new Text(hrefGlance(s) + ">" + super.r.getString(teasession._nLanguage, "Profile"));
                text.setId("PathDiv");
                boolean flag = teasession._rv != null && teasession._rv._strR.equals(s);
                List list = new List();
                if(flag)
                {
                    list.add(new ListItem(new Anchor("LoginHistory", super.r.getString(teasession._nLanguage, "LoginHistory"))));
                    if(teasession._rv.isHR())
                        list.add(new ListItem(new Anchor("Associates", super.r.getString(teasession._nLanguage, "Associates"))));
                    if(teasession._rv.isAccountant())
                    {
                        list.add(new ListItem(new Anchor("BuyInstructions", super.r.getString(teasession._nLanguage, "BuyInstructions"))));
                        list.add(new ListItem(new Anchor("Shippings", super.r.getString(teasession._nLanguage, "Shippings"))));
                        list.add(new ListItem(new Anchor("Coupons", super.r.getString(teasession._nLanguage, "Coupons"))));
                    }
                }
                PrintWriter printwriter = response.getWriter();
                printwriter.print(text);
                printwriter.print(list);
                boolean flag1 = false;
                boolean flag2 = false;
                if(teasession._rv != null)
                {
                    flag1 = ProfileRequest.isExisted(s, teasession._rv);
                    flag2 = s.equals(teasession._rv._strR) || teasession._rv.isWebMaster() || ProfileGrant.isExisted(s, teasession._rv) || Subscriber.inOrganizer(s, teasession._rv._strR);
                }
                Profile profile = Profile.find(s);
                printwriter.print(new Break());
                Text text1 = new Text(s);
                text1.setId("MemberId");
                printwriter.print(text1);
                Text text2 = new Text(hrefNewMessage(s, RequestHelper.makeName(teasession._nLanguage, profile.getFirstName(teasession._nLanguage), profile.getLastName(teasession._nLanguage))));
                text2.setId("MemberName");
                printwriter.print(text2);
                printwriter.print(new Break());
                if(flag2 || profile.getType() == 1)
                {
                    Text text3 = new Text(hrefNewMessage(profile.getEmail(teasession._nLanguage)));
                    text3.setId("MemberEmail");
                    printwriter.print(text3);
                    printwriter.print(new Break());
                    String s1 = profile.getOrganization(teasession._nLanguage);
                    if(s1.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "Organization") + ": "));
                        Text text4 = new Text(s1);
                        text4.setId("MemberOrganization");
                        printwriter.print(text4);
                    }
                    String s3 = profile.getWebPage(teasession._nLanguage);
                    if(s3.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "WebPage") + ": "));
                        Anchor anchor = new Anchor((s3.toLowerCase().startsWith("http://") ? "" : "http://") + s3, "_blank", new Text(s3));
                        printwriter.print(anchor);
                    }
                    String s4 = profile.getAddress(teasession._nLanguage);
                    if(s4.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "Address") + ":"));
                        Text text5 = new Text(s4);
                        text5.setId("MemberAddress");
                        printwriter.print(text5);
                    }
                    String s5 = profile.getCity(teasession._nLanguage);
                    if(s5.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "City") + ":"));
                        Text text6 = new Text(s5);
                        text6.setId("MemberCity");
                        printwriter.print(text6);
                    }
                    String s6 = profile.getState(teasession._nLanguage);
                    if(s6.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "State") + ":"));
                        Text text7 = new Text(s6);
                        text7.setId("MemberState");
                        printwriter.print(text7);
                    }
                    String s7 = profile.getZip(teasession._nLanguage);
                    if(s7.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "Zip") + ":"));
                        Text text8 = new Text(s7);
                        text8.setId("MemberZip");
                        printwriter.print(text8);
                    }
                    String s8 = profile.getCountry(teasession._nLanguage);
                    if(s8.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "Country") + ":"));
                        Text text9 = new Text(s8);
                        text9.setId("MemberCountry");
                        printwriter.print(text9);
                    }
                    String s9 = profile.getTelephone(teasession._nLanguage);
                    if(s9.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "Telephone") + ":"));
                        Text text10 = new Text(s9);
                        text10.setId("MemberTelephone");
                        printwriter.print(text10);
                    }
                    String s10 = profile.getFax(teasession._nLanguage);
                    if(s10.length() != 0)
                    {
                        printwriter.print(new Text(" " + super.r.getString(teasession._nLanguage, "Fax") + ":"));
                        Text text11 = new Text(s10);
                        text11.setId("MemberFax");
                        printwriter.print(text11);
                    }
                } else
                if(flag1)
                    printwriter.print(super.r.getString(teasession._nLanguage, "InfAlreadyRequestedProfile"));
                else
                    printwriter.print(new Anchor("RequestProfile?Member=" + s, new Text(super.r.getString(teasession._nLanguage, "RequestProfile")), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmRequest") + "'));"));
                printwriter.print(new Break());
                if(flag && teasession._rv.isSupport())
                {
                    printwriter.print(new Button(1, "CB", "CBEditAddress", super.r.getString(teasession._nLanguage, "CBEditAddress"), "window.open('EditAddress', '_self');"));
                    printwriter.print(new Break());
                }
                Home home = Home.find(s);
                String s2 = home.getContent(teasession._nLanguage);
                if(s2 != null)
                    printwriter.print(s2);
                if(home.getPictureFlag())
                    printwriter.print(new Image("HomePicture?Member=" + s));
                if(home.getVoiceFlag())
                    printwriter.print(new Button(1, "CB", "CBPlay", super.r.getString(teasession._nLanguage, "CBPlay"), "window.open('HomeVoice?Member=" + s + "', '_self');"));
                if(home.getFileFlag())
                    printwriter.print(new Button(1, "CB", "CBDownload", super.r.getString(teasession._nLanguage, "CBDownload"), "window.open('HomeFile?Member=" + s + "', '_self');"));
                printwriter.print(new Break());
                if(flag && teasession._rv.isSupport())
                    printwriter.print(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditHome', '_self');"));
                if(flag && teasession._rv.isReal())
                {
                    printwriter.print(new Button(1, "CB", "CBChangePassword", super.r.getString(teasession._nLanguage, "CBChangePassword"), "window.open('ChangePassword', '_self');"));
                    printwriter.print(new Button(1, "CB", "CBCancelMemberShip", super.r.getString(teasession._nLanguage, "CBCancelMemberShip"), "window.open('CancelMembership', '_self');"));
                }
                printwriter.print(new Languages(teasession._nLanguage, request));
                printwriter.close();*/
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
//        super.r.add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/profile/Coupons");
    }
}
