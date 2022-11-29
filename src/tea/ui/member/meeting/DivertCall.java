// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-10-8 11:04:15
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   DivertCall.java

package tea.ui.member.meeting;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.html.Anchor;
import tea.html.Text;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DivertCall extends TeaServlet
{

    public DivertCall()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

StringBuilder sb=new StringBuilder("?");
java.util.Enumeration enumeration= request.getParameterNames() ;
while(enumeration.hasMoreElements())
{  String str=enumeration.nextElement().toString();
   sb.append(str+"="+request.getParameter(str)+"&" );
}
sb.setLength(sb.length()-1);
response.sendRedirect("/jsp/meeting/DivertCall.jsp"+sb.toString());

/*
            String s = request.getParameter("Receiver");
            PrintWriter printwriter = response.getWriter();
            Object aobj[] = {
                s, new Anchor("NewMessage?Receiver=" + s, new Text(super.r.getString(teasession._nLanguage, "ClickHere")))
            };
            printwriter.print(MessageFormat.format(super.r.getString(teasession._nLanguage, "InfNotAccept"), aobj));
            printwriter.close();
*/
        }
        catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
       // super.r.add("tea/ui/member/meeting/DivertCall");
    }
}
