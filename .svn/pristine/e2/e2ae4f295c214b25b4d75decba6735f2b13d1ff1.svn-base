package tea.entity.util;

import java.io.*;
import tea.resource.*;

public class HtmlConvert
{
  private int ex; //0:word
  private String url;
  private File file;
  private byte by[];
  public HtmlConvert(String url, int ex)
  {
    this.url = url;
    this.ex = ex;
    load();
  }

  public static HtmlConvert find(String url, int ex)
  {
    return new HtmlConvert(url, ex);
  }

  private void load()
  {
    Runtime r = Runtime.getRuntime();
    try
    {
      if (ex == 0)
      {
        file = File.createTempFile("hc_", ".tmp");
        String cmd = "\"" + new File(Common.REAL_PATH + "/WEB-INF/lib/OfficeConvert").getAbsolutePath() + "\" 0 \"" + url + "\" \"" + file.getAbsolutePath() + "\"";
        System.out.println(cmd);
        Process p = r.exec(cmd);
        for (int i = 0; i < 10 && file.length() < 10240L; i++)
        {
          Thread.sleep(2000L);
          System.out.println(i + ":" + file.length());
        }
        Thread.sleep(5000L);
        p.destroy();
      }
      System.out.println("OK");
      if (file.exists())
      {
        FileInputStream fis = new FileInputStream(file);
        by = new byte[ (int) file.length()];
        fis.read(by);
        fis.close();
        //file.delete();
      }
    } catch (Exception e)
    {
      System.err.print(e.toString());
    }
  }

  public String getUrl()
  {
    return url;
  }

  public File getFile()
  {
    return file;
  }

  public byte[] getByte()
  {
    return by;
  }
}
