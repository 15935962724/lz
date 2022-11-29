package tea.service.version;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;
import javax.servlet.http.HttpSession;
public class ZIPUtil
{
    /**
     * ѹ���ļ�
     *
     * @param input ��ѹ����ļ������ļ���
     * @param output ѹ���ļ�
     * @throws IOException
     */
	public String zipfile;
    public String getZipfile() {
		return zipfile;
	}

	public void setZipfile(String zipfile) {
		this.zipfile = zipfile;
	}

    public void zip(File input, File output) throws IOException
{
    output.getParentFile().mkdirs();
    output.createNewFile();
    this.setZipfile(output.getName());
    ZipOutputStream zipOutput = new ZipOutputStream(new FileOutputStream(
            output));

    if (input.isDirectory())
    {
        addDirectory(zipOutput, "", input);
    }
    else
    {
        addFile(zipOutput, "", input);
    }

    zipOutput.close();

    System.out.println( output.getAbsolutePath()+"  Created!!");
}

/**
 * ѹ���ļ���
 *
 * @param zipOutput
 * @param path
 * @param input
 * @throws IOException
 */

private  void addDirectory(ZipOutputStream zipOutput, String path,
        File input)
        throws IOException
{
    File[] subFiles = input.listFiles(new FileFilter()
    {
        public boolean accept(File pathname)
        {
            return true;
        }
    });


    for (int i = 0; i < subFiles.length; i++)
    {
        if (subFiles[i].isFile())
        {

             Date lastmodify=new Date(subFiles[i].lastModified());


            addFile(zipOutput,
                    (path.trim().length() == 0 ? "" : path + "/")
                            + input.getName(), subFiles[i]);
        }
        else
        {
            if(!subFiles[i].getName().equals("update")&&
               (subFiles[i].getName().indexOf("searchindex")<0))
            addDirectory(zipOutput, (path.trim().length() == 0 ? "" : path
                    + "/")
                    + input.getName(), subFiles[i]);


        }
       }
    }
	public void zip(File input, File output,Date lastpack)
            throws IOException
    {
        output.getParentFile().mkdirs();
        output.createNewFile();
        this.setZipfile(output.getName());
        ZipOutputStream zipOutput = new ZipOutputStream(new FileOutputStream(
                output));

        if (input.isDirectory())
        {
            addDirectory(zipOutput, "", input,lastpack);
        }
        else
        {
            addFile(zipOutput, "", input);
        }

        zipOutput.close();

        System.out.println( output.getAbsolutePath()+"  Created!!");
    }

    public void zip(File input, File output,Date lastpack,HttpSession session)
            throws IOException
    {
        output.getParentFile().mkdirs();
        output.createNewFile();
        this.setZipfile(output.getName());
        ZipOutputStream zipOutput = new ZipOutputStream(new FileOutputStream(
                output));

        if (input.isDirectory())
        {
            addDirectory(zipOutput, "", input,lastpack,session);
        }
        else
        {
            addFile(zipOutput, "", input,session);
        }

        zipOutput.close();
        session.setAttribute("currentjob",output.getAbsolutePath()+"  Created!!");
        //System.out.println( output.getAbsolutePath()+"  Created!!");

    }


    /**
     * ѹ���ļ���
     *
     * @param zipOutput
     * @param path
     * @param input
     * @throws IOException
     */

    private  void addDirectory(ZipOutputStream zipOutput, String path,
            File input,Date lastpack)
            throws IOException
    {
        File[] subFiles = input.listFiles(new FileFilter()
        {
            public boolean accept(File pathname)
            {
                return true;
            }
        });


        for (int i = 0; i < subFiles.length; i++)
        {
            if (subFiles[i].isFile())
            {

            	 Date lastmodify=new Date(subFiles[i].lastModified());
            	 if(lastmodify.compareTo(lastpack)>=0&&
                    !subFiles[i].getName().equals(this.getZipfile())
                  && (subFiles[i].getName().indexOf("rar")<0)
                      && (subFiles[i].getName().indexOf("zip")<0)
                      &&(subFiles[i].getName().indexOf("dbupdate.properties")<0) )

            	addFile(zipOutput,
                        (path.trim().length() == 0 ? "" : path + "/")
                                + input.getName(), subFiles[i]);
            }
            else
            {
            	if(!subFiles[i].getName().equals("update")&&
                   (subFiles[i].getName().indexOf("searchindex")<0))
            	addDirectory(zipOutput, (path.trim().length() == 0 ? "" : path
                        + "/")
                        + input.getName(), subFiles[i],lastpack);


            }
           }
    }

