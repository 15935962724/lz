package tea;

import java.awt.*;
import java.awt.event.*;
import java.applet.*;
import javax.swing.*;


//import netscape.javascript.JSObject;
//import netscape.javascript.JSException;
import java.awt.BorderLayout;

public class Applet5 extends JApplet
{
    boolean isStandalone = false;

    //Get a parameter value
    public String getParameter(String key, String def)
    {
        return isStandalone ? System.getProperty(key, def) : (getParameter(key) != null ? getParameter(key) : def);
    }

    //Construct the applet
    public Applet5()
    {
    }

    //Initialize the applet
    public void init()
    {
        System.out.println("正在初始化...");
        try
        {
            jbInit();
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    public void print(Graphics g)
    {
        System.out.println("正在print...");
        g.drawString("Click here...", 5, 10);
    }

    public void setText(String s) //setText（）必须声明为“public”
    {/*
        JSObject window = JSObject.getWindow(this);
        JSObject document = (JSObject) window.getMember("document");
        JSObject form = (JSObject) document.getMember("textForm");
        JSObject text = (JSObject) form.getMember("textField");
        try
        {
            StringBuilder sb = new StringBuilder();
            java.net.URL url = new java.net.URL(s);//"file:///D|/Buffer/My Pictures/edvard_munch.gif");
            java.io.InputStream fis = url.openStream();
            int value = 0;
            while ((value = fis.read()) != -1)
            {
                sb.append("," + value);
            }
            fis.close();
            System.out.println(sb);
            text.setMember("value", sb.toString());
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        //repaint();*/
    }

    //Component initialization
    private void jbInit() throws Exception
    {
        /*
                 this.setSize(new Dimension(400, 300));

                 setBackground(new Color(0xffffff));
                 setLayout(null);
                 Button btPlay = new Button();
                 btPlay.setBounds(0, 0, 60, 24);
                 add(btPlay);
         */
    }

    //Get Applet information
    public String getAppletInfo()
    {
        return "Applet Information";
    }

    //Get parameter info
    public String[][] getParameterInfo()
    {
        return null;
    }

    //static initializer for setting look & feel
    static
    {
        try
        {
            //UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
            //UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());
        } catch (Exception e)
        {
        }
    }
}
