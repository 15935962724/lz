// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Replicate.java

package tea.ui.node.type.picture;

import java.applet.Applet;
import java.awt.*;
import java.awt.image.*;
import java.io.*;
import java.net.URL;

public class Replicate extends Applet
{

    public Replicate()
    {
        ss = null;
    }

    public void init()
    {
        MediaTracker mediatracker = new MediaTracker(this);
        URL url = getClass().getResource("pic.jpg");
        try
        {
            im = createImage((ImageProducer)url.getContent());
            mediatracker.addImage(im, 0);
            mediatracker.waitForID(0);
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        imw = im.getWidth(this);
        imh = im.getHeight(this);
        ReplicateScaleFilter replicatescalefilter = new ReplicateScaleFilter(100, (100 * imh) / imw);
        FilteredImageSource filteredimagesource = new FilteredImageSource(im.getSource(), replicatescalefilter);
        small = createImage(filteredimagesource);
    }

    public void verse()
    {
        init();
        try
        {
            ss = small.toString();
            byte abyte0[] = ss.getBytes();
            ByteArrayOutputStream bytearrayoutputstream = new ByteArrayOutputStream();
            bytearrayoutputstream.write(abyte0);
            String s = "d:\\uuuuu.jpg";
            FileOutputStream fileoutputstream = new FileOutputStream(s);
            bytearrayoutputstream.writeTo(fileoutputstream);
            fileoutputstream.close();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }

    private Image im;
    private Image big;
    private Image small;
    private int imw;
    private int imh;
    String ss;
}
