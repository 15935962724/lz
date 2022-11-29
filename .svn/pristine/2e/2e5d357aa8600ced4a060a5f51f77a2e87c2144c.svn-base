package tea.applet;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import javax.swing.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.awt.font.FontRenderContext;
import java.awt.print.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.*;
import javax.imageio.ImageIO;
import javax.print.*;
import javax.print.attribute.*;
import java.io.*;
import java.awt.geom.*;
import java.awt.image.ImageObserver;

public class PrintApplet  extends Applet
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
    //副券中的时间，地点
    private String printShijian;//时间
    private String printDidian;//地点
    //票种
    private String printVotename;
    //编号
    private String printBianhao;
    //提示信息
    private String printPrompt;
    private String printPrompt2;

    //applet 启动方法
    public void init()
	{
 	   System.out.println("打印程序启动，等待数据输入....");
    }

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
		   printStrprintBianhao2((Graphics2D) g, printBianhao);//编号


	     printStrprintShijian((Graphics2D) g, printShijian);//时间
	     printStrprintDidian((Graphics2D) g, printDidian);//地点
	   printStrprintBianhao((Graphics2D) g, printBianhao);//编号
	     printStrprintPrompt((Graphics2D) g, printPrompt);//提示信息
	     printStrprintPrompt2((Graphics2D) g, printPrompt2);//提示信息

	     if(printVotename!=null && printVotename.length()>0)
		 {
             printStrprintVotename((Graphics2D) g,printVotename); //票种
		 }

        return Printable.PAGE_EXISTS;
	}

    //实现打印动作按钮监听，并完成具体的打印操作

    public  void printTextAction(String s1,String s2,String s3,String s4,String s5,String url,String s6,String s7,String s8,String s9,String s10,String s11)
    {
    	printPerformname = s1;//演出标题;//area.getText().trim();
    	printPstime=s2;//演出时间
        printPsname=s3;//演出地点
        printRegion=s4;//座位
        printPeice=s5;//票价
        printUrl=url;//二维码信息
        //副券中的时间，地点
        printShijian=s6;//时间
        printDidian=s7;//地点
        //票种
        printVotename=s8;
        //编号
         printBianhao=s9;
        //提示信息
        printPrompt=s10;
        printPrompt2=s11;
        if (printPerformname != null && printPerformname.length() > 0)
        {
        	System.out.println("--开始打印,调用方法printTextAction--");

            PrinterJob myPrtJob = PrinterJob.getPrinterJob();
            PageFormat pageFormat = myPrtJob.defaultPage();
            pageFormat.setOrientation(PageFormat.LANDSCAPE);// // 创建横向格式
            Paper paper=new Paper();
            paper.setSize(227,552);
            paper.setImageableArea(0,0,227,552);//设置此 Paper 的可成像区域。可成像区域是页面上用来打印的区域。567-200 552-195
            pageFormat.setPaper(paper);      //为PageFormat对象设置Paper对象。//将该纸张作为格式 */
           // pf.setPrintPageFormat(pageFormat);    //设置打印纸张的页面设置
            myPrtJob.setPrintable(this, pageFormat);
            //if (myPrtJob.printDialog())
            //{
                try
                {
                    myPrtJob.print();
                }
                catch(PrinterException pe)
                {
                    pe.printStackTrace();
                }
           // }
        }
        else
        {
            JOptionPane.showConfirmDialog(null, "Sorry, Printer Job is Empty, Print Cancelled!", "Empty"
                                        , JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE);
        }
    }

    public void printStrprintPstime(Graphics2D g2,String printPstime)//演出时间
    {
    	 g2.drawString(printPstime,141,85);
		  System.out.println("演出时间："+printPstime);
    }
    public void printStrprintPsname(Graphics2D g2,String printPsname)//演出地点
    {
    	 g2.drawString(printPsname,141,108);
		  System.out.println("演出地点："+printPsname);
    }
    public void printStrprintRegion(Graphics2D g2,String printRegion)//演出座位
    {
    	 g2.drawString(printRegion,141,131);
		  System.out.println("演出座位："+printRegion);
    }
    public void printStrprintPeice(Graphics2D g2,String printPeice)//演出票价
    {
    	g2.drawString(printPeice,141,154);
		 System.out.println("演出票价："+printPeice);
    }
    public void printStrprintVotename(Graphics2D g2,String printVotename)////票种
    {
    	g2.drawString(printVotename,311,154);
        System.out.println("票种："+printVotename);
    }
    public void printStrprintBianhao2(Graphics2D g2,String printBianhao)///  //编号
    {
    	g2.drawString(printBianhao,141,184);
		System.out.println("编号："+printBianhao);
    }
    public void printStrprintPrompt(Graphics2D g2,String printPrompt)///     //提示信息
    {
    	g2.drawString(printPrompt,226,184);
		System.out.println("提示信息.1："+printPrompt);
    }
    public void printStrprintPrompt2(Graphics2D g2,String printPrompt2)///     //提示信息
    {
    	g2.drawString(printPrompt2,271,184);
		System.out.println("提示信息.2："+printPrompt2);
    }
    public void printStrprintPerformname(Graphics2D g2,String printPerformname)//演出标题
    {
    	 Font theFont = new Font(printPerformname, Font.BOLD, 14);
         g2.setFont(theFont);

    	 g2.drawString(printPerformname,141,60);

    	 Font theFont2 = new Font(printPerformname, Font.BOLD, 12);
         g2.setFont(theFont2);
		 System.out.println("演出标题："+printPerformname);
    }
    public void drawShapes(Graphics2D g2,String url)  //打印二维码
    {
    	  //打印起点坐标
        int x =14;
        int y =113;
		try //读取文件
		{
			System.out.println("二维码URL："+url);
			 //实例化url
		    java.net.URL imgurl = new java.net.URL(url);
		    java.net.HttpURLConnection   httpUrl  = ( java.net.HttpURLConnection) imgurl.openConnection();
		    httpUrl.connect();
		    InputStream inStream = httpUrl.getInputStream();
			g2.drawImage(ImageIO.read(inStream),x, y,79,79,null);
		} catch (Exception e) {
			if (e.getClass().getName().compareTo("java.io.FileNotFound   Exception") == 0)
				g2.drawString("文件不存在", x, y);
			else
				g2.drawString("读取错误", x, y);
		}
	}

    public void printStrprintBianhao(Graphics2D g2,String printBianhao) ///  //副券编号
    {
        g2.drawString(printBianhao,438,135);
        System.out.println("副券编号：" + printBianhao);
    }

    public void printStrprintShijian(Graphics2D g2,String printShijian)//副券时间
    {
		Font font = new Font(printShijian, Font.PLAIN, 10);
        g2.setFont(font);//设置字体
    	g2.drawString(printShijian,438,85);
		System.out.println("副券时间："+printShijian);
    }
    public void printStrprintDidian(Graphics2D g2,String printDidian)//副券地点
    {
		Font font = new Font(printDidian, Font.PLAIN, 10);
        g2.setFont(font);//设置字体
    	g2.drawString(printDidian,438,108);
		System.out.println("副券地点："+printDidian);
    }



     //客户端调用方法 现场出票方法
    public  void  openPrintApplet(final String ip,final String sp)
	{
    	try{

    	    HttpURLConnection conn = (HttpURLConnection)new URL("http://"+ip+"/servlet/EditPerformOrders"+sp).openConnection();

             ObjectInputStream ois = new ObjectInputStream(conn.getInputStream());

             final  HashMap m = (HashMap) ois.readObject();
             ois.close();

         AccessController.doPrivileged( new  PrivilegedAction()   {
             public  Object run()   {
            	 ArrayList al = (ArrayList) m.get("performorders");
            	 for(int i = 0;i < al.size();i++)
                 {
            		 //printTextAction(s1,s2,s3, s4,s5, url);
					 System.out.println("开始启动:ArrayList:"+i);
            		 HashMap p_m = (HashMap) al.get(i);

//					 System.out.println((String)p_m.get("performorders.performname"));
//					 System.out.println((String)p_m.get("performorders.pstime"));
//					 System.out.println((String)p_m.get("performorders.psname"));
//					 System.out.println((String)p_m.get("performorders.region"));
//				     System.out.println((String)p_m.get("performorders.peice"));
//					 System.out.println((String) p_m.get("performorders.url"));

            			 printTextAction((String)p_m.get("performorders.performname"),(String)p_m.get("performorders.pstime"),
            					 (String)p_m.get("performorders.psname"), (String)p_m.get("performorders.region"),(String)p_m.get("performorders.peice"),
            					 (String) p_m.get("performorders.url"),(String)p_m.get("performorders.shijian"),(String)p_m.get("performorders.didian"),(String)p_m.get("performorders.votename"),
            					 (String)p_m.get("performorders.bianhao"),(String)p_m.get("performorders.prompt"),(String)p_m.get("performorders.prompt2"));

                 }
				 //
				   al.clear();
	               m.clear();
                return   null ;
           }
       } );
    	}catch (Exception e) {
			// TODO: handle exception
		}
   }
     public static void main(String[] args)
    {
    	//PrintTest pobj = new PrintTest();
    	//String string  ="中国国家话剧院\n\n时间DATE:2009年11月01日09时30分\n\n地址：ADD:梅兰芳大剧院\n\n座位:SEAT:1层楼座8排98号\n\n票价PEICE:800.00元";

    	//pobj.printTextAction("东方红---武警文工团大型交响合唱音乐会","时间   DATE:   2009年12月01日20时05分","地点    ADD:   梅兰芳剧院","座位   SEAT:   池座   1排   120座","PEICE:   800.00元","http://zhangjinshu:8080//servlet/QRCodeImg?content=561-1-120-2009-12-01+20%3A05%3A00&size=120","2009年12月01日20时05分","梅兰芳剧院");
    	//printTextAction
    }
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub

	}
}





