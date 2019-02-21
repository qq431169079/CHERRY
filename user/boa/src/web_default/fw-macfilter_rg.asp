<html>
<! Copyright (c) Realtek Semiconductor Corp., 2003. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>MAC <% multilang(LANG_FILTERING); %></title>
<link rel="stylesheet" type="text/css" href="common_style.css" />
<SCRIPT language="javascript" src="/common.js"></SCRIPT>
<script type="text/javascript" src="share.js">
</script>
<script>
function skip () { this.blur(); }
function addClick(obj)
{
//  if (document.formFilterAdd.srcmac.value=="" )
//	return true;
  if (document.formFilterAdd.srcmac.value==""){ //&& document.formFilterAdd.dstmac.value=="") {
	alert('<% multilang(LANG_INPUT_MAC_ADDRESS); %>');
	return false;
  }

	if (document.formFilterAdd.srcmac.value != "") {
		if (!checkMac(document.formFilterAdd.srcmac, 0))
			return false;
	}
	/*if (document.formFilterAdd.dstmac.value != "") {
		if (!checkMac(document.formFilterAdd.dstmac, 0))
			return false;
	}*/
	obj.isclick = 1;
	postTableEncrypt(document.formFilterAdd.postSecurityFlag, document.formFilterAdd);
	
	return true;
/*  var str = document.formFilterAdd.srcmac.value;
  if ( str.length < 12) {
	alert("Input MAC address is not complete. It should be 12 digits in hex.");
	document.formFilterAdd.srcmac.focus();
	return false;
  }

  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

	alert("Invalid MAC address. It should be in hex number (0-9 or a-f).");
	document.formFilterAdd.srcmac.focus();
	return false;
  }
  return true;*/
}

function disableDelButton()
{
  if (verifyBrowser() != "ns") {
	disableButton(document.formFilterDel.deleteSelFilterMac);
	disableButton(document.formFilterDel.deleteAllFilterMac);
  }
}

function on_submit(obj)
{
	obj.isclick = 1;
	postTableEncrypt(document.formFilterDefault.postSecurityFlag, document.formFilterDefault);
	return true;
}

function deleteClick(obj)
{
	if ( !confirm('<% multilang(LANG_CONFIRM_DELETE_ONE_ENTRY); %>') ) {
		return false;
	}
	else{
		obj.isclick = 1;
		postTableEncrypt(document.formFilterDel.postSecurityFlag, document.formFilterDel);
		return true;
	}
}
        
function deleteAllClick(obj)
{
	if ( !confirm('Do you really want to delete the all entries?') ) {
		return false;
	}
	else{
		obj.isclick = 1;
		postTableEncrypt(document.formFilterDel.postSecurityFlag, document.formFilterDel);
		return true;
	}
}
</script>
</head>

<body>
<blockquote>
<h2 class="page_title"><% multilang(LANG_MAC_FILTERING); %></h2>

<table>
<tr><td><font size=2>
 <% multilang(LANG_PAGE_DESC_LAN_TO_INTERNET_DATA_PACKET_FILTER_TABLE); %>
</font></td></tr>

<tr><td><hr size=1 noshade align=top></td></tr>
</table>

<table>
<form action=/boaform/admin/formFilter method=POST name="formFilterDefault">
<tr><th><% multilang(LANG_MODE); %>&nbsp;&nbsp;
   	<input type="radio" name="outAct" value=0 <% checkWrite("macf_out_act0"); %>><% multilang(LANG_WHITE_LIST); %>&nbsp;&nbsp;
   	<input type="radio" name="outAct" value=1 <% checkWrite("macf_out_act1"); %>><% multilang(LANG_BLACK_LIST); %>&nbsp;&nbsp;</th>
<th><input type="submit" value="<% multilang(LANG_APPLY_CHANGES); %>" name="setMacDft" onClick="return on_submit(this)">&nbsp;&nbsp;
	<input type="hidden" value="/admin/fw-macfilter_rg.asp" name="submit-url">
	<input type="hidden" name="postSecurityFlag" value="">
</th><tr>
</form>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table>
<form action=/boaform/admin/formFilter method=POST name="formFilterAdd">
<!--<br>
<tr>
	<td><font size=2>
	<b><% multilang(LANG_DIRECTION); %>: </b></font>
	</td>
	<td>
	<select name=dir>
		<option select value=0><% multilang(LANG_BOTH); %></option>
		<option value=1><% multilang(LANG_SOURCE); %></option>
		<option value=2><% multilang(LANG_DESTINATION); %></option>
	</select>
	</td>
</tr> -->
<tr>
	<th>
	<% multilang(LANG_MAC_ADDRESS); %>: 
	</th>
	<td>
	<input type="text" name="srcmac" size="15" maxlength="12">&nbsp;&nbsp;</td>
	<td>
	<input type="submit" value="<% multilang(LANG_ADD); %>" name="addFilterMac" onClick="return addClick(this)">&nbsp;&nbsp;
	<input type="hidden" value="/admin/fw-macfilter_rg.asp" name="submit-url">
	<input type="hidden" name="postSecurityFlag" value="">
	</td>
</tr>
<!--<tr><td>&nbsp;</td></tr>-->
<tr><td><hr size=1 noshade align=top></td></tr>
</form>
</table>

<form action=/boaform/admin/formFilter method=POST name="formFilterDel">
	<table>
	<tr><font size=2><b><% multilang(LANG_CURRENT_FILTER_TABLE); %>:</b></font></tr>
	<% macFilterList(); %>
	</table>
	<br>
	<input type="submit" value="<% multilang(LANG_DELETE_SELECTED); %>" name="deleteSelFilterMac" onClick="return deleteClick(this)">&nbsp;&nbsp;
	<input type="submit" value="<% multilang(LANG_DELETE_ALL); %>" name="deleteAllFilterMac" onClick="return deleteAllClick(this)">&nbsp;&nbsp;&nbsp;
	<input type="hidden" value="/admin/fw-macfilter_rg.asp" name="submit-url">
	<input type="hidden" name="postSecurityFlag" value="">
	<script>
		<% checkWrite("macFilterNum"); %>
	</script>
</form>

</blockquote>
</body>
</html>
