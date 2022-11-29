package tea.ui.node.access;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.access.Apk;
import tea.entity.node.access.NodeAccessApk;
import tea.entity.node.access.NodeAccessApkCity;
import tea.entity.node.access.NodeAccessWhere;
import tea.ui.TeaSession;

/** 
 * @author 张超群
 * @version 创建时间：2014-7-23 上午09:30:32 
 * 统计下载apk信息
 */
public class NodeAccessApks extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, java.io.IOException {
		request.setCharacterEncoding("UTF-8");
		
		String path=request.getParameter("path");
		int apkid = Integer.parseInt(request.getParameter("apkid"));
		String community = null;
		String ip = request.getRemoteAddr();
		String address = null;
		NodeAccessApk nodeAccessApk = new NodeAccessApk();
		NodeAccessApkCity nodeAccessApkCity = new NodeAccessApkCity();
		try {
			//纪录用户点击
			community = Apk.find(apkid).getCommunity();
			if(community==null||community.equals("")){
				TeaSession teasession = new TeaSession(request);
				community = teasession._strCommunity;
			}
			address=NodeAccessWhere.findByIp(ip);
			
			nodeAccessApk.setApkid(apkid);
			nodeAccessApk.setCommunity(community);
			nodeAccessApk.setIp(ip);
			nodeAccessApk.setAddress(address);
			//插入下载apk者信息
			nodeAccessApk.set();
			//插入或修改下载apk者地区的sum
			
			nodeAccessApkCity.set(community, address);
			//用户apk点击量加1
			Apk.updateApkCount(apkid);
			
			//判断是否用户下载
			if(downapk(path,request,response)){
				////用户apk下载量加1
				Apk.updateApkDowncount(apkid);
				nodeAccessApkCity.updateDownSum(community, address);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		//response.sendRedirect(path);
	
	return;
	}
	
	public boolean downapk(String path,HttpServletRequest request, HttpServletResponse response)
	{
		ServletContext application = this.getServletContext();  
		String filePath = request.getRealPath("/")+"apk\\"+path;
    	boolean isInline = false;// 是否允许直接在浏览器内打开(如果浏览器能够预览此文件内容,

    	try {
    		java.io.File f = new java.io.File(filePath);
    		if (f.exists() && f.canRead()) {
    			// 我们要检查客户端的缓存中是否已经有了此文件的最新版本, 这时候就告诉
    			// 客户端无需重新下载了, 当然如果不想检查也没有关系
                if( checkFor304( request, f ) )
                {
                    // 客户端已经有了最新版本, 返回 304
                    response.sendError( HttpServletResponse.SC_NOT_MODIFIED );
                    return false;
                }
    			// 从服务器的配置来读取文件的 contentType 并设置此contentType, 不推荐设置为
    			// application/x-download, 因为有时候我们的客户可能会希望在浏览器里直接打开,
    			// 如 Excel 报表, 而且 application/x-download 也不是一个标准的 mime type,
    			// 似乎 FireFox 就不认识这种格式的 mime type
    			String mimetype = null;
    			mimetype = application.getMimeType( filePath );
    			if( mimetype == null )
    			{
    			    mimetype = "application/octet-stream;charset=ISO8859-1";
    			}

    			response.setContentType( mimetype );

    			// IE 的话就只能用 IE 才认识的头才能下载 HTML 文件, 否则 IE 必定要打开此文件!
    			String ua = request.getHeader("User-Agent");// 获取终端类型
    			if(ua == null) ua = "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0;)";
    			boolean isIE = ua.toLowerCase().indexOf("msie") != -1;// 是否为 IE

    			if(isIE && !isInline) {
    				mimetype = "application/x-msdownload";
    			}


    			// 下面我们将设法让客户端保存文件的时候显示正确的文件名, 具体就是将文件名
    			// 转换为 ISO8859-1 编码
    			String downFileName = new String(f.getName().getBytes(), "ISO8859-1");

    			String inlineType = isInline ? "inline" : "attachment";// 是否内联附件

    			// or using this, but this header might not supported by FireFox
    			//response.setContentType("application/x-download");
    			response.setHeader ("Content-Disposition", inlineType + ";filename=\""
    			+ downFileName + "\"");

    			response.setContentLength((int) f.length());// 设置下载内容大小

    	        byte[] buffer = new byte[10240];// 缓冲区
    	        BufferedOutputStream output = null;
    	        BufferedInputStream input = null;

    	        //
    	        try {
    	            output = new BufferedOutputStream(response.getOutputStream());
    	            input = new BufferedInputStream(new FileInputStream(f));

    	            int n = (-1);
    	            while ((n = input.read(buffer, 0, 10240)) > -1) {
    	                output.write(buffer, 0, n);
    	            }
    	            response.flushBuffer();
    	            output.flush();
    	            
    	        }
    	        catch (Exception e) {
    	        	//System.out.println("fail");
    	        	return false;
    	        } // 用户可能取消了下载
    	        finally {
    	            if (input != null) input.close();
    	            if (output != null) output.close();
    	            File oldfile = new File(filePath);
    	           if(oldfile.isFile() && oldfile.exists()) {
    	            	oldfile.canRead();
    	            }
    	         //  oldfile.delete();
    	        }

    		}
    		return true;
    	} catch (Exception ex) {
    	  //ex.printStackTrace();
    	}
    	// 如果下载失败了就告诉用户此文件不存在
    	try {
			response.sendError(404);
		} catch (IOException e) {
			return false;
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
		return true;
	}
	
	public  boolean checkFor304(HttpServletRequest req,File file )
    {
        if( "no-cache".equalsIgnoreCase(req.getHeader("Pragma"))
            || "no-cache".equalsIgnoreCase(req.getHeader("cache-control")))
        {
            // Wants specifically a fresh copy
        }
        else
        {
            //
            //  HTTP 1.1 ETags go first
            //
            String thisTag = Long.toString(file.lastModified());

            String eTag = req.getHeader( "If-None-Match" );

            if( eTag != null )
            {
                if( eTag.equals(thisTag) )
                {
                    return true;
                }
            }
            //
            //  Next, try if-modified-since
            //
            DateFormat rfcDateFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z");
            Date lastModified = new Date(file.lastModified());
            try
            {
                long ifModifiedSince = req.getDateHeader("If-Modified-Since");
                //log.info("ifModifiedSince:"+ifModifiedSince);
                if( ifModifiedSince != -1 )
                {
                    long lastModifiedTime = lastModified.getTime();

                    //log.info("lastModifiedTime:" + lastModifiedTime);
                    if( lastModifiedTime <= ifModifiedSince )
                    {
                        return true;
                    }
                }
                else
                {
                    try
                    {
                        String s = req.getHeader("If-Modified-Since");

                        if( s != null )
                        {
                            Date ifModifiedSinceDate = rfcDateFormat.parse(s);
                            //log.info("ifModifiedSinceDate:" + ifModifiedSinceDate);
                            if( lastModified.before(ifModifiedSinceDate) )
                            {
                                return true;
                            }
                        }
                    }
                    catch (ParseException e)
                    {
                        //log.warn(e.getLocalizedMessage(), e);
                    }
                }
            }
            catch( IllegalArgumentException e )
            {
                // Illegal date/time header format.
                // We fail quietly, and return false.
                // FIXME: Should really move to ETags.
            }
        }

        return false;
    }
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, java.io.IOException {
		doPost(request, response);
	}
	
}
