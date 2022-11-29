package tea.ui.node.aded;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.*;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.*;

public class EditAded extends TeaServlet
{

    public EditAded()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            //权限控制
            /*   if(!teasession._rv.isAdManager())
               {
                   response.sendError(403);
                   return;
               }*/

            String s = teasession.getParameter("Aded");
            boolean flag = s == null;

            //权限控制
            /*    if(!flag)
                {
                    Aded aded = Aded.find(Integer.parseInt(s));
                    if(!aded.isCreator(teasession._rv))
                    {
                        response.sendError(403);
                        return;
                    }
                }*/

            if(request.getMethod().equals("GET"))
            {

                StringBuilder sb = new StringBuilder("?");
                java.util.Enumeration enumeration = request.getParameterNames();
                while(enumeration.hasMoreElements())
                {
                    String str = enumeration.nextElement().toString();
                    sb.append(str + "=" + request.getParameter(str) + "&");
                }
                response.sendRedirect("/jsp/aded/EditAded.jsp" + sb.toString());

                /*
                                int i = 0;
                                int k = 0;
                                Date date1 = null;
                                Date date3 = null;
                                int i1 = 0;
                                String s2 = "";
                                String s4 = "";
                                String s6 = "";
                                int j1 = 0;
                                if(!flag)
                                {
                                    int l1 = Integer.parseInt(s);
                                    Aded aded2 = Aded.find(l1);
                                    i = aded2.getAding();
                                    k = aded2.getOptions();
                                    date1 = aded2.getStartTime();
                                    date3 = aded2.getStopTime();
                                    i1 = aded2.getExpectedImpression() / 1000;
                                    s2 = aded2.getAlt(teasession._nLanguage);
                                    s4 = aded2.getClickUrl(teasession._nLanguage);
                                    s6 = aded2.getPictureUrl(teasession._nLanguage);
                                    j1 = aded2.getPictureLen(teasession._nLanguage);
                                } else
                                {
                                    i = Integer.parseInt(request.getParameter("Ading"));
                                }
                                Ading ading = Ading.find(i);
                                int j2 = ading.getNode();
                                int l2 = ading.getStyle();
                                Date date4 = ading.getStartTime();
                                Date date5 = ading.getStopTime();
                                String s7 = ading.getName(teasession._nLanguage);
                                Form form = new Form("foEdit", "POST", "/servlet/EditAded");
                                form.setMultiPart(true);
                                if(flag)
                                    form.setOnSubmit("return(submitInteger(this.ExpectedImpression,'" + super.r.getString(teasession._nLanguage, "InvalidExpectedImpression") + "')" + ")");
                                form.add(new HiddenField("Node", teasession._nNode));
                                if(!flag)
                                    form.add(new HiddenField("Aded", s));
                                form.add(new HiddenField("Ading", i));
                                Table table = new Table();
                                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Name") + ":"), true));
                                Cell cell = new Cell(new Text("<font>" + s7 + "</font>"));
                                row.add(cell);
                                table.add(row);
                                Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "AdingNode") + ":"), true));
                                Cell cell1 = new Cell(Node.find(j2).getAnchor(teasession._nLanguage));
                                row1.add(cell1);
                                table.add(row1);
                                Row row2 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Style") + ":"), true));
                                Cell cell2 = new Cell(new Text(super.r.getString(teasession._nLanguage, Section.APPLY_STYLE[l2])));
                                row2.add(cell2);
                                table.add(row2);
                                if(date4 != null)
                                {
                                    Row row3 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StartTime") + ":"), true));
                                    row3.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(date4) + "</font>")));
                                    table.add(row3);
                                    Row row5 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StopTime") + ":"), true));
                                    row5.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(date5) + "</font>")));
                                    table.add(row5);
                                }
                                Row row4 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Options") + ":"), true));
                                Cell cell3 = new Cell(new CheckBox("AdedONewWindow", (k & 1) != 0));
                                cell3.add(new Text(super.r.getString(teasession._nLanguage, "AdedONewWindow")));
                                cell3.add(new CheckBox("AdedOPublic", (k & 2) != 0));
                                cell3.add(new Text(super.r.getString(teasession._nLanguage, "AdedOPublic")));
                                row4.add(cell3);
                                table.add(row4);
                                Row row6 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StartTime") + ":"), true));
                                Cell cell4 = new Cell();
                                if(date1 == null)
                                {
                                    Date date6 = new Date(System.currentTimeMillis());
                                    date1 = date6;
                                    date3 = date6;
                                }
                                cell4.add(new TimeSelection("Start", date1));
                                row6.add(cell4);
                                table.add(row6);
                                Row row7 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "StopTime") + ":"), true));
                                row7.add(new Cell(new TimeSelection("Stop", date3)));
                                table.add(row7);
                                Row row8 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, " ") + " "), true));
                                Cell cell5 = new Cell(new CheckBox("AdingOForever", date1 == null));
                                cell5.add(new Text(super.r.getString(teasession._nLanguage, "AdingOForever")));
                                row8.add(cell5);
                                table.add(row8);
                                Row row9 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "ExpectedImpression") + ":"), true));
                                Cell cell6 = new Cell();
                                if(flag)
                                    cell6.add(new TextField("ExpectedImpression", Integer.toString(i1)));
                                else
                                    cell6.add(new Text(Integer.toString(i1)));
                                cell6.add(new Text(super.r.getString(teasession._nLanguage, "KiloTimes")));
                                row9.add(cell6);
                                table.add(row9);
                                Row row10 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "ClickUrl") + ":"), true));
                                row10.add(new Cell(new TextField("ClickUrl", s4, 70, 255)));
                                table.add(row10);
                                Row row11 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Alt") + ":"), true));
                                row11.add(new Cell(new TextField("Alt", s2, 70, 255)));
                                table.add(row11);
                                Row row12 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "PictureUrl") + ":"), true));
                                row12.add(new Cell(new TextField("PictureUrl", s6, 70, 255)));
                                table.add(row12);
                                table.add(new FileInput(teasession._nLanguage, "Picture", j1));
                                form.add(table);
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(Node.find(teasession._nNode).getAncestor(teasession._nLanguage, "Path"));
                                printwriter.print(form);
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();
                 */
            } else if("status".equals(teasession.getParameter("act")))
            {
                Http h = new Http(request,response);
                Aded a = Aded.find(h.getInt("aded"));
                a.status = h.getInt("status");
                a.set("status",String.valueOf(a.status));

				delete(Node.find(a.node));
                PrintWriter out = response.getWriter();
                out.println("<script>parent.location.reload()</script>");
                out.close();
                return;
            } else
            {
                int j = 0;
                if(teasession.getParameter("AdedONewWindow") != null)
                {
                    j |= 1;
                }
                if(teasession.getParameter("AdedOPublic") != null)
                {
                    j |= 2;
                }
                Date date = null;
                Date date2 = null;
                if(teasession.getParameter("AdingOForever") == null)
                {
                    date = TimeSelection.makeTime(teasession.getParameter("StartYear"),teasession.getParameter("StartMonth"),teasession.getParameter("StartDay"),teasession.getParameter("StartHour"),teasession.getParameter("StartMinute"));
                    date2 = TimeSelection.makeTime(teasession.getParameter("StopYear"),teasession.getParameter("StopMonth"),teasession.getParameter("StopDay"),teasession.getParameter("StopHour"),teasession.getParameter("StopMinute"));
                }
                int l = 0;
                if(flag)
                {
                    try
                    {
                        l = Integer.parseInt(teasession.getParameter("ExpectedImpression")) * 1000;
                    } catch(Exception exception1)
                    {
                        outText(teasession,response,super.r.getString(teasession._nLanguage,"InvalidExpectedImpression"));
                        return;
                    }
                }
                String s1 = teasession.getParameter("ClickUrl");
                String s3 = teasession.getParameter("Alt");
                String s5 = teasession.getParameter("PictureUrl");
                Node node = Node.find(teasession._nNode);
                String picturename = teasession.getParameter("Picture");
                if(picturename == null)
                {
                    picturename = teasession.getParameter("PictureName");
                }
                if(flag)
                {
//                    int i2 = teasession._rv.isOrganizer(node.getCommunity()) || node.isCreator(teasession._rv) ? 1 : 0;
                    int i2 = 1;
                    int k2 = Integer.parseInt(teasession.getParameter("Ading"));
                    int i3 = Aded.create(k2,teasession._nNode,teasession._rv,i2,j,date,date2,l,teasession._nLanguage,s3,s1,s5,picturename);
                    Ading ading1 = Ading.find(k2);
                    if(i2 == 1 || ading1.getCpm().compareTo(new BigDecimal(0.0D)) == 0)
                    {
                        response.sendRedirect("/jsp/aded/Adeds.jsp?node=" + teasession._nNode);
                    } else
                    {
                        response.sendRedirect("PayAded?node=" + teasession._nNode + "&Aded=" + i3);
                    }
                } else
                {
                    int k1 = Integer.parseInt(s);
                    Aded aded1 = Aded.find(k1);
                    aded1.set(j,date,date2,teasession._nLanguage,s3,s1,s5,picturename);
                    response.sendRedirect("/jsp/aded/Adeds.jsp?node=" + teasession._nNode);
                }
            }
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/aded/EditAded");
    }
}
