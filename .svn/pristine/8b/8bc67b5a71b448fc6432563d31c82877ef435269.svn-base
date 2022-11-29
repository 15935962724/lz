package tea.http;

import java.io.*;
import java.net.*;
import java.util.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.*;
import tea.entity.site.*;
import java.util.regex.*;
import tea.entity.os.*;

public class MultipartRequest
{
	static final Pattern IGNORE = Pattern.compile("[" + (char) 0 + ":]|[ ./\\\\]+$");
	public HttpServletRequest _req;
	private Hashtable _ht = new Hashtable();
	private String uploadid;
	private int uploadsum;
	public byte[] getBytesParameter(String s)
	{
		String str = getParameter(s);
		if(str != null)
		{
			File f = new File(_req.getRealPath(str));
			if(f.exists())
			{
				ByteArrayOutputStream os = new ByteArrayOutputStream();
				try
				{
					BufferedInputStream fis = new BufferedInputStream(new FileInputStream(f));
					int v;
					while((v = fis.read()) != -1)
					{
						os.write(v);
					}
					fis.close();
				} catch(IOException ex)
				{
				}
				f.delete();
				return os.toByteArray();
			}
		}
		return null;
	}

	public MultipartRequest(HttpServletRequest servletrequest) throws IOException
	{
		_req = servletrequest;
		String s = servletrequest.getContentType();
		if(s != null && s.toLowerCase().startsWith("multipart/form-data"))
		{
			String ce = _req.getCharacterEncoding();
//            if (servletrequest.getContentLength() > 0x4b0000)
//                throw new IOException("Posted content length exceeds 30000K");
			int i = s.indexOf("boundary=");
			if(i == -1)
			{
				throw new IOException("Can not find boundary: " + s);
			}
			String s1 = "--" + s.substring(i + 9);
			int len = _req.getContentLength();
			HttpSession session = _req.getSession();
			session.setAttribute("http.length",new Integer(len));
			MPServletInputStream sis = new MPServletInputStream(_req.getInputStream(),s1,len);
			String s2 = null;
			do
			{
				s2 = sis.readLine();
				if(s2 == null)
				{
					//_blMultipart = false;
					return;
				}
			} while(!s2.startsWith(s1));
			do
			{
				String s3 = sis.readLine();
				if(s3 == null)
				{
					break;
				}
				String s4 = s3;
				s3 = s4.toLowerCase();
				int j = s3.indexOf("content-disposition: ");
				int k = s3.indexOf(";");
				if(j == -1 || k == -1)
				{
					throw new IOException("Content disposition corrupt: " + s4);
				}
				String s5 = s3.substring(j + 21,k);
				if(!s5.equals("form-data"))
				{
					throw new IOException("Invalid content disposition: " + s5);
				}
				j = s3.indexOf("name=\"",k);
				k = s3.indexOf("\"",j + 6);
				if(j == -1 || k == -1)
				{
					break;
				}
				String s6 = s4.substring(j + 6,k);
				String s7 = null;
				j = s3.indexOf("filename=\"",k + 2);
				k = s3.indexOf("\"",j + 10);
				if(j != -1 && k != -1)
				{
					s7 = s4.substring(j + 10,k);
					int l = Math.max(s7.lastIndexOf('/'),s7.lastIndexOf('\\'));
					if(l > -1)
					{
						s7 = s7.substring(l + 1);
					}
					if(s7.length() == 0)
					{
						s7 = "unknown";
					}
				}
				s3 = sis.readLine();
				if(s3 == null)
				{
					break;
				}
				String s8 = null;
				s4 = s3;
				s3 = s4.toLowerCase();
				if(s3.startsWith("content-type"))
				{
					int i1 = s3.indexOf(" ");
					if(i1 == -1)
					{
						throw new IOException("Content type corrupt: " + s4);
					}
					s8 = s3.substring(i1 + 1);
				} else
				if(s3.length() != 0)
				{
					throw new IOException("Malformed line after disposition: " + s4);
				}
				if(s8 != null)
				{
					String s9 = sis.readLine();
					if(s9 == null || s9.length() > 0)
					{
						throw new IOException("Malformed line after content type: " + s9);
					}
				} else
				{
					s8 = "application/octet-stream";
				}
				if(s7 == null)
				{
					StringBuffer stringbuffer = new StringBuffer();
					String s10;
					while((s10 = sis.readLine()) != null)
					{
						if(s10.startsWith(s1))
						{
							break;
						}
						stringbuffer.append(s10 + "\r\n");
					}
					if(stringbuffer.length() != 0)
					{
						stringbuffer.setLength(stringbuffer.length() - 2);
						s7 = stringbuffer.toString();
						if(ce != null)
						{
							s7 = new String(s7.getBytes("ISO-8859-1"),ce);
						}
					}
					if(s6.equals("uploadid"))
					{
						uploadid = s7;
						continue;
					}
				} else
				{
					String community = getParameter("community");
					Cluster c = Cluster.getInstance();
					String re = getParameter("repository");
					if(re == null)
						re = new SimpleDateFormat("yyMM").format(new Date());
					String dir = "/" + c.getPath() + "/" + community + "/" + re + "/";
					File d = new File(_req.getRealPath(dir));
					if(ce != null)
						s7 = new String(s7.getBytes("ISO-8859-1"),ce);
					s7 = s7.replace(' ','_').toLowerCase();
					//扩展名校验
					int of = s7.lastIndexOf('.');
					if(of == -1)
					{
						of = s7.length();
						s7 += ".jpg";
					}
					String suffix = s7.substring(of);
					if(re.contains("..") || IGNORE.matcher(s7).find() || Pattern.compile("jsp|jspx|asp|aspx|php|html|htm|shtml|js|body|class").matcher(suffix.substring(1)).find())
					{
						String ip = _req.getRemoteAddr();
						Filex.logs("MultipartRequest.log","上传非法格式, IP:" + ip + ", VAL:" + s7 + ", REF:" + _req.getHeader("Referer") + ", URL:" + _req.getRequestURI() + "?" + _req.getQueryString());
						if(!ip.startsWith("10.") && !ip.startsWith("192."))
						{
							IpSec.add(ip,"上传非法格式：" + s7 + "，网址：" + _req.getHeader("Referer"));
						}
						return;
					}
					s7 = s7.substring(0,of);
					File f;
					if("flow".equals(re)) //实名存储
					{
						int x = 0;
						do
						{
							f = new File(d,++x + "/" + s7 + suffix);
						} while(f.exists());
						s7 = dir + x + "/" + f.getName();
					} else //文件名后加序号
					{
						int x = 0;
						do
						{
							f = new File(d,s7 + (x++ > 0 ? "(" + x + ")" : "") + suffix);
						} while(f.exists());
						s7 = dir + f.getName();
					}
					f.getParentFile().mkdirs();
					FileOutputStream os = new FileOutputStream(f);
					try
					{
						StringBuilder htm = new StringBuilder();
						int j1 = 0,start = 0,end;
						byte abyte0[] = new byte[8192];
						boolean flag = false;
						while((j1 = sis.readLine(abyte0,0,abyte0.length)) != -1)
						{
							String line = new String(abyte0,0,j1);
							if(line.startsWith(s1))
								break;
							line = line.replace('?','%');
							while((start = htm.length() < 1 ? line.indexOf("<%",start) : 0) != -1)
							{
								end = line.indexOf("%>",start);
								if(end == -1)
								{
									if(htm.length() > 1048576) //1M
										htm.delete(0,htm.length());
									htm.append(line.substring(start));
									start = 0;
									break;
								}
								htm.append(line.substring(start,start = end + 2));
								if(Pattern.compile("java\\s*\\.\\s*io\\s*\\.|Runtime\\s*\\.\\s*getRuntime\\s*\\(\\s*\\)|new\\s+ProcessBuilder\\s*\\(|\\.\\s*invoke\\s*\\(|[\\s(=%;]+eval[\\s(]+|[\\s.]+exec[\\s(]+|[\\s.]+shell_exec[\\s(]+",Pattern.CASE_INSENSITIVE).matcher(htm).find())
								{
									Filex.logs("MultipartRequest.log","上传非法内容, IP:" + _req.getRemoteAddr() + ", VAL:" + f.getPath() + "/" + htm.toString() + ", REF:" + _req.getHeader("Referer") + ", URL:" + _req.getRequestURI() + "?" + _req.getQueryString());
									return;
								}
								htm.delete(0,htm.length());
							}
							if(flag)
							{
								os.write(13);
								os.write(10);
								flag = false;
							}
							if(j1 >= 2 && abyte0[j1 - 2] == 13 && abyte0[j1 - 1] == 10)
							{
								os.write(abyte0,0,j1 - 2);
								flag = true;
							} else
							{
								os.write(abyte0,0,j1);
							}
							if(uploadid != null)
							{
								session.setAttribute(uploadid,uploadsum + ":" + sis.totalRead + ":" + f.getName());
							}
						}
					} catch(SocketTimeoutException ex)
					{
						os.close();
						f.delete();
						throw ex;
					} finally
					{
						os.close();
					}
					if(f.length() == 0L)
					{
						f.delete();
						continue;
					}
					uploadsum++; //已传张数
					c.add(s7); //保存文件列表
					//
					try
					{
						Attch a = new Attch(Seq.get());
						a.community = community;
						a.trace = "MultipartRequest\r\nip: " + _req.getRemoteAddr() + "\r\nurl: " + _req.getRequestURI() + "?" + _req.getQueryString() + "\r\nref: " + _req.getHeader("referer") + "\r\nua: " + _req.getHeader("user-agent");
						a.type = suffix.substring(1);
						a.path = s7;
						a.set();
					} catch(Throwable ex)
					{
						ex.printStackTrace();
					}
					/*
					   if (community != null && !"false".equals(getParameter("watermark")))
					   {
					 Watermark.mark(community, f);
					   }
					 */
					//
					ArrayList al = new ArrayList();
					al.add(f.getName());
					_ht.put(s6 + "Name",al);
				}
				ArrayList al = (ArrayList) _ht.get(s6);
				if(al == null)
				{
					al = new ArrayList();
				}
				al.add(s7);
				_ht.put(s6,al);
			} while(true);
			if(uploadid != null)
			{
				session.removeAttribute(uploadid);
			}
		}
	}

