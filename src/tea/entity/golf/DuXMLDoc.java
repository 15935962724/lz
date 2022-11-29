package tea.entity.golf;

import java.io.IOException;
import java.io.StringReader;
import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;

public class DuXMLDoc {
    public List xmlElements(String xmlDoc) {
        //创建一个新的字符串
        StringReader read = new StringReader(xmlDoc);
        //创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
        InputSource source = new InputSource(read);
        //创建一个新的SAXBuilder
        SAXBuilder sb = new SAXBuilder();
        
        try {
            //通过输入源构造一个Document
            Document doc = sb.build(source);
            //取的根元素
            Element root = doc.getRootElement();
            System.out.println("tasktypename:"+root.getAttributeValue("tasktypename"));
            System.out.println("perfrenceNum:"+root.getAttributeValue("perfrenceNum"));
            System.out.println(root.getName());//输出根元素的名称（测试）
            //得到根元素所有子元素的集合
            List jiedian = root.getChildren();
            
            Element et = null;
            for(int i=0;i<jiedian.size();i++){
                et = (Element) jiedian.get(i);//循环依次得到子元素
                
                if(et.getAttributeValue("inputindex").equals("1")){
                    et.setAttribute("name","1");
                }
                et.setAttribute("age","15");
                System.out.println("name:"+et.getAttributeValue("name"));
                System.out.println("value:"+et.getAttributeValue("value"));
                System.out.println("inputindex:"+et.getAttributeValue("inputindex"));
                System.out.println("perfrence:"+et.getAttributeValue("perfrence"));
                System.out.println("age:"+et.getAttributeValue("age"));
            }
//           
//            et = (Element) jiedian.get(0);
//            List zjiedian = et.getChildren();
//            for(int j=0;j<zjiedian.size();j++){
//                Element xet = (Element) zjiedian.get(j);
//                System.out.println(xet.getName());
//            }
        } catch (JDOMException e) {
            // TODO 自动生成 catch 块
            e.printStackTrace();
        } catch (IOException e) {
            // TODO 自动生成 catch 块
            e.printStackTrace();
        }
        return null;
    }
   /* public static void main(String[] args){
        DuXMLDoc doc = new DuXMLDoc();
        String xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+
        "<submittask tasktypename=\"kind1\" perfrenceNum=\"2\">"+
        "<input name=\"name\" value=\"123\" inputindex=\"1\" perfrence=\"2\"/>"+
        "<input name=\"sex\" value=\"F\" inputindex=\"2\" perfrence=\"2\"/>"+
        "</submittask>"
        ;
        System.out.println(xml);
        doc.xmlElements(xml);
    }*/
}