    private  void addDirectory(ZipOutputStream zipOutput, String path,
               File input,Date lastpack,HttpSession session)
               throws IOException
       {
           File[] subFiles = input.listFiles(new FileFilter()
           {
               public boolean accept(File pathname)
               {
                   return true;
               }
           });


           for (int i = 0; i < subFiles.length; i++)
           {
               if (subFiles[i].isFile())
               {

                    Date lastmodify=new Date(subFiles[i].lastModified());
                    if(lastmodify.compareTo(lastpack)>=0&&
                       !subFiles[i].getName().equals(this.getZipfile())
                     && (subFiles[i].getName().indexOf("rar")<0)
                         && (subFiles[i].getName().indexOf("zip")<0)
                         &&(subFiles[i].getName().indexOf("dbupdate.properties")<0) )

                   addFile(zipOutput,
                           (path.trim().length() == 0 ? "" : path + "/")
                                   + input.getName(), subFiles[i],session);
               }
               else
               {
                   if(!subFiles[i].getName().equals("update")&&
                      (subFiles[i].getName().indexOf("searchindex")<0))
                   addDirectory(zipOutput, (path.trim().length() == 0 ? "" : path
                           + "/")
                           + input.getName(), subFiles[i],lastpack,session);


               }
              }
       }

    /**
     * ѹ���ļ�
     *
     * @param zipOutput
     * @param path
     * @param file
     * @throws IOException
     */
    private  void addFile(ZipOutputStream zipOutput, String path,
            File file)
            throws IOException
    {
        System.out.println("add " + file.getAbsolutePath());

        ZipEntry zipEntry = new ZipEntry((path.trim().length() == 0 ? "" : path
                + "/")
                + file.getName());
        zipEntry.setComment(file.getAbsolutePath());

        zipOutput.putNextEntry(zipEntry);

        FileInputStream ins = new FileInputStream(file);

        byte[] tmp = new byte[1024];
        int len = 0;

        while ((len = ins.read(tmp)) != -1)
        {
            zipOutput.write(tmp, 0, len);
        }
        ins.close();

        zipOutput.closeEntry();
    }
    private  void addFile(ZipOutputStream zipOutput, String path,
                File file,HttpSession session)
                throws IOException
        {
            //System.out.println("add " + file.getAbsolutePath());
            session.setAttribute("currentjob","Add File:" + file.getAbsolutePath());
            ZipEntry zipEntry = new ZipEntry((path.trim().length() == 0 ? "" : path
                    + "/")
                    + file.getName());
            zipEntry.setComment(file.getAbsolutePath());

            zipOutput.putNextEntry(zipEntry);

            FileInputStream ins = new FileInputStream(file);

            byte[] tmp = new byte[1024];
            int len = 0;

            while ((len = ins.read(tmp)) != -1)
            {
                zipOutput.write(tmp, 0, len);
            }
            ins.close();

            zipOutput.closeEntry();
    }
    /**
     * �ͷ��ļ�
     *
     * @param path
     * @param zipIns
     * @param zipEntry
     * @throws IOException
     */
    private void extractFile(File path, ZipInputStream zipIns,
            ZipEntry zipEntry)
            throws IOException
    {
        File file = new File(path, zipEntry.getName());

        file.getParentFile().mkdirs();
        System.out.println("extract:" + file.getAbsolutePath());

        FileOutputStream ous = new FileOutputStream(file);

        byte[] tmp = new byte[1024];
        int len = 0;

        while ((len = zipIns.read(tmp)) != -1)
        {
            ous.write(tmp, 0, len);
        }
        ous.close();
        zipIns.closeEntry();

    }

    /**
     * ��ѹ��
     *
     * @param input ѹ���ļ�
     * @param output ��ѹλ��
     * @throws IOException
     */
    public  void unzip(File input, File output)
            throws IOException
    {
        output.mkdir();

        ZipInputStream zipIns = new ZipInputStream(new FileInputStream(input));
        ZipEntry zipEntry = zipIns.getNextEntry();

        while (zipEntry != null)
        {
            extractFile(output, zipIns, zipEntry);

            zipEntry = zipIns.getNextEntry();
        }
        zipIns.close();
        System.out.println("unzip"+ input.getAbsolutePath());
    }

    /*public static void main(String[] args)
            throws IOException
    {
    	SimpleDateFormat dd=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
     	Date lastpack=new Date();
   	  try {
  		lastpack= dd.parse("2008-06-02 01:01:00");
  	} catch (ParseException e) {
  		e.printStackTrace();
  	}
  	   ZIPUtil zu=new ZIPUtil();
  	    zu.zip(new File("D:\\gxq\\C"), new File("c:\\workspace1.zip"),lastpack);

        zu.unzip(new File("c:\\workspace1.zip"), new File("c:\\"));
    }*/
}

