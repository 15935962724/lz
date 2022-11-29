package tea.ui.node.type.weather;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditWeather extends TeaServlet
{

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            Node node = Node.find(teasession._nNode);
            AccessMember obj_am = AccessMember.find(node._nNode, teasession._rv._strV);
            if (!node.isCreator(teasession._rv) && !obj_am.isProvider(14))
            {
                response.sendError(403);
                return;
            }

            Weather aweather[] = new Weather[Weather.DAY_TYPE.length];
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date(System.currentTimeMillis()));
            calendar.set(11, 0);
            calendar.set(12, 0);
            calendar.set(13, 0);
            calendar.set(14, 0);
            int i = 0;
            do
            {
                aweather[i] = Weather.find(teasession._nNode, calendar.getTime());
                calendar.add(5, 1);
            } while (++i < Weather.DAY_TYPE.length);

            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/weather/EditWeather.jsp" + qs);
                /*
                                StringBuilder stringbuffer = new StringBuilder();
                                int k = 0;
                                do
                                {
                                    stringbuffer.append("&&submitInteger(this.Low" + k + ", '" + super.r.getString(teasession._nLanguage, "InvalidLowTemp") + "')" + "&&submitInteger(this.High" + k + ", '" + super.r.getString(teasession._nLanguage, "InvalidHighTemp") + "')");
                                } while (++k < 5);
                                Form form = new Form("foEdit", "POST", "EditWeather");
                                form.setOnSubmit("return(true" + stringbuffer + ");");
                                form.add(new HiddenField("Node", teasession._nNode));
                                Table table = new Table();
                                table.setTitle(super.r.getString(teasession._nLanguage, "Date") + "\n" + super.r.getString(teasession._nLanguage, "Type") + "\n" + super.r.getString(teasession._nLanguage, "LowTemp") + "\n" + super.r.getString(teasession._nLanguage, "HighTemp") + "\n");
                                int j1 = 0;
                                do
                                {
                                    Row row = new Row(new Cell(new Text((new SimpleDateFormat("MM.dd")).format(aweather[j1]._date))));
                                    DropDown dropdown = new DropDown("Type" + j1, aweather[j1].getType());
                                    for (int l1 = 0; l1 < Weather.WEATHER_TYPE.length; l1++)
                                    {
                                        dropdown.addOption(l1, super.r.getString(teasession._nLanguage, Weather.WEATHER_TYPE[l1]));
                                    }

                                    row.add(new Cell(dropdown));
                                    row.add(new Cell(new TextField("Low" + j1, aweather[j1].getLow())));
                                    row.add(new Cell(new TextField("High" + j1, aweather[j1].getHigh())));
                                    table.add(row);
                                } while (++j1 < 5);
                                form.add(table);
                                form.add(new Go(teasession._nLanguage, 1));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                                printwriter.print(form);
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();
                 */
            } else
            {
                int j = 0;
                do
                {
                    int _nType = Integer.parseInt(request.getParameter("Type0" + j));
                    int _nType2 = Integer.parseInt(request.getParameter("Type1" + j));
                    int _nLow = Integer.parseInt(request.getParameter("Low" + j));
                    int _nHigh = Integer.parseInt(request.getParameter("High" + j));
                    String _strWind = request.getParameter("Wind" + j);
                    aweather[j].set(_nType, _nType2, _nLow, _nHigh, _strWind);
                } while (++j < Weather.DAY_TYPE.length);
                if (request.getParameter("GoBack") != null)
                {
                    response.sendRedirect("EditNode?node=" + teasession._nNode);
                } else
                if (request.getParameter("GoFinish") != null)
                {
                    node.finished(teasession._nNode);
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
                }
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }
}
