package tea.entity.os;

import java.io.*;
import java.util.*;

public class DNSZone
{
    public String name;
    DNSZone(String name)
    {
        this.name = name;
    }

    public static DNSZone find(String name)
    {
        return new DNSZone(name);
    }

    public static int count(final String zone)
    {
        String[] fs = new File(System.getenv("SystemRoot") + "/system32/dns").list(new FilenameFilter()
        {
            public boolean accept(File dir,String name)
            {
                return name.contains(zone) && name.endsWith(".dns");
            }
        });
        return fs == null ? 0 : fs.length;
    }

    public static ArrayList find(final String zone,int pos,int size)
    {
        ArrayList al = new ArrayList();
        File[] fs = new File(System.getenv("SystemRoot") + "/system32/dns").listFiles(new FilenameFilter()
        {
            public boolean accept(File dir,String name)
            {
                return name.contains(zone) && name.endsWith(".dns");
            }
        });
        if(fs != null)
        {
            size = Math.min(fs.length,pos + size);
            for(int i = pos;i < size;i++)
            {
                String name = fs[i].getName();
                al.add(new DNSZone(name.substring(0,name.length() - 4)));
            }
        }
        return al;
    }
}
//dnscmd /ZoneAdd aaa.cn /Primary
//dnscmd /RecordAdd aaa.cn t6 TXT "test txt"
//dnscmd /RecordDelete aaa.cn t A /F
