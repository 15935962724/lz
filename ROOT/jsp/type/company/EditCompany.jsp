<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
//            if(!node.isCreator(teasession._rv))
//            {
//                response.sendError(403);
//                return;
//            }

boolean _bNew=request.getParameter("NewNode")!=null;

r.add("/tea/resource/Company");

Company obj;
String name;
String text;
String license=null,logo=null,picture=null;
int sequence;
int len=0,logolen=0,picturelen=0;

if(_bNew)
{
  obj = Company.find(0);
  name="";
  text="";
  sequence= Node.getMaxSequence(teasession._nNode) + 10;
}else
{
  obj=Company.find(teasession._nNode);
  name=node.getSubject(teasession._nLanguage);
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));

  license=obj.getLicense(teasession._nLanguage);
  if(license!=null)
  len=(int)new File(application.getRealPath(license)).length();

  logo=obj.getLogo(teasession._nLanguage);
  if(logo!=null)
  logolen=(int)new File(application.getRealPath(logo)).length();

  picture=obj.getPicture(teasession._nLanguage);
  if(picture!=null)
  picturelen=(int)new File(application.getRealPath(picture)).length();
  sequence=node.getSequence();
}
String community=node.getCommunity();

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="" src="/tea/card.js"></script>
<script type="">
function submit()
{
  return true;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Company")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM  name="form1" METHOD="POST" action="/servlet/EditCompany" enctype="multipart/form-data" onSubmit="return submitText(this.Node, '<%=r.getString(teasession._nLanguage, "InvalidSelect")%>')&&submitText(this.Name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");

if(_bNew)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode value=ON>");
  Hashtable h=new Hashtable();
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT n.node FROM Node n,Category c WHERE n.node=c.node AND c.category=21 AND n.community="+db.cite(community));
    while(db.next())
    {
      int id=db.getInt(1);
      Node n=Node.find(id);
      Integer f=new Integer(n.getFather());
      StringBuffer sb=(StringBuffer)h.get(f);
      if(sb==null)
    	  sb=new StringBuffer();
      sb.append("op[op.length]=new Option(\"").append(n.getSubject(teasession._nLanguage)).append("\",").append(id).append(");");
      h.put(f,sb);
    }
  }finally
  {
    db.close();
  }
  out.print("<script>function f_change(father){var op=form1.Node.options; while(op.length>1)op[1]=null; switch(parseInt(father.value)){");
  StringBuffer sb=new StringBuffer();
  sb.append("<tr><td>"+r.getString(teasession._nLanguage, "Type")+":</td><td><select name=father onchange=\"f_change(this);\"><option value=''>-----------------");
  Enumeration e=h.keys();
  while(e.hasMoreElements())
  {
	Integer inte=(Integer)e.nextElement();
	Node n=Node.find(inte.intValue());
	sb.append("<option value="+n._nNode+">"+n.getSubject(teasession._nLanguage));
	StringBuffer op=(StringBuffer)h.get(inte);
	out.print("case "+n._nNode+":");
	out.print(op.toString());
	out.print("break;");
  }
  sb.append("</select><select name=Node ><option value=''>-----------------</select>");
  out.print("}}</script>");
  out.print(sb.toString());
}else
  out.print("<input type=hidden name=Node value="+teasession._nNode+">");

