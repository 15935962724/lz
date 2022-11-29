package tea.entity;

import java.io.*;
import java.net.*;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import java.util.regex.*;

import javax.servlet.http.HttpServletRequest;

import tea.db.DbAdapter;
import tea.entity.node.Score;
import tea.entity.site.*;

public class Entity
{
	public static Cache _cache = new Cache(2000);
    public static final String DEFAULT_MEMBER = "<DEFAULT>";
    public static final DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // DateFormat.getDateInstance();
    public static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //<SPAN ID=time_hm></SPAN>
    public static final SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static final DecimalFormat df = new DecimalFormat("#,##0.00");
    public static final SimpleDateFormat sdf_en = new SimpleDateFormat("MMMMM d, yyyy",Locale.ENGLISH);
    public static final String MONTH[] =
            {"","January","February","March","April","May","June","July","August","September","October","November","December"};
    public static final String MONTH_zh[] =
            {"","一","二","三","四","五","六","七","八","九","十","十一","十二"};
    public static final String MONTH_abb[] =
            {"","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEPT","OCT","NOV","DEC"};
    static
    {
        init();
    }

    public static void init()
    {
        try
        {
            CommunityOption co = CommunityOption.find("[SYSTEM]");
            String host = co.get("proxyhost");
            if(host != null)
            {
                Properties p = System.getProperties();
                p.setProperty("http.proxyHost",host);
                p.setProperty("http.proxyPort",co.get("proxyport"));
                p.setProperty("http.nonProxyHosts","localhost|10.4.*.*");
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }

    public Entity()
    {
    }

    public static Object open(String url) throws IOException
    {
        return open(url,null);
    }

    public static Object open(String url,String head) throws IOException
    {
        HttpURLConnection conn = (HttpURLConnection)new URL(url).openConnection();
        conn.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
        conn.setRequestProperty("accept","image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/vnd.ms-excel, application/msword, application/x-shockwave-flash, */*");
        conn.setRequestProperty("accept-language","zh-cn");
        if(head != null)
        {
            conn.setRequestProperty("Cookie",head);
        }
        //conn.setConnectTimeout(20000);
        conn.setReadTimeout(20000);
        byte by[] = read(conn.getInputStream());
        //字符集
        String ct = conn.getContentType();
        boolean flag = "text/html".equals(ct);
        if(ct == null || flag)
        {
            ct = new String(by,0,Math.min(by.length,1024));
        }
        Matcher m = Pattern.compile("charset=([^'\"> ]+)").matcher(ct);
        ct = m.find() ? m.group(1) : flag ? "gbk" : null;
        return ct != null ? new String(by,ct) : by;
    }

    public static byte[] read(InputStream is) throws IOException
    {
        int j = 0;
        byte by[] = new byte[2048];
        ByteArrayOutputStream ba = new ByteArrayOutputStream();
        while((j = is.read(by)) != -1)
        {
            ba.write(by,0,j);
        }
        is.close();
        return ba.toByteArray();
    }

    //英文显示
    public static String sdf_Week_en(Date pTime) throws Exception
    {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        c.setTime(pTime);
        int dayForWeek = 0;
        if(c.get(Calendar.DAY_OF_WEEK) == 1)
        {
            dayForWeek = 7;
        } else
        {
            dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        }

        String[] dayInt = new String[]
                          {"","MON","TUE","WED","THU","FRI","SAT","SUN"}; //星期的数组

        return dayInt[dayForWeek];
    }

    public static String sdf_Week_zn(Date pTime) throws Exception
    {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        c.setTime(pTime);
        int dayForWeek = 0;
        if(c.get(Calendar.DAY_OF_WEEK) == 1)
        {
            dayForWeek = 7;
        } else
        {
            dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        }

        String[] dayInt = new String[]
                          {"","一","二","三","四","五","六","日"}; //星期的数组

        return dayInt[dayForWeek];
    }

    public static File[] listFiles(File f)
    {
        ArrayList al = new ArrayList();
        listFiles(al,f);
        return(File[]) al.toArray(new File[al.size()]);
    }

    private static void listFiles(ArrayList al,File f)
    {
        if(f.isDirectory())
        {
            File fs[] = f.listFiles();
            for(int i = 0;i < fs.length;i++)
            {
                listFiles(al,fs[i]);
            }
        } else
        {
            al.add(f);
        }
    }

    public static int[] parseInt(String[] arr)
    {
        int[] a = new int[arr.length];
        for(int i = 0;i < a.length;i++)
        {
            try
            {
                a[i] = Integer.parseInt(arr[i].replaceAll(",","").trim());
            } catch(Exception ex)
            {}
        }
        return a;
    }

    public static float[] parseFloat(String[] arr)
    {
        float[] a = new float[arr.length];
        for(int i = 0;i < a.length;i++)
        {
            try
            {
                a[i] = Float.parseFloat(arr[i].replaceAll(",","").trim());
            } catch(Exception ex)
            {}
        }
        return a;
    }


    /*大写日期转换*/
    public static String capitalDate(Date date) throws IOException
    {
        String num[] =
                {"零","一","二","三","四","五","六","七","八","九"};
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DATE);

        String years = num[year / 1000] + num[(year / 100) % 10] + num[(year / 10) % 10] + num[year % 10];
        String months = null;
        String days = null;
        if(month > 9)
        {
            if(month == 10)
            {
                months = "十";
            } else
            {
                months = "十" + num[month % 10];
            }
        } else
        {
            months = num[month];
        }

        if(day > 9)
        {
            if(day == 10)
            {
                days = "十";
            } else if(day == 20 || day == 30)
            {
                days = num[day / 10] + "十";

            } else
            {
                days = num[day / 10] + "十" + num[day % 10];
            }
        } else
        {
            days = num[day];
        }
        return years + "年" + months + "月" + days + "日";
    }

    //计算日期 的星期
    public static String sdf_Week(Date pTime) throws Exception
    {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c = Calendar.getInstance();
        c.setTime(pTime);
        int dayForWeek = 0;
        if(c.get(Calendar.DAY_OF_WEEK) == 1)
        {
            dayForWeek = 7;
        } else
        {
            dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        }

        String[] dayInt = new String[]
                          {"日","一","二","三","四","五","六"}; //星期的数组
        return "星期" + dayInt[dayForWeek - 1];
    }

    //转换时间格式
    public static String getTimeToString(Date time) throws Exception
    {
        if(time == null)
        {
            return "";
        }
        return sdf2.format(time);
    }

    //判断是否为空
    public static String getNULL(String mobile)
    {
        if(mobile != null && mobile.length() > 0)
        {
            return mobile;
        } else
        {
            return "";
        }
    }

    public static String getNULL(Date mobile)
    {
        if(mobile != null)
        {
            return sdf.format(mobile);
        } else
        {
            return "";
        }
    }

    //判断是否是日期格式
    public static boolean isValidDate(String sDate)
    {
        String datePattern1 = "\\d{4}-\\d{2}-\\d{2}";
        String datePattern2 = "^((\\d{2}(([02468][048])|([13579][26]))"
                              + "[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|"
                              + "(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?"
                              + "((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?("
                              + "(((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?"
                              + "((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))";
        if((sDate != null))
        {
            Pattern pattern = Pattern.compile(datePattern1);
            Matcher match = pattern.matcher(sDate);
            if(match.matches())
            {
                pattern = Pattern.compile(datePattern2);
                match = pattern.matcher(sDate);
                return match.matches();
            } else
            {
                return false;
            }
        }
        return false;
    }

    public static String getIpAddr(HttpServletRequest request)
    {
        if(request.getHeader("x-forwarded-for") == null)
        {
            return request.getRemoteAddr();
        }
        return request.getHeader("x-forwarded-for");

    }

    //根据天数计算日期 加天数
    public static Date getDayTime(Date date,int day)
    {
        // TODO Auto-generated method stub
        // SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        // System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
        long s = 1000 * 60 * 60 * 24;
        return new Date(date.getTime() + s * day);
        // return canlandar.getTime();
    }

    //根据天数 计算日期 减天数
    public static Date getSubDayTime(Date date,int day)
    {
        // TODO Auto-generated method stub
        // SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        // System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
        long s = 1000 * 60 * 60 * 24;
        return new Date(date.getTime() - s * day);
        // return canlandar.getTime();
    }

    //计算日期相差天数

    public static int countDays(String begin,String end)
    {
        int days = 0;

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c_b = Calendar.getInstance();
        Calendar c_e = Calendar.getInstance();

        try
        {
            c_b.setTime(df.parse(begin));
            c_e.setTime(df.parse(end));

            while(c_b.before(c_e))
            {
                days++;
                c_b.add(Calendar.DAY_OF_YEAR,1);
            }

        } catch(ParseException pe)
        {
            System.out.println("日期格式必须为：yyyy-MM-dd；如：2010-4-4.");
        }

        return days;
    }

    //加减 月份
    public static Date Months(Date times,int months)
    {
        Date m = new Date();
        try
        {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String str = Entity.sdf.format(times);
            Date dt = null;

            dt = sdf.parse(str);

            Calendar rightNow = Calendar.getInstance();
            rightNow.setTime(dt);
            //  rightNow.add(Calendar.YEAR,-1);//日期减1年
            rightNow.add(Calendar.MONTH,months); //日期加3个月
            // rightNow.add(Calendar.DAY_OF_YEAR,10);//日期加10天
            Date dt1 = rightNow.getTime();
            String reStr = sdf.format(dt1);
            m = sdf.parse(reStr);

        } catch(ParseException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return m;
    }

    public static void method1(String file,String conent)
    {
        BufferedWriter out = null;
        try
        {
            out = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(file,true)));
            out.write(conent);
        } catch(Exception e)
        {
            e.printStackTrace();
        } finally
        {
            try
            {
                out.close();
            } catch(IOException e)
            {
                e.printStackTrace();
            }
        }
    }

