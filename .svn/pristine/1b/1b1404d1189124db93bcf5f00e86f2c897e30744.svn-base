package tea.ui.member.order;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Trade;
import tea.entity.member.TradeItem;
import tea.entity.node.Node;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class TradeDataOutput extends TeaServlet
{

    public TradeDataOutput()
    {
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/order/TradeDataOutput");
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            boolean flag = false;
            Object obj = null;
            try
            {
                String s = request.getParameter("Batch");
                if (s != null && s.equalsIgnoreCase("true"))
                {
                    flag = true;
                }
            } catch (Exception _ex)
            {}
            if (!flag)
            {
                int i = Integer.parseInt(request.getParameter("Trade"));
                int k = Integer.parseInt(request.getParameter("Method"));
                switch (k)
                {
                case 0: // '\0'
                    photoShop0(i, teasession._nLanguage, teasession._rv);
                    // fall through

                case -1:
                case 1: // '\001'
                case 2: // '\002'
                case 3: // '\003'
                default:
                    response.sendRedirect("Trade?Trade=" + i);
                    break;
                }
                return;
            }
            int j = Integer.parseInt(request.getParameter("Type"));
            int l = Integer.parseInt(request.getParameter("Status"));
            int i1 = Integer.parseInt(request.getParameter("Method"));
            String as[] = request.getParameterValues("Trades");
            if (as != null)
            {
                for (int j1 = 0; j1 < as.length; j1++)
                {
                    if (as[j1] != null)
                    {
                        int k1 = ((as[j1])).intValue();
                        switch (i1)
                        {
                        case 0: // '\0'
                            photoShop0(k1, teasession._nLanguage, teasession._rv);
                            break;
                        }
                    }
                }

            }
            response.sendRedirect("SaleOrders?Type=" + j + "&Status=" + l);
            return;
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public static void photoShop0(int i, int j, RV rv) throws Exception
    {
        try
        {
            Trade trade = Trade.find(i);
            int k = trade.getType();
            int l = trade.getStatus();
            boolean flag = trade.isVendor(rv);
            if (flag)
            {
                if (l == 2 || l == 5)//2=准备发货  5=已经发货
                {
                    trade.vendorRead();
                    String s = "";
                    String s1 = "C:\\teaOutputData\\Members\\" + rv._strR + "\\SalesOrders\\TradeDataOutput\\";
                    String s2 = "txt";
                    File file = new File(s1);
                    if (file.exists())
                    {
                        s = searchFile(file, s1, i, s2);
                    }
                    if (s.length() == 0)
                    {
                        SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy");
                        SimpleDateFormat simpledateformat1 = new SimpleDateFormat("MM");
                        SimpleDateFormat simpledateformat2 = new SimpleDateFormat("dd");
                        Date date = new Date();
                        String s3 = simpledateformat.format(date);
                        String s4 = simpledateformat1.format(date);
                        String s5 = simpledateformat2.format(date);
                        String s6 = s1 + s3 + "\\" + s4 + "\\" + s5 + "\\";
                        File file1 = new File(s6);
                        file1.mkdirs();
                        File file2 = new File(s6 + i + "." + s2);
                        FileWriter filewriter = new FileWriter(file2);
                        for (Enumeration enumeration = TradeItem.findByTrade(i); enumeration.hasMoreElements(); )
                        {
                            int i1 = ((Integer) enumeration.nextElement()).intValue();
                            TradeItem tradeitem = TradeItem.find(i1);
                            int j1 = tradeitem.getSubject();
                            int k1 = tradeitem.getSubjectx();
                            int l1 = tradeitem.getSQuantity();
                            boolean flag1 = false;
                            String s7 = "";
                            String s9 = "";
                            String s11 = "";
                            String s13 = "";
                            String s15 = "";
                            String s17 = "";
                            String s19 = "";
                            String s20 = "";
                            String s21 = "";
                            String s22 = "";
                            String s24 = "";
                            String s25 = "";
                            String s26 = "";
                            String s27 = "";
                            String s28 = "";
                            if (k == 1 || k == 2 || k == 3)
                            {
                                Node node = Node.find(j1);
                                Node node1 = Node.find(k1);
                                int i2 = node1.getDirection(j);
                                String s8 = node.getCommunity();
                                String s10 = node1.getCommunity();
                                String s12 = node.getSubject(j);
                                String s14 = node1.getSubject(j);
                                String s16 = node1.getSrcUrl(j);
                                String s18 = node1.getSrcUrlx(j);
                                if (s16.length() != 0)
                                {
                                    s19 = s16.substring(getLastIndex(s16, "/", 4) + 1, getLastIndex(s16, "/", 3));
                                    s20 = s16.substring(getLastIndex(s16, "/", 3) + 1, getLastIndex(s16, "/", 2));
                                    s21 = s16.substring(s16.lastIndexOf("/") + 1);
                                } else
                                if (s18.length() != 0)
                                {
                                    s19 = s18.substring(getLastIndex(s18, "/", 4) + 1, getLastIndex(s18, "/", 3));
                                    s20 = s18.substring(getLastIndex(s18, "/", 3) + 1, getLastIndex(s18, "/", 2));
                                    s21 = s18.substring(s18.lastIndexOf("/") + 1);
                                }
                                String s23;
                                if (getIndex(s12, "_", 1) < 0)
                                {
                                    s23 = s12;
                                } else
                                {
                                    s23 = s12.substring(0, s12.indexOf("_"));
                                    if (getIndex(s12, "_", 2) < 0)
                                    {
                                        s24 = s12.substring(getIndex(s12, "_", 1) + 1);
                                    } else
                                    {
                                        s24 = s12.substring(getIndex(s12, "_", 1) + 1, getIndex(s12, "_", 2));
                                        if (getIndex(s12, "_", 3) < 0)
                                        {
                                            s25 = s12.substring(getIndex(s12, "_", 2) + 1);
                                        } else
                                        {
                                            s25 = s12.substring(getIndex(s12, "_", 2) + 1, getIndex(s12, "_", 3));
                                            if (getIndex(s12, "_", 4) < 0)
                                            {
                                                s26 = s12.substring(getIndex(s12, "_", 3) + 1);
                                            } else
                                            {
                                                s26 = s12.substring(getIndex(s12, "_", 3) + 1, getIndex(s12, "_", 4));
                                                if (getIndex(s12, "_", 5) < 0)
                                                {
                                                    s27 = s12.substring(getIndex(s12, "_", 4) + 1);
                                                } else
                                                {
                                                    s27 = s12.substring(getIndex(s12, "_", 4) + 1, getIndex(s12, "_", 5));
                                                    String s29;
                                                    if (getIndex(s12, "_", 6) < 0)
                                                    {
                                                        s29 = s12.substring(getIndex(s12, "_", 5) + 1);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                filewriter.write(s10 + "," + s19 + "," + s20 + "," + s21 + "," + s23 + "," + s24 + "," + l1 + "," + s25 + "," + s26 + "," + s27 + "," + i2);
                                filewriter.write("\r\n");
                            }
                        }

                        filewriter.flush();
                        filewriter.close();
                    }
                }
                return;
            }
        } catch (Exception _ex)
        {}
    }

    private static String searchFile(File file, String s, int i, String s1) throws Exception
    {
        String as[] = file.list();
        File afile[] = new File[as.length];
        String as1[] = new String[as.length];
        String as2[] = new String[as.length];
        String s2 = "";
        boolean flag = false;
        for (int j = 0; j < as.length; j++)
        {
            String s3 = s + "/" + as[j];
            afile[j] = new File(s3);
            if (afile[j].isFile())
            {
                as1[j] = as[j];
                as2[j] = afile[j].getCanonicalPath();
                if (as1[j].equalsIgnoreCase(i + "." + s1))
                {
                    s2 = as2[j];
                    flag = true;
                }
            } else
            {
                s2 = searchFile(afile[j], s3, i, s1);
                if (s2.length() != 0)
                {
                    flag = true;
                }
            }
            if (flag)
            {
                break;
            }
        }

        return s2;
    }

    private static int getLastIndex(String s, String s1, int i) throws Exception
    {
        boolean flag = false;
        int ai[] = new int[i];
        for (int j = 0; j <= i - 1; j++)
        {
            ai[j] = -1;
        }

        ai[0] = s.lastIndexOf(s1);
        if (i > 1)
        {
            for (int k = 0; k < i - 1; k++)
            {
                ai[k + 1] = s.lastIndexOf(s1, ai[k] - 1);
                if (ai[k + 1] < 0)
                {
                    break;
                }
            }

        }
        return ai[i - 1];
    }

    private static int getIndex(String s, String s1, int i) throws Exception
    {
        boolean flag = false;
        int ai[] = new int[i];
        for (int j = 0; j <= i - 1; j++)
        {
            ai[j] = -1;
        }

        ai[0] = s.indexOf(s1);
        if (i > 1)
        {
            for (int k = 0; k < i - 1; k++)
            {
                ai[k + 1] = s.indexOf(s1, ai[k] + 1);
                if (ai[k + 1] < 0)
                {
                    break;
                }
            }

        }
        return ai[i - 1];
    }

    public static final String TRADEDATAOUTPUT_METHOD[] =
            {
            "0 PhotoShop", "1 PhotoShop", "2 PhotoShop", "3 BookStore"
    };
    public static final int TRADEDATAOUTPUTM_0PHOTOSHOP = 0;
    public static final int TRADEDATAOUTPUTM_1PHOTOSHOP = 1;
    public static final int TRADEDATAOUTPUTM_2PHOTOSHOP = 2;
    public static final int TRADEDATAOUTPUTM_3BOOKSTORE = 3;

}
