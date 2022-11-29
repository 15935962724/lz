package tea.entity;

import java.io.*;
import jcifs.smb.*;

// smb://username:password@192.168.0.77/test
public class Smb
{
    public Smb()
    {
    }

    private static SmbFile equals(File f,SmbFile[] fr) throws IOException
    {
        for(int j = 0;j < fr.length;j++)
        {
            String n = fr[j].getName();
            if(n.endsWith("/"))
                n = n.substring(0,n.length() - 1); //文件夹：文件名中多个"/"
            if(!f.getName().equals(n))
                continue;
            if(f.isFile() != fr[j].isFile()) //同名，不同类型
                fr[j].delete();
            else if(f.isDirectory() || (f.length() == fr[j].length() && fr[j].lastModified() >= f.lastModified()))
                return fr[j];
            break;
        }
        return null;
    }

    public static void sync(SmbFile sf,File file,String log) throws IOException
    {
        File[] fs = file.listFiles();
        SmbFile[] fr = sf.listFiles();
        for(int i = 0;i < fs.length;i++)
        {
            String n = fs[i].getName();
            if(!fs[i].canRead() || "_notes".equals(n))
                continue;
            if("Thumbs.db".equals(n))
            {
                fs[i].delete();
                continue;
            }
            SmbFile f = equals(fs[i],fr);
            if(f == null)
            {
                if(fs[i].isDirectory())//目录名必须以"/"结尾,否则listFiles()时报错
                    n += "/";
                f = new SmbFile(sf,n);
                Filex.logs(log,"同步：" + f.getPath());
                if(fs[i].isDirectory())
                    f.mkdirs();
                else
                    Filex.piped(new FileInputStream(fs[i]),new SmbFileOutputStream(f));
                f.setLastModified(fs[i].lastModified());
            }
            if(fs[i].isDirectory())
                sync(f,fs[i],log);
        }
    }
}