    //判断时间大小
    public static int compare_date(String DATE1,String DATE2)
    {

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try
        {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if(dt1.getTime() > dt2.getTime())
            {
                System.out.println("dt1 在dt2前");
                return 1;
            } else if(dt1.getTime() < dt2.getTime())
            {
                System.out.println("dt1在dt2后");
                return -1;
            } else
            {
                return 0;
            }
        } catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return 0;
    }


    //判断是否是数字
    public static boolean isNumeric(String str)
    {
        for(int i = 0;i < str.length();i++)
        {
            //   System.out.println(str.charAt(i));
            if(!Character.isDigit(str.charAt(i)))
            {
                return false;
            }
        }
        return true;
    }

    //获取农历
    public static String getNongli(int year,int month,int day)
    {
        String s = null;
        Calendar cld = Calendar.getInstance();

        String week = "";
        long[] l = NongLi.calElement(year,month,day);
        switch(cld.get(Calendar.DAY_OF_WEEK))
        {
        case 1:
            week = "日";
            break;
        case 2:
            week = "一";
            break;
        case 3:
            week = "二";
            break;
        case 4:
            week = "三";
            break;
        case 5:
            week = "四";
            break;
        case 6:
            week = "五";
            break;
        case 7:
            week = "六";
            break;
        }
        String n = "";
        switch((int) (l[1]))
        {
        case 1:
            n = "一";
            break;
        case 2:
            n = "二";
            break;
        case 3:
            n = "三";
            break;
        case 4:
            n = "四";
            break;
        case 5:
            n = "五";
            break;
        case 6:
            n = "六";
            break;
        case 7:
            n = "七";
            break;
        case 8:
            n = "八";
            break;
        case 9:
            n = "九";
            break;
        case 10:
            n = "十";
            break;
        case 11:
            n = "十一";
            break;
        case 12:
            n = "十二";
            break;
        }
        try
        {
            //  String a = "北京时间： "+year+"年"+month+"月"+day+"日            星期"+week+"　农历"+n+"月"+);
            // String b = "北京时间： "+year+"年"+month+"月"+day+"日　星期"+week+"　农历"+n+"月"+getchina((int)(l[2]));
            // BufferedWriter outout = new BufferedWriter(new FileWriter("rili.html",false));
            //  outout.write(a);
            s = NongLi.getchina((int) (l[2]));
            //  outout.close();
        } catch(Exception e)
        {
            e.printStackTrace();
        }
        return s;
    }


}
