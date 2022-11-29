//Trim
function Trim(sVal)
{
 while ((sVal.lengTD>0)  && (sVal.charAt(0)==' '))
   sVal=sVal.substring(1, sVal.length);
 while ((sVal.lengTD>0)  && (sVal.charAt(sVal.length-1)==' '))
   sVal=sVal.substring(0, sVal.length-1);
 return  sVal;
}

/***********************************************************
 Comment: Validate the E-Mail
 Input:   (must)ChkStr -- The E-mail  Address
 Returns: true -- nonlicet
      false  -- licit
 Editor:  cndragon  2000-12-13
 Modify:
***********************************************************/
function IsMail( ChkStr  ) 
{
  if (Trim(ChkStr).length == 0)  return false;
  if (ChkStr.length  < 5) return  false;
  if (ChkStr.indexOf(" ") >  2) return false;
  var i  = 1;
  var sLength =  ChkStr.length;
  while  ((i  < ChkStr.length) &&  (ChkStr.charAt(i) != "@"))
  {  i++
  }
  if ((i >=  ChkStr.length) || (ChkStr.charAt(i)  != "@")) return  false;
  else i +=  2;
  while  ((i  < ChkStr.length) &&  (ChkStr.charAt(i) != "."))
  {  i++
  }
  if ((i >=  ChkStr.length -  1) || (ChkStr.charAt(i)  != ".")) return  false;
  else return true;
}

function ChkTxt(objItem, strTitle)
{
  if(Trim(objItem.value).length==0)
  {
  alert('请输入' + strTitle + '！' );
  objItem.focus();
  return false;
  }
  
  return true;
}

function StrCmp( sFirst, sSecond )
{
  var  sou  = new String( sFirst );
  var  dest = new String( sSecond );
  
  if ( sou.length  != dest.length )
    return false;
    
  var  i =  0;
  
  while (  sou.charAt(  i )  == dest.charAt(  i )  )
  {
    if ( i == sou.length ) break;
    i++;
  }
  
  if ( i == sou.length )
    return true;
  else
    return false;
}


function ConfirmDelete(objChk,strJsDelType)
{
  var i;
  var blnFlag;
  
  if(StrCmp(objChk,  'undefined'))
  {
  return false;  
  }
  else if(objChk.length  > 1)  
  {
  blnFlag  = false;
  for(i=0;i<objChk.length;i++)
  {
    if(objChk[i].checked)
    {
    blnFlag  = true;
    break;
    }
  }
  }
  else
  {
  blnFlag  = objChk.checked;
  }
  if(blnFlag)
  return confirm("你确定要删除吗？");
  else
  {
  alert("请选择要删除的" + strJsDelType +  "！");
  return false;
  }
}

//check  if the string is only digit
function ChkDigit(objDigit,txtTitle)
{
  var  strDigit=objDigit.value;
  /*
  for  (nIndex=0; nIndex<strDigit.length; nIndex++)
  {
    cCheck = strDigit.charAt(nIndex);
    if (isNaN(cCheck))
    {
      alert(txtTitle + "只能使用正整数！");
      objDigit.focus();
      return false;
    }
  }
  */
  if(isNaN(strDigit))
  {
    alert(txtTitle + "只能使用数字！");
    objDigit.focus();
    return false;
  }
  return true;
}
function ChkPositive(objDigit, txtTitle)
{
  if(!ChkDigit(objDigit, txtTitle))  return false;
  else
  {
  if(parseInt(objDigit.value)<0)
  {
    alert(txtTitle + "不能使用负数！");
    objDigit.focus();
    return false;
  }
  }
  return true;
}

function ChkIDCard(objID)
{
  var  strID =  objID.value;
  
  if (strID.length !=  15 && strID.length != 18)
  {
    alert("身份证号只能为 15 位或 18 位数字，请重新输入！");
    objID.focus();
    return false;
  }

  return true;
}

//check  if the string is beyond  limit
function ChkLength(objItem,  txtTitle, nMaxLength,nMinLength)
{
  var  strItem=objItem.value;

  if(strItem.lengTD>nMaxLength)  {
  alert(txtTitle + "超出字数限制，你最多可以输入 " + nMaxLength +  " 个字！");
    objItem.focus();
    return false;
  }
  if(strItem.length<nMinLength)  {
  alert(txtTitle + "字数太少，你至少要输入 " + nMinLength  + "  个字！");
    objItem.focus();
    return false;
  }
  return true;
  
}

function getLength(strChecked)
{
  alert('现已输入了 ' +  strChecked.length +  ' 个字。');   
}

