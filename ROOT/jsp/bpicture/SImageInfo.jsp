<SCRIPT LANGUAGE="JAVASCRIPT">

    function getSelectedRadio(rb) {
        if (rb.length) {
            //More than one check box
            for (i =0; i < rb.length;i ++) {
                if (rb[i].checked) {
                    return rb[i].value;
                }
            }
            return "";
        }
        else {
            //
            if (rb.checked)
                return rb.value;
            else
                return "";
        }
    }

</SCRIPT>


<script LANGUAGE="javascript">
var openerlocation= window.opener.location.href;

// Added by Arul to show the message box  for preference settings .

function parentReload() {
   if (window.opener && !window.opener.closed) {

    var parentfile= window.opener.location.href;

   if(parentfile.search(/search-results/i)>0 )
    {

      window.onfocus=self;

      //window.opener.frmSearch.submit();
      // Form ID Attribute is addedd ( inc-head ) to fix the Firefox issue submit issue
      window.opener.document.getElementById("frmSearch").submit();

    }
   }
}
function confirmDelete(frm)
{
	if (frm.deleteRadio[0].checked==true || frm.deleteRadio[1].checked==true)
	{
		if (confirm("Click OK to confirm")==true)
		{
			return true;
		}
		else
			return false;
	}
	else
	{
		alert ("Select a choice");
		return false;
	}
}


function AddToBasketPopup( imgname, sImageId)
{
    var sUserId;
    var sRetURL;
    var undefined;

    sUserId = GetCookie("AlamyUserID")

	if(imgname != "" )
		swap(imgname);

    if( sUserId == null || sUserId == "undefined" || sUserId == "" )
    {
		if (opener.parent.location.href.indexOf("crm2/alamy.asp")!=-1)
		{
			//opener.parent.frames.mainFrame.location.href = sLogonURL + "?returnurl=" + sRetURL;
			sRetURL = opener.location + "&cmd=add2basket";
			sRetURL = sRetURL + "&origin=id";
			sRetURL = AddURLParam( sRetURL, "imageid", sImageId );
		    	sRetURL = escape(sRetURL);

			opener.parent.frames.mainFrame.location.href = sLogonURL + "?returnurl=" + sRetURL;

		} else {

			var topmostLocation = opener.parent.window.location;
			sRetURL = topmostLocation.protocol + "//" + topmostLocation.hostname + topmostLocation.pathname + window.location.search

			if(sRetURL.indexOf("?") == -1)
				sRetURL = sRetURL + "?cmd=add2basket"
			else
				sRetURL = sRetURL + "&cmd=add2basket"

			sRetURL = sRetURL + "&origin=id"

			sRetURL = AddURLParam( sRetURL, "imageid",sImageId);

		    	sRetURL = escape(sRetURL);

			topmostLocation.href = sLogonURL + "?returnurl=" + sRetURL;

		}
		window.close();
    }
   else
   {
        var shref
        var now = new Date()
        var httprequest = new Image();
        var statustext;

        shref = "add-to-basket.asp?origin=id&imageid=" + sImageId + "&t=" + now.getTime();

        //window.parent.window.location = shref

        httprequest.onabort = onAddToOrder;
        httprequest.onerror = onAddToOrder;
        httprequest.onload  = onAddToOrder;
        statustext = "Adding image to Shopping Cart...";

        httprequest.src = shref;

        window.status = statustext;
    }
}

function AddToLightboxPopup( imgname, sLightboxId, sImageId)
{
    var sUserId;
    var sRetURL;
    var undefined;

    sUserId = GetCookie("AlamyUserID")

	if(imgname != "" )
		swap(imgname);

    if( sUserId == null || sUserId == "undefined" || sUserId == "" )
    {
	if (opener.parent.location.href.indexOf("crm2/alamy.asp")!=-1)
	{
		//opener.parent.frames.mainFrame.location.href = sLogonURL + "?returnurl=" + sRetURL;
		sRetURL = opener.location + "&cmd=add2lb";
		sRetURL = sRetURL + "&origin=id";
		sRetURL = AddURLParam( sRetURL, "imageid", sImageId );
		sRetURL = AddURLParam( sRetURL, "clbid",sLightboxId )
	    	sRetURL = escape(sRetURL);

		opener.parent.frames.mainFrame.location.href = sLogonURL + "?returnurl=" + sRetURL;

	} else {

		var topmostLocation = opener.parent.window.location;
		sRetURL = topmostLocation.protocol + "//" + topmostLocation.hostname + topmostLocation.pathname + window.location.search
		if(sRetURL.indexOf("?") == -1)
			sRetURL = sRetURL + "?cmd=add2lb"
		else
			sRetURL = sRetURL + "&cmd=add2lb"

		sRetURL = sRetURL + "&origin=id"
		sRetURL = AddURLParam( sRetURL, "imageid",sImageId )
		sRetURL = AddURLParam( sRetURL, "clbid",sLightboxId )

		sRetURL = escape(sRetURL);
		topmostLocation.href = sLogonURL + "?returnurl=" + sRetURL;
	}
	window.close();
    }
    else
    {
        var shref
        var now = new Date()

        shref = "add-to-lightbox.asp?imageid=" + sImageId + "&clbid=" + sLightboxId + "&t=" + now.getTime()+"&origin=id"

        var httprequest = new Image();
        httprequest.onabort = onAddToLightbox;
        httprequest.onerror = onAddToLightbox;
        httprequest.onload  = onAddToLightbox;
        httprequest.src = shref

		//window.parent.window.location.href = shref

        window.status = "Adding image to Lightbox...";
    }
}


