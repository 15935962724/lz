package tea.entity.os;

import tea.entity.*;
import java.io.*;
import java.util.*;
import java.util.regex.*;

//Windows Firewall/Internet Connection Sharing (ICS)
public class Firewall
{
    public static final String[] PROTOCOL_TYPE =
            {"ALL","TCP","UDP"};
    public static final String[] MODE =
            {"ENABLE","DISABLE"};
    public static final String[] MODE_NAME =
            {"启用","禁用"};
    public static final String[] SCOPE =
            {"ALL","SUBNET","CUSTOM"};
    public static final String[] SCOPE_NAME =
            {"任何计算机","仅我的网络(子网)","自定义列表"};
    public static final String[] PROFILE =
            {"CURRENT","DOMAIN","STANDARD","ALL"};
    public static final String[] PROFILE_NAME =
            {"当前","域","标准","所有"};
    public static boolean OPMODE,EXCEPTIONS;
    public static boolean MULTICASTBROADCASTRESPONSE;
    public static boolean NOTIFICATIONS;
    public int protocol; //端口协议
    public int port; //端口号
    public String name; //名称
    public int mode; //端口模式(可选)
    public int scope; //端口范围(可选)
    public String addresses; //自定义范围地址(可选)
    public int profile; //配置的配置文件(可选)
    public String _interface; //接口名(可选)
    public String program; //程序路径和文件名
    public String set() throws IOException
    {
        String cmd = "netsh firewall set " + (port > 0 ? "portopening protocol=" + PROTOCOL_TYPE[protocol] + " port=" + port : "allowedprogram program=" + Attch.cite(program)) + " name=" + Attch.cite(name) + " mode=" + MODE[mode];
        if(scope > 0)
            cmd += " scope=" + SCOPE[scope];
        if(scope == 2)
            cmd += " addresses=" + addresses;
        if(profile > 0)
            cmd += " profile=" + PROFILE[profile];
        if(_interface != null)
            cmd += " interface=" + Attch.cite(_interface);
        return OS.exec(cmd);
    }

    public String delete() throws IOException
    {
        String cmd = "netsh firewall delete " + (port > 0 ? "portopening protocol=" + PROTOCOL_TYPE[protocol] + " port=" + port : "allowedprogram program=" + Attch.cite(program));
        if(profile > 0)
            cmd += " profile=" + PROFILE[profile];
        if(_interface != null)
            cmd += " interface=" + Attch.cite(_interface);
        return OS.exec(cmd);
    }

    public String reset() throws IOException
    {
        return OS.exec("netsh firewall reset");
    }

    public static String set(boolean mode,boolean exceptions) throws IOException
    {
        OPMODE = mode;
        EXCEPTIONS = exceptions;
        return OS.exec("netsh firewall set opmode mode=" + MODE[mode ? 0 : 1] + " exceptions=" + MODE[exceptions ? 0 : 1]);
    }

    public static String set(boolean notifications) throws IOException
    {
        NOTIFICATIONS = notifications;
        return OS.exec("netsh firewall set notifications mode=" + MODE[notifications ? 0 : 1]);
    }

    public static String setM(boolean multicastbroadcastresponse) throws IOException
    {
        MULTICASTBROADCASTRESPONSE = multicastbroadcastresponse;
        return OS.exec("netsh firewall set multicastbroadcastresponse mode=" + MODE[multicastbroadcastresponse ? 0 : 1]);
    }

    public static ArrayList find() throws IOException
    {
        ArrayList al = new ArrayList();
        String str = OS.exec("netsh firewall show config verbose=ENABLE"); //portopening
        str = str.replaceAll("\r\n\t","\t");
        //System.out.println(str);
        int profile = 0,type = 0;
        String inter = null,line = null;
        String[] rs = str.split("\r\n");
        for(int i = 0;i < rs.length;i++)
        {
            if(rs[i].length() < 1)
            {
                line = rs[i + 1];
                int j = line.lastIndexOf(' ');
                if(j != -1)
                {
                    inter = line.substring(0,j);
                    profile = Arrayx.indexOf(PROFILE_NAME,inter);
                }
                i += 3;
                if(rs[i].charAt(0) == '-') //是否有标题
                    i++;
            }
            if(line.endsWith("的端口配置:"))
            {
                Firewall t = new Firewall();
                t.profile = profile;
                t._interface = inter;
                Matcher m = Pattern.compile("(\\d+) +(TCP|UDP) +([^ ]+) +([^\t]+)(\t.+: (.+))?").matcher(rs[i]);
                if(m.find())
                {
                    t.port = Integer.parseInt(m.group(1));
                    t.protocol = Arrayx.indexOf(PROTOCOL_TYPE,m.group(2));
                    t.mode = Arrayx.indexOf(MODE_NAME,m.group(3));
                    t.name = m.group(4);
                    t.addresses = m.group(6);
                    t.parse();
                }
                al.add(t);
            } else if(line.endsWith("的程序配置:"))
            {
                Matcher m = Pattern.compile("([^ ]+) +(.+) / ([^\t]+)(\t.+: (.+))?").matcher(rs[i]);
                Firewall t = new Firewall();
                t.profile = profile;
                t._interface = inter;
                if(m.find())
                {
                    t.mode = Arrayx.indexOf(MODE_NAME,m.group(1));
                    t.name = m.group(2);
                    t.program = m.group(3);
                    t.addresses = m.group(5);
                    t.parse();
                }
                al.add(t);
            } else if(line.endsWith("(当前):"))
            {
                Matcher m = Pattern.compile("([^ ]+) += (.+)").matcher(rs[i]);
                if(m.find())
                {
                    str = m.group(1);
                    boolean flag = "启用".equals(m.group(2));
                    if(str.equals("操作模式"))
                        OPMODE = flag;
                    else if(str.equals("例外模式"))
                        EXCEPTIONS = flag;
                    else if(str.equals("多播/广播响应模式"))
                        MULTICASTBROADCASTRESPONSE = flag;
                    else if(str.equals("通知模式"))
                        NOTIFICATIONS = flag;
                }
            }
        }
        return al;
    }

    void parse()
    {
        if(addresses == null || "*".equals(addresses))
            scope = 0;
        else if("LocalSubNet".equals(addresses))
            scope = 1;
        else
            scope = 2;
    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{protocol:" + protocol);
        sb.append(",port:" + port);
        sb.append(",name:" + Attch.cite(name));
        sb.append(",mode:" + mode);
        sb.append(",scope:" + scope);
        sb.append(",addresses:" + Attch.cite(addresses));
        sb.append(",profile:" + profile);
        sb.append(",program:" + Attch.cite(program));
        sb.append("}");
        return sb.toString();
    }
}
