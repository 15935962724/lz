// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3)
// Source File Name:   InputBuyPoint.java

package tea.ui.member.buypoint;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.BuyPointConvert;
import tea.entity.member.BuyPointTitle;
import tea.html.*;
import tea.htmlx.ConvertCurrencySelection;
import tea.htmlx.CurrencySelection;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class InputBuyPoint extends TeaServlet
{

    public InputBuyPoint()
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
            if(!teasession._rv.isSupport())
            {
                response.sendError(403);
                return;
            }
            int i = 0;
            try
            {
                i = Integer.parseInt(request.getParameter("BuyPointTitle"));
            } catch(Exception _ex)
            {}
            if(request.getMethod().equals("GET"))
            {
                Form form = new Form("foEdit","POST","InputBuyPoint");
                DropDown dropdown = new DropDown("BuyPointTitle",i);
                dropdown.addOption(0,"***********");
                int l;
                String s1;
                for(Enumeration enumeration = BuyPointTitle.find(teasession._rv._strR);enumeration.hasMoreElements();dropdown.addOption(l,s1))
                {
                    l = ((Integer) enumeration.nextElement()).intValue();
                    BuyPointTitle buypointtitle = BuyPointTitle.find(l);
                    s1 = buypointtitle.getTitle();
                }

                Table table = new Table();
                Row row = new Row(new Cell(new Text(r.getString(teasession._nLanguage,"Commodity") + ":"),true));
                Cell cell = new Cell();
                cell.add(new Text(dropdown.toString()));
                row.add(cell);
                table.add(row);
                table.add(new CurrencySelection(teasession._nLanguage,1,false));
                Row row1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage,"Point") + ":"),true));
                Cell cell1 = new Cell();
                cell1.add(new TextField("Point","1.00",6));
                cell1.add(new Radio("Optionsx",0,true));
                cell1.add(new Text(r.getString(teasession._nLanguage,"BaseOnRelation")));
                row1.add(cell1);
                table.add(row1);
                table.add(new ConvertCurrencySelection(teasession._nLanguage,6,false));
                Row row2 = new Row(new Cell(new Text(r.getString(teasession._nLanguage,"TradeIncludeExpiration") + ":"),true));
                Cell cell2 = new Cell();
                cell2.add(new Radio("Options",0,true));
                cell2.add(new Text(r.getString(teasession._nLanguage,"Yes")));
                cell2.add(new Radio("Options",1,false));
                cell2.add(new Text(r.getString(teasession._nLanguage,"No")));
                row2.add(cell2);
                table.add(row2);
                Row row3 = new Row(new Cell(new Text(r.getString(teasession._nLanguage,"Text") + ":"),true));
                row3.add(new Cell(new TextArea("Text","",25,70)));
                table.add(row3);
                form.add(table);
                form.add(new Button(r.getString(teasession._nLanguage,"Submit")));
                PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
                printwriter.print(form);
                printwriter.close(); //printwriter.close();
            } else
            {
                String s = teasession.getParameter("Text");
                int j = Integer.parseInt(request.getParameter("Currency"));
                int k = Integer.parseInt(request.getParameter("ConvertCurrency"));
                int i1 = Integer.parseInt(request.getParameter("Options"));
                BigDecimal bigdecimal = new BigDecimal(0.0D);
                try
                {
                    bigdecimal = new BigDecimal(request.getParameter("Point"));
                } catch(Exception _ex)
                {}
                BuyPointTitle buypointtitle1 = BuyPointTitle.find(i);
                boolean flag = buypointtitle1.getOtherIDTitle().length() == 0;
                String s2 = s.replace('\r',' ').replace('\n',' ');
                StringTokenizer stringtokenizer = new StringTokenizer(s2,", ");
                long l1 = System.currentTimeMillis() + 0x757b12c00L;
                Date date = new Date(l1);
                if(i1 == 0)
                {
                    if(flag)
                    {
                        int j1 = 0;
                        String s3 = "";
                        String s7 = "";
                        String s11 = "";
                        String s16 = "";
                        String s20 = "";
                        while(stringtokenizer.hasMoreTokens())
                        {
                            if(j1 == 0)
                            {
                                s3 = stringtokenizer.nextToken();
                                j1++;
                            } else
                            if(j1 == 1)
                            {
                                s7 = stringtokenizer.nextToken();
                                j1++;
                            } else
                            if(j1 == 2)
                            {
                                String s12 = stringtokenizer.nextToken();
                                date = toDate(s12);
                                j1++;
                            } else
                            if(j1 == 3)
                            {
                                s16 = stringtokenizer.nextToken();
                                j1++;
                            } else
                            if(j1 == 4)
                            {
                                String s21 = stringtokenizer.nextToken();
                                j1++;
                            }
                            if(j1 == 5)
                            {
                                if(!BuyPointConvert.isExisted(s3,s7,"",teasession._rv))
                                {
                                    BigDecimal bigdecimal4 = new BigDecimal(s16);
                                    BigDecimal bigdecimal8 = bigdecimal4;
                                    BigDecimal bigdecimal11 = bigdecimal8.multiply(bigdecimal);
                                    BuyPointConvert.create(s3,s7,"",j,bigdecimal8,k,bigdecimal11,teasession._rv,date);
                                }
                                j1 = 0;
                            }
                        }
                    } else
                    {
                        int k1 = 0;
                        String s4 = "";
                        String s8 = "";
                        String s13 = "";
                        String s17 = "";
                        String s22 = "";
                        while(stringtokenizer.hasMoreTokens())
                        {
                            if(k1 == 0)
                            {
                                s4 = stringtokenizer.nextToken();
                                k1++;
                            } else
                            if(k1 == 1)
                            {
                                s8 = stringtokenizer.nextToken();
                                k1++;
                            } else
                            if(k1 == 2)
                            {
                                s13 = stringtokenizer.nextToken();
                                k1++;
                            } else
                            if(k1 == 3)
                            {
                                String s18 = stringtokenizer.nextToken();
                                date = toDate(s18);
                                k1++;
                            } else
                            if(k1 == 4)
                            {
                                s22 = stringtokenizer.nextToken();
                                k1++;
                            }
                            if(k1 == 5)
                            {
                                if(!BuyPointConvert.isExisted(s4,s8,s13,teasession._rv))
                                {
                                    BigDecimal bigdecimal5 = new BigDecimal(s22);
                                    BigDecimal bigdecimal9 = bigdecimal5;
                                    BigDecimal bigdecimal12 = bigdecimal9.multiply(bigdecimal);
                                    BuyPointConvert.create(s4,s8,s13,j,bigdecimal9,k,bigdecimal12,teasession._rv,date);
                                }
                                k1 = 0;
                            }
                        }
                    }
                } else
                if(flag)
                {
                    int i2 = 0;
                    String s5 = "";
                    String s9 = "";
                    String s14 = "";
                    while(stringtokenizer.hasMoreTokens())
                    {
                        if(i2 == 0)
                        {
                            s5 = stringtokenizer.nextToken();
                            i2++;
                        } else
                        if(i2 == 1)
                        {
                            s9 = stringtokenizer.nextToken();
                            i2++;
                        } else
                        if(i2 == 2)
                        {
                            s14 = stringtokenizer.nextToken();
                            i2++;
                        }
                        if(i2 == 3)
                        {
                            if(!BuyPointConvert.isExisted(s5,s9,"",teasession._rv))
                            {
                                BigDecimal bigdecimal1 = new BigDecimal(s14);
                                BigDecimal bigdecimal2 = bigdecimal1;
                                BigDecimal bigdecimal6 = bigdecimal2.multiply(bigdecimal);
                                BuyPointConvert.create(s5,s9,"",j,bigdecimal2,k,bigdecimal6,teasession._rv,date);
                            }
                            i2 = 0;
                        }
                    }
                } else
                {
                    int j2 = 0;
                    String s6 = "";
                    String s10 = "";
                    String s15 = "";
                    String s19 = "";
                    while(stringtokenizer.hasMoreTokens())
                    {
                        if(j2 == 0)
                        {
                            s6 = stringtokenizer.nextToken();
                            j2++;
                        } else
                        if(j2 == 1)
                        {
                            s10 = stringtokenizer.nextToken();
                            j2++;
                        } else
                        if(j2 == 2)
                        {
                            s15 = stringtokenizer.nextToken();
                            j2++;
                        } else
                        if(j2 == 3)
                        {
                            s19 = stringtokenizer.nextToken();
                            j2++;
                        }
                        if(j2 == 4)
                        {
                            if(!BuyPointConvert.isExisted(s6,s10,s15,teasession._rv))
                            {
                                BigDecimal bigdecimal3 = new BigDecimal(s19);
                                BigDecimal bigdecimal7 = bigdecimal3;
                                BigDecimal bigdecimal10 = bigdecimal7.multiply(bigdecimal);
                                BuyPointConvert.create(s6,s10,s15,j,bigdecimal7,k,bigdecimal10,teasession._rv,date);
                            }
                            j2 = 0;
                        }
                    }
                }
            }
            response.sendRedirect("BuyPoints");
            return;
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/member/contact/InputBuyPoint").add("tea/ui/member/contact/ConvertBuyPoint").add("tea/ui/member/buypoint/BuyPoints").add("tea/ui/node/type/buy/EditBuyPrice");
    }

    public static Date toDate(String s) throws Exception
    {
        String s1 = s.substring(0,s.indexOf("/")).trim();
        String s2 = s.substring(s.indexOf("/") + 1,s.lastIndexOf("/")).trim();
        String s3 = s.substring(s.lastIndexOf("/") + 1).trim();
        GregorianCalendar gregoriancalendar = new GregorianCalendar(Integer.parseInt(s3),Integer.parseInt(s1) - 1,Integer.parseInt(s2));
        Date date = gregoriancalendar.getTime();
        return date;
    }
}
