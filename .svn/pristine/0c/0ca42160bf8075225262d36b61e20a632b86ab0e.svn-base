package tea.entity.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.SQLException;

import tea.db.DbAdapter;

public class ReadFile{

public ReadFile(){
}
/** *//**
   * 读取源文件内容
   * @param filename String 文件路径
   * @throws IOException
   * @return byte[] 文件内容
   */
public static byte[] readFile(String filename) throws IOException {

    File file =new File(filename);
    System.out.println(filename);
    if(filename==null || filename.equals(""))
    {
      throw new NullPointerException("无效的文件路径");
    }
    long len = file.length();
    byte[] bytes = new byte[(int)len];

    BufferedInputStream bufferedInputStream=new BufferedInputStream(new FileInputStream(file));
    int r = bufferedInputStream.read( bytes );
    if (r != len)
      throw new IOException("读取文件不正确");
    bufferedInputStream.close();

    return bytes;

}
public static byte[] readFile(File file) throws IOException {

  
    long len = file.length();
    byte[] bytes = new byte[(int)len];

    BufferedInputStream bufferedInputStream=new BufferedInputStream(new FileInputStream(file));
    int r = bufferedInputStream.read( bytes );
    if (r != len)
      throw new IOException("读取文件不正确");
    bufferedInputStream.close();

    return bytes;

}
/** *//**
   * 将数据写入文件
   * @param data byte[]
   * @throws IOException
   */
public static void writeFile(byte[] data,String filename) throws IOException {
    File file =new File(filename);
    file.getParentFile().mkdirs();
    BufferedOutputStream bufferedOutputStream=new BufferedOutputStream(new FileOutputStream(file));
    bufferedOutputStream.write(data);
    bufferedOutputStream.close();

}

/** *//**
   * 从jar文件里读取class
   * @param filename String
   * @throws IOException
   * @return byte[]
   */
public byte[] readFileJar(String filename) throws IOException {
    BufferedInputStream bufferedInputStream=new BufferedInputStream(getClass().getResource(filename).openStream());
    int len=bufferedInputStream.available();
    byte[] bytes=new byte[len];
    int r=bufferedInputStream.read(bytes);
    if(len!=r)
    {
      bytes=null;
      throw new IOException("读取文件不正确");
    }
    bufferedInputStream.close();
    return bytes;
}

/** *//**
   * 读取网络流，为了防止中文的问题，在读取过程中没有进行编码转换，而且采取了动态的byte[]的方式获得所有的byte返回
   * @param bufferedInputStream BufferedInputStream
   * @throws IOException
   * @return byte[]
   */
public byte[] readUrlStream(BufferedInputStream bufferedInputStream) throws IOException {
    byte[] bytes = new byte[100];
    byte[] bytecount=null;
    int n=0;
    int ilength=0;
    while((n=bufferedInputStream.read(bytes))>=0)
    {
      if(bytecount!=null)
        ilength=bytecount.length;
      byte[] tempbyte=new byte[ilength+n];
      if(bytecount!=null)
      {
        System.arraycopy(bytecount,0,tempbyte,0,ilength);
      }

      System.arraycopy(bytes,0,tempbyte,ilength,n);
      bytecount=tempbyte;

      if(n<bytes.length)
        break;
    }
    return bytecount;
}
public static int find(String community,String subject,int father) throws SQLException
{
   int flag=0;
	DbAdapter db = new DbAdapter();
	try
	{
		db.executeQuery("SELECT n.node FROM Node n,NodeLayer nl  WHERE n.node=nl.node and n.father="+father+" and nl.subject like "+DbAdapter.cite(subject)+" and n.community =" +DbAdapter.cite(community));

	   if(db.next())
		{
		   flag=db.getInt(1);
		}
	} finally
	{
		db.close();
	}
	return flag;
}
}

