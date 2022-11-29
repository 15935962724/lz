package tea;
import java.io.*;
import java.util.StringTokenizer;

public class DelimitedDataFile
{

private String currentRecord = null;
private BufferedReader file;
private String path;
private StringTokenizer token;
//创建文件对象
public DelimitedDataFile()
{file = new BufferedReader(new InputStreamReader(System.in),1);
}
public DelimitedDataFile(String filePath) throws FileNotFoundException
{path = filePath;
file = new BufferedReader(new FileReader(path));
}
//设置文件路径
public void setPath(String filePath)
{path = filePath;
try {
file = new BufferedReader(new
FileReader(path));
} catch (FileNotFoundException e) {
System.out.println("file not found");
}
}
//得到文件路径
public String getPath() {
return path;
}
//关闭文件
public void fileClose() throws IOException
{
file.close();
}
//读取下一行记录，若没有则返回-1
public int nextRecord()
{int returnInt = -1;
    try{currentRecord = file.readLine();}
	catch (IOException e)
		{System.out.println("readLine problem, terminating.");}
	if (currentRecord == null)
		returnInt = -1;
	else
		{
		token = new StringTokenizer(currentRecord);
		returnInt = token.countTokens();}
		return returnInt;}
		//以字符串的形式返回整个记录
		public String returnRecord()
		{return currentRecord;
		}
public String replace(String allstr,String replstr1,String replstr2) {
            while(allstr.indexOf(replstr1)!=-1)
              allstr=allstr.substring(0,allstr.indexOf(replstr1))+replstr2+allstr.substring(allstr.indexOf(replstr1)+replstr1.length());
            return allstr;
          }
public String writeSomething(String something){
try {FileWriter theFile = new FileWriter("d:\\test.txt",true);
PrintWriter out = new PrintWriter(theFile);
out.println(something + " ");
out.close();
theFile.close();
return "Das war sehr gut!";
}catch (IOException e) {
	return e.toString();}
}
		}
