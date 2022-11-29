package tea.entity.util;

import java.awt.image.*;
import javax.imageio.*;
import java.io.*;

public class ZoomOut
{
    double support = (double) 3.0;
    double PI = (double) 3.14159265358978;
    double[] contrib;
    double[] normContrib;
    double[] tmpContrib;
    int startContrib, stopContrib;
    int nDots;
    int nHalfDots;

    public BufferedImage imageZoomOut(BufferedImage srcBufferImage, int width, int height)
    {
        int w = srcBufferImage.getWidth();
        int h = srcBufferImage.getHeight();

        if (w > width || h > height)
        {
//            System.out.println(((double) w / (double)width));
//            System.out.println(((double)h / (double)height));
            if (((double) w / (double)width) >((double)h / (double)height))
            {
                height = (int) ((double)h / ((double) w / (double)width));
            } else
            {
                width = (int) ((double)w / ((double)h / (double)height));
            }

            CalContrib(w, width);
            srcBufferImage = HorizontalFiltering(srcBufferImage, width);
            srcBufferImage = VerticalFiltering(srcBufferImage, height);
        }
        return srcBufferImage;
    }

    private double Lanczos(int i, int inWidth, int outWidth, double Support)
    {
        double x;

        x = (double) i * (double) outWidth / (double) inWidth;

        return Math.sin(x * PI) / (x * PI) * Math.sin(x * PI / Support) / (x * PI / Support);
    } // end of Lanczos()

    //
    // Assumption: same horizontal and vertical scaling factor
    //
    private void CalContrib(int width, int scaleWidth)
    {
        nHalfDots = (int) ((double) width * support / (double) scaleWidth);
        nDots = nHalfDots * 2 + 1;
        try
        {
            contrib = new double[nDots];
            normContrib = new double[nDots];
            tmpContrib = new double[nDots];
        } catch (Exception e)
        {
            System.out.println("init contrib,normContrib,tmpContrib" + e);
        }

        int center = nHalfDots;
        contrib[center] = 1.0;

        double weight = 0.0;
        int i = 0;
        for (i = 1; i <= center; i++)
        {
            contrib[center + i] = Lanczos(i, width, scaleWidth, support);
            weight += contrib[center + i];
        }

        for (i = center - 1; i >= 0; i--)
        {
            contrib[i] = contrib[center * 2 - i];
        }

        weight = weight * 2 + 1.0;

        for (i = 0; i <= center; i++)
        {
            normContrib[i] = contrib[i] / weight;
        }

        for (i = center + 1; i < nDots; i++)
        {
            normContrib[i] = normContrib[center * 2 - i];
        }
    } // end of CalContrib()

    // 处理边缘
    private void CalTempContrib(int start, int stop)
    {
        double weight = 0;

        int i = 0;
        for (i = start; i <= stop; i++)
        {
            weight += contrib[i];
        }

        for (i = start; i <= stop; i++)
        {
            tmpContrib[i] = contrib[i] / weight;
        }

    } // end of CalTempContrib()

    private int GetRedValue(int rgbValue)
    {
        int temp = rgbValue & 0x00ff0000;
        return temp >> 16;
    }

    private int GetGreenValue(int rgbValue)
    {
        int temp = rgbValue & 0x0000ff00;
        return temp >> 8;
    }

    private int GetBlueValue(int rgbValue)
    {
        return rgbValue & 0x000000ff;
    }

    private int ComRGB(int redValue, int greenValue, int blueValue)
    {

        return (redValue << 16) + (greenValue << 8) + blueValue;
    }

    // 行水平滤波
    private int HorizontalFilter(BufferedImage bufImg, int startX, int stopX, int start, int stop, int y, double[] pContrib)
    {
        double valueRed = 0.0;
        double valueGreen = 0.0;
        double valueBlue = 0.0;
        int valueRGB = 0;
        int i, j;

        for (i = startX, j = start; i <= stopX; i++, j++)
        {
            valueRGB = bufImg.getRGB(i, y);

            valueRed += GetRedValue(valueRGB) * pContrib[j];
            valueGreen += GetGreenValue(valueRGB) * pContrib[j];
            valueBlue += GetBlueValue(valueRGB) * pContrib[j];
        }

        valueRGB = ComRGB(Clip((int) valueRed), Clip((int) valueGreen), Clip((int) valueBlue));
        return valueRGB;

    } // end of HorizontalFilter()

