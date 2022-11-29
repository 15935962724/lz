package tea.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Properties;

public class ReadProperties {

 public void saveProperty() throws Exception {

  FileOutputStream output = new FileOutputStream(new File("./lucene.properties"),false);
  //true参数表示:在保留原来数据的基础上新增数据
  Properties p = new Properties();
  p.setProperty("hours", "48");
  p.store(output, "");
  output.close();
 }

/* public static void main(String[] args) throws Exception {

  ReadProperties rp = new ReadProperties();
  InputStream in = new BufferedInputStream(new FileInputStream("./lucene.properties"));
  Properties p = new Properties();
  p.load(in);
  String s = p.getProperty("hours");
  System.out.print(s);
  in.close();
   rp.saveProperty();
 }*/

}

