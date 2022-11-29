package tea.entity.bpicture;

import java.io.File;
import java.util.ArrayList;
import javax.servlet.ServletContext;

public class ImportBP
{
    private static ArrayList filelist = new ArrayList();
   /* public static void main(String[] args)
    {
        long a = System.currentTimeMillis();
        refreshFileList("X:\\edn\\ROOT\\res\\bigpic\\daoru");
        System.out.println(System.currentTimeMillis() - a);
    }*/

    public static void refreshFileList(String strPath)
    {
        File dir = new File(strPath);
        File[] files = dir.listFiles();

        if(files == null)
            return;
        for(int i = 0;i < files.length;i++)
        {
            if(files[i].isDirectory())
            {
                refreshFileList(files[i].getAbsolutePath());
            } else
            {
                String strFileName = files[i].getAbsolutePath().toLowerCase();
                System.out.println("---" + strFileName);
                filelist.add(files[i].getAbsolutePath());
            }
        }
    }
}
