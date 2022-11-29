package tea.entity.util;

import java.util.Date;

import tea.db.DbAdapter;
import tea.entity.*;
import java.util.Calendar;
import tea.entity.site.Communityweather;
import java.io.IOException;
import tea.entity.node.Weather;
import java.sql.SQLException;
public class Flagtime extends Entity
{
    private static Cache _cache = new Cache(31);
    private Date time;
    private String raise;
    private String lower;
    private boolean exists;
    public Flagtime(Date time) throws SQLException
    {
        this.time = time;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT raise,lower FROM Flagtime WHERE time=" + DbAdapter.cite(time));
            if (db.next())
            {
                raise = db.getString(1);
                lower = db.getString(2);
                exists = true;
            } else
            {
                exists = false;
            }} finally
        {
            db.close();
        }
        if (!exists)
        {
            String str[] = update(time);
            raise = str[0];
            lower = str[1];
            exists = true;
        }
    }

    public void set(String raise, String lower)
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("UPDATE Flagtime SET raise=" + DbAdapter.cite(raise) + ",lower=" + DbAdapter.cite(lower) + " WHERE time=" + DbAdapter.cite(time));
        } catch (Exception exception)
        {
            exception.printStackTrace();
        } finally
        {
            db.close();
        }
    }

    public static void create(Date time, String raise, String lower) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("INSERT INTO Flagtime(time,raise,lower)VALUES(" + DbAdapter.cite(time) + "," + DbAdapter.cite(raise) + "," + DbAdapter.cite(lower) + ")");
        } catch (Exception exception)
        {
            //time是主键,如果存在,必须出错,所以在这里写set
            Flagtime ft = Flagtime.find(time);
            ft.set(raise, lower);
        } finally
        {
            db.close();
        }
    }

    public void delete() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate("DELETE FROM Flagtime WHERE time=" + DbAdapter.cite(time));} finally
        {
            db.close();
        }
        _cache.remove(time);
    }

    public static Flagtime find(Date time) throws SQLException
    {
        Flagtime obj = (Flagtime) _cache.get(time);
        if (obj == null)
        {
            obj = new Flagtime(time);
            _cache.put(time, obj);
        }
        return obj;
    }

    public static String[] update(Date time) throws SQLException
    {
        java.util.Calendar c = java.util.Calendar.getInstance();
        c.setTime(time);
        int year = c.get(c.YEAR);
        int month = c.get(c.MONTH) + 1;
        int day = c.get(c.DAY_OF_MONTH);
        String str[] = new String[2];
        try
        {
            java.net.HttpURLConnection conn = (java.net.HttpURLConnection)new java.net.URL("http://www.tiananmen.org.cn/flag/index.asp?year=" + year + "&month=" + month).openConnection();
            conn.setConnectTimeout(10000);
            conn.setRequestProperty("host", "www.tiananmen.org.cn");
            conn.setRequestProperty("user-agent", "Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1");
            conn.setRequestProperty("accept", "text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5");
            conn.setRequestProperty("accept-language", "zh-cn,zh;q=0.5");
            conn.setRequestProperty("accept-charset", "gb2312,utf-8;q=0.7,*;q=0.7");
            conn.setRequestProperty("keep-alive", "300");
            conn.setRequestProperty("connection", "keep-alive");
            conn.setRequestProperty("cache-control", "max-age=0");
            java.io.InputStream is = conn.getInputStream();
            StringBuilder sb = new StringBuilder();
            int value = 0;
            while ((value = is.read()) != -1)
            {
                sb.append((char) value);
            }
            is.close();
            String content = new String(sb.toString().getBytes("ISO-8859-1"), "GBK");
            for (int i = 1; i < 32; i++)
            {
                int day_1 = content.indexOf(">" + i + "</FONT>") + (">" + i + "</FONT>").length();
                int raise_1 = content.indexOf("升　", day_1) + "升　".length();
                int raise_2 = content.indexOf("</", raise_1);
                String raise = null;
                String lower = null;
                if (raise_1 > day_1 && raise_2 > raise_1)
                {
                    raise = (content.substring(raise_1, raise_2).replace('：', ':')); //Lucene.htmlToText

                    int lower_1 = content.indexOf("降　", raise_2) + "降　".length();
                    int lower_2 = content.indexOf("</", lower_1);
                    if (lower_1 > raise_2 && lower_2 > lower_1)
                    {
                        lower = (content.substring(lower_1, lower_2).replace('：', ':'));
                    }
                }
                c.set(c.DAY_OF_MONTH, i);
                System.out.println(c.getTime() + ":升" + raise + "\t降" + lower);
                Flagtime.create(c.getTime(), raise, lower);
                if (day == i)
                {
                    str[0] = raise;
                    str[1] = lower;
                }
            }
        } catch (IOException ex)
        {
            ex.printStackTrace();
        }
        return str;
    }

    public Date getTime()
    {
        return time;
    }

    public String getRaise()
    {
        return raise;
    }

    public String getLower()
    {
        return lower;
    }

    public boolean isExists()
    {
        return exists;
    }
}
