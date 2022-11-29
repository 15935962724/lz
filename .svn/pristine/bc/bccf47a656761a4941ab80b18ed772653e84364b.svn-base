<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/NightShop");
r.add("/tea/resource/Search");
r.add("/tea/resource/Event");
int type122518649 =45;
if(request.getParameter("type")!=null)
type122518649=Integer.parseInt(request.getParameter("type"));
switch(type122518649)
{
    case 21:
    r.add("/tea/ui/node/type/classified/EditClassified");
    break;
    case 50:
    r.add("/tea/resource/Job");
    break;
    case 52:
    r.add("/tea/resource/Resume");
    break;
}

  String name=request.getParameter("name");
  String value=request.getParameter("value");
  if(value==null)
  value="";
  java.util.Enumeration enumeration=null;
  if( type122518649!=255)
  {
    enumeration=Field.findByType(type122518649);
    try
    {
      r.add("/tea/resource/"+Node.NODE_TYPE[type122518649]);
    }catch(java.lang.Exception e)
    {}
  }

String ALL_FIELD[]={"All","Content","Subject","Keywords","Creator","Path"};

out.print("<SELECT name="+name+">");
out.print("<OPTION VALUE=None >---------------</OPTION>");

if(request.getParameter("order")==null&&request.getParameter("than")==null)
{
   for(int i=0;i<ALL_FIELD.length;i++)
   {
         String field=ALL_FIELD[i].toLowerCase();
         out.print("<option value="+field);
         if(value.equals(field))
         out.print(" SELECTED ");
         out.print(">"+r.getString(teasession._nLanguage,ALL_FIELD[i]));
   }
   if(type122518649!=255)
   {
       while(enumeration.hasMoreElements())
       {
         Field field= (Field) enumeration.nextElement();
         out.print("<option value="+field.getName());
         if(value.equals(field.getName()))
         out.print(" SELECTED ");
         out.print(">"+r.getString(teasession._nLanguage,field.getCapital()));
       }
   }
   if(type122518649==52)//����
   {
         out.print("<option value=apply");
         if(value.equals("apply"))
         out.print(" SELECTED ");
         out.print(">"+r.getString(teasession._nLanguage,"Apply"));
   }
} else
{
  %>
   <OPTION  VALUE="time" <%=getSelect("time".equals(value))%> ><%=r.getString(teasession._nLanguage, "IssueTime")%></OPTION>
  <OPTION  VALUE="updatetime" <%=getSelect("updatetime".equals(value))%> ><%=r.getString(teasession._nLanguage, "UpdateTime")%></OPTION>

  <%
    if(   type122518649!=255)
    {if( request.getParameter("order")!=null){%>  <OPTION  VALUE="menuOrder"  <%=getSelect(value.equals("menuOrder"))%> ><%=r.getString(teasession._nLanguage, "MenuOrder")%></OPTION>
    <%}while(enumeration.hasMoreElements())
      {     Field field= (Field)  enumeration.nextElement();
            String typeName=field.getDataType();
            if(!typeName.equals("varchar")&&!typeName.equals("char")&&!typeName.equals("text")&&!typeName.equals("image"))
            {
%>  <OPTION <%=getSelect(value.equals(field.getName()))%> VALUE="<%= field.getName()%>"><%=r.getString(teasession._nLanguage,field.getCapital())%></OPTION>
<%
            }
       }
    }
}
out.print("</SELECT>");
%>


