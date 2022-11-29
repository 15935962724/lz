package tea;

import java.awt.BasicStroke; 
import java.awt.Color; 
import java.awt.Component; 
import java.awt.Font; 
import java.awt.Graphics; 
import java.awt.Graphics2D; 
import java.awt.Image; 
import java.awt.Toolkit; 
import java.awt.RenderingHints; 
import java.awt.font.FontRenderContext; 
import java.awt.font.LineBreakMeasurer; 
import java.awt.font.TextAttribute; 
import java.awt.font.TextLayout; 
import java.awt.geom.Point2D; 
import java.awt.image.BufferedImage; 
import java.awt.print.Book; 
import java.awt.print.PageFormat; 
import java.awt.print.Paper; 
import java.awt.print.Printable; 
import java.awt.print.PrinterException; 
import java.awt.print.PrinterJob; 
import java.text.AttributedString; 
import javax.swing.JApplet; 


public class Ptxst implements Printable 
{ 
	/** */ 
	/** 
	* @param Graphic指明打印的图形环境 
	* @param PageFormat指明打印页格式（页面大小以点为计量单位，1点为1英才的1/72，1英寸为25.4毫米。A4纸大致为595×842点） 
	* @param pageIndex指明页号 
	**/ 
	  private int PAGES = 0;
	  private String printStr;
	public int print(Graphics gra, PageFormat pf, int pageIndex) throws PrinterException 
	{ 
		System.out.println("pageIndex=" + pageIndex); 
		Component c = null; 
		//print string 
		String str=null;
		try {
			str = this.getString();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//"中华民族是勤劳、勇敢和富有智慧的伟大民族。"; 
		//转换成Graphics2D 
		Graphics2D g2 = (Graphics2D) gra; 
		//设置打印颜色为黑色 
		g2.setColor(Color.red); //黑色black
		/**/ 
		Paper paper = pf.getPaper();//得到页面格式的纸张 
		paper.setSize(500,500);//纸张大小 
		paper.setImageableArea(0,0,500,500); //设置打印区域的大小 
		System.out.println(paper.getWidth()); 
		System.out.println(paper.getHeight()); 
		pf.setPaper(paper);//将该纸张作为格式 */ 
		//打印起点坐标 
		double x = pf.getImageableX(); 
		double y = pf.getImageableY(); 
		switch (pageIndex) 
		{
			case 0:   
			//设置打印字体（字体名称、样式和点大小）（字体名称可以是物理或者逻辑名称） 
			//Java平台所定义的五种字体系列：Serif、SansSerif、Monospaced、Dialog 和 DialogInput 
			Font font = new Font("新宋体", Font.PLAIN,15); 
			g2.setFont(font); //设置字体 
			//BasicStroke bs_3=new BasicStroke(0.5f); 
			float[] dash1 = {4.0f}; 
			//设置打印线的属性。 
			//1.线宽 2、3、不知道，4、空白的宽度，5、虚线的宽度，6、偏移量 
			g2.setStroke(new BasicStroke(0.5f, BasicStroke.CAP_BUTT,BasicStroke.JOIN_MITER, 4.0f, dash1, 0.0f)); 
			 
			float heigth = font.getSize2D(); //字体高度 
			System.out.println("x=" + x);
			System.out.println("y=" + y);
			x = 0;
			//使用抗锯齿模式完成文本呈现 
			/**/ 
			/*g2.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, 
			RenderingHints.VALUE_TEXT_ANTIALIAS_ON);*/ 
			// -1- 用Graphics2D直接输出 
			//首字符的基线(右下部)位于用户空间中的 (x, y) 位置处 
			//g2.drawLine(10,10,200,10); 
		/*
			Image src = Toolkit.getDefaultToolkit().getImage("d://logo.gif"); 
			g2.drawImage(src, (int) x, (int) y, c); 
			int img_Height = src.getHeight(c); 
			int img_width = src.getWidth(c); 
			//System.out.println("img_Height="+img_Height+"img_width="+img_width) ; 
			g2.drawString(str, (float) x, (float) y + 1 * heigth + img_Height); 
			g2.drawLine((int) x, (int) (y + 1 * heigth + img_Height + 10), 
			(int) x + 200, (int) (y + 1 * heigth + img_Height + 10)); 
			g2.drawImage(src, (int) x, (int) (y + 1 * heigth + img_Height + 11), c); 
		*/
			// -2- 直接构造TextLayout打印 
			/**/ 
			FontRenderContext frc = g2.getFontRenderContext(); 
			TextLayout layout = new TextLayout(str, font, frc); 
			layout.draw(g2, (float)x, (float)y+2*heigth);
			
			// -3- 用LineBreakMeasurer进行打印 
			/**/ 
			/*AttributedString text = new AttributedString(str); 
			text.addAttribute(TextAttribute.FONT, font); 
			LineBreakMeasurer lineBreaker = new LineBreakMeasurer(text.getIterator(), frc); 
			//每行字符显示长度(点) 
			double width = pf.getImageableWidth(); 
			//首字符的基线位于用户空间中的 (x, y) 位置处 
			Point2D.Double pen = new Point2D.Double (100, y+3*heigth); 
			while ( (layout = lineBreaker.nextLayout( (float) width)) != null){ 
			layout.draw(g2, (float)x, (float) pen.y); 
			pen.y += layout.getAscent(); 
			}*/ 
			return PAGE_EXISTS; 
			default: 
			return NO_SUCH_PAGE; 
		}  
	} 
	public String getString()throws Exception
	{
		String string = "请尽快选座订购，以免您需要的座位被其他人抢先订购请尽快选座订购，以免您需要的座位被其他人抢先订购";
		return string;
	}
	
	//public static void  isPrint() 
	//{
	/*public static void main(String[] args) { 
	//获取打印服务对象 
		boolean  f= false;
		PrinterJob job = PrinterJob.getPrinterJob(); 
		PageFormat pageFormat = job.defaultPage(); //得到默认页格式 
			 
		job.setPrintable(new PrintTest()); //设置打印类 
		try { 
		//可以用printDialog显示打印对话框，在用户确认后打印；也可以直接打印 
		//boolean a=job.printDialog(); 
		//if(a) 
		//{ 
			//for(int i =0;i<2;i++)
			//{
				job.print(); 
			//	System.out.print(i);
			//}
		       
		
		//}
			
		} catch (PrinterException e) { 
		   e.printStackTrace(); 
		} 
	} */
} 

 

