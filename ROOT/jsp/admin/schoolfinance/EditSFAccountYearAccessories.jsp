<%@page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*" %>
<%!
 public  String write(String community, byte byDate[])
    {
        java.io.ByteArrayOutputStream bytestream = new ByteArrayOutputStream();
        OutputStream file = null;
        java.io.File f = new java.io.File(getServletContext().getRealPath("/tea/image/type/" + community + "/" + String.valueOf(System.currentTimeMillis()) + ".gif"));
        if (!f.getParentFile().exists())
        {
            f.getParentFile().mkdirs();
        } while (f.exists())
        {
            f = new java.io.File(getServletContext().getRealPath("/tea/image/type/" + community + "/" + String.valueOf(System.currentTimeMillis()) + ".gif"));
        }
        try
        {
            bytestream.write(byDate);
            file = new FileOutputStream(f);
            bytestream.writeTo(file);
            return "/tea/image/type/" + community + "/" + f.getName();
        } catch (Exception e)
        {
            e.printStackTrace();
        } finally
        {
            try
            {
                if (file != null)
                {
                    file.close();
                }
                bytestream.close();
            } catch (IOException ex)
            {
            }
        }
        return "";
    }
%>
<%
request.setCharacterEncoding("UTF-8");
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
int rootid = tea.entity.admin.SFAccount.getRootId(node.getCommunity());


java.util.Calendar c=  java.util.Calendar.getInstance();
int formsyear;
String _strFormsyear=teasession.getParameter("formsyear");
if(_strFormsyear!=null)
formsyear=Integer.parseInt(_strFormsyear);
else
{
  formsyear= c.get(  java.util.Calendar.YEAR);
}
int sfaccount=Integer.parseInt(teasession.getParameter("sfaccount"));





if(request.getMethod().equals("POST"))
{
  String del=teasession.getParameter("del");
  if(del!=null)
  {
    int sfaccountyearaccessories= Integer.parseInt(teasession.getParameter("sfaccountyearaccessories"));
    tea.entity.admin.SFAccountYearAccessories sfay_obj=  tea.entity.admin.SFAccountYearAccessories.find(sfaccountyearaccessories);
    sfay_obj.delete();
  }else
  {
    byte by[]=teasession.getBytesParameter("picture");
    if(by!=null)
    {
      String name=teasession.getParameter("pictureName");
      tea.entity.admin.SFAccountYearAccessories.find(0).set(formsyear,sfaccount,name,write(node.getCommunity(),by));
    }
  }
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>

<form action="/jsp/admin/schoolfinance/EditSFAccountYearAccessories.jsp?node=<%=teasession._nNode%>" name="form111" method="POST" enctype="multipart/form-data">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="sfaccountyearaccessories" value="0"/>
<input type="hidden" name="sfaccount" value="<%=sfaccount%>"/>
<input type="hidden" name="formsyear" value="<%=formsyear%>"/>


<input type="file" name="picture">
<input type="submit" name="up" value="上传附件"/>
<br/>
<%
java.util.Enumeration enumer= tea.entity.admin.SFAccountYearAccessories.find(formsyear,sfaccount);
while(enumer.hasMoreElements())
{
  int id=((Integer) enumer.nextElement()).intValue();
  tea.entity.admin.SFAccountYearAccessories sfay_obj=  tea.entity.admin.SFAccountYearAccessories.find(id);

%>
<A href="<%=sfay_obj.getPicture()%>" target="_blank"><%=sfay_obj.getName()%></A><input type="submit" name="del" value="删除" onClick="if(confirm('确认删除')){form111.sfaccountyearaccessories.value='<%=id%>'; return true;}else{return false;}"/><Br>
<%
}
%>
</form>
</body>
</html>



