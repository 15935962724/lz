package tea;

import java.awt.geom.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.awt.event.*;
import java.awt.*;
import javax.swing.*;

import java.awt.print.*;
import java.io.*;
import javax.imageio.ImageIO;

public class ShapesPrint extends JPanel //继承jpanel   shapesparint本身是个panel   
		implements Printable, ActionListener {
	final static JButton button = new JButton("Print");
    private int PAGES = 0;
    private String printStr;
    private String printStr2;
   


	public ShapesPrint() { //构造函数中添加按扭事件   
		
		
		button.addActionListener(this);
		System.out.println("this+++++++++++++++++++++++++++" + this.getSize());
	}

	public void actionPerformed(ActionEvent e) { //在ActionListener中重载actionPerformed方法   
		if (e.getSource() instanceof JButton) {
			PrinterJob printJob = PrinterJob.getPrinterJob();
			printJob.setPrintable(this); //继承Printable   传this     
			if (printJob.printDialog()) { //显示打印对话框   
				try {
					printJob.print(); //执行打印     
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}

	//重载print方法，实现具体打印   
	public int print(Graphics g, PageFormat pf, int pi) throws PrinterException {
		if (pi >= 1) {
			return Printable.NO_SUCH_PAGE;
		}
		drawShapes((Graphics2D) g);//二维码
		
		
		return Printable.PAGE_EXISTS;
	}
	public void paintComponent(Graphics g) //panel当中的方法，画图应该在他当中实现   
	{
		super.paintComponent(g);
		Graphics2D g2 = (Graphics2D) g; //把Graphics强制转化为Graphics2D丛而实现2D方法   
		drawShapes(g2);
		printTextAction(printStr,g2);
		System.out.println("printStr:"+printStr);
	}
	public void drawShapes(Graphics2D g2) { //实现具体画法   
		int x = 98;
		int y = 98;
		try //读取文件   
		{
			g2.drawImage(ImageIO.read(new FileInputStream(new File("D:\\QRCodeTest\\123.jpg"))),98,98,84,98,Color.black, this);
		} catch (Exception e) {
			if (e.getClass().getName().compareTo(
					"java.io.FileNotFound   Exception") == 0)
				g2.drawString("文件不存在", x, y);
			else
				g2.drawString("读取错误", x, y);
		}
	}
	
	  public void printTextAction(String s,Graphics2D g2)
	    { 
	        printStr = "时间 DATE:";//area.getText().trim();
	        printStr2="地点   ADD:";
	        if (printStr != null && printStr.length() > 0)
	        { 
	        	System.out.print("--文件读取--");
	            
	        	
	        	Font theFont = new Font(printStr, Font.BOLD, 20);
	        	
	            g2.setFont(theFont);
	            PageFormat pageFormat =new PageFormat();
	            
	            g2.drawString(printStr, 100,20);
	            g2.drawString(printStr2,100,40);
	            
	            pageFormat.setOrientation(PageFormat.LANDSCAPE);// // 创建横向格式
	            Paper paper=new Paper();
	            paper.setSize(227,567);
	            
	            paper.setImageableArea(0,0,227,567);//设置此 Paper 的可成像区域。可成像区域是页面上用来打印的区域。
	            
	            pageFormat.setPaper(paper);      //为PageFormat对象设置Paper对象。//将该纸张作为格式 */ 
	            
	      
	        }
	        else
	        {
	            JOptionPane.showConfirmDialog(null, "Sorry, Printer Job is Empty, Print Cancelled!", "Empty"
	                                        , JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE);
	        }
	    }
 


	/*public static void main(String s[]) {
		
		WindowListener l = new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				System.exit(0);
			}

			public void windowClosed(WindowEvent e) {
				System.exit(0);
			}
		};
		
		JFrame f = new JFrame();
		f.addWindowListener(l);
		JPanel panel = new JPanel();
		panel.add(button);
		f.getContentPane().add(BorderLayout.SOUTH, panel);
		JScrollPane scrollPane = new JScrollPane(new ShapesPrint());
		scrollPane.setPreferredSize(new Dimension(222, 222));
		f.getContentPane().add(scrollPane, BorderLayout.CENTER);
		f.setSize(580, 600);
		f.setLocation(150, 100);
		f.show();

		System.out.println("panel++++++++++++++++++++++++++" + panel.getSize());

		System.out.println("f++++++++++++++++++++++++++++++" + f.getSize());
	}*/

}