	public String getParameter(String name)
	{
		String[] arr = getParameterValues(name);
		String val = arr == null ? _req.getParameter(name) : arr[0];
		if(val != null)
			val = val.replace((char) 0,' ');
		return val;
	}

	public String[] getParameterValues(String name)
	{
		ArrayList al = (ArrayList) _ht.get(name);
		if(al == null)
		{
			return _req.getParameterValues(name);
		}
		String arr[] = new String[al.size()];
		al.toArray(arr);
		return arr;
	}

	public String getQueryString()
	{
		return _req.getQueryString();
	}

	public String getRequestURI()
	{
		return _req.getRequestURI();
	}

	public javax.servlet.http.HttpServletRequest getRequest()
	{
		return _req;
	}

}


class MPServletInputStream
{
	ServletInputStream in;
	String boundary;
	int totalExpected;
	protected int totalRead;
	byte buf[];

	public MPServletInputStream(ServletInputStream servletinputstream,String s,int i)
	{
		totalRead = 0;
		buf = new byte[8192];
		in = servletinputstream;
		boundary = s;
		totalExpected = i;
	}

	public String readLine() throws IOException
	{
		StringBuffer sb = new StringBuffer();
		int i;
		do
		{
			i = readLine(buf,0,buf.length);
			if(i != -1)
			{
				sb.append(new String(buf,0,i,"ISO-8859-1"));
			}
		} while(i == buf.length);
		if(sb.length() == 0)
		{
			return null;
		} else
		{
			sb.setLength(sb.length() - 2);
			return sb.toString();
		}
	}

	public int readLine(byte abyte0[],int i,int j) throws IOException
	{
		if(totalRead >= totalExpected)
		{
			return -1;
		}
		int av = in.available(); //IIS+tomcat后上传文件问题.
		if(av < 200)
		{
			try
			{
				Thread.sleep(100);
			} catch(InterruptedException ex)
			{
			}
		}
		int k = in.readLine(abyte0,i,j);
		if(k > 0)
		{
			totalRead += k;
		}
		return k;
	}

}
