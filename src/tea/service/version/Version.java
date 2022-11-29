	package tea.service.version;
	import java.io.File;
	import java.io.FileFilter;
	import java.io.FileInputStream;
	import java.io.FileOutputStream;
	import java.io.IOException;
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.util.Date;
	import java.util.Properties;
	import java.util.zip.ZipEntry;
	import java.util.zip.ZipInputStream;
	import java.util.zip.ZipOutputStream;
       import java.net.URL;
	public class Version
	{
	    private String preversion;
	    private String curversion;
	    private String updatetime;
	    private String client;


		/**
	     * ѹ���ļ�
	     *
	     * @param input ��ѹ����ļ������ļ���
	     * @param output ѹ���ļ�
	     * @throws IOException
	     */
	    public String getversion()
	            throws IOException
	    {   Properties properties = new Properties();
           //  String  name = "/version.properties";
             File file=new File(".\\version.properties");
              if (!file.exists())
                  return null;
               properties.load(new FileInputStream(file));
	    	preversion=properties.getProperty("preversion");
	        curversion=properties.getProperty("curversion");
	        updatetime=properties.getProperty("updatetime");
	        client=properties.getProperty("client");
	       return curversion;


	    }

        public String getversion(String filename)
                throws IOException
        {   Properties properties = new Properties();
           File file=new File (filename);
          if (!file.exists())
              return null;
           properties.load(new FileInputStream(file));
            preversion=properties.getProperty("preversion");
            curversion=properties.getProperty("curversion");
            updatetime=properties.getProperty("updatetime");
            client=properties.getProperty("client");
           return curversion;


        }


	    public  void saveversion()
	    throws IOException
	{
	    	Properties properties = new Properties();

	        FileOutputStream file = new FileOutputStream(".\\version.properties");
	       properties.setProperty("preversion",preversion);
	       properties.setProperty("curversion",curversion);
	       properties.setProperty("updatetime",updatetime);
	       properties.setProperty("client",client);
	       properties.store(file,"version");
               file.close();
	}
	    public  void saveversion(String path)
	    throws IOException
	{      File f=new File(path);
              if(!f.exists())
                 f.mkdirs();
	    	Properties properties = new Properties();
	        FileOutputStream file = new FileOutputStream(new File(path+"\\version.properties"));
	        properties.setProperty("preversion",preversion);
	        properties.setProperty("curversion",curversion);
	        properties.setProperty("updatetime",updatetime);
	        properties.setProperty("client",client);
	       properties.store(file,"ss");

	}


		/*public static void main(String[] args)
	            throws IOException
	    {
	         Version v=new Version();
                v.setCurversion("aaa");
                v.setClient("asfd");
                v.setPreversion("sdaf");
                v.setUpdatetime("sadf");
	        v.saveversion();
	         v.getversion();
	        System.out.print((System.getProperty("/version.properties")));
	         System.out.println(v.getCurversion());
	         System.out.println(v.getClient());

	    }*/

	    public String getCurversion() {
			return curversion;
		}

		public void setCurversion(String curversion) {
			this.curversion = curversion;
		}

		public String getPreversion() {
			return preversion;
		}

		public void setPreversion(String preversion) {
			this.preversion = preversion;
		}

		public String getUpdatetime() {
			return updatetime;
		}

		public void setUpdatetime(String updatetime) {
			this.updatetime = updatetime;
		}

		   public String getClient() {
				return client;
			}

			public void setClient(String client) {
				this.client = client;
			}

	}

