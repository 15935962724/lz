package tea.ui.admin.im;

import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import tea.entity.admin.im.*;
import tea.entity.site.*;
import tea.ui.*;

/**
 * Servlet implementation class for Servlet: EditIm
 *
 */
public class EditIm extends TeaServlet implements javax.servlet.Servlet
{
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String act = request.getHeader("act");
        try
        {
            if ("client".equals(act))
            {
                String community = request.getHeader("community");
                String sn = request.getServerName();
                InputStream is = request.getInputStream();

                Map m = new HashMap();

//                Communityim cim = Communityim.find(teasession._strCommunity);
//                String dayfocus = cim.getDayfocus();
//                if (dayfocus != null && dayfocus.length() > 0 && !dayfocus.startsWith("http"))
//                {
//                    dayfocus = "http://" + sn + dayfocus;
//                }
//                String report = cim.getReport();
//                if (report != null && report.length() > 0 && !report.startsWith("http"))
//                {
//                    report = "http://" + sn + report;
//                }
//                m.put("dayfocus", dayfocus);
//                m.put("report", report);

                ArrayList al = new ArrayList();
                java.util.Enumeration e = Imdirectory.find(community, "", 0, 200);
                while (e.hasMoreElements())
                {
                    int id = ((Integer) e.nextElement()).intValue();
                    Imdirectory obj = Imdirectory.find(id);
                    String picture = obj.getPicture();
                    if (picture != null && picture.length() > 0 && !picture.startsWith("http"))
                    {
                        picture = "http://" + sn + picture;
                    }
                    String url = obj.getUrl();
                    if (!url.startsWith("http"))
                    {
                        url = "http://" + sn + url;
                    }
                    url = url + (url.lastIndexOf("?") != -1 ? "&" : "?") + "community=" + community;

                    Map map = new HashMap();
                    map.put("name", obj.getName());
                    map.put("picture", picture);
                    map.put("url", url);
                    map.put("type", new Integer(obj.getType()));
                    al.add(map);
                }
                m.put("imdirectory", al);
                ObjectOutputStream oos = new ObjectOutputStream(response.getOutputStream());
                oos.writeObject(m);
                oos.close();
                return;
            } else if ("history".equals(act))
            {
                ObjectInputStream is = new ObjectInputStream(request.getInputStream());
                ArrayList al = (ArrayList) is.readObject();
                is.close();
                for (int i = 0; i < al.size(); i++)
                {
                    Map m = (Map) al.get(i);
                    String from = (String) m.get("from");
                    String to = (String) m.get("to");
                    String content = (String) m.get("content");
                    Date time = (Date) m.get("time");

                    int tmp = from.indexOf("@127.0.0.1");
                    if (tmp != -1)
                    {
                        from = from.substring(0, tmp);
                    }
                    tmp = to.indexOf("@127.0.0.1");
                    if (tmp != -1)
                    {
                        to = to.substring(0, tmp);
                    }
                    ImHistory.create(from, to, content, time);
                }
                return;
            }
            request.setCharacterEncoding("UTF-8");
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getRequestURI() + "?" + request.getQueryString(), "UTF-8"));
                return;
            }
            act = teasession.getParameter("act");
            String nexturl = teasession.getParameter("nexturl");
            if ("editimdirectory".equals(act))
            {
                String name = teasession.getParameter("name");
                byte by[] = teasession.getBytesParameter("picture");
                String picture = null;
                if (by != null)
                {
                    picture = super.write(teasession._strCommunity, by, ".gif");
                } else if (request.getParameter("clear") != null)
                {
                    picture = "";
                }
                int imdirectory = Integer.parseInt(teasession.getParameter("imdirectory"));
                int type = Integer.parseInt(teasession.getParameter("type"));
                String url = teasession.getParameter("url");
                if (imdirectory < 1)
                {
                    Imdirectory.create(teasession._strCommunity, name, picture, url, type);
                } else
                {
                    Imdirectory obj = Imdirectory.find(imdirectory);
                    obj.set(name, picture, url, type);
                }
            } else if ("deleteimdirectory".equals(act))
            {
                int imdirectory = Integer.parseInt(request.getParameter("imdirectory"));
                Imdirectory obj = Imdirectory.find(imdirectory);
                obj.delete();
            } else if ("moveimdirectory".equals(act))
            {
                int imdirectory = Integer.parseInt(request.getParameter("imdirectory"));
                int sequence = Integer.parseInt(request.getParameter("sequence"));
                java.util.Enumeration e = Imdirectory.find(teasession._strCommunity, "", 0, Integer.MAX_VALUE);
                for (int i = 1; e.hasMoreElements(); i = i + 2)
                {
                    Imdirectory obj = Imdirectory.find(((Integer) e.nextElement()).intValue());
                    obj.setSequence(i);
                }
                Imdirectory obj = Imdirectory.find(imdirectory);
                obj.setSequence(obj.getSequence() + sequence);
            }
            response.sendRedirect(nexturl);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
