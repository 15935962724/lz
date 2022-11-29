package tea.service.version;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;


import javax.servlet.ServletContext;


public class FileService
{

	private  String split="\\";
	//private String os="linux";
    public FileService()
    {

    }
    public void delete(String path)
    {

        try
        {
            File f = new File(path);
            if (f.exists())
            {
                File fs[] = f.listFiles();
                for (int i = 0; i < fs.length; i++)
                {  System.out.println(fs[i].getName());
                    fs[i].delete();
                }
                f.delete();
            }
        } catch (Exception ex)
        {ex.printStackTrace();
        }


    }


    public void cretesql(byte[] abyte0, String path, String filename)
    {
        try
        {
            ByteArrayOutputStream bytearrayoutputstream1 = new ByteArrayOutputStream();
            bytearrayoutputstream1.write(abyte0);

            File d = new File(path);
            if (!d.exists())
            {
                d.mkdirs();
            }


          FileOutputStream fileoutputstream1 = new FileOutputStream(path + split + filename);
            bytearrayoutputstream1.writeTo(fileoutputstream1);
            fileoutputstream1.close();
        } catch (FileNotFoundException e)
        {

            e.printStackTrace();
        } catch (IOException e)
        {

            e.printStackTrace();
        }
    }



}

