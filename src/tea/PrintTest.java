package tea;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.Properties;
import java.awt.font.FontRenderContext;
import java.awt.print.*;
import tea.SystemProperties;
import javax.print.*;
import javax.print.attribute.*;
import java.io.*;

public class PrintTest extends JFrame
implements ActionListener, Printable
{
	private JButton printTextButton = new JButton("Print Text");
    private JButton previewButton = new JButton("Print Preview");
	private JButton printText2Button = new JButton("Print Text2");
	private JButton printFileButton = new JButton("Print File");
    private JButton printFrameButton = new JButton("Print Frame");
    private JButton exitButton = new JButton("Exit");
    private JLabel tipLabel = new JLabel("");
    private JTextArea area = new JTextArea();
    private JScrollPane scroll = new JScrollPane(area);
    private JPanel buttonPanel = new JPanel();

    private int PAGES = 0;
    private String printStr;

    public PrintTest()
    {
        this.setTitle("Print Test");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setBounds((int)((SystemProperties.SCREEN_WIDTH - 800) / 2), (int)((SystemProperties.SCREEN_HEIGHT - 600) / 2), 800, 600);
        initLayout();
    }

    private void initLayout()
    {
        this.getContentPane().setLayout(new BorderLayout());
        this.getContentPane().add(scroll, BorderLayout.CENTER);
        printTextButton.setMnemonic('P');
        printTextButton.addActionListener(this);
        buttonPanel.add(printTextButton);
        previewButton.setMnemonic('v');
        previewButton.addActionListener(this);
        buttonPanel.add(previewButton);
        printText2Button.setMnemonic('e');
        printText2Button.addActionListener(this);
        buttonPanel.add(printText2Button);
        printFileButton.setMnemonic('i');
        printFileButton.addActionListener(this);
        buttonPanel.add(printFileButton);
        printFrameButton.setMnemonic('F');
        printFrameButton.addActionListener(this);
        buttonPanel.add(printFrameButton);
        exitButton.setMnemonic('x');
        exitButton.addActionListener(this);
        buttonPanel.add(exitButton);
        this.getContentPane().add(buttonPanel, BorderLayout.SOUTH);
    }

    public void actionPerformed(ActionEvent evt)
    {
        Object src = evt.getSource();
        if (src == printTextButton)
            printTextAction();
        else if (src == previewButton)
            previewAction();
        else if (src == printText2Button)
            printText2Action();
      
        else if (src == printFrameButton)
            printFrameAction();
        else if (src == exitButton)
            exitApp();
    }
 
    public int print(Graphics g, PageFormat pf, int page) throws PrinterException
	{
        Graphics2D g2 = (Graphics2D)g;
        g2.setPaint(Color.black);
	    if (page >= PAGES)
	        return Printable.NO_SUCH_PAGE;
	    
	    Paper paper = pf.getPaper();//??????????????????????????? 
		//paper.setSize(80,80);//???????????? 
		paper.setImageableArea(80,80,80,80); //??????????????????????????? 
		System.out.println(paper.getWidth()); 
		System.out.println(paper.getHeight()); 
		pf.setPaper(paper);//???????????????????????? */ 
		double x = 0;//pf.getImageableX(); 
		double y = 0;//pf.getImageableY(); 
	    
        g2.translate(x, y);
           
         
        
        
        drawCurrentPageText(g2, pf, page);
        return Printable.PAGE_EXISTS;
	}

    private void drawCurrentPageText(Graphics2D g2, PageFormat pf, int page)
	{
        Font f = area.getFont();
        String s = getDrawText(printStr)[page];
        String drawText;
        float ascent = 16;
        int k, i = f.getSize(), lines = 0;
        while(s.length() > 0 && lines < 54)
        {
            k = s.indexOf('\n');
            if (k != -1)
            {
                lines += 1;
                drawText = s.substring(0, k);
                g2.drawString(drawText, 0, ascent);
                if (s.substring(k + 1).length() > 0)
                {
                    s = s.substring(k + 1);
                    ascent += i;
                }
            }
            else
            {
                lines += 1;
                drawText = s;
                g2.drawString(drawText, 0, ascent);
                s = "";
            }
        }
	}

    public String[] getDrawText(String s)
    {
        String[] drawText = new String[PAGES];
        for (int i = 0; i < PAGES; i++)
            drawText[i] = "";

        int k, suffix = 0, lines = 0;
        while(s.length() > 0)
        {
            if(lines < 54)
            {
                k = s.indexOf('\n');
                if (k != -1)
                {
                    lines += 1;
                    drawText[suffix] = drawText[suffix] + s.substring(0, k + 1);
                    if (s.substring(k + 1).length() > 0)
                        s = s.substring(k + 1);
                }
                else
                {
                    lines += 1;
                    drawText[suffix] = drawText[suffix] + s;
                    s = "";
                }
            }
            else
            {
                lines = 0;
                suffix++;
            }
        }
        return drawText;
    }

    public int getPagesCount(String curStr)
	{
        int page = 0;
        int position, count = 0;
        String str = curStr;
	    while(str.length() > 0)
	    {
	        position = str.indexOf('\n');
            count += 1;
	        if (position != -1)
                str = str.substring(position + 1);
	        else
	            str = "";
	    }

	    if (count > 0)
	        page = count / 54 + 1;

        return page;
	}

    private void printTextAction()
    {
        printStr = area.getText().trim();
        if (printStr != null && printStr.length() > 0)
        {
            PAGES = getPagesCount(printStr);
            PrinterJob myPrtJob = PrinterJob.getPrinterJob();
            PageFormat pageFormat = myPrtJob.defaultPage();
            myPrtJob.setPrintable(this, pageFormat);
            if (myPrtJob.printDialog())
            {
                try
                {
                    myPrtJob.print();
                }
                catch(PrinterException pe)
                {
                    pe.printStackTrace();
                }
            }
        }
        else
        {
            JOptionPane.showConfirmDialog(null, "Sorry, Printer Job is Empty, Print Cancelled!", "Empty"
                                        , JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE);
        }
    }

    private void previewAction()
    {
        printStr = area.getText().trim();
        PAGES = getPagesCount(printStr);
        (new PrintPreviewDialog(this, "Print Preview", true, this, printStr)).setVisible(true);
    }

    private void printText2Action()
    {
        printStr = area.getText().trim();
        if (printStr != null && printStr.length() > 0)
        {
            PAGES = getPagesCount(printStr);
            DocFlavor flavor = DocFlavor.SERVICE_FORMATTED.PRINTABLE;
          //???????????????????????????
            PrintService printService = PrintServiceLookup.lookupDefaultPrintService();
            //??????????????????
            DocPrintJob job = printService.createPrintJob();
            //??????????????????
            PrintRequestAttributeSet pras = new HashPrintRequestAttributeSet();
           
            DocAttributeSet das = new HashDocAttributeSet();
            //??????????????????
            Doc doc = new SimpleDoc(this, flavor, das);

            try
            {
                job.print(doc, pras);
            }
            catch(PrintException pe)
            {
                pe.printStackTrace();
            }
        }
        else
        {
            JOptionPane.showConfirmDialog(null, "Sorry, Printer Job is Empty, Print Cancelled!", "Empty"
                                        , JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE);
        }
    }


    private void printFrameAction()
    {
        Toolkit kit = Toolkit.getDefaultToolkit();
        Properties props = new Properties();
        props.put("awt.print.printer", "durango");
        props.put("awt.print.numCopies", "2");
        if(kit != null)
        {
            PrintJob printJob = kit.getPrintJob(this, "Print Frame", props);
            if(printJob != null)
            {
                Graphics pg = printJob.getGraphics();
                if(pg != null)
                {
					try
					{
                        this.printAll(pg);
                    }
                    finally
                    {
                        pg.dispose();
                    }
                }
                printJob.end();
            }
        }
    }

    private void exitApp()
    {
        this.setVisible(false);
        this.dispose();
        System.exit(0);
    }

//    public static void main(String[] args)
//    {
//        (new PrintTest()).setVisible(true);
//    }
    /*public static void main(String[] args) throws UnsupportedEncodingException {   
        //?????????3?????????   
        String src = "?????????";   
        //String src = "?????????";   
           
        //???????????????utf-8??????????????????????????????   
        byte[] bytes1 = src.getBytes("utf-8");   
        System.out.println(bytes1.length);//9   
           
        //tomcat???gbk????????????(??????????????????????????????gbk?????????????????????)   
        //?????????????????????????????????gbk????????????????????????????????????'?'(ascii 63)??????   
        //?????????????????????????????????(???9???)?????????????????????,????????????(?????????src="?????????"???)   
        //?????????????????????????????????????????????gbk??????????????????'?'???(?????????src="?????????"???)   
        //??????temp??????????????????????????????'?'   
        String temp = new String(bytes1, "gbk");    
           
        //??????action????????????   
        //???????????????tomcat???gbk??????utf-8????????????   
        //????????????bytes2???bytes1?????????   
        byte[] bytes2 = temp.getBytes("gbk");   
        System.out.println(bytes2.length);   
        for (int i = 0; i < bytes1.length; i++) {   
            System.out.print(bytes1[i] & 0xff);   
            System.out.print("\t");   
        }   
        System.out.println();   
        for (int i = 0; i < bytes2.length; i++) {   
            System.out.print(bytes2[i] & 0xff);   
            System.out.print("\t");   
        }   
        System.out.println();   
      
        //???????????????dest?????????????????????src   
        String dest = new String(bytes2, "utf-8");   
        System.out.println(dest);   
           
    }   */
}

