// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2003-5-27 19:52:52
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   Chart.java

package tea.applet;

import java.applet.Applet;
import java.awt.*;

public class Chart extends Applet
{

    public void paint(Graphics g)
    {
        Rectangle rectangle = getBounds();
        g.setColor(Color.red);
        g.fillArc(0, 0, rectangle.width, rectangle.height, 0, arcA);
        g.setColor(Color.orange);
        g.fillArc(0, 0, rectangle.width, rectangle.height, arcA, arcB);
        g.setColor(Color.yellow);
        g.fillArc(0, 0, rectangle.width, rectangle.height, arcA + arcB, arcC);
        g.setColor(Color.green);
        g.fillArc(0, 0, rectangle.width, rectangle.height, arcA + arcB + arcC, arcD);
        g.setColor(Color.cyan);
        g.fillArc(0, 0, rectangle.width, rectangle.height, arcA + arcB + arcC + arcD, arcE);
        g.setColor(Color.blue);
        g.fillArc(0, 0, rectangle.width, rectangle.height, arcA + arcB + arcC + arcD + arcE, arcF);
    }

    public Chart()
    {
    }

    public void start()
    {
        int i = 0;
        try
        {
            i = Integer.parseInt(getParameter("A"));
        }
        catch(Exception _ex) { }
        int j = 0;
        try
        {
            j = Integer.parseInt(getParameter("B"));
        }
        catch(Exception _ex) { }
        int k = 0;
        try
        {
            k = Integer.parseInt(getParameter("C"));
        }
        catch(Exception _ex) { }
        int l = 0;
        try
        {
            l = Integer.parseInt(getParameter("D"));
        }
        catch(Exception _ex) { }
        int i1 = 0;
        try
        {
            i1 = Integer.parseInt(getParameter("E"));
        }
        catch(Exception _ex) { }
        int j1 = 0;
        try
        {
            j1 = Integer.parseInt(getParameter("F"));
        }
        catch(Exception _ex) { }
        int k1 = i + j + k + l + i1 + j1;
        if(k1 == 0)
        {
            arcA = arcB = arcC = arcD = arcE = arcF = 0;
        } else
        {
            arcA = (i * 360) / k1;
            arcB = (j * 360) / k1;
            arcC = (k * 360) / k1;
            arcD = (l * 360) / k1;
            arcE = (i1 * 360) / k1;
            arcF = (j1 * 360) / k1;
        }
    }

    public void init()
    {
        setBackground(Color.white);
    }

    int arcA;
    int arcB;
    int arcC;
    int arcD;
    int arcE;
    int arcF;
}