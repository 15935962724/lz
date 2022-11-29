var currentPath;
var lastSelectdResult;
var queryURL="/auction/get_category.do?keyword=";
var URL_category_memo="/auction/publish/category_memo.do";
var appMessages=new Array();appMessages['SearchWait']='<p style="margin:10px;color:#333;">Now is searching,please wait\u2026\u2026</p>';appMessages['SearchHint']='<p style="margin:10px;color:#333;">It doesn\'t mean you have to put your item in one of the search results.</p>'
appMessages['NoResult']='<p style="margin:10px;color:#333;">We did not find results for keyword\u201d.</p>';appMessages['NoSelection']='Please select one search result first.'
var memoMsgs=new Array();memoMsgs['CatMemo']='';memoMsgs['CatRelateMemo']='';memoMsgs['SEMemo']='';var g_debug=false;var g_isRelationNode=false;var g_sKeyword;var g_sCategoryId;function self_debug(msg)
{if(g_debug)
{alert("=[debug]="+msg);}}
function initCat(id){var sSelectId=id;if(!id||!cats[id]){id='0';}
g_isRelationNode=false;var catPath=new Array();if(currentPath&&currentPath.length>1)
{var iLoop=-1;var nParentID=getParent(id);for(var loop=currentPath.length-1;loop>=1;loop--){if(tree[currentPath[loop]]){if(currentPath[loop]==nParentID){iLoop=loop;break;}
else if(hasFathChildRelation(id,currentPath[loop])){iLoop=loop;g_isRelationNode=true;break;}}
else{continue;}}
if(iLoop>-1)
{for(var loop=0;loop<=iLoop;loop++)
{catPath[loop]=currentPath[loop];}
catPath[catPath.length]=id;}
if(!g_isRelationNode)
{for(var j=catPath.length-2;j>=1;j--)
{var strId=catPath[j];var sParentId=getParent(strId);var sParInArr=catPath[j-1];if(sParentId==sParInArr){continue;}
else if(hasFathChildRelation(strId,sParInArr)){g_isRelationNode=true;}}}}
if(!catPath||!catPath.length>0)
{do{catPath[catPath.length]=id;}while(id=getParent(id));catPath=catPath.reverse();}
for(var i=0;i<catPath.length&&i<4;i++){if(!currentPath||catPath[i+1]!=currentPath[i+1]||!currentPath[i+1]){showCategoryList(i,getChildren(catPath[i]),catPath[i+1]);}}
for(i=0;i<4;i++){if(document.getElementById('CategoryLevel'+i).innerHTML==''||i>=catPath.length){clearCategoryList(i);}}
deployTriggers();currentPath=catPath;showCurrentPath();changeRelationMemo(sSelectId,g_isRelationNode);changeCategoryMemo(sSelectId);}
function hasFathChildRelation(id,fid)
{var bHas=false;var oRelations=getRelation(fid);if(oRelations&&oRelations.length>0)
{for(var loop=0;loop<oRelations.length;loop++)
{if(oRelations[loop]==id)
{bHas=true;break;}}}
return bHas;}
function searchCategory(k){if(!k){return;}
g_sKeyword=k;var x=document.getElementById('SearchCategoryResult');if(!x)return;document.getElementById('ChooseTheResult').disabled='disabled';var oSEMemoID=document.getElementById("SEMemoID");if(oSEMemoID)
{oSEMemoID.innerHTML='';oSEMemoID.style.display='none';}
x.innerHTML=appMessages['SearchWait'];var result=new Array();result=searchCategoryArray(k);var req=new XMLHttpRequest();if(req){req.onreadystatechange=function(){if(req.readyState==4&&req.status==200){var content=req.responseText;var ra=new Array();;var b_SE;try{if(content&&content.length>0){eval(content);}}
catch(e){}
showSearchResult(k,ra,result,b_SE);}else{if(req.readyState>200){var temp=new Array();showSearchResult(k,temp,result);}}};var sURL=queryURL+k+'&t='+getTimestamp();req.open('GET',sURL);req.send(null);}}
function getSearchArrayResult(searchResult)
{var temp=new Array();if(searchResult)
{var oArray=searchResult.split("$$");if(oArray&&oArray.length>0)
{for(var loop=0;loop<oArray.length;loop++)
{var record=oArray[loop];if(record&&record.length>0)
{var oRecordArray=record.split("||");if(oRecordArray&&oRecordArray.length==3)
{temp[temp.length]=[oRecordArray[0],oRecordArray[1],oRecordArray[2]];}}}}}
return temp;}
function showSearchResult(k,temp,result,seFlag){var x=document.getElementById('SearchCategoryResult');if(!x)return;var output=new Array();var parentId='';var thisLine='';var html='';var b_isSE=seFlag;if(temp&&result)
{var i_tempLen=0;if(b_isSE)
{if(result&&result.length>0)
{temp=result;}}
if(temp)
{i_tempLen=temp.length;}
if(!b_isSE)
{for(var i=0;i<result.length;i++)
{for(var j=0;j<temp.length;j++)
{if(result[i][0]==temp[j][0])
{break;}}
if(j>=temp.length&&result[i])
{temp[temp.length]=result[i];}}}
for(i=0;i<temp.length;i++){if(!cats[temp[i][0]]){continue;}
thisLine=cats[temp[i][0]][0];if(tree[temp[i][0]])thisLine+=' > ...';parentId=getParent(temp[i][0]);while(parentId!='0'){if(!cats[parentId])break;thisLine=cats[parentId][0]+' > '+thisLine;parentId=getParent(parentId);}
if(parentId=='0')
{if(temp[i][1]&&temp[i][1].length>0)
{if(temp[i][1]=='-1')
{thisLine+=" (<font color=\"#006623\" class=\"B\">"+temp[i][2]+"</font>) ";}
else
{thisLine+=" > "+temp[i][1].split(";").join(" > ")+"";}}
output[i]=thisLine;}else{output[i]='';}}
var t;for(i=0;i<i_tempLen;i++){if(b_isSE)
{break;}
for(j=0;j<i_tempLen-1;j++){if(output[j]>output[j+1]){t=output[j];output[j]=output[j+1];output[j+1]=t;t=temp[j];temp[j]=temp[j+1];temp[j+1]=t;}}}
var t;for(i=i_tempLen;i<output.length;i++){for(j=i_tempLen;j<output.length-1;j++){if(output[j]>output[j+1]){t=output[j];output[j]=output[j+1];output[j+1]=t;t=temp[j];temp[j]=temp[j+1];temp[j+1]=t;}}}
for(i=0;i<temp.length;i++){if(output[i]){r=new RegExp('('+k+')',"ig");if(temp[i][1]&&temp[i][1].length>0&&temp[i][2]&&temp[i][2].length>0)
{if(temp[i][1]=='-1')
{html+='<li id="'+temp[i][0]+'" countid="'+temp[i][2]+'">'+output[i].replace(r,"<span>$1</span>")+'</li>';}
else
{html+='<li id="'+temp[i][0]+'" pvid="'+temp[i][2]+'">'+output[i].replace(r,"<span>$1</span>")+'</li>';}}
else
{html+='<li id="'+temp[i][0]+'">'+output[i].replace(r,"<span>$1</span>")+'</li>';}}}}
if(html&&html.length>0){x.innerHTML=html;var lis=x.getElementsByTagName('LI');if(!lis)return;for(var i=0;i<lis.length;i++){lis[i].onclick=selectOneResult;lis[i].ondblclick=returnOneResult;}
document.getElementById('ChooseTheResult').disabled='';}else{x.innerHTML=appMessages['NoResult'].replace('keyword',k);}}
function searchCategoryArray(k){var result=new Array();try
{for(var c in cats){if(cats[c][0].toLowerCase().indexOf(k.toLowerCase())>-1){result[result.length]=[c,"",""];}}}
catch(e)
{self_debug(e.description);}
return result;}
function selectOneResult(evnt){var x=getTriggerNode(evnt);if(lastSelectdResult){lastSelectdResult.className="";}
if(x.tagName!='LI'&&x.tagName!='li'){x=x.parentNode;}
x.className="Selected";lastSelectdResult=x;showSearchEngineMemo(x.getAttribute("countid"));}
function showSearchEngineMemo(count)
{var oSEMemoID=document.getElementById("SEMemoID");if(!oSEMemoID)
{return;}
if(count)
{var sHTML=memoMsgs['SEMemo'].replace('[count]',count);var sHTML=sHTML.replace('[keyword]',g_sKeyword);oSEMemoID.innerHTML=sHTML;oSEMemoID.style.display='';}
else
{oSEMemoID.innerHTML='';oSEMemoID.style.display='none';}}
function returnOneResult(evnt){var id;var pvid;var oObj=getTriggerNode(evnt);var sTagName=oObj.tagName.toLowerCase();if(sTagName=='input'){var x=document.getElementById('SearchCategoryResult');if(!x)return;var lis=x.getElementsByTagName('LI');if(!lis)return;for(var i=0;i<lis.length;i++){if(lis[i].className=='Selected'){id=lis[i].id;if(lis[i].getAttribute("pvid"))
{pvid=lis[i].getAttribute("pvid");}
break;}}
if(i==lis.length){alert(appMessages['NoSelection']);return;}}
else if(sTagName=='span'||sTagName=='font')
{var oParent=oObj.parentNode;try{id=oParent.id;pvid=oParent.getAttribute("pvid");}
catch(e){}}
else{id=oObj.id;try{pvid=oObj.getAttribute("pvid");}
catch(e){}}
if(pvid){document.getElementById("CategoryPropertyID").value=pvid;}
if(id){document.getElementById('SelectedCategoryID').value=id;if(tree[id])
{document.getElementById('SearchCategory').style.display='none';document.getElementById('NormalCategorySelector').style.display='';changeCategoryAuto(id);}
else
{if(submitpreCheck())
{document.forms['mainform'].submit();}}}}
function initSearch(){document.getElementById('ChooseTheResult').onclick=returnOneResult;document.getElementById('SearchCategoryResult').innerHTML=appMessages['SearchHint'];document.getElementById('SearchCategory').style.display='none';}
function startSearch(){document.getElementById('SearchCategory').style.display='';document.getElementById('NormalCategorySelector').style.display='none';}
function cancelSearch(){document.getElementById('SearchCategory').style.display='none';document.getElementById('NormalCategorySelector').style.display='';}
function clearCategoryList(level){document.getElementById('CategoryLevel'+level).innerHTML='';document.getElementById('CategoryLevel'+level).className='Blank';}
function showCategoryList(level,arr,selected){var listBox;listBox=document.getElementById('CategoryLevel'+level);if(!listBox){alert("Error!Please reload this page and try again.");}else{var liClass='';var output='';listBox.innerHTML='';listBox.className='';for(var i=0;i<arr.length;i++){if(arr[i]==selected){liClass='Selected';}
output='<li id="'+arr[i]+'" class="'+liClass+'">'+cats[arr[i]][0]+'</li>';listBox.innerHTML+=output;liClass='';}
showSpecialStyle(level);}}
function showSpecialStyle(level){var lis;lis=document.getElementById('CategoryLevel'+level).getElementsByTagName('LI');if(!lis){alert("Error!Please reload this page and try again.");}else{for(var i=0;i<lis.length;i++){if(tree[lis[i].id]){lis[i].className+=' IsFather';}
if(used[lis[i].id]){lis[i].className+=' RecentUsed';}}}}
function showCurrentPath(){var x=document.getElementById('NowSelectedResult');if(!x)return;var y=document.getElementById('SubmitButton');if(!y)return;x.innerHTML='';for(var i=1;i<currentPath.length;i++){x.innerHTML+=cats[currentPath[i]][0];if(i<currentPath.length-1){x.innerHTML+=' > ';}}
if(tree[currentPath[i-1]]){x.innerHTML+=' > ...';y.disabled='disabled';}else{y.disabled='';}}
function refreshPosition(level){var x=document.getElementById('CategoryLevel'+level);if(!x)return;var lis=x.getElementsByTagName('LI');if(!lis)return;for(var i=0;i<lis.length;i++){if(lis[i].className.indexOf('Selected')>-1){break;}}
if(i>=lis.length){return;}
if(i>4){i-=4;}else{i=0;}
var t=x.scrollTop;x.scrollTop=22*i;}
function refreshAllPosition(){for(var i=0;i<4;i++){refreshPosition(i);}}
function changeCategory(evnt){var x=getTriggerNode(evnt);var selectCatID;if(x.tagName!='LI'&&x.tagName!='li'){selectCatID=x.parentNode.id;initCat(selectCatID);}else{selectCatID=x.id;initCat(selectCatID);}
document.getElementById('SelectedCategoryID').value=selectCatID;}
function changeRelationMemo(sCatId,b_isRelation)
{var oCatRelationId=document.getElementById("CategoryRelationID");if(!oCatRelationId)
{return;}
if(b_isRelation&&b_isRelation==true)
{var sRealPath=getRealPath(sCatId);if(sRealPath)
{oCatRelationId.innerHTML=memoMsgs['CatRelateMemo'].replace('[realPath]',sRealPath);;oCatRelationId.style.display='';}}
else
{oCatRelationId.innerHTML='';oCatRelationId.style.display='none';}}
function changeCategoryMemo(sCatId)
{var bCateMemo=false;var oCatMemoId=document.getElementById("CategoryMemoID");if(!oCatMemoId)
{return;}
if(sCatId)
{if(cm[sCatId])
{oCatMemoId.innerHTML=memoMsgs['CatMemo'].replace('[catMemo]',cm[sCatId]);oCatMemoId.style.display='';}
else
{oCatMemoId.innerHTML='';oCatMemoId.style.display='none';}}}
function getRealPath(sCatId)
{var sRelPath='';var realPath=new Array();do{realPath[realPath.length]=sCatId;}while(sCatId=getParent(sCatId));realPath=realPath.reverse();if(realPath&&realPath.length>0)
{for(var i=1;i<realPath.length;i++)
{sRelPath+=cats[realPath[i]][0];if(i<realPath.length-1){sRelPath+=' > ';}}}
return sRelPath;}
function changeCategoryAuto(id){document.getElementById('SelectedCategoryID').value=id;initCat(id);refreshAllPosition();}
function deployTriggers(){var lis=document.getElementById('CategorySelector').getElementsByTagName('LI');for(var i=0;i<lis.length;i++){lis[i].onclick=changeCategory;}}

  function createUsed()
  {
    var x=document.getElementById('RecentUsedCategories').getElementsByTagName('OPTION');
    if(!x)return;
    var y;
    for(var i=1;i<x.length;i++)
    {
      y=x[i].value;
      while(cats[y])
      {
       used[y]='yes';y=cats[y][1];
      }
    }
  }
