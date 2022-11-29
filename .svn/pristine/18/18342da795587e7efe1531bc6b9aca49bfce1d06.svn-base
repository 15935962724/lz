package tea.entity.node;

import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;
import tea.entity.Cache;
import tea.entity.site.*;
import tea.entity.util.*;
import tea.html.*;
import tea.resource.*;
import java.util.regex.*;

public class Weather extends Entity
{
    private static Cache _cache = new Cache(100);
    private static Cache ht = new Cache(100); //用来缓存天气是否已过期
    public static final String WEATHER_TYPE[] =
            {"Weather0","Weather1","Weather2","Weather3","Weather4","Weather5","Weather6","Weather7","Weather8","Weather9","Weather10","Weather11","Weather12","Weather13","Weather14","Weather15","Weather16","Weather17","Weather18","Weather19","Weather20","Weather21","Weather22","Weather23","Weather24","Weather25","Weather26","Weather27","Weather28","Weather29","Weather30","Weather31"};
    public static final String DAY_OF_WEEK[] =
            {"","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
    // 今天 明天 后天
    public static final String DAY_TYPE[] =
            {"1170053139821","1170053150680","1170053157211"};
    public int node;
    public Date time;
    private int _nType;
    private int _nType2;
    private int _nLow;
    private int _nHigh;
    /////////
    private String typeToString;
    private String _strWind;
    private boolean exists;
    private String pollute1;//污染指数
    private String pollute2;
    private String ultraviolet1;//紫外线指数
    private String ultraviolet2;
    private String comfort1;//舒适度指数
    private String comfort2;
    private String feel1;//体感指数
    private String feel2;
    private String ac1;//空调指数
    private String ac2;
    private String carwash1;//洗车指数
    private String carwash2;
    private String cold1;//感冒指数
    private String cold2;
    private String cold3;
    private String sunscreen1;//防晒指数
    private String sunscreen2;
    private String sunscreen3;
    private String calenture1;//中暑指数
    private String calenture2;
    private String calenture3;
    private String dressing1;//穿衣指数
    private String dressing2;
    private String dressing3;
    private String angling1;//钓鱼指数
    private String angling2;
    private String angling3;

    public Weather(int i,Date time) throws SQLException
    {
        this.node = i;
        this.time = time;
        load();
    }

    public static Weather find(int node,Date time) throws SQLException
    {
        //判断是否有是当天的记录,如果没有则获取并更新今天和明天记录
        Integer day = (Integer) ht.get(new Integer(node));
        Calendar c = Calendar.getInstance();
        int cd = c.get(Calendar.DAY_OF_YEAR);
        if(day == null || day.intValue() != cd)
        {
            System.out.println("更新天气:" + node);
            uptime(node);
            ht.put(new Integer(node),new Integer(cd));
        }
        Weather obj = (Weather) _cache.get(node + ":" + time);
        if(obj == null)
        {
            obj = new Weather(node,time);
            _cache.put(node + ":" + time,obj);
        }
        return obj;
    }

    public void set(int _nType,int _nType2,int _nLow,int _nHigh,String _strWind) throws SQLException
    {
        int i;
        DbAdapter db = new DbAdapter();
        try
        {
            i = db.executeUpdate(node,"UPDATE Weather SET type=" + _nType + ",type2=" + _nType2 + ",low=" + _nLow + ",high=" + _nHigh + ",wind=" + DbAdapter.cite(_strWind) + " WHERE node=" + node + " AND time=" + DbAdapter.cite(time));
        } finally
        {
            db.close();
        }
        this._nType = _nType;
        this._nType2 = _nType2;
        this._nLow = _nLow;
        this._nHigh = _nHigh;
        this._strWind = _strWind;
        if(i < 1)
        {
            create(node,time,_nType,_nType2,_nLow,_nHigh,_strWind);
        }
    }

    public static void create(int node,Date time,int _nType,int _nType2,int _nLow,int _nHigh,String _strWind) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"INSERT Weather(node,time,type,type2,low,high,wind)VALUES(" + node + "," + DbAdapter.cite(time) + "," + _nType + "," + _nType2 + "," + _nLow + "," + _nHigh + "," + DbAdapter.cite(_strWind) + ")");
        } finally
        {
            db.close();
        }
    }

    public void set(String pollute1,String pollute2,String ultraviolet1,String ultraviolet2,String comfort1,String comfort2,String feel1,String feel2,String ac1,String ac2,String carwash1,String carwash2,String cold1,String cold2,String cold3,String sunscreen1,String sunscreen2,String sunscreen3,String calenture1,String calenture2,String calenture3,String dressing1,String dressing2,String dressing3,String angling1,String angling2,String angling3) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeUpdate(node,"UPDATE Weather SET pollute1=" + DbAdapter.cite(pollute1) + ",pollute2=" + DbAdapter.cite(pollute2) + ",ultraviolet1=" + DbAdapter.cite(ultraviolet1) + ",ultraviolet2=" + DbAdapter.cite(ultraviolet2) + ",comfort1=" + DbAdapter.cite(comfort1) + ",comfort2=" + DbAdapter.cite(comfort2) + ",feel1=" + DbAdapter.cite(feel1) + ",feel2=" + DbAdapter.cite(feel2) + ",ac1=" + DbAdapter.cite(ac1) + ",ac2=" + DbAdapter.cite(ac2) + ",carwash1=" + DbAdapter.cite(carwash1) + ",carwash2=" + DbAdapter.cite(carwash2) + ",cold1=" + DbAdapter.cite(cold1) + ",cold2="
                             + DbAdapter.cite(cold2) + ",cold3=" + DbAdapter.cite(cold3) + ",sunscreen1=" + DbAdapter.cite(sunscreen1) + ",sunscreen2=" + DbAdapter.cite(sunscreen2) + ",sunscreen3=" + DbAdapter.cite(sunscreen3) + ",calenture1=" + DbAdapter.cite(calenture1) + ",calenture2=" + DbAdapter.cite(calenture2) + ",calenture3=" + DbAdapter.cite(calenture3) + ",dressing1=" + DbAdapter.cite(dressing1) + ",dressing2=" + DbAdapter.cite(dressing2) + ",dressing3=" + DbAdapter.cite(dressing3) + ",angling1=" + DbAdapter.cite(angling1) + ",angling2=" + DbAdapter.cite(angling2) + ",angling3="
                             + DbAdapter.cite(angling3) + " WHERE node=" + node + " AND time=" + DbAdapter.cite(time));
        } finally
        {
            db.close();
        }
        this.pollute1 = pollute1;
        this.pollute2 = pollute2;
        this.ultraviolet1 = ultraviolet1;
        this.ultraviolet2 = ultraviolet2;
        this.comfort1 = comfort1;
        this.comfort2 = comfort2;
        this.feel1 = feel1;
        this.feel2 = feel2;
        this.ac1 = ac1;
        this.ac2 = ac2;
        this.carwash1 = carwash1;
        this.carwash2 = carwash2;
        this.cold1 = cold1;
        this.cold2 = cold2;
        this.cold3 = cold3;
        this.sunscreen1 = sunscreen1;
        this.sunscreen2 = sunscreen2;
        this.sunscreen3 = sunscreen3;
        this.calenture1 = calenture1;
        this.calenture2 = calenture2;
        this.calenture3 = calenture3;
        this.dressing1 = dressing1;
        this.dressing2 = dressing2;
        this.dressing3 = dressing3;
        this.angling1 = angling1;
        this.angling2 = angling2;
        this.angling3 = angling3;
    }


    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT type,type2,low,high,wind,pollute1,pollute2,ultraviolet1,ultraviolet2,comfort1,comfort2,feel1,feel2,ac1,ac2,carwash1,carwash2,cold1,cold2,cold3,sunscreen1,sunscreen2,sunscreen3,calenture1,calenture2,calenture3,dressing1,dressing2,dressing3,angling1,angling2,angling3 FROM Weather WHERE node=" + node + " AND time=" + DbAdapter.cite(time));
            if(db.next())
            {
                _nType = db.getInt(1);
                _nType2 = db.getInt(2);
                _nLow = db.getInt(3);
                _nHigh = db.getInt(4);
                _strWind = db.getString(5);
                pollute1 = db.getString(6);
                pollute2 = db.getString(7);
                ultraviolet1 = db.getString(8);
                ultraviolet2 = db.getString(9);
                comfort1 = db.getString(10);
                comfort2 = db.getString(11);
                feel1 = db.getString(12);
                feel2 = db.getString(13);
                ac1 = db.getString(14);
                ac2 = db.getString(15);
                carwash1 = db.getString(16);
                carwash2 = db.getString(17);
                cold1 = db.getString(18);
                cold2 = db.getString(19);
                cold3 = db.getString(20);
                sunscreen1 = db.getString(21);
                sunscreen2 = db.getString(22);
                sunscreen3 = db.getString(23);
                calenture1 = db.getString(24);
                calenture2 = db.getString(25);
                calenture3 = db.getString(26);
                dressing1 = db.getString(27);
                dressing2 = db.getString(28);
                dressing3 = db.getString(29);
                angling1 = db.getString(30);
                angling2 = db.getString(31);
                angling3 = db.getString(32);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public int getType()
    {
        return _nType;
    }

    public int getType2()
    {
        return _nType2;
    }

    public int getLow()
    {
        return _nLow;
    }

    public static String getDetail(Node node,int _nLanguage,int listing,String target) throws SQLException
    {
        Resource r = new Resource();
        r.add("tea/ui/node/type/weather/EditWeather");
        Span span = null;
        StringBuilder sb = new StringBuilder();
        Weather aweather[] = new Weather[DAY_TYPE.length];
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(System.currentTimeMillis());
        calendar.set(11,0);
        calendar.set(12,0);
        calendar.set(13,0);
        calendar.set(14,0);
        for(int index = 0;index < aweather.length;index++)
        {
            aweather[index] = Weather.find(node._nNode,calendar.getTime());
            calendar.add(5,1);
        }
        Class c = aweather[0].getClass();
        ListingDetail ld = ListingDetail.find(listing,14,_nLanguage);
        java.util.Iterator e = ld.keys();
        while(e.hasNext())
        {
            String name = (String) e.next(),value = null;
            int istype = ld.getIstype(name);
            if(istype == 0)
            {
                continue;
            }
            int index = name.charAt(name.length() - 1) - 48; // 0的asc等于48
            if(name.equals("Subject" + index))
            {
                value = node.getSubject(_nLanguage);
                int qu = ld.getQuantity(name);
                if(qu > 0 && value.length() > qu)
                {
                    value = value.substring(0,qu) + " ...";
                }
            } else if(name.equals("Date" + index))
            {
                // value = (r.getString(_nLanguage, Weather.DAY_TYPE[index]));
                calendar.setTime(aweather[index].time);
                value = String.valueOf(calendar.get(calendar.DAY_OF_MONTH));
            } else if(name.equals("Type" + index))
            {
                value = r.getString(_nLanguage,Weather.WEATHER_TYPE[aweather[index].getType()]);
                if(aweather[index].getType() != aweather[index].getType2())
                {
                    value += r.getString(_nLanguage,"WeatherChange") + r.getString(_nLanguage,Weather.WEATHER_TYPE[aweather[index].getType2()]);
                }
            } else if(name.equals("Legenda" + index))
            {
                value = "<img src=\"/tea/image/weather/a" + aweather[index].getType() + ".gif\" alt=\"" + r.getString(_nLanguage,Weather.WEATHER_TYPE[aweather[index].getType()]) + "\" />";
                if(aweather[index].getType() != aweather[index].getType2())
                {
                    value += "<img src=\"/tea/image/weather/a" + aweather[index].getType2() + ".gif\" alt=\"" + r.getString(_nLanguage,Weather.WEATHER_TYPE[aweather[index].getType2()]) + "\" />";
                }
            } else if(name.equals("Legend" + index))
            {
                value = "<img src=\"/tea/image/weather/" + aweather[index].getType() + ".gif\" alt=\"" + r.getString(_nLanguage,Weather.WEATHER_TYPE[aweather[index].getType()]) + "\" />";
                if(aweather[index].getType() != aweather[index].getType2())
                {
                    value += "<img src=\"/tea/image/weather/" + aweather[index].getType2() + ".gif\" alt=\"" + r.getString(_nLanguage,Weather.WEATHER_TYPE[aweather[index].getType2()]) + "\" />";
                }
            } else if(name.equals("Low" + index))
            {
                value = String.valueOf(aweather[index].getLow()) + "℃";
            } else if(name.equals("High" + index))
            {
                value = (aweather[index].getHigh()) + "℃";
            } else if(name.equals("Wind" + index))
            {
                value = aweather[index].getWind();
            } else
            {
                try
                {
                    value = (String) c.getMethod("get" + name,(Class[])null).invoke(aweather[0],(Object[])null);
                } catch(Exception ex)
                {
                    ex.printStackTrace();
                }
            }
            if(ld.getAnchor(name) != 0)
            {
                Anchor anchor = new Anchor("/servlet/Weather?node=" + node._nNode + "&language=" + _nLanguage,value);
                anchor.setTarget(target);
                span = new Span(anchor);
            } else
            {
                span = new Span(value);
            }
            span.setId("WeatherID" + name + index);
            sb.append(ld.getBeforeItem(name)).append(span).append(ld.getAfterItem(name));
        }
        return sb.toString();
    }

    public String getTypeToString()
    {
        return typeToString;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getPollute1()
    {
        return pollute1;
    }

    public int getHigh()
    {
        return _nHigh;
    }

    public String getPollute2()
    {
        return pollute2;
    }

    public String getUltraviolet1()
    {
        return ultraviolet1;
    }

    public String getUltraviolet2()
    {
        return ultraviolet2;
    }

    public String getComfort1()
    {
        return comfort1;
    }

    public String getComfort2()
    {
        return comfort2;
    }

    public String getFeel1()
    {
        return feel1;
    }

    public String getFeel2()
    {
        return feel2;
    }

    public String getAc1()
    {
        return ac1;
    }

    public String getAc2()
    {
        return ac2;
    }

    public String getCarwash1()
    {
        return carwash1;
    }

    public String getCarwash2()
    {
        return carwash2;
    }

    public String getCold1()
    {
        return cold1;
    }

    public String getCold2()
    {
        return cold2;
    }

    public String getCold3()
    {
        return cold3;
    }

    public String getSunscreen1()
    {
        return sunscreen1;
    }

    public String getSunscreen2()
    {
        return sunscreen2;
    }

    public String getSunscreen3()
    {
        return sunscreen3;
    }

    public String getCalenture1()
    {
        return calenture1;
    }

    public String getCalenture2()
    {
        return calenture2;
    }

    public String getCalenture3()
    {
        return calenture3;
    }

    public String getDressing1()
    {
        return dressing1;
    }

    public String getDressing2()
    {
        return dressing2;
    }

    public String getDressing3()
    {
        return dressing3;
    }

    public String getAngling1()
    {
        return angling1;
    }

    public String getAngling2()
    {
        return angling2;
    }

    public String getAngling3()
    {
        return angling3;
    }

    public Date getTime()
    {
        return time;
    }

    public String getWind()
    {
        return _strWind;
    }

    public static void uptime(int node) throws SQLException
    {
        Communityweather cw = Communityweather.find(node);
        if(cw.isExists())
        {
            String area = new java.text.DecimalFormat("00000").format(cw.getArea());
            Weather weather[] = new Weather[DAY_TYPE.length];
            Calendar c = Calendar.getInstance();
            c.setTimeInMillis(System.currentTimeMillis());
            c.set(11,0);
            c.set(12,0);
            c.set(13,0);
            c.set(14,0);
            try
            {
                for(int day = 0;day < weather.length;day++)
                {
                    weather[day] = new Weather(node,c.getTime());
                    _cache.put(node + ":" + weather[day].time,weather[day]);
                    c.add(5,1);
                    // http://www.sina.com.cn/iframe/2006/weather/110100.html
                    // http://www.cma.gov.cn/tqyb/weatherframe/54511/1.html
                    String content = (String) Entity.open("http://www.cma.gov.cn/tqyb/weatherframe/" + area + "/" + (day + 1) + ".html");
                    int _nType = 0,_nType2 = 0;
                    int t_1 = content.indexOf("/tqyb/img/weather/a") + "/tqyb/img/weather/a".length();
                    int t_2 = 0;
                    if(t_1 > 50)
                    {
                        t_2 = content.indexOf(".gif",t_1);
                        _nType = Integer.parseInt(content.substring(t_1,t_2));
                        t_1 = content.indexOf("/tqyb/img/weather/a",t_2) + "/tqyb/img/weather/a".length();
                        if(t_1 > 50)
                        {
                            t_2 = content.indexOf(".gif",t_1);
                            _nType2 = Integer.parseInt(content.substring(t_1,t_2));
                        }
                    }
                    // ///气温///////////
                    Matcher m = Pattern.compile("气温：(\\d+) ~ (\\d+) ℃").matcher(content);
                    int _nLow = 0,_nHigh = 0;
                    if(m.find())
                    {
                        _nHigh = Integer.parseInt(m.group(1));
                        _nLow = Integer.parseInt(m.group(2));
                    }
                    // ///风向风力///////////
                    String _strWind = "";
                    int w_1 = content.indexOf("风向风力：",0) + "风向风力：".length();
                    int w_2 = 0;
                    if(w_1 > 50)
                    {
                        w_2 = content.indexOf("</span></td>",w_1);
                        _strWind = content.substring(w_1,w_2).trim();
                    }
                    // ///////////
                    weather[day].set(_nType,_nType2,_nLow,_nHigh,_strWind);
                }
            } catch(IOException ex)
            {
                ex.printStackTrace();
            }
            try
            {
                String content = (String) Entity.open("http://weather.china.com.cn/city/54511_full.html");
                // System.out.println(content);
                // ///////////////////////污染指数///////////////////////////////////////////////////////
                Pattern PTD = Pattern.compile(">([^<]+)</");
                int pollute1_1 = content.indexOf("污染指数</td>") + "污染指数</td>".length();
                String pollute1 = "";
                String pollute2 = "";
                if(pollute1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(pollute1_1));
                    if(m.find())
                        pollute1 = m.group(1);
                    if(m.find())
                        pollute2 = m.group(1); // 空气质量状况
                }
                //System.out.println("污染指数:" + pollute1 + "\t:" + pollute2);
                // ///////////////////////紫外线指数///////////////////////////////////////////////////////
                int ultraviolet1_1 = content.indexOf("紫外线指数</td>") + "紫外线指数</td>".length();
                String ultraviolet1 = "";
                String ultraviolet2 = "";
                if(ultraviolet1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(ultraviolet1_1));
                    if(m.find())
                        ultraviolet1 = m.group(1);
                    if(m.find())
                        ultraviolet2 = m.group(1); // 防护措施
                }
                //System.out.println("紫外线指数:" + ultraviolet1 + "\t:" + ultraviolet2);
                // ///////////////////////舒适度指数///////////////////////////////////////////////////////
                int comfort1_1 = content.indexOf("舒适度指数</td>") + "舒适度指数</td>".length();
                String comfort1 = "";
                String comfort2 = "";
                if(comfort1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(comfort1_1));
                    if(m.find())
                        comfort1 = m.group(1);
                    if(m.find())
                        comfort2 = m.group(1); // 舒适度状况
                }
                //System.out.println("舒适度指数:" + comfort1 + "\t:" + comfort2);
                // ///////////////////////体感指数///////////////////////////////////////////////////////
                int feel1_1 = content.indexOf("体感指数</td>") + "体感指数</td>".length();
                String feel1 = "";
                String feel2 = "";
                if(feel1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(feel1_1));
                    if(m.find())
                        feel1 = m.group(1);
                    if(m.find())
                        feel2 = m.group(1); // 体感最高温度
                }
                //System.out.println("体感指数:" + feel1 + "\t:" + feel2);
                // ///////////////////////空调指数///////////////////////////////////////////////////////
                int ac1_1 = content.indexOf("空调指数</td>") + "空调指数</td>".length();
                String ac1 = "";
                String ac2 = "";
                if(ac1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(ac1_1));
                    if(m.find())
                        ac1 = m.group(1);
                    if(m.find())
                        ac2 = m.group(1); // 开启制暖空调
                }
                //System.out.println("空调指数:" + ac1 + "\t:" + ac2);
                // ///////////////////////洗车指数///////////////////////////////////////////////////////
                int carwash1_1 = content.indexOf("洗车指数</td>") + "洗车指数</td>".length();
                String carwash1 = "";
                String carwash2 = "";
                if(carwash1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(carwash1_1));
                    if(m.find())
                        carwash1 = m.group(1);
                    if(m.find())
                        carwash2 = m.group(1); // 洗车状况
                }
                //System.out.println("洗车指数:" + carwash1 + "\t:" + carwash2);
                // ///////////////////////感冒指数///////////////////////////////////////////////////////
                int cold1_1 = content.indexOf("感冒指数</td>") + "感冒指数</td>".length();
                String cold1 = "";
                String cold2 = "";
                String cold3 = "";
                if(cold1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(cold1_1));
                    if(m.find())
                        cold1 = m.group(1); // 级别
                    if(m.find())
                        cold2 = m.group(1); // 说明
                    if(m.find())
                        cold3 = m.group(1); // 建议
                }
                //System.out.println("感冒指数:" + cold1 + "\t:" + cold2 + "\t:" + cold3);
                // ///////////////////////防晒指数///////////////////////////////////////////////////////
                int sunscreen1_1 = content.indexOf("防晒指数</td>") + "防晒指数</td>".length();
                String sunscreen1 = "";
                String sunscreen2 = "";
                String sunscreen3 = "";
                if(sunscreen1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(sunscreen1_1));
                    if(m.find())
                        sunscreen1 = m.group(1); // 级别
                    if(m.find())
                        sunscreen2 = m.group(1); // 说明
                    if(m.find())
                        sunscreen3 = m.group(1); // 建议
                }
                //System.out.println("防晒指数:" + sunscreen1 + "\t:" + sunscreen2 + "\t:" + sunscreen3);
                // ///////////////////////中暑指数///////////////////////////////////////////////////////
                int calenture1_1 = content.indexOf("中暑指数</td>") + "中暑指数</td>".length();
                String calenture1 = "";
                String calenture2 = "";
                String calenture3 = "";
                if(calenture1_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(calenture1_1));
                    if(m.find())
                        calenture1 = m.group(1); // 级别
                    if(m.find())
                        calenture2 = m.group(1); // 说明
                    if(m.find())
                        calenture3 = m.group(1); // 建议
                }
                //System.out.println("中暑指数:" + calenture1 + "\t:" + calenture2 + "\t:" + calenture3);
                // ///////////////////////穿衣指数///////////////////////////////////////////////////////
                int dressing_1 = content.indexOf("穿衣指数</td>") + "穿衣指数</td>".length();
                String dressing1 = "";
                String dressing2 = "";
                String dressing3 = "";
                if(dressing_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(dressing_1));
                    if(m.find())
                        dressing1 = m.group(1); // 级别
                    if(m.find())
                        dressing2 = m.group(1); // 说明
                    if(m.find())
                        dressing3 = m.group(1); // 建议
                }
                //System.out.println("穿衣指数:" + dressing1 + "\t:" + dressing2 + "\t:" + dressing3);
                // ///////////////////////钓鱼指数///////////////////////////////////////////////////////
                int angling_1 = content.indexOf("钓鱼指数</td>") + "钓鱼指数</td>".length();
                String angling1 = "";
                String angling2 = "";
                String angling3 = "";
                if(angling_1 > 100)
                {
                    Matcher m = PTD.matcher(content.substring(angling_1));
                    if(m.find())
                        angling1 = m.group(1); // 级别
                    if(m.find())
                        angling2 = m.group(1); // 说明
                    if(m.find())
                        angling3 = m.group(1); // 建议
                }
                weather[0].set(pollute1,pollute2,ultraviolet1,ultraviolet2,comfort1,comfort2,feel1,feel2,ac1,ac2,carwash1,carwash2,cold1,cold2,cold3,sunscreen1,sunscreen2,sunscreen3,calenture1,calenture2,calenture3,dressing1,dressing2,dressing3,angling1,angling2,angling3);
            } catch(IOException ex)
            {
                ex.printStackTrace();
            }
        }
    }
}
