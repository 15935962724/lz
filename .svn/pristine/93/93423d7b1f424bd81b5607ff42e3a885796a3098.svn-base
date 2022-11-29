package tea.entity.bpicture;


import java.sql.*;
import java.util.Date;

import tea.db.*;
import tea.entity.*;

public class BExifParam extends Entity
{

    private int node;
    private String artist;//作者
    private String make;//生产厂家
    private String model;//型号
    private String orientation;//影像方向
    private String xresolution;//影像分辨率 X
    private String yresolution;//影像分辨率 Y
    private String resolutionunit;//分辨率单位
    private Date datetime;//日期 时间
    private String ycbcrpositioning;//色相定位
    private String exposuretime;//曝光时间（快门速度）
    private String fnumber;//光圈系数
    private String gpsinfo;//GPS定位
    private Date dtoriginal;//拍摄时间
    private Date stdigitized;//存入时间
    private String cbperpixel;//压缩程度
    private String exposurebasvalue;//曝光补偿
    private String maxaperturevalue;//最大光圈
    private String meteringmode;//测光方式
    private String lightsource;//光源
    private String flash;//是否使用闪光灯
    private String focallength;//焦距
    private String colorspace;//色域
    private String imagewidth;//图像宽度
    private String imagelength;//图像高度
    private boolean exists;

    public BExifParam(int node) throws SQLException
    {
        this.node = node;
        load();
    }

    public static BExifParam find(int node) throws SQLException
    {
        return new BExifParam(node);
    }

    public void load() throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node,artist,make,model,orientation,xresolution,yresolution,resolutionunit,datetime,ycbcrpositioning,exposuretime,fnumber,gpsinfo,dtoriginal,stdigitized,cbperpixel,exposurebasvalue,maxaperturevalue,meteringmode,lightsource,flash,focallength,colorspace,imagewidth,imagelength from exifparam");
            if(db.next())
            {
                int j = 1;
                node = db.getInt(j++);
                artist = db.getString(j++);
                make = db.getString(j++);
                model = db.getString(j++);
                orientation = db.getString(j++);
                xresolution = db.getString(j++);
                yresolution = db.getString(j++);
                resolutionunit = db.getString(j++);
                datetime = db.getDate(j++);
                ycbcrpositioning = db.getString(j++);
                exposuretime = db.getString(j++);
                fnumber = db.getString(j++);
                gpsinfo = db.getString(j++);
                dtoriginal = db.getDate(j++);
                stdigitized = db.getDate(j++);
                cbperpixel = db.getString(j++);
                exposurebasvalue = db.getString(j++);
                maxaperturevalue = db.getString(j++);
                meteringmode = db.getString(j++);
                lightsource = db.getString(j++);
                flash = db.getString(j++);
                focallength = db.getString(j++);
                colorspace = db.getString(j++);
                imagewidth = db.getString(j++);
                imagelength = db.getString(j++);
                exists = true;
            } else
            {
                exists = false;
            }
        } finally
        {
            db.close();
        }
    }

    public static void create(int node, String artist,String make,String model, String orientation,String xresolution,String yresolution, String resolutionunit, Date datetime, String ycbcrpositioning, String exposuretime, String fnumber, String gpsinfo,Date dtoriginal,Date stdigitized, String cbperpixel, String exposurebasvalue,String maxaperturevalue, String meteringmode, String lightsource,String flash,String focallength, String colorspace,String imagewidth, String imagelength )throws SQLException
    {
        DbAdapter db = new DbAdapter();
        try
        {
            db.executeQuery("select node from exifparam where node="+node);
            if(!db.next()){
                db.executeUpdate("insert into exifparam values(" + node + "," + db.cite(artist) + "," + db.cite(make) + "," + db.cite(model) + "," + db.cite(orientation) + "," + db.cite(xresolution) + "," + db.cite(yresolution) + "," + db.cite(resolutionunit) + "," + db.cite(datetime) + "," + db.cite(ycbcrpositioning) + "," + db.cite(exposuretime) + "," + db.cite(fnumber) + "," + db.cite(gpsinfo) + "," + db.cite(dtoriginal) + "," + db.cite(stdigitized) + "," + db.cite(cbperpixel) + "," + db.cite(exposurebasvalue) + "," + db.cite(maxaperturevalue) + "," + db.cite(meteringmode) + "," + db.cite(lightsource) + "," + db.cite(flash) + "," + db.cite(focallength) + "," + db.cite(colorspace) + "," + db.cite(imagewidth) + "," + db.cite(imagelength) + ")");
            }
        } finally
        {
            db.close();
        }
    }


    public boolean isExists()
    {
        return exists;
    }

    public String getArtist()
    {
        return artist;
    }

    public String getCbperpixel()
    {
        return cbperpixel;
    }

    public String getColorspace()
    {
        return colorspace;
    }

    public String getDatetimeToString()
    {
        String dt = "";
        if(datetime!=null){
           dt = BExifParam.sdf.format(datetime);
        }
        return dt;
    }

    public Date getDtoriginal()
    {
        return dtoriginal;
    }

    public String getExposurebasvalue()
    {
        return exposurebasvalue;
    }

    public String getExposuretime()
    {
        return exposuretime;
    }

    public String getFlash()
    {
        return flash;
    }

    public String getFnumber()
    {
        return fnumber;
    }

    public String getFocallength()
    {
        return focallength;
    }

    public String getImagelength()
    {
        return imagelength;
    }

    public String getImagewidth()
    {
        return imagewidth;
    }

    public String getLightsource()
    {
        return lightsource;
    }

    public String getgpsinfo()
    {
        return gpsinfo;
    }

    public String getMake()
    {
        return make;
    }

    public String getMaxaperturevalue()
    {
        return maxaperturevalue;
    }

    public String getMeteringmode()
    {
        return meteringmode;
    }

    public String getModel()
    {
        return model;
    }

    public int getNode()
    {
        return node;
    }

    public String getOrientation()
    {
        return orientation;
    }

    public String getResolutionunit()
    {
        return resolutionunit;
    }

    public Date getStdigitized()
    {
        return stdigitized;
    }

    public String getXresolution()
    {
        return xresolution;
    }

    public String getYcbcrpositioning()
    {
        return ycbcrpositioning;
    }

    public String getYresolution()
    {
        return yresolution;
    }
}
