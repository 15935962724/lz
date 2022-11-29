package tea.entity.util;

import java.security.*;
import java.net.*;
import java.util.*;
import java.io.*;
import sun.awt.shell.*;

//cd E:/workspace/edn/ROOT/WEB-INF/classes
//E:/JBuilder2006/jdk1.5/bin/java tea/entity/util/AutoBuild
public class AutoBuild extends Thread
{
    private static final String JAVA_HOME = "D:/Program Files/JBuilder2006/jdk1.5";
    private static final String JPX[] =
            {"x:/edn"};
    private String build;
    private File jpx;
    private String cp;
    private int len;
    private long time = 1213151378446L; //06-11
    public AutoBuild(String str,String b)
    {
        jpx = new File(str);
        build = b;
        len = str.length();
        StringBuilder cp = new StringBuilder();
        cp.append(".;D:/Program Files/JBuilder2006/thirdparty/jakarta-tomcat-5.5.9/common/lib/servlet-api.jar;");
        cp.append(build).append(";");
        int j = build.lastIndexOf("/");
        File fs[] = new File(build.substring(0,j) + "/lib").listFiles();
        if(fs != null)
        {
            for(int i = 0;i < fs.length;i++)
            {
                String n = fs[i].getName();
                if(n.endsWith(".jar"))
                {
                    cp.append(fs[i].getPath()).append(";");
                }
            }
        }
        this.cp = cp.toString();
    }

    public void run()
    {
        while(true)
        {
            long lo = System.currentTimeMillis();
            try
            {
                check(new File(jpx,"src"));
                Thread.sleep(1000);
            } catch(Exception ex)
            {
                ex.printStackTrace();
            }
            time = lo;
            //time = System.currentTimeMillis() - 3600000L;
        }
    }

    private void check(File f) throws IOException
    {
        File fs[] = f.listFiles();
        for(int i = 0;i < fs.length;i++)
        {
            long last = fs[i].lastModified();
            if(fs[i].isFile())
            {
                if(last < time)
                {
                    continue;
                }
                String n = fs[i].getName();
                String p = fs[i].getPath().substring(len + 4);
                if(n.endsWith(".java"))
                {
                    f = new File(build + p.substring(0,p.length() - 4) + "class");
                    if(f.lastModified() < last)
                    {
                        make(fs[i]);
                    }
                } else if(n.endsWith(".properties"))
                {
                    f = new File(build + p);
                    if(f.lastModified() < last)
                    {
                        System.out.println(f);
                        int len;
                        byte by[] = new byte[8192];
                        FileOutputStream fos = new FileOutputStream(f);
                        FileInputStream fis = new FileInputStream(fs[i]);
                        while((len = fis.read(by)) != -1)
                        {
                            fos.write(by,0,len);
                        }
                        fis.close();
                        fos.close();
                    }
                }
            } else
            {
                check(fs[i]);
            }
        }
    }

    private void make(File f) throws IOException
    {
        Runtime rt = Runtime.getRuntime();
        String cmd = JAVA_HOME + "/bin/javac -g -encoding UTF-8 -d \"" + build + "\" -cp \"" + cp + "\" " + f.getPath();
        Process p = rt.exec(cmd);
        InputStream is = p.getErrorStream();
        int i = is.read();
        if(i == 215) //注意//
        {
            i = -1;
        }
        System.out.println((i == -1 ? "OK " : "ERR") + " " + f);
//        File log = new File(SRC[jpx] + "/../" + f.getName() + ".log");
//        if(i != -1)
//        {
//            FileOutputStream fos = new FileOutputStream(log);
//            //fos.write(cmd.getBytes());
//            fos.write(i);
//            System.out.print((char) i);
//            byte by[] = new byte[1024 * 8];
//            while((i = is.read(by)) != -1)
//            {
//                fos.write(by,0,i);
//                System.out.println(new String(by,0,i));
//            }
//            fos.close();
//        } else
//        {
//            log.delete();
//        }
        is.close();
    }

   /* public static void main(String args[])
    {
        for(int i = 0;i < JPX.length;i++) //
        {
            AutoBuild ab = new AutoBuild(JPX[i],JPX[i] + "/ROOT/WEB-INF/classes");
            ab.start();
        }
    }*/
}
