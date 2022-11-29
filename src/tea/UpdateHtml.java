package tea;

import java.io.*;

public class UpdateHtml
{
    public static void backup(String path) throws IOException
    {
        File bak = new File(path + "/res/html/");
        bak.mkdirs();
//
        String cs[] = new File(path + "/res/").list();
        for(int i = 0;i < cs.length;i++)
        {
            System.out.println(cs[i]);
            if(!"html".equals(cs[i]))
            {
                File fs[] = new File(path + ("/res/" + cs[i] + "/html/")).listFiles();
                if(fs != null)
                {
                    for(int j = 0;j < fs.length;j++)
                    {
                        if(fs[j].isFile())
                        {
                            String name = fs[j].getName().replaceFirst("_jsp","");
                            int x = name.indexOf('_');
                            if(x == -1)
                            {
                                x = name.indexOf('P');
                            }
                            if(x != -1)
                            {
                                File f = new File(bak,name.substring(0,x) + ".html");
                                if(f.lastModified() + 86400000 < fs[j].lastModified())
                                {
                                    System.out.print(fs[j].getCanonicalPath() + "\r");
                                    byte by[] = new byte[(int) fs[j].length()];
                                    FileInputStream fis = new FileInputStream(fs[j]);
                                    fis.read(by);
                                    fis.close();
                                    //
                                    FileOutputStream fos = new FileOutputStream(f);
                                    fos.write(by);
                                    fos.close();
                                }
                            }
                        }
                    }
                }
            }
        }
    }

   /* public static void main(String[] args) throws IOException
    {
        String path = (args.length > 0) ? args[0] : "d:/edn";
        File f = new File(path + "/WEB-INF");
        if(f.exists())
        {
            backup(path);
        } else
        {
            String cs[] = new File(path).list();
            if(cs == null)
            {
                System.out.println("path error!!!");
            }
            for(int i = 0;i < cs.length;i++)
            {
                f = new File(path + "/" + cs[i] + "/ROOT");
                if(f.exists())
                {
                    backup(path + "/" + cs[i] + "/ROOT");
                }
            }
        }
    }*/
}