%>  <tr>
      <td>*<%=r.getString(teasession._nLanguage, "Company.name")%>:</td>
      <td colspan="2"><input type="text" class="edit_input"  name="Name" size="40" MAXLENGTH="255" value="<%=(name)%>"></td>
    </tr>
    <tr>
      <td>logo:</td>
      <td colspan="2">
        <input type=file  name=logo>
          <%
          if(logolen>0)
          {
            out.print("<a href="+logo+" target=_blank>"+logolen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input type=checkbox name=logoClear onclick='form1.logo.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td colspan="2">
         <input type=file  name=picture>
          <%
          if(picturelen>0)
          {
            out.print("<a href="+picture+" target=_blank>"+picturelen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input type=checkbox name=pictureClear onclick='form1.picture.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.superior")%>:</td>
      <td colspan="2"><select name="superior">
          <option value=0 >--------------</option>
          <%
          java.util.Enumeration enumer=Node.findByType(21,community);
          int nodecode;
          while(enumer.hasMoreElements())
          {
                nodecode=((Integer)enumer.nextElement()).intValue();
                if( nodecode!=teasession._nNode)
                {
                    out.print("<option ");
                    if(nodecode==obj.getSuperior(teasession._nLanguage))
                    out.print("SELECTED ");
                    out.print("value="+nodecode+">"+tea.entity.node.Node.find(nodecode).getSubject(teasession._nLanguage));
                }
           }%>
        </select></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.intro")%>:</td>
      <td colspan="2"><textarea name="Text" rows="8" cols="70" class="edit_input"><%=text%></textarea></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
      <td><input type="text" class="edit_input"  name=Contact value="<%=getNull(obj.getContact(teasession._nLanguage))%>">
        <INPUT  id="radio" type="radio" NAME="rdoGender" value="1" CHECKED><%=r.getString(teasession._nLanguage, "Man")%>
        <INPUT  id="radio" type="radio" NAME="rdoGender" value="0"<%=getCheck(!obj.getSex(teasession._nLanguage))%>><%=r.getString(teasession._nLanguage, "Woman")%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
      <td><input type="text" class="edit_input"  name=Email value="<%=getNull(obj.getEmail(teasession._nLanguage))%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Organization")%>:</td>
      <td colspan="2"><input type="text" class="edit_input"  name=Organization value="<%=getNull(obj.getOrganization(teasession._nLanguage))%>" SIZE=40 MAXLENGTH=40></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "City")%>:</td>
      <td>
      <!--
      <select name=City >
      <option value="0">------------
      <%--
      Enumeration e=Card.find(" AND card<100",0,100);
      while(e.hasMoreElements())
      {
        Card card=(Card)e.nextElement();
        int id=card.getCard();
        out.print("<option value="+id);
        if(id==obj.getCity(teasession._nLanguage))
        out.print(" SELECTED ");
        out.print(">"+card.getAddress());
      }
      --%>
      </select>
      -->
      <script type="">selectcard("city0",null,null,"<%=obj.getCity(teasession._nLanguage)%>");</script>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td colspan="2"><TEXTAREA name=Address  class="edit_input" ROWS=2 COLS=60><%=HtmlElement.htmlToText(getNull(obj.getAddress(teasession._nLanguage)))%></TEXTAREA></td>
    </tr>
    <!--
    <tr>
      <td><%=r.getString(teasession._nLanguage, "State")%>:</td>
      <td><input type="text" class="edit_input"  name=State value="<%=getNull(obj.getState(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    -->
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
      <td><input type="text" class="edit_input"  name=Zip value="<%=getNull(obj.getZip(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.country")%>:</td>
      <td><input type="text" class="edit_input"  name="Country" value="<%=getNull(obj.getCountry(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
      <td><input type="text" class="edit_input"  name=Telephone value="<%=getNull(obj.getTelephone(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
      <td><input type="text" class="edit_input"  name=Fax value="<%=getNull(obj.getFax(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "WebPage")%>:</td>
      <td colspan="2"><input type="text" class="edit_input"  name=WebPage value="<%=getNull(obj.getWebPage(teasession._nLanguage))%>" SIZE=60 MAXLENGTH=255></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "??????")%>:</td>
      <td><input name="map" value="<%=getNull(obj.getMap(teasession._nLanguage))%>" SIZE=60 MAXLENGTH=255></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "??????")%>:</td>
      <td><input name="eyp" value="<%=getNull(obj.getEyp(teasession._nLanguage))%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sequence")%>:</td>
      <td><input type="text" class="edit_input"  name=sequence  value="<%=sequence%>" ></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "License")%>:</td>
      <td colspan="2"><input type="file"  name="license" class="edit_input" />
      <%
      if(len>0)
      {
        out.print("<a href="+license+" target=_blank>"+len+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
        out.print("<input type=checkbox name=Clear onclick='form1.license.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
      }
      %>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.property")%>:</td>
      <td><select name="property" >
      <%
      for(int index=0;index<Company.PROPERTY_TYPE.length;index++)
      {
        out.print("<OPTION value="+index);
        if(index==obj.getProperty(teasession._nLanguage))
        out.print(" SELECTED ");
        out.print(">"+Company.PROPERTY_TYPE[index]);
      }
      %></select>
      </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Company.size")%></td>
        <td>
        <SELECT NAME="scale">
        <%
        for(int index=0;index<Company.SIZE_TYPE.length;index++)
        {
          out.print("<OPTION value="+index);
          if(index==obj.getScale(teasession._nLanguage))
          out.print(" SELECTED ");
          out.print(">"+Company.SIZE_TYPE[index]);
        }
        %>
        </SELECT>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.calling")%>???</td>
      <td colspan="2"><%=new tea.htmlx.TradeSelection("calling",obj.getCalling(teasession._nLanguage))%>
        <%--
 <SELECT  class="edit_input" NAME="lstIndustry" SIZE="5"  MULTIPLE  STYLE="width:275px">
<OPTION value="100">?????????</OPTION>
<OPTION value="3600">???????????????????????</OPTION>
<OPTION value="300">???????????????????????</OPTION>
<OPTION value="400">?????????????????</OPTION>
<OPTION value="1300">???????????????(?????????????????????????????????)</OPTION>
<OPTION value="3800">????????????(?????????????????????????????????????)</OPTION>
<OPTION value="1400">?????????</OPTION>
<OPTION value="1101000">?????????????????</OPTION>
<OPTION value="1102000">???????????????????????????????????????????????????</OPTION>
<OPTION value="1103000">????????????????????????????????????????</OPTION>
<OPTION value="1104000">???????????????</OPTION>
<OPTION value="1500">????????????????????????????</OPTION>
<OPTION value="600">??????????????(?????????????????????????????????)</OPTION>
<OPTION value="700">?????????????????</OPTION>
<OPTION value="1700">??????????????????????</OPTION>
<OPTION value="1600">????????????????????????????</OPTION>
<OPTION value="3700">??????????????????????????</OPTION>
<OPTION value="1100">?????????????????</OPTION>
<OPTION value="800">??????????????????????</OPTION>
<OPTION value="900">????????????????????????????????????</OPTION>
<OPTION value="2800">????????????(??????????????????????????????????????????)</OPTION>
<OPTION value="1000">?????????(??????????????????????????????????????)</OPTION>
<OPTION value="1200">??????????????????????</OPTION>
<OPTION value="2500">??????????????????????????????????</OPTION>
<OPTION value="4000">????????????????????</OPTION>
<OPTION value="2000">????????????</OPTION>
<OPTION value="2300">????????????????????</OPTION>
<OPTION value="3200">????????????????????????????</OPTION>
<OPTION value="1800">????????????????????</OPTION>
<OPTION value="2100">?????????????????(???????????????????????????????)</OPTION>
<OPTION value="2200">?????????????????????????????????????????</OPTION>
<OPTION value="500">??????????????????????</OPTION>
<OPTION value="3900">???????????????????????????????</OPTION>
<OPTION value="1900">?????????????????????????????????????</OPTION>
<OPTION value="2600">??????????????????????</OPTION>
<OPTION value="2700">??????????????????????</OPTION>
<OPTION value="2400">????????????????????</OPTION>
<OPTION value="1105000">??????/?????????????????????</OPTION>
<OPTION value="1106000">?????????</OPTION>
<OPTION value="2900">??????????????????</OPTION>
<OPTION value="3100">??????????????????????????????????</OPTION>
<OPTION value="3300">????????????????????</OPTION>
<OPTION value="3400">???????????????????????????????????????</OPTION>
<OPTION value="3500">????????????</OPTION>
<OPTION value="4100">??????</OPTION>
              </SELECT> <SPAN CLASS="note">??????Ctrl???????????????????????????????????? </SPAN>--%>
      </td>
    </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Company.mode")%>???</td>
      <td colspan="2">
      <%
      String mode=obj.getMode(teasession._nLanguage);
      for(int index=0;index<Company.MODE_TYPE.length;index++)
      {
        out.print("<INPUT type=CHECKBOX NAME=mode"+index+"  onClick=\"return checkBizType(this);\" value="+index);
        if(mode!=null&&mode.indexOf("/"+index+"/")!=-1)
        out.print(" CHECKED ");
        out.print(">"+Company.MODE_TYPE[index]);
      }
      %>
      <br>
      <span class="note">(????????????2???????????????)</span> </td>
      <script language="javascript">
          // ????????????????????????????????????????????????2??????????????????2????????????
          function checkBizType(obj)
          {
            var counter = 0;
            if (form1.mode0.checked)counter++;
            if (form1.mode1.checked)counter++;
            if (form1.mode2.checked)counter++;
            if (form1.mode3.checked)counter++;
            if (form1.mode4&&form1.mode4.checked)counter++;
            if (form1.mode5&&form1.mode5.checked)counter++;
            if (form1.mode6&&form1.mode6.checked)counter++;
            if (form1.mode7&&form1.mode7.checked)counter++;
            if (counter > 2)
            {
              if (obj.checked)
              {
                alert("??????????????????2???????????????!");
                return false;
              }
            }
            return true;
          }
        </script>
    </tr>
    <tr id="regCapitalTr">
      <td><%=r.getString(teasession._nLanguage, "Company.enrol")%>???</td>
      <td colspan="2"><select name="enrol">
      <%
      for(int index=0;index<Company.ENROL_TYPE.length;index++)
      {
        out.print("<OPTION value="+index);
        if(index==obj.getEnrol(teasession._nLanguage))
        out.print(" SELECTED ");
        out.print(">"+Company.ENROL_TYPE[index]);
      }
      %>
        </select> <span class="note">?????????????????????</span>
      </td>
    </tr>
    <tr>
      <td ><%=r.getString(teasession._nLanguage, "Company.product")%>???<br>
        <span class=note>???????????????10?????? </span> </td>
      <td colspan="2">
        <%
        String product=obj.getProduct(teasession._nLanguage);
        int p_index=0;
        if(product!=null)
        {
          for(java.util.StringTokenizer tokenizer=new java.util.StringTokenizer(product,";");tokenizer.hasMoreTokens();p_index++)
          {
            out.println("<input type=text name=product"+p_index+" size=10 value=\""+tokenizer.nextToken()+"\" maxlength=20>???");
          }
        }
        for(;p_index<20;p_index++)
        {
          out.println("<input type=text name=product"+p_index+" size=10 maxlength=20>???");
        }
        %>
        <SPAN class=note>?????????????????????<font color="#FF0000">????????????</font>??????????????????</SPAN> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.enroladd")%>???</td>
      <td colspan="2"><input type="text" name="enroladd" value="<%=getNull(obj.getEnroladd(teasession._nLanguage))%>" size="30" maxlength=64>
        <span class="note">????????????</span> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.fareadd")%>???</td>
      <td colspan="2"><input type="text" name="fareadd" value="<%=getNull(obj.getFareadd(teasession._nLanguage))%>" size="30" maxlength=64>
      </td>
    </tr>
    <tr>
    <td><%=r.getString(teasession._nLanguage, "Company.birth")%>???</td>
      <td colspan="2"><input type="text" size=4 maxlength=4 name="birth" value="<%=getNull(obj.getBirth(teasession._nLanguage))%>">
        <span class=note>??????????????????2004???</span> </td>
    </tr>
    <!--
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.brand")%>???</td>
      <td colspan="2"><input type="text" name="brand" value="<%=getNull(obj.getBrand(teasession._nLanguage))%>" size="30" maxlength=32>
      </td>
    </tr>
    -->
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.principal")%>:</td>
      <td colspan="2"><input type="text" size=30 maxlength=32 name="principal" value="<%=getNull(obj.getPrincipal(teasession._nLanguage))%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.turnover")%>???</td>
      <td><select name="turnover">
      <%
      for(int index=1;index<Company.ENROL_TYPE.length;index++)
      {
        out.print("<OPTION value="+index);
        if(index==obj.getTurnover(teasession._nLanguage))
        out.print(" SELECTED ");
        out.print(">"+Company.ENROL_TYPE[index]);
      }
      %>
        </select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.agora")%>???<br>
        <span class="S"><font color="#999999">??????????????????????????????</font></span></td>
      <td colspan="2">
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)" id="TradeRegion1" value="??????"  ><label for="TradeRegion1">??????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion2" value="???????????????"  ><label for="TradeRegion2">???????????????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion3" value="??????"  ><label for="TradeRegion3">??????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion4" value="??????"  ><label for="TradeRegion4">??????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion5" value="??????"  ><label for="TradeRegion5">??????</label>
        <input  type="CHECKBOX" name="tradeRegion"  onclick="fclick(this,form1.p_z_Z_TradeRegion2)" id="TradeRegion6" value="??????"  ><label for="TradeRegion6">??????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion7" value="??????"  ><label for="TradeRegion7">??????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion8" value="?????????"  ><label for="TradeRegion8">?????????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion9" value="??????"  ><label for="TradeRegion9">??????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion10" value="??????"  ><label for="TradeRegion10">??????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion11" value="?????????"  ><label for="TradeRegion11">?????????</label>
        <input  type="CHECKBOX" name="tradeRegion" onclick="fclick(this,form1.p_z_Z_TradeRegion2)"  id="TradeRegion12" value="??????"  ><label for="TradeRegion12">??????</label>
        <br>
        <label for="TradeRegionOther">???????????????</label>
        <input type="text" name="p_z_Z_TradeRegion2" id="TradeRegionOther" size="70" maxlength=32 value="<%=getNull(obj.getAgora(teasession._nLanguage))%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.client")%>???</td>
      <td colspan="2"><input type="text" name="client" value="<%=getNull(obj.getClient(teasession._nLanguage))%>" size="30" maxlength=64>
        <span class="note"> ????????????????????????????????????</span></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.export")%>???</td>
      <td><select name="export">
      <%
      for(int index=1;index<Company.ENROL_TYPE.length;index++)
      {
        out.print("<OPTION value="+index);
        if(index==obj.getExport(teasession._nLanguage))
        out.print(" SELECTED ");
        out.print(">"+Company.ENROL_TYPE[index]);
      }
      %>
        </select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.imports")%>???</td>
      <td><select name="imports">
      <%
      for(int index=1;index<Company.ENROL_TYPE.length;index++)
      {
        out.print("<OPTION value="+index);
        if(index==obj.getImports(teasession._nLanguage))
        out.print(" SELECTED ");
        out.print(">"+Company.ENROL_TYPE[index]);
      }
      %>
        </select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.attestation")%>???</td>
      <td colspan="2">
        <input type="CHECKBOX" name="certification" onclick="fclick(this,form1.p_z_Z_Certification2)" id="Certification1" value="ISO9000"  ><label for="Certification1">ISO 9000</label>
        <input type="CHECKBOX" name="certification" onclick="fclick(this,form1.p_z_Z_Certification2)"  id="Certification2" value="ISO9001"  ><label for="Certification2">ISO 9001</label>
        <input type="CHECKBOX" name="certification"  onclick="fclick(this,form1.p_z_Z_Certification2)" id="Certification3" value="ISO9002"  ><label for="Certification3">ISO 9002</label>
        <input type="CHECKBOX" name="certification"  onclick="fclick(this,form1.p_z_Z_Certification2)" id="Certification4" value="ISO9003"  ><label for="Certification4">ISO 9003</label>
        <input type="CHECKBOX" name="certification"  onclick="fclick(this,form1.p_z_Z_Certification2)" id="Certification5" value="ISO9004"  ><label for="Certification5">ISO 9004</label>
        <input type="CHECKBOX" name="certification"  onclick="fclick(this,form1.p_z_Z_Certification2)" id="Certification6" value="ISO14000"  ><label for="Certification6">ISO 14000</label>
        <br>
        <label for="CertificationOther">?????????</label>
        <input type="text" name="p_z_Z_Certification2" id="CertificationOther" value="<%=getNull(obj.getAttestation(teasession._nLanguage))%>" size="40" maxlength=32>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.bank")%>???</td>
      <td><input type="text" name="bank" value="<%=getNull(obj.getBank(teasession._nLanguage))%>" size=30 maxlength=128>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.accounts")%>:</td>
      <td><input type="text" name="account" value="<%=getNull(obj.getAccounts(teasession._nLanguage))%>" size=30 maxlength=50>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.branch")%>???</td>
      <td width="72%" colspan="2"><input maxlength="28" size=30 name="branch" value="<%=getNull(obj.getBranch(teasession._nLanguage))%>">
        <br>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.job")%>???</td>
      <td width="72%" colspan="2"><input maxlength="28" size=30 name="job" value="<%=getNull(obj.getJob(teasession._nLanguage))%>"> </td>
    </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td width=28%><%=r.getString(teasession._nLanguage, "Company.oem")%></td>
    <td width=72%  colspan="2"><input  id="radio" type="radio" name="oem" checked="checked" id="OemOdmNo" value="n"  ><label for="OemOdmNo"><%=r.getString(teasession._nLanguage, "No")%></label>
      <input  id="radio" type="radio" <%=getCheck(obj.isOem(teasession._nLanguage))%> name="oem" id="OemOdmYes" value="y"  ><label for="OemOdmYes"><%=r.getString(teasession._nLanguage, "Yes")%></label>