function createTree()
{
  var fatherid;
  for(var c in cats)
  {
    fatherid=cats[c][1];
    if(!tree[fatherid])
    {
      tree[fatherid]=new Array();
    }
tree[fatherid][tree[fatherid].length]=c;if(used[c]){for(var i=tree[fatherid].length-1;i>0&&!used[tree[fatherid][i-1]];i--){tree[fatherid][i]=tree[fatherid][i-1];}
tree[fatherid][i]=c;}}
try{if(cr){for(var i=0;i<cr.length;++i){var c=cr[i][0];var p=cr[i][1];if(!crIndex[p])crIndex[p]=new Array();crIndex[p][crIndex[p].length]=c;}}}catch(ex){}}
function getParent(id){if(id!='0'){return cats[id][1];}else{return null;}}
function getChildren(id){var ch;if(tree[id]){ch=tree[id];}else{ch=new Array();}
return getRelation(id,ch);}
function getRelation(id,childArr)
{relaArr=childArr;if(!relaArr)
{relaArr=new Array();}
try{if(crIndex[id]&&crIndex[id].length>0){for(var i=0;i<crIndex[id].length;++i){var exists=false;for(var j=0;j<relaArr.length;++j){if(relaArr[j]==crIndex[id][i]){exists=true;break;}}
if(!exists)
relaArr[relaArr.length]=crIndex[id][i];}}}catch(ex){}
return relaArr;}
function getTriggerNode(e){var obj;if(document.all){obj=event.srcElement;}else{obj=e.target;}
return obj;}

function initCategory(aync,categoryId)
{
  g_sCategoryId=categoryId;
  var b_aync=false;
  if(aync)
  {
    b_aync=true;
  }
  var sURL=URL_category_memo+'?t='+getTimestamp();
  sAJAX(handleCategoryMemo,'GET',sURL,null,handleCatMemoExcep);
}
function handleCategoryMemo(res)
{if(res){try{if(res.responseText&&res.responseText.length>0){var data=(res.responseText);if(data){var datas=data.split('\n');if(datas&&datas.length>0){for(var i=0;i<datas.length;++i){var ds=datas[i];if(ds){var ss=ds.split('=');if(ss&&ss.length==2){var cid='0';var memo='';try{cid=ss[0].split("'")[1];}catch(e){}
try{memo=ss[1].split('"')[1];}catch(e){}
eval("cm[cid] = '"+memo+"';");}}}}}}}
catch(e){self_debug(e.description);}}
changeCategoryAuto(g_sCategoryId);initSearch();}
function handleCatMemoExcep(res)
{changeCategoryAuto(g_sCategoryId);initSearch();}
function getTimestamp()
{var d=new Date();return d.getTime();}
