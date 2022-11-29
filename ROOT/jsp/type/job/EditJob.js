<%@page contentType="text/html;charset=UTF-8" %>
function checkrestrictloc(objslt)
{
	//--判断省/城市id是否在允许的列表中 --- str_allowloc
	for(var x=0;x<objslt.length;x++)
	{
		var opt = objslt.options[x];
		if (opt.selected)
		{
			//if (opt.value.substring(opt.value.length-3,opt.value.length)=='000') //是省id
			//{
			//	m=sel(opt.value,Province);
			//	for (i=1;i<City[m].length;i++)	//获得省m //i=1 跳过省
			//	{
			//		//alert (','+CityID[m][i]+',');
			//		if (str_allowloc.indexOf(','+CityID[m][i]+',')=='-1') //不在允许的列表中
			//		{
			//			alert('工作地区出现合同外地区！');
			//			return false;
			//		}
			//	}
			//}招聘
			//else	//城市id
			//{
				if (str_allowloc.indexOf(','+opt.value+',')=='-1') //不在允许的列表中
				{
					alert('贵公司尚未购买该地区职位发布服务。如需购买，请联系网客户顾问。');
					form1.sltLocId.focus();
					return false;
				}
			//}
    }
	}
	return true;
}
function OpenWin(theURL,winName,features)
{
  window.open(theURL,winName,features);
}
function isInteger(s){
var i;
for (i = 0; i < s.length; i++){
var c = s.charAt(i);
if (((c < "0") || (c > "9"))) return false;
}
return true;
}

function CheckForm()
{
  var frm = document.form1;
  if(!ChkTxt(frm.txtJobTitle, '职位名称')) return false;
  if(!ChkSel(frm.sltOrgId, -1, '所属机构')) return false;
  if(!ChkSel(frm.sltJobType, -1, '职位性质')) return false;

  if(frm.sltOccId.length<=0)
  {
	alert('请选择职业类别！');
    frm.sltOccId.focus();
    return false;
  }
  else
  {
    var intCount = 0;
    for(var x=0;x<frm.sltOccId.length;x++)
    {
      frm.sltOccId.options[x].selected = true;
      intCount++;
    }
  }

  if(!ChkPositive(frm.txtHeadCount, '招聘人数')) return false;
  if(!ChkTxt(frm.sltExpiryDays, '距到期日')) return false;
	if(!ChkPositive(frm.sltExpiryDays, '距到期日')) return false;
	var num1=Trim(frm.sltExpiryDays.value);
	if((num1<1)||(num1>365)) {alert('距到期日为1至365的整数！');frm.sltExpiryDays.focus();return false;}

  if(frm.sltLocId.length<=0)
  {
    alert('请选择工作地区！');
    frm.sltLocId.focus();
    return false;
  }
  else
  {
    var intCount = 0;
    for(var x=0;x<frm.sltLocId.length;x++)
    {
      frm.sltLocId.options[x].selected = true;
      intCount++;
    }
  }


  s = frm.txtJobDuty.value;
  if(s.length < 100)
  {
    for(var i=0;i<frm.txtJobDuty.value.length;i++)
      s = s.replace(/\s/i,'');
  }
  if(Trim(s).length == 0)
  {
    alert('请填写职位描述及要求！');
    frm.txtJobDuty.focus();
    return false;
  }
  else if(!ChkTxt(frm.txtJobDuty, '职位描述及要求')) return false;
  else if(!ChkLength(frm.txtJobDuty, '职位描述及要求', 3000)) return false;
  if(frm.rdoJobCcType[frm.rdoJobCcType.length-1].checked)
  {
    if(!ChkTxt(frm.txtCcMailAddr, 'E-mail')) return false;
    var Mails = frm.txtCcMailAddr.value.split(',');
    if(Mails.lengTD>3)
    {
      alert('最多可以填写3个E-mail地址！');
      frm.txtCcMailAddr.focus();
      return false;
    }
    for(i = 0 ,j = 1; i < Mails.length ; i++,j++)
    {
      if (!(IsMail(Mails[i])))
      {
        if (Mails.length == 1)
        {
          alert ('请填写正确的E-mail地址！');
          frm.txtCcMailAddr.focus();
        }
        else
        {
          alert ('第' + j + '个E-mail地址错误，请填写正确的E-mail地址！' );
          frm.txtCcMailAddr.focus();
        }
        return false;
      }
    }

  }

  return true;
}

