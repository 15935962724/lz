package tea.htmlx;

import java.util.*;
import tea.html.*;


public class TimeSelection extends HtmlElement
{

    public String toString()
    {
        StringBuffer sb = new StringBuffer();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(_date);
        if (_blSelectYear)
        {
            int i = calendar.get(1);
            DropDown dropdown1 = new DropDown(_strPrefix + "Year", i);
            for (int k = i - 70; k <= i + 15; k++)
            {
                dropdown1.addOption(k, Integer.toString(k));
            }
            sb.append(dropdown1).append("年 ");
        } else
        {
            TextField textfield = new TextField(_strPrefix + "Year", calendar.get(1), 4);
            sb.append(textfield);
        }
        DropDown dropdown = new DropDown(_strPrefix + "Month", calendar.get(2) + 1);
        int j = 1;
        do
        {
            dropdown.addOption(j, Integer.toString(j));
        } while (++j <= 12);
        sb.append(dropdown).append("月 ");
        DropDown dropdown2 = new DropDown(_strPrefix + "Day", calendar.get(5));
        int l = 1;
        do
        {
            dropdown2.addOption(l, Integer.toString(l));
        } while (++l <= 31);
        sb.append(dropdown2).append("日 ");
        if (_blSelectTime)
        {
            DropDown dropdown3 = new DropDown(_strPrefix + "Hour", calendar.get(11));
            int i1 = 0;
            do
            {
                dropdown3.addOption(i1, Integer.toString(i1));
            } while (++i1 <= 23);
            sb.append(dropdown3).append("时 ");
            //
            sb.append("<select name='" + _strPrefix + "Minute'>");
            int m = calendar.get(12);
            boolean b = m % 5 != 0;
            for (int j1 = 0; j1 < 60; j1 += 1)
            {
                if (b && m < j1) 
                {
                    b = false;
                    sb.append("<option value='" + m + "'  selected='' >" + m + "</option>");
                }
                sb.append("<option value='" + j1 + "'");
                if (m == j1)
                {
                    sb.append(" selected=''");
                }
                sb.append(">" + j1 + "</option>");
            }
            sb.append("</select>分");
        }
        return sb.toString();
    }

    public TimeSelection(String s, Date date)
    {
        this(s, date, true, false);
    }

    public TimeSelection(String prefix, Date date, boolean flag, boolean flag1)
    {
        _strPrefix = prefix;
        if (date == null)
        {
            date = new Date(System.currentTimeMillis());
        }
        _date = date;
        _blSelectYear = flag;
        _blSelectTime = flag1;
    }

    public static Date makeTime(String year, String month, String date, String hour, String minute)
    {
        Calendar calendar;
        int i = Integer.parseInt(year);
        int j = Integer.parseInt(month) - 1;
        int k = Integer.parseInt(date);
        int l = 0;
        try
        {
            l = Integer.parseInt(hour);
        } catch (Exception exception1)
        {}
        int i1 = 0;
        try
        {
            i1 = Integer.parseInt(minute);
        } catch (Exception exception2)
        {}
        try
        {
            calendar = Calendar.getInstance();
            calendar.set(i, j, k, l, i1, 0);
            return new Date(calendar.getTime().getTime());
        } catch (Exception exception3)
        {
            exception3.printStackTrace();
        }
        return null;
    }

    public static Date makeTime(String year, String month, String date)
    {
        try
        {
            Calendar calendar;
            int i = Integer.parseInt(year);
            int j = Integer.parseInt(month) - 1;
            int k = Integer.parseInt(date);
            calendar = Calendar.getInstance();
            calendar.set(i, j, k, 0, 0, 0);
            return new Date(calendar.getTime().getTime());
        } catch (Exception e)
        { //e.printStackTrace();
        }
        return null;
    }

    public static Date makeTime(String year_month_date)
    {
        try
        {
            StringTokenizer tokenizer = new StringTokenizer(year_month_date, "-");
            int time[] = new int[3];
            int i = 0;
            while (tokenizer.hasMoreTokens() && i < 3)
            {
                time[i] = Integer.parseInt(tokenizer.nextToken());
                i++;
            }
            Calendar calendar;
            calendar = Calendar.getInstance();

            calendar.set(time[0], time[1] - 1, time[2], 0, 0, 0);
            return new Date(calendar.getTime().getTime());
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return null;
    }

    String _strPrefix;
    Date _date;
    boolean _blSelectYear;
    boolean _blSelectTime;
}