function OnSetPreferenceforseession(preference,size)
{//function to set the archive and filesize in cookie and header hidden cntrl -by divya
      var shref,  includearchive;
      includearchive = 1


   if(preference == 1)
   {

    //set cookie whether or not archive is reqd on current session

            if(document.getElementById("chckArchive").checked == true)
            {
               includearchive = 0;

            }
            else
           {
               includearchive = 1;

           }

          window.opener.document.getElementById('archive').value = includearchive;
          window.opener.document.getElementById('adv').value = 1;//to set the hidden value in header
     }
      else
       if(preference==2)
       {


    		window.opener.document.getElementById('size').value = size;//to set the hidden value in header
    		window.opener.document.getElementById('adv').value = 1;//to set the hidden value in header
    		//alert(window.opener.document.getElementById('adv').value);
     	}


      shref = "setarchivepreferenceforsession.asp?preference="+preference+"&archive="+includearchive+"&size="+size;
      var httprequest = new Image();
      httprequest.src = shref;
	  setTimeout("alert('Your search results have been updated.')",1000);

	  parentReload();
   }

function toggle(obj) {
  var el = document.getElementById(obj);
  if(el != null) {
	if (el.style.display != 'none') {
	  el.style.display = 'none';
    } else {
  	  el.style.display = 'block';
    }
  }
}

</script>
<%@page contentType="text/html;charset=UTF-8"  %>

<html>
<head>
<title>Alamy图像-图像细节A JAFWB-专利免费</title>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
<link REL="stylesheet" HREF="http://www.alamy.com/style/1h.css?v=20" TYPE="text/css">

<link href="http://www.alamy.com/style/hide.css" rel="stylesheet" type="text/css" media="print">

<link REL="stylesheet" HREF="/style/xhtml-archive.css" TYPE="text/css">
<link rel="stylesheet" href="style/hide.css" type="text/css" media="print">
<link rel="stylesheet" href="style/xhtml-archive.css" type="text/css" media="screen">

<script language="javascript" src="http://www.alamy.com/script/client-execcmd4.js"></script>
<SCRIPT LANGUAGE="JAVASCRIPT">

function PopDown(tg)
	{	var gotoURL;

		if (opener.parent.location.href.indexOf("crm2/alamy.asp")!=-1)
		{	gotoURL = opener.parent.frames.mainFrame.location.href;

			if (tg.indexOf("?")>0)
			{
				opener.parent.frames.mainFrame.location.href = tg + "&returnurl=" + escape(gotoURL);
			}
			else
			{	opener.parent.frames.mainFrame.location.href = tg + "?returnurl=" + escape(gotoURL);
			}
		}
		else
		{	gotoURL = opener.parent.location.href;

			if (tg.indexOf("?")>0)
			{
				opener.parent.location.href = tg +"&returnurl=" + escape(gotoURL);
			}
			else
			{	opener.parent.location.href = tg + "?returnurl=" + escape(gotoURL);
			}
		}
		close();

	}

function PopDownNoReturn(tg)
	{	var gotoURL;

		if (opener.parent.location.href.indexOf("crm2/alamy.asp")!=-1)
		{	opener.parent.frames.mainFrame.location.href = tg;
		}
		else
		{	opener.parent.location.href = tg;
		}
		close();

	}

</SCRIPT>

<script language="javascript">
var sLogonURL = 'https://secure.alamy.com/logon.asp';
//alert (sLogonURL);
</script>
</head>

<BODY LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 >

