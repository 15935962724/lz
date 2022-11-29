package tea.entity.bpicture;

import java.io.File;
import java.io.*;
import java.util.ArrayList;


public class FileSystem
{
    private static ArrayList filelist = new ArrayList();
    private static int filecnt;
    private static int dircnt;

   /*public static void main(String[] args) {

       long a = System.currentTimeMillis();
       refreshFileList("c:\\java","jpg");
       System.out.println(System.currentTimeMillis() - a);
   }*/
   public static ArrayList refreshFileList(String strPath,String suffix)
   {
       File dir = new File(strPath);
       File[] files = dir.listFiles();

       if (files == null)
           return filelist;
       for (int i = 0; i < files.length; i++)
       {
           if (files[i].isDirectory())
           {
               refreshFileList(files[i].getAbsolutePath(),suffix);
           } else {
               String strFileName = files[i].getAbsolutePath().toLowerCase();
               if(suffix!=null && suffix.length()>0)
               {
                   if(strFileName.endsWith(suffix))
                   {
                       System.out.println("---" + strFileName);
                       filelist.add(files[i].getAbsolutePath());
                   }
                   else
                   {

                   }
               }
               else
               {
                   System.out.println("---" + strFileName);
                   filelist.add(files[i].getAbsolutePath());
               }
           }
        }
        return filelist;
   }

   public static final boolean delTree(File f) throws IOException
   {
       if(f.isDirectory())
       {
           File[] ff = f.listFiles();
           for(int i = ff.length;--i >= 0;)
           {
               boolean ret = delTree(ff[i]);
               if(!ret)
                   return false;
           }
           if(!f.delete())
               return false;
           dircnt++;
       } else
       {
           if(!f.delete())
               return false;
           filecnt++;
       }
       return true;
   }

}
