package tea.entity;

import java.util.*;
import tea.entity.member.*;
import java.net.*;

public class Err
{
    private static HashMap<String,String> ERR = new HashMap();
    static
    {
        ERR.put("将截断字符串或二进制数据。","抱歉，信息填写太长，无法保存！"); //com.microsoft.sqlserver.jdbc.SQLServerException:
        ERR.put("从 char 数据类型到 datetime 数据类型的转换导致 datetime 值越界。","抱歉，日期越界！必须是1753年1月1日到9999年12月31日之间！");
        ERR.put("multiple points","抱歉，小数点过多，请检查修改！"); //java.lang.NumberFormatException:
        ERR.put("Read timed out","抱歉，读取超时，请检查网络或重试！"); //java.net.SocketTimeoutException:
        ERR.put("/ by zero","抱歉，除数不能为零！"); //java.lang.ArithmeticException:
    }

    //java.lang.NoSuchFieldError: dept
    //java.sql.SQLException: [Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]'|' 附近有语法错误。
    public static String get(Http h,Throwable th)
    {
        if(th == null)
            th = new Exception("未知错误！");
        else
        {
            Throwable ca = th.getCause(); //org.apache.jasper.JasperException
            th = ca == null ? th : ca;
        }
        String msg = th.getMessage();
        if(msg == null)
            msg = th.toString();
        if(msg.startsWith("[Microsoft][SQLServer 2000 Driver for JDBC][SQLServer]")) //java.sql.SQLException:
            msg = msg.substring(54);
        String val = ERR.get(msg);
        if(msg.startsWith("For input string: ")) //java.lang.NumberFormatException:
        {
            val = "抱歉，您输入的" + msg.substring(18) + "不正确！请输入数字！";
        } else if(msg.startsWith("Unparseable date: ")) //java.text.ParseException:
        {
            val = "抱歉，您输入的" + msg.substring(18) + "不正确！请输入日期！";
        } else if(msg.endsWith(" 附近有语法错误。"))
        {
            msg = "抱歉，SQL中的" + msg.substring(0,msg.length() - 9) + "有错误！";
        } else
        {
            msg = th.toString();
        }
        if(val == null)
        {
            //Email.remind(h,th);
        }
        return val == null ? msg : val;
    }
}
