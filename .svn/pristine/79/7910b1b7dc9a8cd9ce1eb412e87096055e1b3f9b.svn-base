package tea.ui.leo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import tea.entity.node.Reserve;

public class FileUpLoad extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String path = "";

	/**
	 * 初始化的时候创建一个文件夹，上传的文件就在这个文件夹里
	 */
	public void init() throws ServletException {
		String urlpath = this.getServletContext().getRealPath("");
		path = urlpath + "/res/papc/kmz/";
		File file = new File(path);
		if (!file.exists()) {
			file.mkdirs();
		}
	}

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		String node = request.getParameter("node");
		String lh = request.getParameter("lh");
		String newName = "";
		try {
			List list = upload.parseRequest(request);// 要commons-fileupload组件接管request请求对象
			// 通过这一个方法，进行将request中的内容进行分析，最后返回的
			// 内容就是被分析过的文件，文件会被封装为一个commons组件提供的类中
			for (Iterator iterator = list.iterator(); iterator.hasNext();) {
				FileItem fItem = (FileItem) iterator.next();
				// 如何来区分到底是表单元素，还是文件内容
				if (fItem.isFormField()) {// 说明表单元样对象
					// 如何获得表单对象的内容啦
					String name = fItem.getName();
					String value = fItem.getString("utf-8");// 取得表单元素的值
				} else {
					String fileName = fItem.getName();
					newName = node+"_"+new Date().getTime()+".kmz";
					String newPath = path+newName;
					InputStream in = null;
					OutputStream out = null;
					try {
						in = fItem.getInputStream();
						out = new FileOutputStream(newPath);
						byte[] b = new byte[1024];
						int i = -1;
						while ((i = in.read(b, 0, 1024)) != -1) {
							out.write(b);
							out.flush();
						}
						System.out.println("文件上传成功！");
						System.out.println("文件保存在：" + newPath + "这里！！");
					} catch (IOException k) {
						k.printStackTrace();
					} finally {
						in.close();
						out.close();
					}
				}
			}
			Reserve reserve = Reserve.find(Integer.valueOf(node), Integer.valueOf(lh));
			reserve.set("kmzpath", newName);
		} catch (Exception k) {
			k.printStackTrace();
		}
	}

}