<div align="right" style="position:absolute; z-index:1; width:100%;" class="hide"><table border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td valign="bottom"><img src="http://www.alamy.com/images/bg.gif" width="5" height="20" border="0"></td>

		<td nowrap class="nav1"><a class="menu" href="#" onClick="window.print()">打印此页</a>&nbsp;</td>
		<td nowrap class="nav2">&nbsp;<a class="menu" href="javascript:window.close()">关闭窗口</a>&nbsp;</td>
    </tr>
</table></div>
<table width="100%" border="0" cellspacing="7" cellpadding="0" class="bg2">
	<tr valign="bottom">

		<td width="5%" rowspan="2"></td>

		<td width="95%" rowspan="2">
			<table border="0" cellspacing="0" cellpadding="2">
				<tr>
					<td class="s"><strong>英国</strong></td>
					<td class="s">+44 (0)1235 844600</td>
					<td colspan="2">&nbsp;</td>
				</tr>

				<tr>
					<td class="top s"><strong>美国</strong></td>
					<td class="top s">+1 866 671 7305 - toll free</td>
					<td class="top s"><strong>传真</strong></td>
					<td class="top s">+44 1235 844650</td>
				</tr>

				<tr>

						<td class="top s" nowrap><strong>加拿大</strong>&nbsp;</td>
						<td class="top s">+1 866 331 4914 - toll free&nbsp;&nbsp;</td>

					<td class="top s"><strong>Email</strong>&nbsp;</td>
					<td class="top s"><a href="mailto:sales@alamy.com">sales@B-picture.com</a></td>

				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="10" cellpadding="0" class="borders">
	<tr valign="top">
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3">
				<tr class="bg2">
					<td><span class="big"><strong>AJAFWB</strong>
					<span class="rf">版税免费</td>

				</tr>
				<tr>
					<td class="bottom"><em>美国犹他州的沙漠公路12日阿莲景观页道越野车跟踪土壤侵蚀雪地</em></td>
				</tr><div id="tbl1" name="tbl1" style="overflow:hidden;display:none">

				<tr>
					<td class="bottom"><a href="javascript:PopDownNoReturn('http://www.alamy.com/help/stock-photography-rel-info.asp#model?origin=id')">发布模型类</a> - NO</td>
				</tr>
				<tr>
					<td class="bottom" nowrap><a href="javascript:PopDownNoReturn('http://www.alamy.com/help/stock-photography-rel-info.asp#property?origin=id')">发布知识产权类</a> - NO</td>
				</tr>




			    <tr>
                  <td>
				 <div><span class="archivehead_bold">最大文件大小 : 51.4 MB </span>
				 <script>

				 if ((openerlocation.search(/royalty-free-images-phot-browse.asp\?/i)<0 ) && (openerlocation.search(/stock-photography-contrib-browse.asp\?/i)<0 ))
				{
					  	document.write("<br>");
					  document.write("(<a href=javascript:toggle('DivFilesize')>Set Preferences</a>)")
					  }
					  </script>