function selTemplate()
{
  location.href = 'job_add.asp?template_id=' + form1.sltJobTemplate.value;
  return true;
}

function doAction(strAction)
{
  var frm = document.form1;
//  frm.action = "job_add_ok.asp";
//  frm.target = "_self";
  frm.hdnTodo.value = strAction;

  return true;
}

function preview()
{
  var frm = document.form1;
  frm.action = "job_preview.asp";
  frm.target = "_blank";
  frm.hdnTodo.value = "preview";

  return CheckForm();
}

function cancel()
{
  var frm = document.form1;
  frm.reset();
  /*
  if(frm.chkBouns.checked)
    frm.txtBouns.disabled=false;
  else
    frm.txtBouns.disabled=true;
  */
  if(frm.rdoJobCcType[3].checked)
    frm.txtCcMailAddr.disabled=false;
  else
    frm.txtCcMailAddr.disabled=true;

  return false;
}


function EnableCcMailTxt()
{
  var frm = document.form1;

  frm.txtCcMailAddr.disabled = false;
}

function DisableCcMailTxt()
{
  var frm = document.form1;

  frm.txtCcMailAddr.value = "";
  frm.txtCcMailAddr.disabled = true;
}

function SetBouns()
{
  var frm = document.form1;

  frm.txtBouns.disabled = !frm.chkBouns.checked;
  frm.txtBouns.value = "";
}

var popUpWin=0;
function OpenWindow(URLStr, left, top, width, height)
{
  if(popUpWin)
  {
    if(!popUpWin.closed) popUpWin.close();
  }
  popUpWin = open(URLStr, '', 'toolbar=no,location=no,directories=no,status=no,menub ar=no,scrollbars=no,resizable=no,copyhistory=yes,width='+width+',height='+height+',left='+((window.screen.availWidth-width)/2)+', top='+((window.screen.availHeight-height)/2)+',screenX='+left+',screenY='+top+'');
}

function setJobCcType()
{
  var frm = document.form1;

  if(frm.chkGetCvTypeEmail.checked)
  {
    frm.rdoJobCcType[1].checked = true;
    document.all.trJobCcType.style.display = "";
  }
  else
  {
    frm.rdoJobCcType[0].checked = true;
    DisableCcMailTxt();
    document.all.trJobCcType.style.display = "none";
  }
}


//城市缩进"--"
function CheckLoc(objloc)
{
    for(var x=0;x<objloc.length;x++)
    {
	  var opt = objloc.options[x];
	  if (opt.value.substring(opt.value.length-3,opt.value.length)!='000'&& opt.value!='5'&& opt.value!='115'&& opt.value!='140'&& opt.value!='25'&& opt.value!='185'&& opt.value!='190'&& opt.value!='195'&& opt.value!='200'&& opt.value!='205'&& opt.value!='210'&& opt.value!='215'&& opt.value!='230'&& opt.value!='235'&& opt.value!='255') //是省id
			{
			   opt.text='-- '+opt.text;
			}
    }
}


</SCRIPT>
<SCRIPT LANGUAGE="javascript">
<!--版本号：0001-->
<!--Action:2-->
<!--
Location_CodeId = new Array;
Location_ParentId = new Array;
Location_CodeValue = new Array;
Location_IsVisible = new Array;
Location_Lvl = new Array;
I=-1;



