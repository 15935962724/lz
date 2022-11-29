<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/include/Header.jsp"%>
<%

if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(node.getType()))
  {
    response.sendError(403);
    return;
  }
}

r.add("/tea/ui/node/type/buy/EditCommodity");
int i = 0,k=0;
int commodity=0;
int supplier=0;
String SKU="";
String SerialNumber="";
int inventory=0;
int MinQuantity=0;
int MaxQuantity=0;
int Delta=0;
int Weight=0;
int Volume=0;
int Quality=0;

String _strCommodity=request.getParameter("commodity");
if(_strCommodity!=null)
{
  commodity=Integer.parseInt(_strCommodity);
}

if(commodity!=0)
{
    Commodity obj = Commodity.find(commodity);
    supplier=obj.getSupplier();
    SKU=obj.getSKU();
    SerialNumber=obj.getSerialNumber();
    inventory=obj.getInventory();
    MinQuantity=obj.getMinQuantity();
    MaxQuantity=obj.getMaxQuantity();
    Delta=obj.getDelta();
    Weight=obj.getWeight();
    Volume=obj.getWeight();
    Quality=obj.getQuality();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function on_sel_rela(index)
{
  window.showModalDialog("/jsp/type/goods/ProductSel.jsp?index="+index,self,"edge:raised;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:550px;dialogTop:"+100+";dialogLeft:"+150+"");
}
function checkint(obj)
{
  if(isNaN(parseInt(obj.value)))
  {
    alert('<%=r.getString(teasession._nLanguage, "Goods")%>');
    obj.value=0;
    obj.focus();
  }else
  {
    obj.value=parseInt(obj.value);
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditBuy")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
        <FORM name=foEdit METHOD=POST action="/servlet/EditBuy" onSubmit="return submitSelect(this.Supplier,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-<%=r.getString(teasession._nLanguage, "Supplier")%>');">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
          <input type='hidden' name=commodity VALUE="<%=commodity%>">
            <%
            String parameter=teasession.getParameter("nexturl");

            if(parameter!=null)
            out.print("<input type='hidden' name=nexturl value="+parameter+">");
          %>
          <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
            <tr id="Optionsid">
              <td><%=r.getString(teasession._nLanguage, "Options")%>:</td><td>
              <%
          switch(i)
          {
            case 4: // '\004'%>
              <input  id="CHECKBOX" type="CHECKBOX" name=BuyOFast value=null <%=getCheck((k & 1) != 0)%>>
                <%=r.getString(teasession._nLanguage, "BuyOFast")%>
                <%                    break;
            case 5: // '\005
%>
              <input  id="CHECKBOX" type="CHECKBOX" name=BuyOFast value=null <%=getCheck((k & 1) != 0)%>>
                <%=r.getString(teasession._nLanguage, "BidOOnce")%>
                <%                  break;
            case 6: // '\006'
  %>
              <input  id="CHECKBOX" type="CHECKBOX" name=BargainOOnce value=null <%=getCheck((k & 1) != 0)%>>
                <%=r.getString(teasession._nLanguage, "BargainOOnce")%>
                <%                    break;
  }
%>
              <input type="CHECKBOX" name=BuyOFreeShipping value=null <%=getCheck((k & 2) != 0)%>><%=r.getString(teasession._nLanguage, "BuyOFreeShipping")%></td>
            </tr>
            <tr>
              <td><%=r.getString(teasession._nLanguage, "Supplier")%>:</td>
              <td>
              <select name="Supplier">
              <option value="0">------------</option>
              <%
              java.util.Enumeration enumer=tea.entity.admin.Supplier.findByCommunity(teasession._strCommunity);
              while(enumer.hasMoreElements())
              {
                int id=((Integer)enumer.nextElement()).intValue();
                tea.entity.admin.Supplier obj=tea.entity.admin.Supplier.find(id);
                out.print("<OPTION VALUE="+id);
                if(id==supplier)
                out.print(" SELECTED ");
                out.print(">"+obj.getName(teasession._nLanguage));
              }
              %>
              </select>
              </td>
            </tr>
            <tr id="skuid">
              <td><%=r.getString(teasession._nLanguage, "SKU")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=SKU VALUE="<%=SKU%>" SIZE=40 MAXLENGTH=40></td>
            </tr>
            <tr id="SerialNumberID">
              <td><%=r.getString(teasession._nLanguage, "SerialNumber")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=SerialNumber VALUE="<%=SerialNumber%>" SIZE=40 MAXLENGTH=40></td>
            </tr>
                        <!--tr>
              <td><%=r.getString(teasession._nLanguage, "Goods")%>:</td>
              <td><input type="TEXT" class="edit_input" onkeyup="checkint(this)" onchange="checkint(this)"   name=goods VALUE="<%//=goods%>"> <input class="edit_input" onclick="on_sel_rela('foEdit.goods')"  type="button" value="浏览..."/></td>
            </tr-->
            <tr id="Qualityid">
              <td><%=r.getString(teasession._nLanguage, "Quality")%>:</td><td>
              <% for(int j2 = 0; j2 < Commodity.QUALITY.length; j2++)
                {%>
              <input  id="radio" type="radio" name=Quality VALUE="<%=j2%>" <%=getCheck(j2 == Quality)%>>
                <%=r.getString(teasession._nLanguage, Commodity.QUALITY[j2])%>
                <%}%>
            </tr>
            <tr id="Inventoryid">
              <td><%=r.getString(teasession._nLanguage, "Inventory")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Inventory VALUE="<%=inventory%>" SIZE=10></td>
            </tr>
            <tr id="MinQuantityid"><!--id="MinQuantityid"-->
              <td><%=r.getString(teasession._nLanguage, "MinQuantity")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=MinQuantity VALUE="<%=MinQuantity%>" SIZE=10></td>
            </tr>
            <tr id="MaxQuantityid">
              <td><%=r.getString(teasession._nLanguage, "MaxQuantity")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=MaxQuantity VALUE="<%=MaxQuantity%>" SIZE=10></td>
            </tr>
            <tr id="Deltaid">
              <td><%=r.getString(teasession._nLanguage, "Delta") %>:</td>
              <td><input type="TEXT" class="edit_input"  name=Delta VALUE="<%=Delta%>" SIZE=10></td>
            </tr>
            <tr id="Weightid">
              <td><%=r.getString(teasession._nLanguage, "Weight") %>:</td>
              <td><input type="TEXT" class="edit_input"  name=Weight VALUE="<%=Weight%>" SIZE=10>
                <%=r.getString(teasession._nLanguage, "gram")%></td>
            </tr>
            <tr id="Volumeid">
              <td><%=r.getString(teasession._nLanguage, "Volume")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Volume VALUE="<%=Volume%>" SIZE=10>
                <%=r.getString(teasession._nLanguage, "cm3")%></td>
            </tr>
          </table>
          <P ALIGN=CENTER>
            <!--input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>"-->
            <input type=SUBMIT name="GoNext" id="edit_GoNext" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBNext")%>">
            <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
          </P>
        </FORM>
        <SCRIPT>document.foEdit.SKU.focus();</SCRIPT>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div></td>
</body>
</html>
