package tea.entity.admin.map;

import java.util.*;
import java.io.*;
import javax.imageio.*;
import java.awt.image.*;
import java.awt.*;
import java.awt.geom.*;

public class Puzzles
{
	File f[] = new File[10];

	public Puzzles(File f1, File f2, File f3, File f4, File f5, File f6, File f7, File f8, File sky, File earth)
	{
		f[0] = f1;
		f[1] = f2;
		f[2] = f3;
		f[3] = f4;
		f[4] = f5;
		f[5] = f6;
		f[6] = f7;
		f[7] = f8;
		f[8] = sky;
		f[9] = earth;
	}

	public BufferedImage joint() throws IOException
	{
		int sumw = 0, sumh = Integer.MAX_VALUE;
		BufferedImage bi[] = new BufferedImage[f.length];
		for (int i = 0; i < bi.length; i++)
		{
			if (f[i] != null && f[i].exists())
			{
				bi[i] = ImageIO.read(f[i]);
				sumw += bi[i].getWidth();
				int h = bi[i].getHeight();
				if (sumh > h)
					sumh = h;
			}
		}
		int w = bi[0].getWidth();
		int h = bi[0].getHeight();
		int w2 = w / 2, h2 = h / 2;

		BufferedImage b = new BufferedImage(sumw, sumh, BufferedImage.TYPE_INT_RGB);
		Graphics g = b.getGraphics();
		for (int i = 0, left = 0; i < 8; i++)
		{
			if (bi[i] != null)
			{
				g.drawImage(bi[i], left, 0, null);// h2
				left += bi[i].getWidth();
			}
		}
		if (f[8] != null)
			g.drawImage(puz(bi[8], true), 0, 0, null);
		if (f[9] != null)
			g.drawImage(puz(bi[9], false), 0, h + h2, null);
		return b;
	}

	// 天或地/////////////
	private BufferedImage puz(BufferedImage bi, boolean bool)
	{
		int w = bi.getWidth(), h = bi.getHeight();
		int w2 = w / 2, h2 = h / 2;

		// 先切为分四块
		BufferedImage b[] = new BufferedImage[4];
		b[0] = bi.getSubimage(0, 0, w2, h2);
		b[1] = bi.getSubimage(w2, 0, w2, h2);
		b[2] = bi.getSubimage(0, h2, w2, h2);
		b[3] = bi.getSubimage(w2, h2, w2, h2);

		BufferedImage b8[] = new BufferedImage[8];
		for (int i = 0; i < b8.length; i++)
		{
			b8[i] = new BufferedImage(w2, h2, bi.getType());
		}
		// try
		// {
		// FileOutputStream fos=new FileOutputStream("E:/city8/"+bool+"_1.jpg");
		// ImageIO.write(b[0], "JPEG", fos);
		// fos.close();
		//
		// fos=new FileOutputStream("E:/city8/"+bool+"_2.jpg");
		// ImageIO.write(b[1], "JPEG", fos);
		// fos.close();
		//
		// fos=new FileOutputStream("E:/city8/"+bool+"_3.jpg");
		// ImageIO.write(b[2], "JPEG", fos);
		// fos.close();
		//
		// fos=new FileOutputStream("E:/city8/"+bool+"_4.jpg");
		// ImageIO.write(b[3], "JPEG", fos);
		// fos.close();
		// }catch(Exception ex)
		// {
		// ex.printStackTrace();
		// }

		// true:天,false:地
		if (bool)
		{
			// //1=4.1/////////////
			Graphics g = b8[0].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[3], i, 0, i + 1, w2, i, 0, i + 1, i, null);
			}
			b8[0] = rotate(b8[0], 90);

