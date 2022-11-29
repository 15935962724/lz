package tea.entity.site;

import java.awt.*;
import java.awt.image.*;
import java.io.*;
import java.sql.*;
import tea.entity.util.*;

import javax.imageio.*;

import tea.db.*;
import tea.entity.*;
import tea.resource.*;

//水印///////////
public class Watermark
{
    private static Cache _cache = new Cache(100);
    public static final String LOCA_TYPE[] =
            {"无","左上","右上","中间","左下","右下","平铺"};
    private String community;
    private int location; //位置
    private String logo; //水印
    private int alpha; //透明度
    private int zoom; //缩放
    private String ext; //文件格式
    public String type = "|"; //节点类型
    private boolean exists;

    public static Watermark find(String community) throws SQLException
    {
        Watermark obj = (Watermark) _cache.get(community);
        if(obj == null)
        {
            obj = new Watermark(community);
            _cache.put(community,obj);
        }
        return obj;
    }

    public Watermark(String community) throws SQLException
    {
        this.community = community;
        load();
    }

    private void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("SELECT location,logo,alpha,ext,type,zoom FROM Watermark WHERE community=" + DbAdapter.cite(community));
            if(db.next())
            {
                int j = 1;
                location = db.getInt(j++);
                logo = db.getString(j++);
                alpha = db.getInt(j++);
                ext = db.getString(j++);
                type = db.getString(j++);
                zoom = db.getInt(j++);
                exists = true;
            } else
            {
                ext = "/.jpg/.gif/.png/.bmp/";
                alpha = 20;
                zoom = 20;
                exists = false;
            }
            //历史版本
            if(type == null)
                type = "|";
        } finally
        {
            db.close();
        }
    }

    public void set(int location,String logo,int alpha,String ext,int zoom) throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            int j = db.executeUpdate("UPDATE Watermark SET location=" + location + ",logo=" + DbAdapter.cite(logo) + ",alpha=" + alpha + ",ext=" + DbAdapter.cite(ext) + ",type=" + DbAdapter.cite(type) + ",zoom=" + zoom + " WHERE community=" + DbAdapter.cite(community));
            if(j < 1)
            {
                db.executeUpdate("INSERT INTO Watermark(community,location,logo,alpha,ext,type,zoom)VALUES(" + DbAdapter.cite(community) + "," + location + "," + DbAdapter.cite(logo) + "," + alpha + "," + DbAdapter.cite(ext) + "," + DbAdapter.cite(type) + "," + zoom + ")");
            }
        } finally
        {
            db.close();
        }
        this.exists = true;
        this.location = location;
        this.logo = logo;
        this.alpha = alpha;
        this.ext = ext;
        this.zoom = zoom;
    }

    public static void mark(String community,File f)
    {
        try
        {
            Watermark obj = Watermark.find(community);
            int location = obj.getLocation();
            if(obj.isExists() && location > 0 && obj.isExt(f.getName()))
            {
                if(f.length() > 1024 * 1024 * 5)
                {
                    return;
                }
                BufferedImage bi = ImageIO.read(f); //new ByteArrayInputStream(by)
                int w = bi.getWidth();
                int h = bi.getHeight();

//                type = 13 IndexColorModel: #pixelBits = 8 numComponents = 4 color space = java.awt.color.ICC_ColorSpace@1fd9b49 transparency = 2 transIndex   = 255 has alpha = true isAlphaPre = false ByteInterleavedRaster: width = 160 height = 60 #numDataElements 1 dataOff[0] = 0
//                type = 13 IndexColorModel: #pixelBits = 8 numComponents = 4 color space = java.awt.color.ICC_ColorSpace@1fd9b49 transparency = 2 transIndex   = 16 has alpha = true isAlphaPre = false ByteInterleavedRaster: width = 160 height = 60 #numDataElements 1 dataOff[0] = 0
//                type = 13 IndexColorModel: #pixelBits = 8 numComponents = 3 color space = java.awt.color.ICC_ColorSpace@690247 transparency = 1 transIndex   = -1 has alpha = false isAlphaPre = false ByteInterleavedRaster: width = 286 height = 110 #numDataElements 1 dataOff[0] = 0
//                type = 5       ColorModel: #pixelBits = 24 numComponents = 3 color space = java.awt.color.ICC_ColorSpace@1fd9b49 transparency = 1                 has alpha = false isAlphaPre = false ByteInterleavedRaster: width = 160 height = 60 #numDataElements 3 dataOff[0] = 2
//                IndexColorModel icm = (IndexColorModel) bi.getColorModel();
//                System.out.println(bi.toString());
                //if(w > 200 && h > 200)
                {
                    Graphics2D g = bi.createGraphics();
                    BufferedImage bil = ImageIO.read(new File(Common.REAL_PATH + obj.getLogo()));
                    int wl = bil.getWidth(); //log的宽度
                    int hl = bil.getHeight();

                    if(obj.getZoom() > 0)
                    {
                        float ww = ((float) 0.01 * (float) obj.getZoom()); //按比例缩放好的
                        float hh = ((float) 0.01 * (float) obj.getZoom()); //

                        float www = ww * (float) w;

                        float hhh = (float) hl * (www / wl); //hh * (float) h;

                        //ZoomOut zo = new ZoomOut();
                        //	bil = zo.imageZoomOut(bil,(int) www,(int) hhh);

                        //wl = bil.getWidth();
                        //hl = bil.getHeight();
                        wl = (int) www;
                        hl = (int) hhh;

                    }
                    g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,obj.getAlpha() / 100F));
                    switch(location)
                    {
                    case 1:
                        g.drawImage(bil,20,20,wl,hl,null);
                        break;
                    case 2:
                        g.drawImage(bil,w - 20 - wl,20,wl,hl,null);
                        break;
                    case 3:
                        g.drawImage(bil,w / 2 - wl / 2,h / 2 - hl / 2,wl,hl,null);
                        break;
                    case 4:
                        g.drawImage(bil,20,h - 20 - hl,wl,hl,null);
                        break;
                    case 5:
                        g.drawImage(bil,w - 20 - wl,h - 20 - hl,wl,hl,null);
                        break;
                    case 6:
                        int ii = wl + 1,jj = h / hl + 1;
                        for(int j = 0;j < jj;j++)
                        {
                            for(int i = 0;i < ii;i++)
                            {
                                g.drawImage(bil,i * wl,j * hl,wl,hl,null);
                            }
                        }
                        break;
                    }
                    g.dispose();
                    ImageIO.write(bi,"JPEG",f);
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            System.out.println("添加水印错误:" + ex.getMessage() + "\t" + f.getPath());
        }
    }

    public String getCommunity()
    {
        return community;
    }

    public String getLogo()
    {
        return logo;
    }

    public int getLocation()
    {
        return location;
    }

    public boolean isExists()
    {
        return exists;
    }

    public int getAlpha()
    {
        return alpha;
    }

    public String getExt()
    {
        return ext;
    }

    private boolean isExt(String name)
    {
        String es[] = ext.split("/");
        for(int i = 1;i < es.length;i++)
        {
            if(name.endsWith(es[i]))
            {
                return true;
            }
        }
        return false;
    }

    public int getZoom()
    {
        return zoom;
    }

}
