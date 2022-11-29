package tea.entity.bpicture;

import java.io.*;
import java.sql.*;
import java.util.*;

import com.drew.imaging.jpeg.*;
import com.drew.metadata.*;
import com.drew.metadata.exif.ExifDirectory;
public class ExifReader {
    private Directory exifDirectory = null;
    private static ExifReader eiw = null;
    public static ExifReader getInstance(String filename)
    {
        if(eiw == null)
        {
            eiw = new ExifReader(filename);
        }
        return eiw;
    }

    public ExifReader(String filename)
    {
        File jpegFile = new File(filename);
        try
        {
            Metadata metadata = JpegMetadataReader.readMetadata(jpegFile); //读取jpeg源数据信息
            exifDirectory = metadata.getDirectory(Class.forName("com.drew.metadata.exif.ExifDirectory")); //读取jpeg中exif目录
        } catch(JpegProcessingException je)
        {
            System.out.println(je);
        } catch(Exception ex)
        {
            System.out.println(ex);
        }
    }

    public String getArtist()
    {
        String artist = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_ARTIST))
            {
                artist = exifDirectory.getString(ExifDirectory.TAG_ARTIST);
            } else
            {
                artist = "";
            }
        } catch(Exception e)
        {
            System.out.println(e);
            artist = "";
        } finally
        {
            return artist;
        }
    }

    public String getMake()
    {
        String make = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_MAKE))
            {
                make = exifDirectory.getString(ExifDirectory.TAG_MAKE);

            } else
            {
                make = "";
            }
        } catch(Exception e)
        {
            System.out.println(e);
            make = "";
        } finally
        {
            return make;
        }
    }

    public String getModel()
    {
        String value = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_MODEL))
            {
                value = exifDirectory.getString(ExifDirectory.TAG_MODEL);

            } else
            {
                value = "";
            }
        } catch(Exception e)
        {
            System.out.println(e);
            value = "";
        } finally
        {
            return value;
        }
    }

    public String getOrientation()
    {
        String value = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_ORIENTATION))
            {
                value = exifDirectory.getString(ExifDirectory.TAG_ORIENTATION);

            } else
            {
                value = "";
            }
        } catch(Exception e)
        {
            System.out.println(e);
            value = "";
        } finally
        {
            return value;
        }
    }

    public String getXResolution()
    {
        String value = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_X_RESOLUTION))
            {
                value = exifDirectory.getString(ExifDirectory.TAG_X_RESOLUTION);
            } else
            {
                value = "";
            }
        } catch(Exception e)
        {
            System.out.println(e);
            value = "";
        } finally
        {
            return value;
        }
    }

    public String getYResolution()
    {
        String value = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_Y_RESOLUTION))
            {
                value = exifDirectory.getString(ExifDirectory.TAG_Y_RESOLUTION);
            } else
            {
                value = "";
            }
        } catch(Exception e)
        {
            System.out.println(e);
            value = "";
        } finally
        {
            return value;
        }
    }

    public String getResolutionUnit()
        {
            String value = null;
            try
            {
                if(exifDirectory.containsTag(ExifDirectory.TAG_RESOLUTION_UNIT))
                {
                    value = exifDirectory.getString(ExifDirectory.TAG_RESOLUTION_UNIT);
                } else
                {
                    value = "";
                }
            } catch(Exception e)
            {
                System.out.println(e);
                value = "";
            } finally
            {
                return value;
            }
    }

    public String getDateTime()
    {
        String time = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_DATETIME))
            {
                java.util.Date d = exifDirectory.getDate(ExifDirectory.
                        TAG_DATETIME); //将exif中的日期信息读出
                Timestamp ts = new Timestamp(d.getTime());
                time = ts.toString();

            } else
            {
                time = "";
            }
        } catch(MetadataException ex)
        {
            System.out.println(ex);
            time = "";
        } catch(Exception e)
        {
            System.out.println(e);
            time = "";
        } finally
        {
            return time;
        }
    }

    public String getYcbcrpositioning()
        {
            String value = null;
            try
            {
                if(exifDirectory.containsTag(ExifDirectory.TAG_YCBCR_POSITIONING))
                {
                    value = exifDirectory.getString(ExifDirectory.TAG_YCBCR_POSITIONING);
                } else
                {
                    value = "";
                }
            } catch(Exception e)
            {
                System.out.println(e);
                value = "";
            } finally
            {
                return value;
            }
    }

    public String getExposuretime()
        {
            String value = null;
            try
            {
                if(exifDirectory.containsTag(ExifDirectory.TAG_EXPOSURE_TIME))
                {
                    value = exifDirectory.getString(ExifDirectory.TAG_EXPOSURE_TIME);
                } else
                {
                    value = "";
                }
            } catch(Exception e)
            {
                System.out.println(e);
                value = "";
            } finally
            {
                return value;
            }
    }

    public String getfnumber()
            {
                String value = null;
                try
                {
                    if(exifDirectory.containsTag(ExifDirectory.TAG_FNUMBER))
                    {
                        value = exifDirectory.getString(ExifDirectory.TAG_FNUMBER);

                    } else
                    {
                        value = "";
                    }
                } catch(Exception e)
                {
                    System.out.println(e);
                    value = "";
                } finally
                {
                    return value;
                }
    }

    public String getGPSinfo()
            {
                String value = null;
                try
                {
                    if(exifDirectory.containsTag(ExifDirectory.TAG_GPS_INFO))
                    {
                        value = exifDirectory.getString(ExifDirectory.TAG_GPS_INFO);
                    } else
                    {
                        value = "";
                    }
                } catch(Exception e)
                {
                    System.out.println(e);
                    value = "";
                } finally
                {
                    return value;
                }
    }

    public String getCbPerPixel()
            {
                String value = null;
                try
                {
                    if(exifDirectory.containsTag(ExifDirectory.TAG_SAMPLES_PER_PIXEL))
                    {
                        value = exifDirectory.getString(ExifDirectory.TAG_SAMPLES_PER_PIXEL);
                    } else
                    {
                        value = "";
                    }
                } catch(Exception e)
                {
                    System.out.println(e);
                    value = "";
                } finally
                {
                    return value;
                }
    }

    public String getExposureValue()
            {
                String value = null;
                try
                {
                    if(exifDirectory.containsTag(ExifDirectory.TAG_EXPOSURE_BIAS))
                    {
                        value = exifDirectory.getString(ExifDirectory.TAG_EXPOSURE_BIAS);
                    } else
                    {
                        value = "";
                    }
                } catch(Exception e)
                {
                    System.out.println(e);
                    value = "";
                } finally
                {
                    return value;
                }
    }

    public String getMaxApertureValue()
            {
                String value = null;
                try
                {
                    if(exifDirectory.containsTag(ExifDirectory.TAG_MAX_APERTURE))
                    {
                        value = exifDirectory.getString(ExifDirectory.TAG_MAX_APERTURE);
                    } else
                    {
                        value = "";
                    }
                } catch(Exception e)
                {
                    System.out.println(e);
                    value = "";
                } finally
                {
                    return value;
                }
    }

    public String getMeteringmode()
                {
                    String value = null;
                    try
                    {
                        if(exifDirectory.containsTag(ExifDirectory.TAG_METERING_MODE))
                        {
                            value = exifDirectory.getString(ExifDirectory.TAG_METERING_MODE);
                        } else
                        {
                            value = "";
                        }
                    } catch(Exception e)
                    {
                        System.out.println(e);
                        value = "";
                    } finally
                    {
                        return value;
                    }
    }

    public String getLightSoure()
                {
                    String value = null;
                    try
                    {
                        if(exifDirectory.containsTag(ExifDirectory.TAG_LIGHT_SOURCE))
                        {
                            value = exifDirectory.getString(ExifDirectory.TAG_LIGHT_SOURCE);
                        } else
                        {
                            value = "";
                        }
                    } catch(Exception e)
                    {
                        System.out.println(e);
                        value = "";
                    } finally
                    {
                        return value;
                    }
    }

    public String getFlash()
                {
                    String value = null;
                    try
                    {
                        if(exifDirectory.containsTag(ExifDirectory.TAG_FLASH))
                        {
                            value = exifDirectory.getString(ExifDirectory.TAG_FLASH);
                        } else
                        {
                            value = "";
                        }
                    } catch(Exception e)
                    {
                        System.out.println(e);
                        value = "";
                    } finally
                    {
                        return value;
                    }
    }

    public String getFocalLength()
                {
                    String value = null;
                    try
                    {
                        if(exifDirectory.containsTag(ExifDirectory.TAG_FOCAL_LENGTH))
                        {
                            value = exifDirectory.getString(ExifDirectory.TAG_FOCAL_LENGTH);
                        } else
                        {
                            value = "";
                        }
                    } catch(Exception e)
                    {
                        System.out.println(e);
                        value = "";
                    } finally
                    {
                        return value;
                    }
    }

    public String getColorSpace()
                    {
                        String value = null;
                        try
                        {
                            if(exifDirectory.containsTag(ExifDirectory.TAG_COLOR_SPACE))
                            {
                                value = exifDirectory.getString(ExifDirectory.TAG_COLOR_SPACE);
                            } else
                            {
                                value = "";
                            }
                        } catch(Exception e)
                        {
                            System.out.println(e);
                            value = "";
                        } finally
                        {
                            return value;
                        }
    }

    public String getImageWidth()
            {
                String value = null;
                try
                {
                    if(exifDirectory.containsTag(ExifDirectory.TAG_TILE_WIDTH))
                    {
                        value = exifDirectory.getString(ExifDirectory.TAG_TILE_WIDTH);
                    } else
                    {
                        value = "";
                    }
                } catch(Exception e)
                {
                    System.out.println(e);
                    value = "";
                } finally
                {
                    return value;
                }
    }

    public String getImageLength()
            {
                String value = null;
                try
                {
                    if(exifDirectory.containsTag(ExifDirectory.TAG_TILE_LENGTH))
                    {
                        value = exifDirectory.getString(ExifDirectory.TAG_TILE_LENGTH);
                    } else
                    {
                        value = "";
                    }
                } catch(Exception e)
                {
                    System.out.println(e);
                    value = "";
                } finally
                {
                    return value;
                }
    }




    public String getPhotoCreatTime()
    {
        String time = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_DATETIME_ORIGINAL))
            {
                java.util.Date d = exifDirectory.getDate(ExifDirectory.
                        TAG_DATETIME_ORIGINAL); //将exif中的日期信息读出
                Timestamp ts = new Timestamp(d.getTime());
                time = ts.toString();

            } else
            {
                time = "";
            }
        } catch(MetadataException ex)
        {
            System.out.println(ex);
            time = "";
        } catch(Exception e)
        {
            System.out.println(e);
            time = "";
        } finally
        {
            return time;
        }
    }

    public String getDigitizedTime()
    {
        String time = null;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_DATETIME_DIGITIZED))
            {
                java.util.Date d = exifDirectory.getDate(ExifDirectory.TAG_DATETIME_DIGITIZED); //将exif中的日期信息读出
                Timestamp ts = new Timestamp(d.getTime());
                time = ts.toString();

            } else
            {
                time = "";
            }
        } catch(MetadataException ex)
        {
            System.out.println(ex);
            time = "";
        } catch(Exception e)
        {
            System.out.println(e);
            time = "";
        } finally
        {
            return time;
        }
    }


    public String getResolution()
    {
        int num = 0;
        try
        {
            if(exifDirectory.containsTag(ExifDirectory.TAG_X_RESOLUTION))
            {
                num= exifDirectory.getInt(ExifDirectory.TAG_X_RESOLUTION); //像素
            } else
            {
               num=0;
            }
        } catch(MetadataException ex)
        {
            System.out.println(ex);
            num = 0;
        } catch(Exception e)
        {
            System.out.println(e);
            num = 0;
        } finally
        {
            return String.valueOf(num);
        }
    }
    public String getCompression()
        {
            int num = 0;
            try
            {
                if(exifDirectory.containsTag(ExifDirectory.TAG_PLANAR_CONFIGURATION  ))
                {
                    num= exifDirectory.getInt(ExifDirectory.TAG_PLANAR_CONFIGURATION); //像素
                } else
                {
                   num=0;
                }
            } catch(MetadataException ex)
            {
                System.out.println(ex);
                num = 0;
            } catch(Exception e)
            {
                System.out.println(e);
                num = 0;
            } finally
            {
                return String.valueOf(num);
            }
        }
}