    // 图片水平滤波
    private BufferedImage HorizontalFiltering(BufferedImage bufImage, int iOutW)
    {
        int dwInW = bufImage.getWidth();
        int dwInH = bufImage.getHeight();
        int value = 0;
        BufferedImage pbOut = new BufferedImage(iOutW, dwInH, BufferedImage.TYPE_INT_RGB);

        for (int x = 0; x < iOutW; x++)
        {

            int startX;
            int start;
            int X = (int) (((double) x) * ((double) dwInW) / ((double) iOutW) + 0.5);
            int y = 0;

            startX = X - nHalfDots;
            if (startX < 0)
            {
                startX = 0;
                start = nHalfDots - X;
            } else
            {
                start = 0;
            }

            int stop;
            int stopX = X + nHalfDots;
            if (stopX > (dwInW - 1))
            {
                stopX = dwInW - 1;
                stop = nHalfDots + (dwInW - 1 - X);
            } else
            {
                stop = nHalfDots * 2;
            }

            if (start > 0 || stop < nDots - 1)
            {
                CalTempContrib(start, stop);
                for (y = 0; y < dwInH; y++)
                {
                    value = HorizontalFilter(bufImage, startX, stopX, start, stop, y, tmpContrib);
                    pbOut.setRGB(x, y, value);
                }
            } else
            {
                for (y = 0; y < dwInH; y++)
                {
                    value = HorizontalFilter(bufImage, startX, stopX, start, stop, y, normContrib);
                    pbOut.setRGB(x, y, value);
                }
            }
        }

        return pbOut;

    } // end of HorizontalFiltering()

    private int VerticalFilter(BufferedImage pbInImage, int startY, int stopY, int start, int stop, int x, double[] pContrib)
    {
        double valueRed = 0.0;
        double valueGreen = 0.0;
        double valueBlue = 0.0;
        int valueRGB = 0;
        int i, j;

        for (i = startY, j = start; i <= stopY; i++, j++)
        {
            valueRGB = pbInImage.getRGB(x, i);

            valueRed += GetRedValue(valueRGB) * pContrib[j];
            valueGreen += GetGreenValue(valueRGB) * pContrib[j];
            valueBlue += GetBlueValue(valueRGB) * pContrib[j];
            // System.out.println(valueRed+"->"+Clip((int)valueRed)+"<-");
            //
            // System.out.println(valueGreen+"->"+Clip((int)valueGreen)+"<-");
            // System.out.println(valueBlue+"->"+Clip((int)valueBlue)+"<-"+"-->");
        }

        valueRGB = ComRGB(Clip((int) valueRed), Clip((int) valueGreen), Clip((int) valueBlue));
        // System.out.println(valueRGB);
        return valueRGB;

    } // end of VerticalFilter()

    private BufferedImage VerticalFiltering(BufferedImage pbImage, int iOutH)
    {
        int iW = pbImage.getWidth();
        int iH = pbImage.getHeight();
        int value = 0;
        BufferedImage pbOut = new BufferedImage(iW, iOutH, BufferedImage.TYPE_INT_RGB);

        for (int y = 0; y < iOutH; y++)
        {

            int startY;
            int start;
            int Y = (int) (((double) y) * ((double) iH) / ((double) iOutH) + 0.5);

            startY = Y - nHalfDots;
            if (startY < 0)
            {
                startY = 0;
                start = nHalfDots - Y;
            } else
            {
                start = 0;
            }

            int stop;
            int stopY = Y + nHalfDots;
            if (stopY > (int) (iH - 1))
            {
                stopY = iH - 1;
                stop = nHalfDots + (iH - 1 - Y);
            } else
            {
                stop = nHalfDots * 2;
            }

            if (start > 0 || stop < nDots - 1)
            {
                CalTempContrib(start, stop);
                for (int x = 0; x < iW; x++)
                {
                    value = VerticalFilter(pbImage, startY, stopY, start, stop, x, tmpContrib);
                    pbOut.setRGB(x, y, value);
                }
            } else
            {
                for (int x = 0; x < iW; x++)
                {
                    value = VerticalFilter(pbImage, startY, stopY, start, stop, x, normContrib);
                    pbOut.setRGB(x, y, value);
                }
            }

        }

        return pbOut;

    } // end of VerticalFiltering()

    int Clip(int x)
    {
        if (x < 0)
        {
            return 0;
        }
        if (x > 255)
        {
            return 255;
        }
        return x;
    }

    /*public static void main(String args[]) throws IOException
    {
        // Html2Pic hp = Html2Pic.find("http://qingmiao.redcome.com/");
        File f = new File("d:/html2pic55423.bmp");
        System.out.println(f);

        BufferedImage bi = ImageIO.read(f);
        int w = bi.getWidth(), h = bi.getHeight();
        int s_w = 1024, s_h = 768;
        if (w < 800)
        {
            s_w = 800;
            s_h = 600;
        }
        if (h > s_h)
        {
            h = (int) (s_h * ((float) w / s_w));
            bi = bi.getSubimage(0, 0, w, h);
        }
        ZoomOut zo = new ZoomOut();
        bi = zo.imageZoomOut(bi, 256, 192);
        ImageIO.write(bi, "BMP", new java.io.FileOutputStream("d:/text.bmp"));
    }*/
}
/*
 * double d = 1D; if (bi.getHeight() > 80 || bi.getWidth() > 80) { if (bi.getHeight() > bi.getWidth()) { d = 80D / (double) bi.getHeight(); } else { d = 80D / (double) bi.getWidth(); } } AffineTransformOp affinetransformop = new AffineTransformOp(AffineTransform.getScaleInstance(d, d), null); bi =
 * affinetransformop.filter(bi, null);
 */
