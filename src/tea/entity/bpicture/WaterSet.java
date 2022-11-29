package tea.entity.bpicture;

import tea.entity.Entity;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import javax.imageio.ImageIO;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.image.codec.jpeg.*;
import java.awt.Graphics2D;
import javax.swing.ImageIcon;


public class WaterSet extends Entity
{
    public WaterSet()
    {
    }

	/** *//**
		* 给图片添加水印
		*
		* @param filePath
		*            需要添加水印的图片的路径
		* @param markContent
		*            水印的文字
		* @param markContentColor
		*            水印文字的颜色
		* @param qualNum
		*            图片质量
		* @return
		*/
	   public static boolean createMark(String filePath, String markContent,
			   Color markContentColor, float qualNum) {
		   ImageIcon imgIcon = new ImageIcon(filePath);
		   Image theImg = imgIcon.getImage();
		   int width = theImg.getWidth(null);
		   int height = theImg.getHeight(null);
		   BufferedImage bimage = new BufferedImage(width, height,
				   BufferedImage.TYPE_INT_RGB);
		   Graphics2D g = bimage.createGraphics();
		   g.setColor(markContentColor);
		   g.setBackground(Color.white);
		   g.drawImage(theImg, 0, 0, null);
		   g.drawString(markContent, width / 5, height / 5); // 添加水印的文字和设置水印文字出现的内容
		   g.dispose();
		   try {
			   FileOutputStream out = new FileOutputStream(filePath);
			   JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			   JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(bimage);
			   param.setQuality(qualNum, true);
			   encoder.encode(bimage, param);
			   out.close();
		   } catch (Exception e) {
			   return false;
		   }
		   return true;
	   }


   /** *//**
	* 把图片印刷到图片上
	*
	* @param pressImg --
	*            水印文件
	* @param targetImg --
	*            目标文件
	* @param x
	*            --x坐标
	* @param y
	*            --y坐标
	*/
   public final static void pressImage(String pressImg, String targetImg,
		   int x, int y) {
	   try {
		   //目标文件
		   File _file = new File(targetImg);
		   Image src = ImageIO.read(_file);
		   int wideth = src.getWidth(null);
		   int height = src.getHeight(null);
		   BufferedImage image = new BufferedImage(wideth, height,
				   BufferedImage.TYPE_INT_RGB);
		   Graphics g = image.createGraphics();
		   g.drawImage(src, 0, 0, wideth, height, null);

		   //水印文件
		   File _filebiao = new File(pressImg);
		   Image src_biao = ImageIO.read(_filebiao);
		   int wideth_biao = src_biao.getWidth(null);
		   int height_biao = src_biao.getHeight(null);
		   g.drawImage(src_biao, (wideth - wideth_biao) / 2,
				   (height - height_biao) / 2, wideth_biao, height_biao, null);
		   //水印文件结束
		   g.dispose();
		   FileOutputStream out = new FileOutputStream(targetImg);
		   JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		   encoder.encode(image);
		   out.close();
	   } catch (Exception e) {
		   e.printStackTrace();
	   }

   }

   /** *//**
	* 打印文字水印图片
	*
	* @param pressText
	*            --文字
	* @param targetImg --
	*            目标图片
	* @param fontName --
	*            字体名
	* @param fontStyle --
	*            字体样式
	* @param color --
	*            字体颜色
	* @param fontSize --
	*            字体大小
	* @param x --
	*            偏移量
	* @param y
	*/

   public static void pressText(String pressText, String targetImg,
		   String fontName, int fontStyle, int color, int fontSize, int x,
		   int y) {
	   try {
		   File _file = new File(targetImg);
		   Image src = ImageIO.read(_file);
		   int wideth = src.getWidth(null);
		   int height = src.getHeight(null);
		   BufferedImage image = new BufferedImage(wideth, height,
				   BufferedImage.TYPE_INT_RGB);
		   Graphics g = image.createGraphics();
		   g.drawImage(src, 0, 0, wideth, height, null);
		   g.setColor(Color.RED);
		   g.setFont(new Font(fontName, fontStyle, fontSize));

		   g.drawString(pressText, wideth - fontSize - x, height - fontSize
				   / 2 - y);
		   g.dispose();
		   FileOutputStream out = new FileOutputStream(targetImg);
		   JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		   encoder.encode(image);
		   out.close();
	   } catch (Exception e) {
		   System.out.println(e);
	   }
   }


}
