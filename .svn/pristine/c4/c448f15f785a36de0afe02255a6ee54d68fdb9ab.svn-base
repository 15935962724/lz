// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Chart.java

package tea.applet;

import java.applet.Applet;
import java.awt.*;

public class Chart extends Applet
{

    public void paint(Graphics g)
    { 
        Rectangle r = getBounds();
        g.setColor(Color.red);
        g.fillArc(0, 0, r.width, r.height, 0, arcA);
        g.setColor(Color.orange);
        g.fillArc(0, 0, r.width, r.height, arcA, arcB);
        g.setColor(Color.yellow);
        g.fillArc(0, 0, r.width, r.height, arcA + arcB, arcC);
        g.setColor(Color.green);
        g.fillArc(0, 0, r.width, r.height, arcA + arcB + arcC, arcD);
        g.setColor(Color.cyan);
        g.fillArc(0, 0, r.width, r.height, arcA + arcB + arcC + arcD, arcE);
        g.setColor(Color.blue);
        g.fillArc(0, 0, r.width, r.height, arcA + arcB + arcC + arcD + arcE, arcF);
    }

    public Chart()
    {
    }

    public void start()
    {
        int A = 0;
        try
        {
            A = Integer.parseInt(getParameter("A"));
        }
        catch(Exception e) { }
        int B = 0;
        try
        {
            B = Integer.parseInt(getParameter("B"));
        }
        catch(Exception e) { }
        int C = 0;
        try
        {
            C = Integer.parseInt(getParameter("C"));
        }
        catch(Exception e) { }
        int D = 0;
        try
        {
            D = Integer.parseInt(getParameter("D"));
        }
        catch(Exception e) { }
        int E = 0;
        try
        {
            E = Integer.parseInt(getParameter("E"));
        }
        catch(Exception e) { }
        int F = 0;
        try
        {
            F = Integer.parseInt(getParameter("F"));
        }
        catch(Exception e) { }
        int nAll = A + B + C + D + E + F;
        if(nAll == 0)
        {
            arcA = arcB = arcC = arcD = arcE = arcF = 0;
        } else
        {
            arcA = (A * 360) / nAll;
            arcB = (B * 360) / nAll;
            arcC = (C * 360) / nAll;
            arcD = (D * 360) / nAll;
            arcE = (E * 360) / nAll;
            arcF = (F * 360) / nAll;
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