function FormatDate(sDate, intLength){
  var mDate    =  Trim(sDate);
  var arrDate =  mDate.split('-');
  var mYear    =  parseInt(arrDate[0],10);
  var mMonth  =  parseInt(arrDate[1],10);
  var mDay    =  parseInt(arrDate[2],10);
  if(mMonth  < 10) mMonth = '0' + mMonth;
  if(mDay <  10)  mDay = '0' + mDay;
  if(intLength==15)  mYear =  mYear %  100;
  var sVal = mYear.toString() +  mMonth.toString() +  mDay.toString();
  //alert(sVal);
  return sVal;
}

// yyyy-mm-dd
function IsDate(sDate) {
var  mDate  = Trim(sDate);
var  mLen  = mDate.length;

if ( mLen <  8 || mLen >  11 )   return false;

mDate =  mDate.replace(/(\/)/g, "-");
mDate =  mDate.replace("年",  "-");
mDate =  mDate.replace("月",  "-");
mDate =  mDate.replace("日",  "");
if ( mDate.search(/\d{4}-\d{1,2}-\d{1,2}/gi) ==  -1 ) return  false;

var  arrDate  = mDate.split('-');
var  mYear  = parseInt(arrDate[0],10);
var  mMonth  = parseInt(arrDate[1],10) -  1;  
var  mDay  = parseInt(arrDate[2],10);

var  today =  new  Date();
if (mYear<1900 || mYear  >= 2100) return  false;

var  objDate  = new Date(mYear,mMonth,mDay);
if(objDate.getFullYear() !=  mYear || objDate.getMonth()  != mMonth || objDate.getDate() != mDay )
  return false;

return true;
}

// yyyy-mm
function IsMonth(sDate)  {
var  mDate  = Trim(sDate);
var  mLen  = mDate.length;

if ( mLen <  6 || mLen >  7 )    return false;

mDate =  mDate.replace(/(\/)/g, "-");
if ( mDate.search(/\d{4}-\d{1,2}/gi) ==  -1 ) return  false;

var  arrDate  = mDate.split('-');
var  mYear  = parseInt(arrDate[0],10);
var  mMonth  = parseInt(arrDate[1],10) -  1;  

if (mYear<1900 || mYear>2100) return false;

var  objDate  = new Date(mYear,mMonth,1);
if(objDate.getFullYear() !=  mYear || objDate.getMonth()  != mMonth)
  return false;

return true;
}

// hh:mm
function IsTime(sTime) {
var  mTime  = Trim(sTime);
var  mLen  = mTime.length;

if ( mLen <  3 || mLen >  5 )  return false;
if ( mTime.search(/\d{1,2}:\d{1,2}/gi) == -1 ) return false;

var  arrDate  = mTime.split(':');
var  mHour   = parseInt(arrDate[0],10);
var  mMinute   = parseInt(arrDate[1],10);   

if ( mHour < 0 || mHour  > 23 ||  mMinute  < 0  || mMinute > 59  ) return false;

return true;
}

// 0: yyyy-mm-dd  1: yyyy-mm-dd  hh:mm 2: hh:mm 3: yyyy-mm
function IsDateTime(sDate,sType) {
switch (sType.toString(10))  {
case '0':  // yyyy-mm-dd
  return IsDate(sDate);
case '1':  // yyyy-mm-dd hh:mm

  var  mDate  = Trim(sDate);
  var  mLen  = mDate.length;

  if ( mLen <  12 || mLen > 16  ) return false;
  if ( mDate.search(/\d{4}-\d{1,2}-\d{1,2} \d{1,2}:\d{1,2}/gi) ==  -1 ) return  false;

  var  arrDate  = mDate.split('  ');
  
  if ( IsDate( arrDate[0]  ) == false || IsTime( arrDate[1]) == false )
    return false;
  break;
case '2':  // hh:mm
  return IsTime(sDate);
case '3':  // yyyy-mm
  return IsMonth(sDate);
default:
  return false;
}
return true;
  
}

function SetOther(objText, objItem)
{
  objText.value  = "";
  objText.disabled = objItem.checked;
}

/*
function CheckAll(frm, chkItemName,  objChkAll)
{
for  (var i=0;i<frm.elements.length;i++)
  {
  var e  = frm.elements[i];
  if (e.name ==  chkItemName)
   e.checked = objChkAll.checked;
  }
}
*/
function CheckAll(objItem, objAll)
{
  if(!StrCmp(objItem, 'undefined'))
  {
  if(objItem.length >  1)
  {
    for(var i=0;i<objItem.length;i++)
    objItem[i].checked = objAll.checked;
  }
  else
    objItem.checked =  objAll.checked;
  }
}

function ChkSel(objElement,  intSelect, txtTitle)
{
 if  ( objElement.value == intSelect  ) {
    alert("请选择" + txtTitle + "！");
    objElement.focus();
    return false;
  }
  return true;
}

