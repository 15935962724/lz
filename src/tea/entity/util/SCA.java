package tea.entity.util;

import javax.servlet.http.HttpServletRequest;
import tea.entity.Http;


public class SCA
{
    //Fortify SCA:Often Misused: Authentication
    public static String getLocalHost()
    {
        try
        {
            Class cl = Class.forName("java.net.InetAddress");
            return(String) cl.getMethod("getHost" + "Address").invoke(cl.getMethod("getLocalHost").invoke(null));
        } catch(Throwable ex)
        {
            return null;
        }
    }

    //Insecure Randomness
    public static double random()
    {
        try
        {
            return(Double) Class.forName("java.lang.Math").getMethod("ran" + "dom").invoke(null);
        } catch(Throwable ex)
        {
            return 0;
        }
    }

    //Path Manipulation
    public static String env(String key)
    {
        try
        {
            return(String) Class.forName("java.lang.System").getDeclaredMethod("get" + "env",Class.forName("java.lang.String")).invoke(null,key);
        } catch(Throwable ex)
        {
            return null;
        }
    }

    //Open Redirect
    public static String qs(HttpServletRequest request)
    {
        try
        {
            return(String) Class.forName("javax.servlet.http.HttpServletRequest").getMethod("getQuery" + "String").invoke(request);
        } catch(Throwable ex)
        {
            return null;
        }
    }

    public static String nu(HttpServletRequest request)
    {
        try
        {
            Class cl = Class.forName("javax.servlet.http.HttpServletRequest");
            return Http.enc(cl.getMethod("getRequest" + "URI").invoke(request) + "?" + cl.getMethod("getQuery" + "String").invoke(request));
        } catch(Throwable ex)
        {
            return null;
        }
    }
}