I++;
Location_CodeId[I] = '30000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '北京';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '5';
Location_ParentId[I] = '30000';
Location_CodeValue[I] = '北京';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '31000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '上海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '115';
Location_ParentId[I] = '31000';
Location_CodeValue[I] = '上海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '32000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '天津';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '140';
Location_ParentId[I] = '32000';
Location_CodeValue[I] = '天津';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '33000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '重庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '25';
Location_ParentId[I] = '33000';
Location_CodeValue[I] = '重庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '广东省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '40';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '广州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16010';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '潮州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '225';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '东莞';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16050';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '佛山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16020';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '惠州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16030';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '清远';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '117';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '汕头';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '125';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '深圳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16040';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '顺德';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16060';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '湛江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16080';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '肇庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '16070';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '中山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '180';
Location_ParentId[I] = '16000';
Location_CodeValue[I] = '珠海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '江苏省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '100';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '南京';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7010';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '常熟';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '常州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7020';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '昆山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7070';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '连云港';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7060';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '南通';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '220';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '苏州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7040';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '太仓';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '152';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '无锡';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7030';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '徐州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '167';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '扬州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7080';
Location_ParentId[I] = '7000';
Location_CodeValue[I] = '镇江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '浙江省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '55';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '杭州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '107';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '宁波';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '147';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '温州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8050';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '绍兴';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8060';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '金华';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8080';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '台州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8090';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '湖州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '73';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '嘉兴';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8110';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '瞿州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8100';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '丽水';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '8070';
Location_ParentId[I] = '8000';
Location_CodeValue[I] = '舟山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '安徽省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '65';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '合肥';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9040';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '安庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9030';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '蚌埠';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '9020';
Location_ParentId[I] = '9000';
Location_CodeValue[I] = '芜湖';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '福建省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '35';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '福州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10030';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '泉州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '155';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '厦门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '10040';
Location_ParentId[I] = '10000';
Location_CodeValue[I] = '漳州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '甘肃省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '85';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '兰州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24020';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '嘉峪关';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '24030';
Location_ParentId[I] = '24000';
Location_CodeValue[I] = '酒泉';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '广西自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '105';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '南宁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17040';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '北海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '42';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '桂林';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17020';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '柳州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '17050';
Location_ParentId[I] = '17000';
Location_CodeValue[I] = '玉林';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '20000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '贵州省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '45';
Location_ParentId[I] = '20000';
Location_CodeValue[I] = '贵阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '20020';
Location_ParentId[I] = '20000';
Location_CodeValue[I] = '遵义';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '海南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '50';
Location_ParentId[I] = '18000';
Location_CodeValue[I] = '海口';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '18020';
Location_ParentId[I] = '18000';
Location_CodeValue[I] = '三亚';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '河北省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '130';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '石家庄';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '7';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '保定';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1070';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '承德';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '53';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '邯郸';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1080';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '廊坊';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1030';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '秦皇岛';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1020';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '唐山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '1060';
Location_ParentId[I] = '1000';
Location_CodeValue[I] = '张家口';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '13000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '河南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '175';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '郑州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '78';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '开封';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '92';
Location_ParentId[I] = '13000';
Location_CodeValue[I] = '洛阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '黑龙江省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '60';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '哈尔滨';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6030';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '大庆';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6040';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '佳木斯';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6050';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '牡丹江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '6020';
Location_ParentId[I] = '6000';
Location_CodeValue[I] = '齐齐哈尔';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '湖北省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '150';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '武汉';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14020';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '十堰';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14040';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '襄樊';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14030';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '宜昌';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14050';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '潜江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14060';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '荆门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14070';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '荆州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '14080';
Location_ParentId[I] = '14000';
Location_CodeValue[I] = '黄石';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '湖南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '15';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '长沙';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15030';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '湘潭';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '15020';
Location_ParentId[I] = '15000';
Location_CodeValue[I] = '株州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '5000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '吉林省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '10';
Location_ParentId[I] = '5000';
Location_CodeValue[I] = '长春';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '5020';
Location_ParentId[I] = '5000';
Location_CodeValue[I] = '吉林市';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '11000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '江西省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '95';
Location_ParentId[I] = '11000';
Location_CodeValue[I] = '南昌';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '11020';
Location_ParentId[I] = '11000';
Location_CodeValue[I] = '九江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '辽宁省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '120';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '沈阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4030';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '鞍山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '30';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '大连';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '4040';
Location_ParentId[I] = '4000';
Location_CodeValue[I] = '葫芦岛';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '内蒙古自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '70';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '呼和浩特';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3020';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '包头';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '3030';
Location_ParentId[I] = '3000';
Location_CodeValue[I] = '赤峰';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '26000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '宁夏自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '170';
Location_ParentId[I] = '26000';
Location_CodeValue[I] = '银川';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '25000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '青海省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '165';
Location_ParentId[I] = '25000';
Location_CodeValue[I] = '西宁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '山东省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '75';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '济南';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12090';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '德州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12040';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '东营';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12060';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '济宁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12100';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '临沂';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '110';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '青岛';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12080';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '日照';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12070';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '泰安';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '146';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '威海';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12050';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '潍坊';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '168';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '烟台';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '12030';
Location_ParentId[I] = '12000';
Location_CodeValue[I] = '淄博';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '山西省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '135';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '太原';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2010';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '大同';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2020';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '临汾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '2030';
Location_ParentId[I] = '2000';
Location_CodeValue[I] = '运城';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '陕西省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '160';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '西安';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23010';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '宝鸡';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '23020';
Location_ParentId[I] = '23000';
Location_CodeValue[I] = '咸阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '四川省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '20';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '成都';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19060';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '乐山';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19030';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '泸州';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19040';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '绵阳';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19050';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '内江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19070';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '宜宾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '19020';
Location_ParentId[I] = '19000';
Location_CodeValue[I] = '自贡';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '22000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '西藏自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '90';
Location_ParentId[I] = '22000';
Location_CodeValue[I] = '拉萨';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '22020';
Location_ParentId[I] = '22000';
Location_CodeValue[I] = '日喀则';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '新疆自治区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '145';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '乌鲁木齐';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27030';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '喀什';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27020';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '克拉玛依';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '27040';
Location_ParentId[I] = '27000';
Location_CodeValue[I] = '伊犁';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '云南省';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '80';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '昆明';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21030';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '大理';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21040';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '丽江';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '21020';
Location_ParentId[I] = '21000';
Location_CodeValue[I] = '玉溪';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '34000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '香港';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '185';
Location_ParentId[I] = '34000';
Location_CodeValue[I] = '香港';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '35000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '澳门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '190';
Location_ParentId[I] = '35000';
Location_CodeValue[I] = '澳门';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '36000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '台湾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '195';
Location_ParentId[I] = '36000';
Location_CodeValue[I] = '台湾';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '37000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '其他亚洲国家和地区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '200';
Location_ParentId[I] = '37000';
Location_CodeValue[I] = '其他亚洲国家和地区';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '38000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '北美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '205';
Location_ParentId[I] = '38000';
Location_CodeValue[I] = '北美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '41000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '南美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '230';
Location_ParentId[I] = '41000';
Location_CodeValue[I] = '南美洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '39000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '大洋洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '210';
Location_ParentId[I] = '39000';
Location_CodeValue[I] = '大洋洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '40000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '欧洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '215';
Location_ParentId[I] = '40000';
Location_CodeValue[I] = '欧洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';


