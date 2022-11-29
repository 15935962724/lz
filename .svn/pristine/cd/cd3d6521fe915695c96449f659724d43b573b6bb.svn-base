package tea.entity.netdisk;

import java.util.*;
import java.sql.SQLException;
import java.io.*;
import tea.db.DbAdapter;
import java.net.URLEncoder;
import tea.resource.Common;
import tea.entity.*;

public class NetDiskMember extends Entity
{
    private String community;
    private String member;
    private String path;
    private String prefix;
    private boolean exists;

    public NetDiskMember(String community,String member,String path)
    {
        this.community = community;
        this.member = member;
        this.path = path;
        this.prefix = "/res/" + community + "/netdiskmember/" + member;
    }

    public static NetDiskMember find(String community,String member,String path)
    {
        return new NetDiskMember(community,member,path);
    }

    public static NetDiskMember find(String community,String member,String path,int size)
    {
        return new NetDiskMember(community,member,path);
    }

    public String getPrefix()
    {
        return prefix;
    }

    public String getPath()
    {
        return path;
    }

    public String getMember()
    {
        return member;
    }

    public boolean isExists()
    {
        return exists;
    }

    public String getCommunity()
    {
        return community;
    }

    //base: 说明:null=没有链接
    public String getAncestor(String base) throws SQLException
    {
        boolean bool = base != null;
        StringBuilder a = new StringBuilder("/ ");
        StringBuilder p = new StringBuilder();
        String bp = path;
        try
        {
            if(bool)
            {
                bp = path.substring(base.length());
                p.append(base).append("/");
                base = java.net.URLEncoder.encode(base,"UTF-8");
                a.append("<a href=\"?community=" + community + "&base=" + base + "&path=" + base + "%2F\">");
            }
            a.append("根目录</a>");
            StringTokenizer st = new StringTokenizer(bp,"/");
            while(st.hasMoreTokens())
            {
                String label = st.nextToken();
                a.append(" / ");
                if(bool)
                {
                    p.append(label).append("/");
                    a.append("<a href=?community=" + community + "&base=" + base + "&path=" + java.net.URLEncoder.encode(p.toString(),"UTF-8") + ">");
                }
                a.append(label + "</a>");
            }
        } catch(UnsupportedEncodingException ex)
        {
        }
        return a.toString();
    }


    public String getTreeToHtml(int step) throws SQLException
    {
        StringBuilder h = new StringBuilder();
        try
        {
            tree(step,h);
        } catch(UnsupportedEncodingException ex)
        {
        }
        return h.toString();
    }

    private void tree(int step,StringBuilder h) throws SQLException,UnsupportedEncodingException
    {
        File f = new File(Common.REAL_PATH + prefix + path);
        if(!f.canRead())
        {
            return;
        }
        File fs[] = f.listFiles(new FilenameFilter()
        {
            public boolean accept(File dir,String name)
            {
                return new File(dir,name).isDirectory();
            }
        }
        );
        StringBuilder s = new StringBuilder();
        for(int loop = 0;loop < step;loop++)
        {
            s.append("　 ");
        }
        for(int i = 0;i < fs.length;i++)
        {
            String name = fs[i].getName();
            String id = URLEncoder.encode(path + name + "/","UTF-8");
            h.append(s);
            h.append("<SPAN id=leftuptree" + step + " >");
            h.append("<a href=### onclick=f_ex('" + id + "'," + step + "); ID=a" + step + "><IMG SRC=/tea/image/tree/tree_plus.gif align=absmiddle ID=img" + id + " /></a> ");
            h.append("<a href=### onclick=f_open('" + id + "');>" + name + "</a>");
            h.append("<br></SPAN>");
            h.append("<Div id=divid" + id + " style=display:none>");
            //obj.tree(teasession, popedom, step + 1, def, h);
            h.append("</Div>");
        }
    }
}
