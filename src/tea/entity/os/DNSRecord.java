package tea.entity.os;

import java.io.*;
import java.util.*;
import tea.entity.*;
import java.util.regex.*;

public class DNSRecord
{
    public String zone;
    public String name;
    public String type;
    public String content;
    public DNSRecord(String zone,String name)
    {
        this.zone = zone;
        this.name = name;
    }

    public static ArrayList find(final String zone,String name,int pos,int size) throws IOException
    {
        ArrayList al = new ArrayList();
        String str = Filex.read(System.getenv("SystemRoot") + "/system32/dns/" + zone + ".dns","GBK");
        Matcher m = Pattern.compile("^([^\\s]+) +([^\\s]+)	(.+)",Pattern.MULTILINE).matcher(str);
        size += pos;
        for(int i = 0;i < size && m.find();)
        {
            String tmp = m.group(1);
            if(tmp.indexOf(name) == -1)
                continue;
            if(i++ < pos)
                continue;
            DNSRecord t = new DNSRecord(zone,tmp);
            t.type = m.group(2);
            t.content = m.group(3);
            al.add(t);
        }
        return al;
    }

    public void set() throws IOException
    {
        OS.exec("net stop DNS"); //通过dnsmgmt.msc修改的，停止服务后才会写入文件！
        StringBuilder sb = new StringBuilder();
        sb.append(";");
        sb.append("\r\n;  Database file " + zone + ".dns for " + zone + " zone.");
        sb.append("\r\n;      Zone version:  0");
        sb.append("\r\n;");
        sb.append("\r\n");
        sb.append("\r\n@                       IN  SOA ay130911014115z.  hostmaster. (");
        sb.append("\r\n                        	10           ; serial number");
        sb.append("\r\n                        	900          ; refresh");
        sb.append("\r\n                        	600          ; retry");
        sb.append("\r\n                        	86400        ; expire");
        sb.append("\r\n                        	3600       ) ; default TTL");
        sb.append("\r\n\r\n");
        ArrayList al = find(zone,"",0,Integer.MAX_VALUE);
        for(int i = 0;i < al.size();i++)
        {
            DNSRecord r = (DNSRecord) al.get(i);
            if(r.name.equals(name))
                r = this;
            sb.append(r.name);
            for(int j = 23 - r.name.length();j > 0;j--)
                sb.append(" ");
            sb.append(" " + r.type + "	" + r.content + "\r\n");
        }
        Filex.write(System.getenv("SystemRoot") + "/system32/dns/" + zone + ".dns",sb.toString(),"GBK");
        OS.exec("net start DNS");
    }

}
