package tea.ui.node.general;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.StringTokenizer;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.Node;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class RotatePicture extends TeaServlet
{

    public RotatePicture()
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
            String s = teasession.getParameter("Clockwise");
            int i = teasession._nNode;
            Node node = Node.find(i);
            String s1 = node.getCommunity();
            String s2 = node.getSrcUrl(teasession._nLanguage);
            String s3 = node.getSrcUrlx(teasession._nLanguage);
            String s4 = "0, 1, 2, 3, 4, 5, 6, 7, 8, 9";
            int j = node.getDirection(teasession._nLanguage);
            int k = node.getType();
            int l = node.getFather();
            Node node1 = Node.find(l);
            int i1 = node1.getFather();
            Node node2 = Node.find(i1);
            int j1 = node2.getFather();
            Node node3 = Node.find(j1);
            int k1 = node3.getFather();
            Node node4 = Node.find(k1);
            boolean flag = node.isCreator(teasession._rv);
            boolean flag1 = teasession._rv.isOrganizer(s1);
            boolean flag2 = teasession._rv.isProvider(i,k);
            boolean flag3 = teasession._rv.isWebMaster();
            boolean flag4 = node1.isCreator(teasession._rv);
            boolean flag5 = node2.isCreator(teasession._rv);
            boolean flag6 = node3.isCreator(teasession._rv);
            boolean flag7 = node4.isCreator(teasession._rv);
            if(flag || flag1 || flag2 || flag3 || flag4 || flag5 || flag6 || flag7)
            {
                if(s2.length() != 0 && s2.lastIndexOf(".") >= 1 && s2.lastIndexOf("/") < s2.lastIndexOf("."))
                {
                    boolean flag8 = false;
                    Object obj = null;
                    int l1 = j;
                    for(StringTokenizer stringtokenizer = new StringTokenizer(s4," ,");stringtokenizer.hasMoreTokens();)
                    {
                        String s9 = stringtokenizer.nextToken();
                        if(s9.equalsIgnoreCase(s2.substring(s2.lastIndexOf("/") + 1,s2.lastIndexOf("/") + 2)))
                        {
                            flag8 = true;
                            break;
                        }
                    }

                    if(flag8)
                    {
                        if(s.equalsIgnoreCase("right"))
                        {
                            int j2 = 0;
                            String s5;
                            do
                            {
                                l1++;
                                if(l1 > 9)
                                {
                                    l1 = 0;
                                    j2++;
                                }
                                s5 = s2.substring(0,s2.lastIndexOf("/") + 1) + l1 + s2.substring(s2.lastIndexOf("/") + 2);
                            } while(l1 <= 9 && j2 <= 1 && !isUrlValid(s5));
                            if(l1 <= 9 && j2 <= 1)
                            {
                                node.setDirection(l1);
                                node.setSrcUrl(s5);
                            }
                        }
                        if(s.equalsIgnoreCase("left"))
                        {
                            int k2 = 0;
                            String s6;
                            do
                            {
                                l1--;
                                if(l1 < 0)
                                {
                                    l1 = 9;
                                    k2++;
                                }
                                s6 = s2.substring(0,s2.lastIndexOf("/") + 1) + l1 + s2.substring(s2.lastIndexOf("/") + 2);
                            } while(l1 >= 0 && k2 <= 1 && !isUrlValid(s6));
                            if(l1 >= 0 && k2 <= 1)
                            {
                                node.setDirection(l1);
                                node.setSrcUrl(s6);
                            }
                        }
                    }
                }
                if(s3.length() != 0 && s3.lastIndexOf(".") >= 1 && s3.lastIndexOf("/") < s3.lastIndexOf("."))
                {
                    boolean flag9 = false;
                    Object obj1 = null;
                    int i2 = j;
                    for(StringTokenizer stringtokenizer1 = new StringTokenizer(s4," ,");stringtokenizer1.hasMoreTokens();)
                    {
                        String s10 = stringtokenizer1.nextToken();
                        if(s10.equalsIgnoreCase(s3.substring(s3.lastIndexOf("/") + 1,s3.lastIndexOf("/") + 2)))
                        {
                            flag9 = true;
                            break;
                        }
                    }

                    if(flag9)
                    {
                        if(s.equalsIgnoreCase("right"))
                        {
                            int l2 = 0;
                            String s7;
                            do
                            {
                                i2++;
                                if(i2 > 9)
                                {
                                    i2 = 0;
                                    l2++;
                                }
                                s7 = s3.substring(0,s3.lastIndexOf("/") + 1) + i2 + s3.substring(s3.lastIndexOf("/") + 2);
                            } while(i2 <= 9 && l2 <= 1 && !isUrlValid(s7));
                            if(i2 <= 9 && l2 <= 1)
                            {
                                node.setDirection(i2);
                                node.setSrcUrlx(s7);
                            }
                        }
                        if(s.equalsIgnoreCase("left"))
                        {
                            int i3 = 0;
                            String s8;
                            do
                            {
                                i2--;
                                if(i2 < 0)
                                {
                                    i2 = 9;
                                    i3++;
                                }
                                s8 = s3.substring(0,s3.lastIndexOf("/") + 1) + i2 + s3.substring(s3.lastIndexOf("/") + 2);
                            } while(i2 >= 0 && i3 <= 1 && !isUrlValid(s8));
                            if(i2 >= 0 && i3 <= 1)
                            {
                                node.setDirection(i2);
                                node.setSrcUrlx(s8);
                            }
                        }
                    }
                }
            } else
            {
                response.sendError(403);
                return;
            }
            response.sendRedirect("Node?node=" + i);
            return;
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/general/RotatePicture").add("tea/ui/node/general/NodeServlet");
    }

    private static boolean isUrlValid(String s) throws Exception
    {
        String s1 = s.substring(0,s.indexOf(":"));
        boolean flag = false;
        if(s.length() != 0 && s1.equalsIgnoreCase("http"))
            try
            {
                URL url = new URL(s);
                java.net.URLConnection urlconnection = url.openConnection();
                HttpURLConnection httpurlconnection = (HttpURLConnection) urlconnection;
                int i = httpurlconnection.getResponseCode();
                if(i == 403 || i == 200)
                    flag = true;
            } catch(Exception _ex)
            {}
        return flag;
    }
}
