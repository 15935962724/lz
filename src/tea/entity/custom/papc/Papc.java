package tea.entity.custom.papc;

import net.mietian.convert.Video;
import tea.entity.Filex;
import tea.entity.Http;
import tea.entity.Img;
import tea.entity.node.SPicture;
import tea.entity.node.Specimen;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

public class Papc
{
    //28924：E:\TestData\2008\4\n9\188022Multimedia4.jpg
    //e:\600\2008\4\n9\188022-4.jpg
    //28925：E:\TestData\2008\4\n9\188023Multimedia2.jpg
    //e:\600\2008\4\n9\188023-2.jpg

    public static void main_(String args[]) throws Exception
    {
        int node = 0;
        String dir = "D:/Tomcat6/webapps_papc/ROOT";
        while(true)
        {
            Iterator it = SPicture.find(" AND node>" + node + " ORDER BY node",0,100).iterator();
            if(!it.hasNext())
                break;
            while(it.hasNext())
            {
                SPicture t = (SPicture) it.next();
                node = t.node;
                System.out.println(t.node);
                //600
                String path = "/res/attch" + t.mulname.replaceFirst("TestData","600").replaceFirst("Multimedia","-");
                Filex.copy(dir + path,Http.REAL_PATH + path);
                //170
                path = "/res/attch" + t.mulname.replaceFirst("TestData","170").replaceFirst("Multimedia","-");
                Filex.copy(dir + path,Http.REAL_PATH + path);
            }
        }
    }

    //第二次，导数据
    public static void main2(String args[]) throws Exception
    {
        while(true)
        {
//            Iterator it = Specimen.find(" AND node=0 ORDER BY sid",0,100).iterator();
//            if(!it.hasNext())
//                break;
//            while(it.hasNext())
//            {
//                Specimen t = (Specimen) it.next();
//                t.imp();
//            }
//            Iterator it = SPicture.find(" AND node=0 ORDER BY pid,sid",0,100).iterator();
//            if(!it.hasNext())
//                break;
//            while(it.hasNext())
//            {
//                SPicture t = (SPicture) it.next();
//                t.imp();
//			}
//            Iterator it = SIdentify.find(" AND node=0 ORDER BY jid,sid",0,100).iterator();
//            if(!it.hasNext())
//                break;
//            while(it.hasNext())
//            {
//                SIdentify t = (SIdentify) it.next();
//                t.imp();
//            }

            Iterator it = SPicture.find(" AND specimen=0",0,100).iterator();
            if(!it.hasNext())
                break;
            while(it.hasNext())
            {
                SPicture t = (SPicture) it.next();
                Iterator it2 = Specimen.find(" AND sid=" + t.sid,0,1).iterator();
                if(it2.hasNext())
                {
                    Specimen s = (Specimen) it2.next();
                    t.set("specimen",String.valueOf(t.specimen = s.node));
                }
            }
        }
    }

    public static void main(String args[]) throws IOException
    {
        System.out.println("目标：" + Http.REAL_PATH);
        final File[] fs = new File("D:/红外相机20131115").listFiles();
        //final File[] fs = new File("D:/TestData").listFiles();
        for(int i = 0;i < fs.length;i++) //
        {
            final int j = i;
            new Thread()
            {
                public void run()
                {
                    scale(fs[j]);
                }
            }.start();
        }
    }

    static int hits = 0;
    public static void scale(File f)
    {
        System.out.println((hits++) + "：" + f.getPath());
        if(f.isFile())
        {
            String name = f.getName();
            if("Thumbs.db".equals(name))
            {
                f.delete();
                return;
            }
            String ex = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
            if("rar".equals(ex) || "xls".equals(ex))
                return;
            if("avi".equals(ex))
            {
                String path = f.getPath();
                try
                {
                    Video v = new Video(path);
                    //转FLV
//                    path = path.substring(0,path.length() - 3) + "flv";
//                    path = path.substring(0,2) + "\\_flv_" + path.substring(2).toLowerCase();
//                    f = new File(path);
//                    f.getParentFile().mkdirs();
//                    v.width = 640;
//                    v.height = 480;
//                    v.start(path,new PrintWriter(System.out));
//                    if(true)
//                        return;
                    //
                    path = path.substring(0,path.length() - 3) + "jpg";
                    path = path.substring(0,2) + "\\_img_" + path.substring(2);
                    System.out.println("IMG：" + path);
                    f = new File(path);
                    f.getParentFile().mkdirs();
                    v.pic(0,path);
                } catch(Throwable th)
                {
                    th.printStackTrace();
                    return;
                }
            }
            Img i = new Img(f);
            //600 无水印
            i.quality = 100;
            i.width = i.height = 600;
            String path = f.getPath().replace('\\','/');
            path = path.substring(0,2) + "/600_src" + path.substring(2)
                   .replaceFirst("/TestData/","/").replaceFirst("Multimedia","-")
                   .replaceFirst("/红外相机数据处理2012.12.4/","/infrared/").toLowerCase();
            f = new File(path);
            if(!f.exists())
            {
                f.getParentFile().mkdirs();
                i.start(f);
            }

            //170
            i = new Img(f);
            i.width = i.height = 170;
            File f2 = new File(Http.REAL_PATH + "/res/attch/170" + path.substring(10)); //10是:D:/600_src
            if(!f2.exists())
            {
                f2.getParentFile().mkdirs();
                i.start(f2);
            }

            //600
            i = new Img(f);
            i.gravity = "Center";
            i.composite = Http.REAL_PATH + "/res/papc/1303/watermark.png";
            File f3 = new File(Http.REAL_PATH + "/res/attch/600" + path.substring(10));
            if(!f3.exists())
            {
                f3.getParentFile().mkdirs();
                i.start(f3);
            }
        } else
        {
            File[] fs = f.listFiles();
            if(fs == null)
            {
                System.out.println("NULL:" + f.getPath());
                return;
            }
            for(int i = 0;i < fs.length;i++)
            {
                scale(fs[i]);
            }
        }
    }
}
