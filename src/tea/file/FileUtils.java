package tea.file;

import java.io.*;

import java.util.*;


public class FileUtils//排序LIST中的对象
{
	public static class CompratorByLastModified implements Comparator {
        public int compare(Object o1,Object o2)
        {
            File file1 = (File) o1;
            File file2 = (File) o2;
            long diff = file1.lastModified() - file2.lastModified();
            if(diff > 0)
                return 1;
            else if(diff == 0)
                return 0;
            else
                return -1;
        }

        public boolean equals(Object obj)
        {
            return true; //简单做法
        }
    }
}