			// 2=2.2/////////////
			g = b8[1].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				// g.drawImage(b[1], i, 0, i + 1, w2, +i, w2 - i, i + 1, w2, null);
				g.drawImage(b[1], i, 0, i + 1, h2, +i, h2 - i, i + 1, h2, null);
			}
			b8[1] = rotate(b8[1], 90);

			// 3=2.1/////////////
			g = b8[2].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[1], 0, i, w2, i + 1, 0, i, w2 - i, i + 1, null);
			}
			b8[2] = rotate(b8[2], 180);

			// 4=1.2/////////////
			g = b8[3].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[0], 0, i, w2, i + 1, i, i, w2, i + 1, null);
			}
			b8[3] = rotate(b8[3], 180);

			// 5=1.1/////////////
			g = b8[4].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[0], i, 0, i + 1, w2, i, i, i + 1, w2, null);
			}
			b8[4] = rotate(b8[4], 270);

			// 6=3.2/////////////
			g = b8[5].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[2], i, 0, i + 1, w2, i, 0, i + 1, w2 - i, null);
			}
			b8[5] = rotate(b8[5], 270);

			// 7=3.1/////////////
			g = b8[6].getGraphics();
			for (int i = 0; i < h2; i++)
			{
				g.drawImage(b[2], 0, i, w2, i + 1, w2 - i, i, w2, i + 1, null);
			}

			// 8=4.2/////////////
			g = b8[7].getGraphics();
			for (int i = 0; i < h2; i++)
			{
				g.drawImage(b[3], 0, i, w2, i + 1, 0, i, i + 1, i + 1, null);
			}
		} else
		{
			// //1=2.2/////////////
			Graphics g = b8[0].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[1], i, 0, i + 1, w2, i, w2 - i, i + 1, w2, null);
			}
			b8[0] = rotate(b8[0], 270);

			// 2=4.1/////////////
			g = b8[1].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[3], i, 0, i + 1, w2, i, 0, i + 1, i, null);
			}
			b8[1] = rotate(b8[1], 270);

			// 3=4.2/////////////
			g = b8[2].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[3], 0, i, w2, i + 1, 0, i, i + 1, i + 1, null);
			}
			b8[2] = rotate(b8[2], 180);

			// 4=3.1/////////////
			g = b8[3].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[2], 0, i, w2, i + 1, w2 - i, i, w2, i + 1, null);
			}
			b8[3] = rotate(b8[3], 180);

			// 5=3.2/////////////
			g = b8[4].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[2], i, 0, i + 1, w2, i, 0, i + 1, w2 - i, null);
			}
			b8[4] = rotate(b8[4], 90);

			// 6=1.1/////////////
			g = b8[5].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[0], i, 0, i + 1, w2, i, i, i + 1, w2, null);
			}
			b8[5] = rotate(b8[5], 90);

			// 7=1.2/////////////
			g = b8[6].getGraphics();
			for (int i = 0; i < h2; i++)
			{
				g.drawImage(b[0], 0, i, w2, i + 1, i, i, w2, i + 1, null);
			}

			// 8=2.1/////////////
			g = b8[7].getGraphics();
			for (int i = 0; i < w2; i++)
			{
				g.drawImage(b[1], 0, i, w2, i + 1, 0, i, w2 - i, i + 1, null);
			}
		}

		BufferedImage rs = new BufferedImage(w * 4, h2, bi.getType());
		Graphics g = rs.getGraphics();
		for (int i = 0; i < b8.length; i++)
		{
			g.drawImage(b8[i], i * w2, 0, null);
		}
		return rs;
	}

	// /旋转
	// g2.drawImage(b2,0,0,256,256, 256,0,0,256,null);//左右
	// g2.drawImage(b2,0,0,256,256, 0,256,256,0,null);//上下
	// g2.drawImage(b2,0,0,256,256, 256,256,0,0,null);//上下
	// http://topic.csdn.net/t/20060712/15/4875844.html
	public static BufferedImage rotate(BufferedImage b2, int r)
	{
		int h = b2.getHeight(), w = b2.getWidth();
		BufferedImage dstImage = null;
		AffineTransform at = new AffineTransform();
		if (r == 90)
		{
			at.translate(h, 0);
			dstImage = new BufferedImage(h, w, b2.getType());
		} else if (r == 180)
		{
			at.translate(w, h);
			dstImage = new BufferedImage(w, h, b2.getType());
		} else if (r == 270)
		{
			at.translate(0, w);
			dstImage = new BufferedImage(h, w, b2.getType());
		}
		at.rotate(Math.toRadians(r));
		AffineTransformOp ato = new AffineTransformOp(at, null);
		return ato.filter(b2, dstImage);
	}
}

// 天========================
// |
// 4 | 3
// |
// 5 | 2
// ------------------------
// 6 | 1
// |
// 7 | 8
// |
//
// 地========================
// |
// 7 | 8
// |
// 6 | 1
// ------------------------
// 5 | 2
// |
// 4 | 3
// |