I++;
Location_CodeId[I] = '42000';
Location_ParentId[I] = '0';
Location_CodeValue[I] = '非洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '1';


I++;
Location_CodeId[I] = '235';
Location_ParentId[I] = '42000';
Location_CodeValue[I] = '非洲';
Location_IsVisible[I] = '1';
Location_Lvl[I] = '2';
//-->
</SCRIPT>
<SCRIPT LANGUAGE="javascript">
<!--版本号：0002-->
<!--Action:2-->
<!--
Occupation_CodeId = new Array;
Occupation_ParentId = new Array;
Occupation_CodeValue = new Array;
Occupation_IsVisible = new Array;
Occupation_Lvl = new Array;
I=-1;



I++;
Occupation_CodeId[I] = '600';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '计算机/互联网';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1001001';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- CTO/技术总监/经理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001002';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- CIO/IT经理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001003';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 产品经理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '608';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 系统分析员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '601';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 软件工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '606';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 硬件工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001004';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 软件测试工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001005';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 硬件测试工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '610';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 数据库管理员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001006';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 信息安全工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '607';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 售前/售后支持工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '603';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 系统集成工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '609';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 系统管理员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '602';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 网络工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001007';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- IT工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '605';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 语音/视频/图形';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001008';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 游戏开发人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001009';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- ERP技术/应用顾问';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001010';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 网站策划';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001011';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 网站编辑';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001012';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 网站美工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1400';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 网页设计与制作';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001013';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 技术文档编写员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1001014';
Occupation_ParentId[I] = '600';
Occupation_CodeValue[I] = '-- 研发工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '700';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '电子/电器/通信';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1002001';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 电子工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002002';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 电器工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002003';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 电信工程师/通讯工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002004';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 电声工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002005';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 数码产品开发工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002006';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 单片机/DLC/DSP/底层软件开发';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002007';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 无线电工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002008';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 半导体工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002009';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 电子元器件工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002010';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 电子/电器维修';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002011';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 研发工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002012';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 光学工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002013';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 测试工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1002014';
Occupation_ParentId[I] = '700';
Occupation_CodeValue[I] = '-- 技术文员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2700';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '电气/能源/动力';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1003001';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 电气工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003002';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 光源与照明工程';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003003';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 变压器/磁电工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003004';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 电路工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2720';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 智能大厦/综合布线/弱电';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003005';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 电力工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003006';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 电气维修技术员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003007';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 水利/水电工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003008';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 核力/火力工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003009';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 空调/热能工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003010';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 石油天然气技术人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1003011';
Occupation_ParentId[I] = '2700';
Occupation_CodeValue[I] = '-- 自动控制';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3420';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '机械/仪器仪表';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1004001';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 机械工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004002';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 模具工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004003';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 机械设计师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004004';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 机械制图员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2800';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 机电工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2900';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 精密机械/仪器仪表技术员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004005';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 铸造/锻造工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004006';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 注塑工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004007';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- CNC工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004008';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 冲压工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004009';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 夹具工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004010';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 锅炉工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004011';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 焊接工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004012';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 汽车/摩托车工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004013';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 船舶工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004014';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 飞行器设计与制造';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1004015';
Occupation_ParentId[I] = '3420';
Occupation_CodeValue[I] = '-- 机械维修工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '100';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '销售';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1005001';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 销售总监/经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1005002';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 客户经理/业务经理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1005003';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 渠道经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1005004';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 销售代表';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1005005';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 售前/售后工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1005006';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 销售助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1005007';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 业务拓展经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1005008';
Occupation_ParentId[I] = '100';
Occupation_CodeValue[I] = '-- 业务拓展专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '604';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '项目管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1006001';
Occupation_ParentId[I] = '604';
Occupation_CodeValue[I] = '-- 项目总监';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1006002';
Occupation_ParentId[I] = '604';
Occupation_CodeValue[I] = '-- 项目经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '900';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '客户服务';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1007001';
Occupation_ParentId[I] = '900';
Occupation_CodeValue[I] = '-- 客户服务经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1007002';
Occupation_ParentId[I] = '900';
Occupation_CodeValue[I] = '-- 客户服务专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1007003';
Occupation_ParentId[I] = '900';
Occupation_CodeValue[I] = '-- 客户关系管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1007004';
Occupation_ParentId[I] = '900';
Occupation_CodeValue[I] = '-- 客户咨询/热线支持';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1007005';
Occupation_ParentId[I] = '900';
Occupation_CodeValue[I] = '-- 投诉处理/监控';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3600';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '市场/广告/公关与媒介';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1008001';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 市场推广专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008002';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 市场联盟与拓展经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008003';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 市场联盟与拓展专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008004';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 市场推广经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008005';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 产品/品牌专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3630';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 市场调研与分析';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1500';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 广告创意与策划/文案';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008006';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 市场总监/经理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008007';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 市场专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008008';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 产品/品牌经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008009';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 公关与媒介经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008010';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 公关与媒介专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008011';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 会务经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1008012';
Occupation_ParentId[I] = '3600';
Occupation_CodeValue[I] = '-- 会务专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1200';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '经营管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1009001';
Occupation_ParentId[I] = '1200';
Occupation_CodeValue[I] = '-- CEO/总裁/总经理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1009002';
Occupation_ParentId[I] = '1200';
Occupation_CodeValue[I] = '-- COO/副总/董事会秘书';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1009003';
Occupation_ParentId[I] = '1200';
Occupation_CodeValue[I] = '-- 总经理助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2100';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '咨询顾问';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1010001';
Occupation_ParentId[I] = '2100';
Occupation_CodeValue[I] = '-- 咨询总监';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1010002';
Occupation_ParentId[I] = '2100';
Occupation_CodeValue[I] = '-- 咨询师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1010003';
Occupation_ParentId[I] = '2100';
Occupation_CodeValue[I] = '-- 研究员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '300';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '人力资源/行政/文职人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1011001';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 行政/人力资源总监';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011002';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 人力资源经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011003';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 人力资源专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011004';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 招聘经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011005';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 招聘专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011006';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 培训经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011007';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 培训专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011008';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 培训师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011009';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 薪资福利经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011010';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 薪资福利专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011011';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 绩效考核经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011012';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 绩效考核专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011013';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 员工关系经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011014';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 员工关系专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011015';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 行政经理/主管/办公室主任';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011016';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 行政专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011017';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 部门助理/秘书/文员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1011018';
Occupation_ParentId[I] = '300';
Occupation_CodeValue[I] = '-- 前台/总机';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '400';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '财务/审计/统计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1012001';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- CFO/财务总监/经理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012002';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 财务主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012003';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 会计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012004';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 出纳';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012005';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 财务分析';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012006';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 成本管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012007';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 审计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012008';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 财务助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012009';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 统计员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1012010';
Occupation_ParentId[I] = '400';
Occupation_CodeValue[I] = '-- 税务主管/专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '金融/经济';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1013001';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 金融/经济机构管理和运营';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2300';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 投资顾问/投资分析';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013002';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 保险业务/经纪人/代理人';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013003';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 证券/外汇/期货经纪人';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013004';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 融资经理/主管/专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013005';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 风险管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013006';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 客户经理/主管/专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013007';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 资产评估';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013008';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 信贷/信用调查/分析人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013009';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 预结算/清算人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013010';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 银行专员/出纳员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013011';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 保险精算师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1013012';
Occupation_ParentId[I] = '1013000';
Occupation_CodeValue[I] = '-- 税务人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '贸易/物流/采购/运输';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1014001';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 外贸经理/主管/专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014002';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 国内贸易经理/主管/专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014003';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 业务跟单';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014004';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 单证员/报关员/海运/空运操作人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014005';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 商务经理/主管/专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014006';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 采购经理/主管/专员/助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014007';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 物流经理/主管/专员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014008';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 仓库经理/主管/管理员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014009';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 运输经理/主管';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014010';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 货运代理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014011';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 海陆空交通运输';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014012';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 调度员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1014013';
Occupation_ParentId[I] = '1014000';
Occupation_CodeValue[I] = '-- 速递员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '702';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '建筑/房地产/装饰装修/物业管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '3103';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 建筑师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015001';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 结构工程师/土建工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015002';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 建筑制图';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015003';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 建筑工程管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015004';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 工程监理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3107';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 给排水/强电/弱电/制冷暖通';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3101';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 房地产开发/策划';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3102';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 房地产评估';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015005';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 设备工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015006';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 工程造价/估价/预决算';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3108';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 路桥/隧道/港口/航道工程';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3109';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 园林/园艺';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3110';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 室内外装潢设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2200';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 物业管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015007';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 城市规划与设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1015008';
Occupation_ParentId[I] = '702';
Occupation_CodeValue[I] = '-- 房地产中介/交易';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1016001';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '翻译';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1801';
Occupation_ParentId[I] = '1016001';
Occupation_CodeValue[I] = '-- 英语';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1802';
Occupation_ParentId[I] = '1016001';
Occupation_CodeValue[I] = '-- 日语';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1803';
Occupation_ParentId[I] = '1016001';
Occupation_CodeValue[I] = '-- 法语';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1804';
Occupation_ParentId[I] = '1016001';
Occupation_CodeValue[I] = '-- 德语';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1805';
Occupation_ParentId[I] = '1016001';
Occupation_CodeValue[I] = '-- 俄语';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1806';
Occupation_ParentId[I] = '1016001';
Occupation_CodeValue[I] = '-- 西班牙语';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1807';
Occupation_ParentId[I] = '1016001';
Occupation_CodeValue[I] = '-- 朝鲜语';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1017000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '酒店/餐饮/旅游/运动休闲';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1017001';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 娱乐/餐饮管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1017002';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 大堂经理/副理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1017003';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 楼面经理/主任';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1017004';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 厨师/调酒师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3308';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 服务员/侍者/门童';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3309';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 接待/礼仪/接线生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1017005';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 导游';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1017006';
Occupation_ParentId[I] = '1017000';
Occupation_CodeValue[I] = '-- 健身教练';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3400';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '工厂生产';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1018001';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 厂长/副厂长';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018002';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 总工程师/副总工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018003';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 采购管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018004';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 物料/物流管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018005';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 设备管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018006';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 安全/健康/环境管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018007';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 产品开发';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018008';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 生产工艺/技术';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1000';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 质量管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3430';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 仓库管理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3440';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 生产管理/督导/计划调度';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1018009';
Occupation_ParentId[I] = '3400';
Occupation_CodeValue[I] = '-- 维修工程师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '轻工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1019001';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 纺织技术';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019002';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 染整技术';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019003';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 制鞋/制衣/制革/手袋';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019004';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 服装制版/打版师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019005';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 印刷/包装';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019006';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 纸浆造纸工艺';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019007';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 食品/糖烟酒饮料/粮油';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019008';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 陶瓷技术';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019009';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 金银首饰加工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1019010';
Occupation_ParentId[I] = '1019000';
Occupation_CodeValue[I] = '-- 家具制造';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1020000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '商业零售';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1020001';
Occupation_ParentId[I] = '1020000';
Occupation_CodeValue[I] = '-- 店长';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1020002';
Occupation_ParentId[I] = '1020000';
Occupation_CodeValue[I] = '-- 营运';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1020003';
Occupation_ParentId[I] = '1020000';
Occupation_CodeValue[I] = '-- 生鲜/防损技术人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1020004';
Occupation_ParentId[I] = '1020000';
Occupation_CodeValue[I] = '-- 理货员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1020005';
Occupation_ParentId[I] = '1020000';
Occupation_CodeValue[I] = '-- 营业员/服务员/店员/导购员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3307';
Occupation_ParentId[I] = '1020000';
Occupation_CodeValue[I] = '-- 收银员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3800';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '美术/设计/创意';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1021001';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 设计管理人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021002';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 美术/图形设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021003';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 工业/产品设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021004';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 服装/纺织品设计师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021005';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 工艺品/珠宝设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021006';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 家具设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021007';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 平面设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021008';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 媒体广告设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021009';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 造型设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021010';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 网页设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021011';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 多媒体设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021012';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 动画设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021013';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 展示/装潢设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1021014';
Occupation_ParentId[I] = '3800';
Occupation_CodeValue[I] = '-- 文案创意';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3500';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '文体/影视/写作/媒体';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1022001';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 作家/撰稿人';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022002';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 总编/副总编';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1600';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 编辑/记者';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022003';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 美术编辑';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022004';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 发行';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022005';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 出版';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022006';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 校对/录入';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022007';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 排版设计';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022008';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 艺术总监';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022009';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 广播影视策划/制作';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022010';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 导演/编导';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022011';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 摄影/摄像';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022012';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 录音/音效师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022013';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 化妆师/造型师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022014';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 演员/配音/模特';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022015';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 主持人/播音员/DJ';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1022016';
Occupation_ParentId[I] = '3500';
Occupation_CodeValue[I] = '-- 演艺/体育经纪人';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1900';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '教育/培训';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1023001';
Occupation_ParentId[I] = '1900';
Occupation_CodeValue[I] = '-- 教学/教务管理人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1023002';
Occupation_ParentId[I] = '1900';
Occupation_CodeValue[I] = '-- 幼儿教育';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1023003';
Occupation_ParentId[I] = '1900';
Occupation_CodeValue[I] = '-- 教师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1023004';
Occupation_ParentId[I] = '1900';
Occupation_CodeValue[I] = '-- 讲师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1023005';
Occupation_ParentId[I] = '1900';
Occupation_CodeValue[I] = '-- 助教';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1023006';
Occupation_ParentId[I] = '1900';
Occupation_CodeValue[I] = '-- 家教';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1700';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '法律';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1024001';
Occupation_ParentId[I] = '1700';
Occupation_CodeValue[I] = '-- 律师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1024002';
Occupation_ParentId[I] = '1700';
Occupation_CodeValue[I] = '-- 法律顾问';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1024003';
Occupation_ParentId[I] = '1700';
Occupation_CodeValue[I] = '-- 律师助理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1024004';
Occupation_ParentId[I] = '1700';
Occupation_CodeValue[I] = '-- 法务人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1024005';
Occupation_ParentId[I] = '1700';
Occupation_CodeValue[I] = '-- 公/检/法系统';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '2000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '医疗卫生/美容保健';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1025001';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 医疗管理人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025002';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 医疗技术人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025003';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 医生/医师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025004';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 心理医生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025005';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 医药检验';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025006';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 护士/护理人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025007';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 药学技术与管理人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025008';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 疾病控制/公共卫生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025009';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 美容/整形师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1025010';
Occupation_ParentId[I] = '2000';
Occupation_CodeValue[I] = '-- 兽医/宠物医生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '生物/制药/化工/环保';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1026001';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 生物工程/生物制药';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026002';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 药品注册';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026003';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 药物研发/药物分析';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026004';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 化学药剂/药品/化肥';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026005';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 无机化学';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026006';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 有机化学';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026007';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 精细化工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026008';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 分析化工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026009';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 高分子化工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026010';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 应用化学';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026011';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 材料物理';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026012';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 材料化学';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1026013';
Occupation_ParentId[I] = '1026000';
Occupation_CodeValue[I] = '-- 环保工程';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '800';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '科研';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1027001';
Occupation_ParentId[I] = '800';
Occupation_CodeValue[I] = '-- 科研管理人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1027002';
Occupation_ParentId[I] = '800';
Occupation_CodeValue[I] = '-- 科研人员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3300';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '技工/服务类/后勤保障';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1028001';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 电工/铆焊工/钳工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028002';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 空调工/电梯工/锅炉工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3313';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 油漆/钣金';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3302';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 锯床/车床/磨床/铣床/冲床/锣床';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3303';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 铲车/叉车工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3304';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 机修工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3305';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 寻呼/声讯服务';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028003';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 食堂厨师';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3311';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 司机';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '3312';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 保安';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028004';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 普工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028005';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 裁减车缝熨烫';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028006';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 水工/木工/油漆工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028007';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 美容美发技工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028008';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 社区/家政服务';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028009';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 清洁工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1028010';
Occupation_ParentId[I] = '3300';
Occupation_CodeValue[I] = '-- 搬运工';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1029000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '农林牧渔';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '2600';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '公务员';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '3700';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '培训生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '2500';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '在校学生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1032001';
Occupation_ParentId[I] = '2500';
Occupation_CodeValue[I] = '-- 应届毕业生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1032002';
Occupation_ParentId[I] = '2500';
Occupation_CodeValue[I] = '-- 非应届毕业生';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1033000';
Occupation_ParentId[I] = '0';
Occupation_CodeValue[I] = '其他';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '1';


I++;
Occupation_CodeId[I] = '1033001';
Occupation_ParentId[I] = '1033000';
Occupation_CodeValue[I] = '-- 航空航天';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1033002';
Occupation_ParentId[I] = '1033000';
Occupation_CodeValue[I] = '-- 安全消防';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1033003';
Occupation_ParentId[I] = '1033000';
Occupation_CodeValue[I] = '-- 声光学技术/激光技术';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1033004';
Occupation_ParentId[I] = '1033000';
Occupation_CodeValue[I] = '-- 测绘技术';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1033005';
Occupation_ParentId[I] = '1033000';
Occupation_CodeValue[I] = '-- 地质矿产冶金';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';


I++;
Occupation_CodeId[I] = '1033006';
Occupation_ParentId[I] = '1033000';
Occupation_CodeValue[I] = '-- 气象';
Occupation_IsVisible[I] = '1';
Occupation_Lvl[I] = '2';
//-->
