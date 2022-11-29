<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.*" %>
<%@page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
int[] ly = new int[7];
ly[6] = (int)(Math.random()*(16-1)+1);
int index = 0;
int z = 6;
boolean tf = false;
for(int i = 0; i < z; i ++){

  int d = (int)(Math.random()*(33-1)+1);
  if(d!=ly[0]&&d!=ly[1]&&d!=ly[2]&&d!=ly[3]&&d!=ly[4]&&d!=ly[5]){
    ly[index] = d;
    index++;

  }else
  {
    z++;
  }

}
String result = "";
int temp;


for(int i=1;i<6;i++)
{
  for(int j=6-1;j>=i;j--)
  {
    if(ly[j]<ly[j-1])
    {
      temp = ly[j-1];
      ly[j-1] = ly[j];
      ly[j] = temp;
    }
  }
}


  for(int i = 0 ; i < 6; i++){
    result +=ly[i]+",";
  }
  out.print(result+"　"+ly[6]);

  %>