</div>
                 <div id="DivFilesize" name="DivFilesize" style="overflow:hidden;display:none">
                  <table width="0" border="0" cellspacing="0" cellpadding="5">
				   <tr><td valign="top" >显示文件不得小于:</td></tr>
				   <tr>
				   <td>

				    <input type="radio" id="minimumsize" name="minimumsize"  value="0xC0" onClick="javascript:OnSetPreferenceforseession(2,this.value)"  />&nbsp;&nbsp;70 MB
					          <br />

					          <input type="radio" id="minimumsize" name="minimumsize" value="0xE0" onClick="javascript:OnSetPreferenceforseession(2,this.value)" />&nbsp;&nbsp;48 MB
					          <br />

					          <input type="radio" id="minimumsize" name="minimumsize" value="0xF0" onClick="javascript:OnSetPreferenceforseession(2,this.value)"   />&nbsp;&nbsp;24 MB
					          <br />

					          <input type="radio" id="minimumsize" name="minimumsize" value="0xF8" onClick="javascript:OnSetPreferenceforseession(2,this.value)"  />&nbsp;&nbsp;15 MB
					          <br />

				              <input type="radio" id="minimumsize" name="minimumsize" value="0xFC" onClick="javascript:OnSetPreferenceforseession(2,this.value)"   />&nbsp;&nbsp;5 MB
				              <br />

		                     <input type="radio" id="minimumsize" name="minimumsize" value="0xFE" onClick="javascript:OnSetPreferenceforseession(2,this.value)"  />&nbsp;&nbsp;1 MB
		                      <br />

		                      <input type="radio" id="minimumsize" name="minimumsize" value="0xFF" onClick="javascript:OnSetPreferenceforseession(2,this.value)"  Checked  />&nbsp;&nbsp;显示所有文件大小
				   </td>
				   </tr>
				<!--	 <tr><td>



					</td></tr>-->
					</table>
					<p class="bottom"></p>
		    	   </td>
				 </tr>

			    <!--end-->

				<!-- edited by divya-->

				<tr class="hide">
					<td><script language="javascript">
						//document.write (gotoURL);
						if (navigator.userAgent.toLowerCase().indexOf("mac") != -1 ) {
						  // MAC
						  if (navigator.appName.indexOf("Netscape") != -1) {
							document.write("<strong>如需下载</strong>, click and hold on the image and select <em>Save image...</em>");
						  }else {
							document.write("<strong>如需下载</strong>, click and hold on the image and select <em>Download Image to Disk...</em>");
							}

						 }else{
						document.write("<strong>如需下载</strong>, 右键单击图片选择 <em>另存为...</em>");
						}
						</script>
					</td>
				</tr>
			</table>
		</td>
		<td align="right" rowspan="2">
         <IMG SRC="http://www.alamy.com/thumbs/6/{2503A4D2-581E-4D2D-BA33-8F7AF3184067}/AJAFWB.jpg" title="AJAFWB">
         </td>
	</tr>
	<tr>
		<td valign="bottom">
			<table border="0" cellspacing="0" cellpadding="0" class="hide">
				<tr valign="bottom">
					<td><a href="JavaScript:PopDown('price-calc.asp?origin=id&imageid={2503A4D2-581E-4D2D-BA33-8F7AF3184067}')"><img src="http://www.alamy.com/images/d-black.gif" title="Calculate price" width="17" height="17" border="0"></a></td>
					<td nowrap><a href="JavaScript:PopDown('price-calc.asp?origin=id&imageid={2503A4D2-581E-4D2D-BA33-8F7AF3184067}')">计算价格</a></td>
				</tr>
				<tr valign="bottom">
					<td style="padding-top:5px; padding-right:5px;"><a href="javascript:AddToBasketPopup('c1','{2503A4D2-581E-4D2D-BA33-8F7AF3184067}','')"><img name=c1 src="http://www.alamy.com/images/cb.gif" title="Add image to cart" width="17" height="17" border="0"></a></td>
					<td nowrap><a href="javascript:AddToBasketPopup('c1','{2503A4D2-581E-4D2D-BA33-8F7AF3184067}','')">放入购物车</a></td>
				</tr>
				<tr valign="bottom">
					<td style="padding-top:5px;"><a href="javascript:AddToLightboxPopup('l1','','{2503A4D2-581E-4D2D-BA33-8F7AF3184067}','')"><img name=l1 src="http://www.alamy.com/images/lbb.gif" title="Add image to lightbox" width="17" height="17" border="0"></a></td>
					<td nowrap><a href="javascript:AddToLightboxPopup('l1','','{2503A4D2-581E-4D2D-BA33-8F7AF3184067}','')">添加至图库</a></td>
				</tr>

			</table>
		</td>
	</tr>
</table>



<table width="100%" cellspacing="0" cellpadding="0">
<!-- edited by Caroline for EasyD downloads -->