/*********************************************************
* Comment:  将某一列表框中的选定项“移动”到另一列表框
* Author :  谷文栋
* Input   : sltFrom -- 要移走项目的列表框
*       sltTo --  要接收项目的列表框
* Output : 
***********************************************************/
function AddOption(sltFrom,  sltTo){
  var strVal;
  var strText;
  if(sltFrom.value==0 | sltFrom.value=='') return false;
  
  for(var x=0;x<sltFrom.length;x++){
  var  opt  = sltFrom.options[x];
  if (opt.selected){
    flag = true;
    for (var y=0;y<sltTo.length;y++){
    var  myopt =  sltTo.options[y];
    if (myopt.value  == opt.value){
      flag = false;
    }
    }
    /*
    实现已经选择省以后就不再选择所属的市县
    
    首先确定要选择的项目的编号；其次确定所属省的编号；然后判断省是否已经选择
    */
    for(var  Ii = 0 ; Ii  < I  ; Ii++){
      for(var  Jj = 0 ; Jj  <= CityID[Ii].length ; Jj++){
        //确定所属省的数组的位置，并得到所属省的编号
        if(parseInt(CityID[Ii][Jj]) == parseInt(opt.value)){
          for  (var Py  = 0;Py<sltTo.length;Py++)
          {
            var  myPopt = sltTo.options[Py];
            //如果省的编号已经被选定，则将标记置为false
            if (myPopt.value ==  Province[Ii])
            {
              flag = false;
            }
            //如果当前编号是省，则删除所有已选择的下辖县市
            if (opt.value == Province[Ii])
            {
              //判断当前选定的编号是不是属于要选择的省
              /*for (var Jjj = 0 ; Jjj <=  CityID[Ii].length ;  Jjj++)
              {
                if (myPopt.value ==  CityID[Ii][Jjj])
                  {
                    myPopt.selected  = true;
                    DelOption(sltTo);
                  }
              }
              */
              
            }
          }
        }
      }
    }
    if(flag){
    sltTo.options[sltTo.options.length]  = new Option(opt.text, opt.value, 0, 0);
    strVal=opt.value;
    strText=opt.text;
    removeExistCity(sltTo, strVal, strText);
    //sltFrom.options[x] = null;
    x--;
    }
    
  }
  }
  
}

//===================================================
//-- 去掉已选择的市
//===================================================
function removeExistCity(sltTo, PVal, strText)
{ 
  var flag=-1;
  var i,j,l,k;
  arrNewV = new Array;
  arrNewT = new Array;
  for(i=0;i<Province.length;i++)
  {
    if(Province[i]==PVal) flag=i;
  }
  l=0;
  if(flag!=-1)
  {
    i=0;
    for(i=0;i<sltTo.options.length;i++)
    {
      j=0;
      k=false;
      for(j=0;j<CityID[flag].length;j++)
      {
        if(CityID[flag][j]==sltTo.options[i].value)
        {
          k=true;
        }
      }
      
      if(!k)
      {
        arrNewV[l]=sltTo.options[i].value;
        arrNewT[l]=sltTo.options[i].text;
        l++;
      }
    }
    
    arrNewV[l]=PVal;
    arrNewT[l]=strText;
    
    for(i=sltTo.options.length;i>=0;i--)
    {
      sltTo.options[i]=null;
    }
    
    for(i=0;i<arrNewV.length;i++)
    {
      sltTo.options[i]= new Option(arrNewT[i], arrNewV[i], 0, 0)
    }
    return false;
  }
}

function DelOption(sltFrom){
  for(var x=sltFrom.length-1;x>=0;x--){
  var  opt  = sltFrom.options[x];
  if (opt.selected){
    sltFrom.options[x] = null;
  }
  }
}

/*********************************************************
* Comment:  检查多项列表中的要求个数
* Author : Alex  Zhang
* Input   : obj -- 要检查的多项列表
*       maxNum -- 最大数  为0表示不要求
*       mimNum -- 最小数  为0表示不要求
*       txtTitle  --  提示用户的Title
* Output :  如果obj不是多项选择，则检查是否为C_CODE_SELECT,
*      是则返回false ,  否则返回true
***********************************************************/
function CheckMulSelect(obj, maxNum, minNum, txtTitle)
{
  if(obj.multiple)
  {
  var  optionNum=obj.length;
  if(maxNum!=0 &&  optionNum>maxNum)
  {
    alert('"'+txtTitle+'"  最多选择'+maxNum+'项！');
    obj.focus();
    return false;
  }
  
  if(minNum!=0 &&  optionNum<minNum &&  maxNum==0)
  {
    alert('"'+txtTitle+'"  最少选择'+minNum+'项！');
    obj.focus();
    return false;
  }
  
  return true;
  }
  else
  {
  if(obj.value==-1)
  {
    alert('"'+txtTitle+'"  必须选择！');
    obj.focus();
    return false;
  }
  else
    return true;
  }
}

