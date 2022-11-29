package tea.applet;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import java.util.Properties;
import java.awt.font.FontRenderContext;
import java.awt.print.*;

import tea.applet.SystemProperties;

import javax.imageio.ImageIO;
import javax.print.*;
import javax.print.attribute.*;
import java.io.*;
import java.awt.geom.*;
import java.awt.image.ImageObserver;

public class PrintTest
implements ActionListener, Printable
{


    private JTextArea area = new JTextArea();


    private int PAGES = 0;
    private String printPerformname;//演出标题
    private String printPstime;//演出时间
    private String printPsname;//演出地点
    private String printRegion;//座位
    private String printPeice;//票价
    private String printUrl;//打印二维码路径
    //实现Printable print 接口
    public int print(Graphics g, PageFormat pf, int page) throws PrinterException
	{

    	Graphics2D g2 = (Graphics2D)g;
        g2.setPaint(Color.black);
	   // if (page >= PAGES)
	     //   return Printable.NO_SUCH_PAGE;
        if (page >= 1) {
			return Printable.NO_SUCH_PAGE;
		}
        g2.translate(pf.getImageableX(), pf.getImageableY());
        printStrprintPerformname((Graphics2D) g,printPerformname);//演出标题
        printStrprintPstime((Graphics2D) g,printPstime);//演出时间
        printStrprintPsname((Graphics2D) g,printPsname);//演出地点
        printStrprintRegion((Graphics2D) g,printRegion);//演出座位
        printStrprintPeice((Graphics2D) g,printPeice);//演出票价
        drawShapes((Graphics2D) g,printUrl);//打印二维码
        return Printable.PAGE_EXISTS;
	}

    //实现打印动作按钮监听，并完成具体的打印操作

    public void printTextAction(String s1,String s2,String s3,String s4,String s5,String url)
    {
    	printPerformname = s1;//演出标题;//area.getText().trim();
    	printPstime=s2;//演出时间
        printPsname=s3;//演出地点
        printRegion=s4;//座位
        printPeice=s5;//票价
        printUrl=url;
        if (printPerformname != null && printPerformname.length() > 0)
        {
        	System.out.println("--开始打印--");

            PrinterJob myPrtJob = PrinterJob.getPrinterJob();
            PageFormat pageFormat = myPrtJob.defaultPage();
            pageFormat.setOrientation(PageFormat.LANDSCAPE);// // 创建横向格式
            Paper paper=new Paper();
            paper.setSize(227,552);
            paper.setImageableArea(0,0,227,552);//设置此 Paper 的可成像区域。可成像区域是页面上用来打印的区域。567-200 552-195
            pageFormat.setPaper(paper);      //为PageFormat对象设置Paper对象。//将该纸张作为格式 */
           // pf.setPrintPageFormat(pageFormat);    //设置打印纸张的页面设置
            myPrtJob.setPrintable(this, pageFormat);
          //  if (myPrtJob.printDialog())
         //   {
               try
                {
                   myPrtJob.print();
               }
                catch(PrinterException pe)
               {
                  pe.printStackTrace();
              }
          //  }
        }
        else
        {
            JOptionPane.showConfirmDialog(null, "Sorry, Printer Job is Empty, Print Cancelled!", "Empty"
                                        , JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE);
        }
    }

    public void printStrprintPstime(Graphics2D g2,String printPstime)//演出时间
    {
    	 g2.drawString(printPstime,114,93);
    }
    public void printStrprintPsname(Graphics2D g2,String printPsname)//演出地点
    {
    	 g2.drawString(printPsname,114,116);
    }
    public void printStrprintRegion(Graphics2D g2,String printRegion)//演出座位
    {
    	 g2.drawString(printRegion,114,139);
    }
    public void printStrprintPeice(Graphics2D g2,String printPeice)//演出票价
    {
    	g2.drawString(printPeice,114,162);
    }
    public void printStrprintPerformname(Graphics2D g2,String printPerformname)//演出标题
    {
    	 Font theFont = new Font(printPerformname, Font.BOLD, 14);
         g2.setFont(theFont);

    	 g2.drawString(printPerformname,170,70);

    	 Font theFont2 = new Font(printPerformname, Font.BOLD, 12);
         g2.setFont(theFont2);

    }
  
    public void drawShapes(Graphics2D g2,String url) { //打印二维码
    	  //打印起点坐标
        int x =369;
        int y =110;
		try //读取文件
		{ 
		
			boolean b=false;  
			 //实例化url   
		    java.net.URL imgurl = new java.net.URL(url);   
		    java.net.HttpURLConnection   httpUrl  = ( java.net.HttpURLConnection) imgurl.openConnection();
		               httpUrl.connect();
		    InputStream inStream = httpUrl.getInputStream();
           //载入图片到输入流   
           java.io.BufferedInputStream bis = new BufferedInputStream(imgurl.openStream());   

           //实例化存储字节数组   
           byte[] bytes = new byte[100];   
           //设置写入路径以及图片名称   
          url = url.substring(url.lastIndexOf("/"), url.length()); 
      
          
       /*  //判断客户端是否有这个目录
          File d=new File("c:\\QRCodeImg\\");//建立代表Sub目录的File对象，并得到它的一个引用 
          if(d.exists()){//检查Sub目录是否存在 
            d.delete(); 
           // System.out.println("c:\\QRCodeImg\\目录存在，已删除"); 
            d.mkdir();//建立Sub目录 
            File f1=new File("c:\\QRCodeImg\\",url); 
	        System.out.println("先删除文件夹QRCodeImg 在去创建文件夹QRCodeImg 已经创建文件："+url); 
          }else{ 
        	d.mkdir();//建立Sub目录 
        	File f2=new File("c:\\QRCodeImg\\",url); 
  	        System.out.println("c:\\QRCodeImg\\，已建立目录和文件："+url); 
          } 
         
           OutputStream bos = new FileOutputStream(new File("c:\\QRCodeImg\\453.jpg"));   
           int len;   
           while ((len = bis.read(bytes)) > 0) {   
               bos.write(bytes, 0, len);   
           }
           bis.close();   
           bos.flush();   
           bos.close();   
           //关闭输出流   
           b=true;    
       //} catch (Exception e) {   
           //如果图片未找到    
        
      // }   */
    
      System.out.println(new FileInputStream(new File("c:\\QRCodeImg\\453.jpg")).hashCode());
      System.out.println(inStream.toString().hashCode());
			g2.drawImage(ImageIO.read(inStream),x, y,70,70,null);
       //System.out.println("img_Height="+img_Height+"img_width="+img_width) ;
		} catch (Exception e) {
			if (e.getClass().getName().compareTo("java.io.FileNotFound   Exception") == 0)
			{
				g2.drawString("文件不存在", x, y);
			System.out.println("文件不存在");
			}else{
				g2.drawString("读取错误", x, y);
			System.out.println("读取错误");
			}
		}
	} 
     public static void main(String[] args)
    {
    	PrintTest pobj = new PrintTest();
    //	String string  ="中国国家话剧院\n\n时间DATE:2009年11月01日09时30分\n\n地址：ADD:梅兰芳大剧院\n\n座位:SEAT:1层楼座8排98号\n\n票价PEICE:800.00元";
    	//pobj.drawShapes("http://zhangjinshu:8080/res/REDCOME/QRCodeImg/453.jpg");
    	for(int i = 1;i<2;i++){
    	pobj.printTextAction("中国国家话剧院","时间DATE:2009年11月01日09时30分","地址：ADD:梅兰芳大剧院","座位:SEAT:1层楼座8排98号","票价PEICE:800.00元","http://zhangjinshu:8080/res/REDCOME/QRCodeImg/453.jpg");
    	}
    	//printTextAction
    }
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub

	}
}

