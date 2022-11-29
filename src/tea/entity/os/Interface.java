package tea.entity.os;

import tea.entity.*;
import java.io.*;
import java.util.*;
import java.util.regex.*;

//Windows Firewall/Internet Connection Sharing (ICS)
public class Interface
{
    public String name; //名称
    //
    public boolean asource = true; //DHCP 启用
    public String aaddr; //指定接口的 IP 地址
    public String amask; //指定 IP 地址的子网掩码
    public String agateway; //默认网关
    public String agwmetric; //默认网关的跃点数。如果网关设置为 'none'，则不应设置此字段。
    //DNS
    public boolean dsource = true; //DHCP 启用
    public String daddr; //DNS服务器
    //none: 禁用动态 DNS 注册
    //primary: 只在主 DNS 后缀下注册
    //both: 在主 DNS 后缀下注册，也在特定连接后缀下注册
    public static final String[] REGISTER =
            {"none","primary","both"};
    public static final String[] REGISTER_NAME =
            {"无","只是主要","主要和特定连接"};
    public int dregister;
    //WINS
    public boolean wsource = true; //DHCP 启用
    public String waddr; //WINS服务器
    public String set() throws IOException
    {
        String cmd = "netsh interface ip set address name=" + Attch.cite(name) + " source=" + (asource ? "dhcp" : "static addr=" + aaddr + " mask=" + amask) + " gateway=" + agateway + " gwmetric=" + agwmetric;
        //cmd = "netsh interface ip set dns name=" + Attch.cite(name) + " source=" + (dsource ? "dhcp" : "static addr=" + daddr )  + " register=" + dregister;
        //cmd = "netsh interface ip set wins name=" + Attch.cite(name) + " source=" + (wsource ? "dhcp" : "static addr=" + waddr ) ;
        System.out.println(cmd);
        return OS.exec(cmd);
    }


    public String reset() throws IOException
    {
        return OS.exec("netsh firewall reset");
    }


    public static ArrayList find() throws IOException
    {
        ArrayList al = new ArrayList();
        String str = OS.exec("netsh interface ip show config");
        str = str.replaceAll("\r\n\t","\t");
        System.out.println(str + "==");
        String[] rs = str.split("\r\n");
        Interface t = null;
        for(int i = 0;i < rs.length;i++)
        {
            if(rs[i].length() < 1)
            {
                if(t != null)
                    al.add(t);
                t = new Interface();
                Matcher m = Pattern.compile("\"(.+)\"").matcher(rs[++i]);
                if(m.find())
                    t.name = m.group(1);
                ++i;
            }
            Matcher m = Pattern.compile("    (.+) {2,}(.+) ?").matcher(rs[i]);
            if(m.find())
            {
                System.out.println(m.group(1).trim() + "===" + m.group(2));
                str = m.group(1).trim();
                if(str.equals("DHCP 启用"))
                    t.asource = "是".equals(m.group(2));
                else if(str.equals("通过 DHCP 配置的 DNS 服务器:")) //无
                    t.dsource = true;
                else if(str.equals("静态配置的 DNS 服务器:"))
                {
                    t.dsource = false;
                    t.daddr = m.group(2);
                } else if(str.equals("用哪个前缀注册:"))
                    t.dregister = Arrayx.indexOf(REGISTER_NAME,m.group(2));
                else if(str.equals("通过 DHCP 配置的 WINS 服务器:")) //无
                    t.wsource = true;
                else if(str.equals("静态配置的 WINS 服务器:"))
                {
                    t.wsource = false;
                    t.waddr = m.group(2);
                }
            }
        }
        al.add(t);
        return al;
    }


    public String toString()
    {
        StringBuilder sb = new StringBuilder();
//        sb.append("{protocol:" + protocol);
//        sb.append(",port:" + port);
//        sb.append(",name:" + Attch.cite(name));
//        sb.append(",mode:" + mode);
//        sb.append(",scope:" + scope);
//        sb.append(",addresses:" + Attch.cite(addresses));
//        sb.append(",profile:" + profile);
//        sb.append(",program:" + Attch.cite(program));
//        sb.append("}");
        return sb.toString();
    }
}