</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Company.developer")%>???</td>
    <td  colspan="2"><select name="developer">
            <%
      out.println("<OPTION value=255 >------------</OPTION>");
      for(int index=1;index<Company.DEVELOPER_TYPE.length;index++)
      {
        out.print("<OPTION value="+index);
        if(index==obj.getDeveloper(teasession._nLanguage))
        out.print(" SELECTED ");
        out.print(">"+Company.DEVELOPER_TYPE[index]);
      }
      %>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.turnout")%>???</td>
      <td colspan="2"><input type="text" name="p_z_Z_ProductionCapacity" value="<%=getNull(obj.getTurnout(teasession._nLanguage))%>" size="8" maxlength=32>
        <select name="p_z_Z_ProductionUnit" >
          <option value=""  selected  >------------</option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="??????"> ?????? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???"> ??? </option>
          <option value="???(???)"> ???????????? </option>
          <option value="??????"> ?????? </option>
          <option value="??????"> ?????? </option>
          <option value="???"> ??? </option>
          <option value="??????"> ?????? </option>
          <option value="??????"> ?????? </option>
          <option value="??????"> ?????? </option>
          <option value="??????(???)"> ??????(???) </option>
          <option value="??????(???)"> ??????(???) </option>
          <option value="???"> ??? </option>
          <option value="??????"> ?????? </option>
          <option value="???"> ??? </option>
          <option value="??????"> ?????? </option>
          <option value="???(???)"> ???(???) </option>
          <option value="???(???)"> ???(???) </option>
          <option value="??????"> ?????? </option>
          <option value="??????"> ?????? </option>
          <option value="??????"> ?????? </option>
          <option value="??????"> ?????? </option>
          <option value="??????(???)"> ??????(???) </option>
          <option value="??????(???)"> ??????(???) </option>
          <option value="???"> ??? </option>
          <option value="????????????"> ???????????? </option>
          <option value="????????????"> ???????????? </option>
          <option value="?????????"> ????????? </option>
          <option value="?????????"> ????????? </option>
          <option value="?????????"> ????????? </option>
        </select>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.acreage")%>???</td>
      <td colspan="2"><input type="text" name="acreage"  value="<%=getNull(obj.getAcreage(teasession._nLanguage))%>" size="30" maxlength=16>
        ??????????????? </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Company.mass")%>???</td>
      <td colspan="2"><input type="text" name="mass" value="<%=getNull(obj.getMass(teasession._nLanguage))%>"/>
        <select onChange="form1.mass.value=this.value;">
          <option value="">----------</option>
          <option value="<%=r.getString(teasession._nLanguage, "Company.inner")%>"><%=r.getString(teasession._nLanguage, "Company.inner")%></option>
          <option value="<%=r.getString(teasession._nLanguage, "Company.thirdparty")%>"><%=r.getString(teasession._nLanguage, "Company.thirdparty")%></option>
          <option value="<%=r.getString(teasession._nLanguage, "Company.none")%>"><%=r.getString(teasession._nLanguage, "Company.none")%></option>
        </select>
      </td>
  </table>
  <P ALIGN=CENTER>
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
  </P>
</form>

<script>
form1.Name.focus();
function fclick(checkboxobj,textobj)
{
  if(checkboxobj.type=='checkbox')
  if(checkboxobj.checked)
  textobj.value+=' '+checkboxobj.value;
  else
  {
    index=textobj.value.indexOf(' '+checkboxobj.value);
    // if(index==-1&&textobj.value.indexOf(checkboxobj.value)==0)
    //            textobj.value=textobj.value.substring(0,index)+textobj.value.substring(index+checkboxobj.value.length);
    //            else
    if(index!=-1)
    textobj.value=textobj.value.substring(0,index)+textobj.value.substring(index+1+checkboxobj.value.length);
  }else
  textobj.value+=' '+checkboxobj.value;
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