<!-- end edited by Caroline for EasyD downloads -->
	<tr valign="top">
		<td width="75%">
			<table width="100%" border="0" cellspacing="0" cellpadding="4">

					<tr valign="top">
						<td class="detail" nowrap><strong>摄影师</strong></td>
						<td colspan="4" class="bottom">
							<a href="JavaScript:PopDown('royalty-free-images-phot-browse.asp?pid={A7CC20A5-D16F-4890-8F12-998C08D01104}&pname=Bob Elsdale&srch=qt%253D12%2526lic%253D7%2526ipn%253D1%2526apn%253D1%2526cpn%253D1%2526cdpn%253D1%2526mr%253D0%2526pr%253D0%2526ot%253D0%2526nu%253D0%2526archive%253D1%2526size%253D0xFF%2526cdsrt%253D0%2526pn%253D1%2526st%253D0%2526a%253D%252D1%2526cid%253D%2526s1%253D0%2526s3%253D0%2526s5%253D0%2526s7%253D0%2526cn%253D%2526cdid%253D%2526cdn%253D')">Bob Elsdale</a>

						</td>
					</tr>

				<tr valign="top">
					<td class="detail"><strong>机构</strong></td>
					<td colspan="4" class="bottom"><a href="JavaScript:PopDown('stock-photography-contrib-browse.asp?cid={0F959F0F-006F-4714-983B-6B6DE5B5DF0E}&name=Eureka&srch=qt%253D12%2526lic%253D7%2526ipn%253D1%2526apn%253D1%2526cpn%253D1%2526cdpn%253D1%2526mr%253D0%2526pr%253D0%2526ot%253D0%2526nu%253D0%2526archive%253D1%2526size%253D0xFF%2526cdsrt%253D0%2526pn%253D1%2526st%253D0%2526a%253D%252D1%2526cid%253D%2526s1%253D0%2526s3%253D0%2526s5%253D0%2526s7%253D0%2526cn%253D%2526cdid%253D%2526cdn%253D')">Eureka</a></td>
				</tr>
				<tr valign="top">
					<td class="detail"><strong>信用额</strong></td>
					<td colspan="4" class="bottom">&copy; Eureka / B-picture</td>
				</tr>

				<tr valign="top" align="center">
					<td align="left" nowrap class="detail2"><strong>最大尺寸</strong></td>
					<td class="bottom" nowrap><em><strong>文件大小</strong></em></td>
					<td class="bottom" nowrap><em><strong>像素</strong></em></td>
					<td class="bottom" nowrap><em><strong>厘米</strong></em>*</td>
					<td class="bottom" nowrap><em><strong>英寸</strong></em>*</td>
				</tr>
				<tr align="center">
					<td align="left" class="detail2"></td>
					<td class="bottom" align="right" nowrap>51.4 MB</td>
					<td class="bottom" nowrap>5190 x 3460</td>
					<td class="bottom" nowrap>44.0 x 29.0</td>
					<td class="bottom" nowrap>17.0 x 12.0</td>
				</tr>

								<tr align="center">
									<td align="left" class="detail2"></td>
									<td class="bottom" align="right" nowrap>28.9 MB</td>
									<td class="bottom" nowrap>3892 x 2595</td>
									<td class="bottom" nowrap>33.0 x 22.0</td>
									<td class="bottom" nowrap>13.0 x 9.0</td>
								</tr>


								<tr align="center">
									<td align="left" class="detail2"></td>
									<td class="bottom" align="right" nowrap>16.3 MB</td>
									<td class="bottom" nowrap>2919 x 1946</td>
									<td class="bottom" nowrap>25.0 x 16.0</td>
									<td class="bottom" nowrap>10.0 x 6.0</td>
								</tr>


								<tr align="center">
									<td align="left" class="detail2"></td>
									<td class="bottom" align="right" nowrap>4.1 MB</td>
									<td class="bottom" nowrap>1460 x 973</td>
									<td class="bottom" nowrap>12.0 x 8.0</td>
									<td class="bottom" nowrap>5.0 x 3.0</td>
								</tr>


								<tr align="center">
									<td align="left" class="detail2"></td>
									<td class="bottom" align="right" nowrap>0.9 MB</td>
									<td class="bottom" nowrap>701 x 467</td>
									<td class="bottom" nowrap>6.0 x 4.0</td>
									<td class="bottom" nowrap>2.0 x 2.0</td>
								</tr>



				<tr>
					<td class="detail">&nbsp;</td>
					<td colspan="4" class="bottom">*尺寸为 300 dpi</span></td>
				</tr>

				<tr valign="top" class="hide">
					<td class="detail"><strong>关键字</strong></td>
					<td colspan="4" class="bottom">
					无
					</td>
				</tr>

			</table>

		</td>

	</tr>
</table>

	<table width="100%" cellspacing="0" cellpadding="4">

	</table>
	<!--
	RULES TO DISPLAY IMMEDIATE DELETE, DELAYED DELETE AND UNDELETE on INTRANET
	IF DateDeleteExpiry exists (71, 110 - ImageStatus does not matter), then show DATEDELETEEXPIRY (or deleted prior releasedate for 71)
	IF DateDeleteExpiry exists and logged in then show UNDELETE + DATEDELETEEXPIRY (or deleted prior releasedate for 71)
	IF 110 and no DateDeleteExpiry exists and logged in, then show IMMEDIATE DELETE & DELAYED DELETE
	IF 75 and logged in then show only IMMEDIATE DELETE
	-->
<a name="nosale">


</a>


<table width="100%" border="0" cellspacing="0" cellpadding="10">
	<td class="s">B-picture有限公司的B-picture及其标志的商标已在某些国家注册。<br>版权所有 2008年 保留所有权利。</td>
</table>


</body>
</html>
