package tea.entity.node;

import java.io.*;
import java.sql.*;
import java.util.*;
import tea.db.*;
import tea.entity.*;
import tea.entity.convert.*;
import tea.resource.*;
import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.util.*;
import org.apache.poi.*;
import org.apache.poi.extractor.*;

public class Read
{
    public static void start() throws SQLException
    {
        if(Node.count(" AND type=41") < 1)
            return;
        new Thread()
        {
            public void run()
            {
                while(true)
                {
                    try
                    {
                        Thread.sleep(60000);
                        ArrayList al = new ArrayList();
                        DbAdapter db = new DbAdapter();
                        try
                        {
                            db.executeQuery("SELECT node,language FROM Files WHERE pconv=1 AND pcount=0",0,100);
                            while(db.next())
                            {
                                al.add(new int[]
                                       {db.getInt(1),db.getInt(2)});
                            }
                        } finally
                        {
                            db.close();
                        }
                        Iterator it = al.iterator();
                        if(!it.hasNext())
                            continue;
                        while(it.hasNext())
                        {
                            int[] arr = (int[]) it.next();
                            Files t = Files.find(arr[0],arr[1]);
                            File f = new File(Common.REAL_PATH + t.getNamepath());
                            try
                            {
                                Node n = Node.find(arr[0]);
                                System.out.println("节点号：" + n._nNode + " 文件：" + f.getPath());
                                File d = new File(Common.REAL_PATH + "res/" + n.getCommunity() + "/read/" + (n._nNode / 2000) + "-" + arr[1] + "/" + n._nNode + "-" + t.getCode() + ".swf");
                                Swf s = new Swf(f);
                                s.outline = t.outline;
                                s.start(d);
                                String ext = f.getName();
                                ext = ext.substring(ext.lastIndexOf('.') + 1).toLowerCase();
                                //bcprov-jdk15-146.jar, fontbox-1.5.0.jar, pdfbox-1.5.0.jar
                                if("pdf".equals(ext))
                                {
                                    try
                                    {
                                        PDDocument pd = PDDocument.load(f);
                                        PDFTextStripper ts = new PDFTextStripper();
                                        t.ptext = ts.getText(pd);
                                        pd.close();
                                    } catch(NoClassDefFoundError ex)
                                    {
                                        //加密的pdf 要用到org/apache/commons/logging/LogFactory类
                                        //ex.printStackTrace();
                                    }
                                } else if("|doc|docx|dot|dotx|rtf|txt|wps||ppt|pptx|pot|potx|pps|ppsx|dps|".indexOf(ext) != -1)
                                {
                                    if("txt".equals(ext))
                                    {
                                        byte[] by = Filex.read(f.getPath());
                                        t.ptext = new String(by,by.length > 2 && by[0] == -17 && by[1] == -69 && by[2] == -65 ? "UTF-8" : "GBK");
                                    } else
                                    {
                                        POITextExtractor te = ExtractorFactory.createExtractor(f);
                                        t.ptext = te.getText();
                                    }
                                }
                                t.pcount = 1;
                            } catch(Exception ex)
                            {
                                t.pcount = -1;
                                ex.printStackTrace();
                            }
                            t.set();
                            System.out.println("页数：" + t.pcount + " 大小：" + t.pheight);
                        }
//旧的在线阅读文档
//                        Office o = Office.getInstance();
//                        while(it.hasNext())
//                        {
//                            int[] arr = (int[]) it.next();
//                            Files t = Files.find(arr[0],arr[1]);
//                            File f = new File(Common.REAL_PATH + t.getNamepath());
//                            if(!f.exists())
//                            {
//                                t.pcount = -1;
//                                t.set();
//                                continue;
//                            }
//                            Node n = Node.find(arr[0]);
//                            System.out.println("节点号：" + n._nNode + " 文件：" + f.getPath());
//                            File d = new File(Common.REAL_PATH + "res/" + n.getCommunity() + "/read/" + (n._nNode / 2000) + "-" + arr[1] + "/" + n._nNode);
//                            d.mkdirs();
//                            String ext = f.getName();
//                            ext = ext.substring(ext.lastIndexOf('.') + 1).toLowerCase();
//                            //bcprov-jdk15-146.jar, fontbox-1.5.0.jar, pdfbox-1.5.0.jar
//                            if("pdf".equals(ext))
//                            {
//                                try
//                                {
//                                    PDDocument pd = PDDocument.load(f);
//                                    PDFTextStripper ts = new PDFTextStripper();
//                                    t.ptext = ts.getText(pd);
//                                    pd.close();
//                                } catch(NoClassDefFoundError ex)
//                                {
//                                    //加密的pdf 要用到org/apache/commons/logging/LogFactory类
//                                    //ex.printStackTrace();
//                                }
//                                Gs g = new Gs(f);
//                                g.start(d);
//                            } else if("|doc|docx|dot|dotx|rtf|txt|wps||ppt|pptx|pot|potx|pps|ppsx|dps|".indexOf(ext) != -1)
//                            {
//                                if("txt".equals(ext))
//                                {
//                                    byte[] by = Filex.read(f.getPath());
//                                    t.ptext = new String(by,by.length > 2 && by[0] == -17 && by[1] == -69 && by[2] == -65 ? "UTF-8" : "GBK");
//                                } else
//                                {
//                                    POITextExtractor te = ExtractorFactory.createExtractor(f);
//                                    t.ptext = te.getText();
//                                }
//                                o.start(f.getCanonicalPath(),d.getCanonicalPath() + ".jpg");
//                            }
//                            File[] fs = d.listFiles();
//                            if("pdf".equals(ext))
//                                for(int i = 0;i < fs.length;i++)
//                                {
//                                    fs[i] = new File(d,i + ".jpg"); //只有一页是，没有此句，获取宽高不对。
//                                    Img img = new Img(new File(d,(i + 1) + ".jpg"));
//                                    img.density = 192;
//                                    img.resize = 64;
//                                    img.start(fs[i]);
//                                }
//                            t.pcount = fs.length == 0 ? -1 : fs.length;
//                            Img img = new Img(fs[0]);
//                            img.init();
//                            t.pwidth = img.width;
//                            t.pheight = img.height;
//                            t.set();
//                            System.out.println("页数：" + t.pcount + " 大小：" + t.pwidth + "x" + t.pheight);
//                        }
//                        o.close();
                    } catch(Exception ex)
                    {
                        ex.printStackTrace();
                    }
                }
            }
        }.start();
    }
}
