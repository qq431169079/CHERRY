<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--系统默认模板-->
<HTML>
<HEAD>
<TITLE>端口过滤-白名单添加</TITLE>
<META http-equiv=pragma content=no-cache>
<META http-equiv=cache-control content="no-cache, must-revalidate">
<META http-equiv=content-type content="text/html; charset=gbk">
<META http-equiv=content-script-type content=text/javascript>
<!--系统公共css-->
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
<!--系统公共脚本-->
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">

var links = new Array();
with(links){<%listWanif("rt");%>}

function on_chkclick(index)
{
	if(index < 0 || index >= links.length)
		return;
	links[index].select = !links[index].select;
	if(links[index].select)form.portnum.value = parseInt(form.portnum.value) + 1;
	else form.portnum.value = parseInt(form.portnum.value) - 1;
}

<%listWanPath();%>
/*
var nEntryNum = 4;
var vArrayStr = "1_TR069_R_VID_4015,2_INTERNET_R_VID_200,3_OTHER_R_VID_2030,4_VOICE_R_VID_3951,";
var vEntryName = vArrayStr.split(',');
vArrayStr = "nas0_0,nas1_0,ppp16,nas3_0,";
var vEntryValue = vArrayStr.split(',');
vArrayStr = "0,8,16,24,";
vArrayStr = "Yes,Yes,No,No,";
vArrayStr = "Disabled,Enable,Enable,Disabled,";
var WANEnNAT = vArrayStr.split(',');

*/
vEntryName = SortUtil.UpdateWanIFName( vEntryName, nEntryNum );
vEntryValue = SortUtil.SortMyArray( vEntryValue );
WANEnNAT = SortUtil.SortMyArray( WANEnNAT );

function ChangeInface()
{
	var index = document.getElementById('WanPath').selectedIndex;
	if (index > -1)
	{
		for (i = 0; i < WANEnNAT.length-1; i++)
		{
			if (vEntryValue[i] == document.getElementById('WanPath').value)
			{
				break;
			}
		}
		if (WANEnNAT[i] == "Disabled")
		{
			document.getElementById('NatState').innerHTML = '禁用';
		}
		else
		{
			document.getElementById('NatState').innerHTML = '启用';
		}
	}
}

/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
	sji_docinit(document);
	/*
	if(lstrc.rows){while(lstrc.rows.length > 0) lstrc.deleteRow(0);}
	for(var i = 0; i < links.length; i++)
	{
		var row = lstrc.insertRow(i);

		row.nowrap = true;
		row.vAlign = "top";
		row.align = "center";

		var cell = row.insertCell(0);
		cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
		cell = row.insertCell(1);
		cell.innerHTML = links[i].displayname(1);
	}
	*/

	if ( <%checkWrite("IPv6Show");%> )
	{
		if (document.getElementById)  // DOM3 = IE5, NS6
		{
			document.getElementById('ipprotbl').style.display = 'block';
		}
		else {
			if (document.layers == false) // IE4
			{
				document.all.ipprotbl.style.display = 'block';
			}
		}

		protocolChange();
	}
}

function refresh()
{
	window.location.reload(true);
}

function protocolChange()
{
	// If protocol is IPv4 only.
	if(document.forms[0].IpProtocolType.value == 1){
		if (document.getElementById)  // DOM3 = IE5, NS6
		{
			document.getElementById('ip4tbl').style.display = 'block';
			document.getElementById('ip6tbl').style.display = 'none';
			document.getElementById('ip4protoType').style.display = 'block';
			document.getElementById('ip6protoType').style.display = 'none';
		}
		else {
			if (document.layers == false) // IE4
			{
				document.all.ip4tbl.style.display = 'block';
				document.all.ip6tbl.style.display = 'none';
				document.all.ip4protoType.style.display = 'block';
				document.all.ip6protoType.style.display = 'none';
			}
		}
	}
	// If protocol is IPv6 only.
	else if(document.forms[0].IpProtocolType.value == 2){
		if (document.getElementById)  // DOM3 = IE5, NS6
		{
			document.getElementById('ip4tbl').style.display = 'none';
			document.getElementById('ip6tbl').style.display = 'block';
			document.getElementById('ip4protoType').style.display = 'none';
			document.getElementById('ip6protoType').style.display = 'block';
		}
		else {
			if (document.layers == false) // IE4
			{
				document.all.ip4tbl.style.display = 'none';
				document.all.ip6tbl.style.display = 'block';
				document.all.ip4protoType.style.display = 'none';
				document.all.ip6protoType.style.display = 'block';
			}
		}
	}
}

// Mason Yu:20110524 ipv6 setting. START

/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
	with ( document.forms[0] )
	{
		if(filterName.value.length <= 0)
		{
			filterName.focus();
			alert("过滤器名不能为空，请输入过滤器名!");
			return;
		}
		if(sji_checkstrnor(filterName.value, 1, 22) == false)
		{
			filterName.focus();
			alert("过滤器名错误，请重新输入过滤器名!");
			return;
		}

    if(sipStart.value.length==0 && sipEnd.value.length)
    {
      sipStart.focus();
			alert("源IP结束地址必须搭配源IP起始地址！");
			return;
    }
    if(dipStart.value.length==0 && dipEnd.value.length)
    {
      dipStart.focus();
			alert("目的IP结束地址必须搭配目的IP起始地址！");
			return;
    }
    if(smask.value.length && sipStart.value.length==0)
    {
      sipStart.focus();
      alert("源子网掩码必须搭配源IP地址！")
      return;
    }
    if(dmask.value.length && dipStart.value.length==0)
    {
      dipStart.focus();
      alert("目的子网掩码必须搭配目的IP地址！");
      return;
    }
    if(sportStart.value.length==0 && sportEnd.value.length)
    {
      sportStart.focus();
      alert("结束源端口必须搭配起始源端口！");
      return;
    }
    if(sportStart.value.length==0 && sportEnd.value.length)
    {
      sportStart.focus();
      alert("结束目的端口必须搭配起始目的端口！");
      return;
    }

		if(sipStart.value.length == 0)
		{
			sipStart.focus();
			alert("源IP地址(起始) 为无效地址，请重新输入！");
			return;
		}
		if((!isGlobalIpv6Address(sipStart.value)) && sji_checkvip(sipStart.value) == false)
		{
			sipStart.focus();
			alert("源IP地址(起始)\"" + sipStart.value + "\"为无效地址，请重新输入！");
			return;
		}

		if(isGlobalIpv6Address(sipStart.value))
		{	
			IpProtocolType.value = 2;
 			protoTypeV6.value = protoType.value;
			sip6Start.value = sipStart.value;
			sip6End.value = sipEnd.value;
			dip6Start.value = dipStart.value;
			dip6End.value = dipEnd.value;
			protoType.value = 5;
			sipStart.value = "";
			sipEnd.value = "";
			dipStart.value = "";
			dipEnd.value = "";
		}
		else
		{
			IpProtocolType.value = 1;
		}

		//////////
		if((protoType.value ==0 || protoType.value ==4 ) && (protoTypeV6.value ==0 || protoTypeV6.value ==4 ) && (sportStart.value || sportEnd.value || dportStart.value || dportEnd.value))
		{
		  sportStart.focus();
		  alert("端口号必须与TCP, UDP一起选择");
		  return;
		}
		
		if(document.forms[0].IpProtocolType.value == 1){
			if(sipEnd.value.length == 0 || sji_checkvip(sipEnd.value) == false)
		{
			sipEnd.focus();
			alert("源IP地址(结束)\"" + sipEnd.value + "\"为无效地址，请重新输入！");
			return;
		}
		if(sipStart.value.length != 0 && sipEnd.value.length != 0 && sji_ipcmp(sipStart.value, sipEnd.value) > 0)
		{
			sipEnd.focus();
			alert("源IP起始地址不能大于结束地址，请重新输入结束地址！");
			return;
		}
			
		if(sipStart.value.length != 0 && sipEnd.value.length==0 && sji_checkmask(smask.value) == false)
		{
			smask.focus();
			alert("源子网掩码\"" + smask.value + "\"为无效掩码，请重新输入！");
			return;
		}
		if(sipStart.value.length != 0 && sipEnd.value.length != 0 && smask.value.length !=0)
		{
			smask.focus();
			alert("设定源IP范围时不能填入源子网掩码！");
			return;
		}

		}
		
		if(sportStart.value.length != 0 && sji_checkdigitrange(sportStart.value, 1, 65535) == false)
		{
			sportStart.focus();
			alert("源端口(起始)\"" + sportStart.value + "\"为无效端口，请重新输入！");
			return;
		}
		if(sportEnd.value.length != 0 && sji_checkdigitrange(sportEnd.value, 1, 65535) == false)
		{
			sportEnd.focus();
			alert("源端口(结束)\"" + sportStart.value + "\"为无效端口，请重新输入！");
			return;
		}
		if(sportStart.value.length != 0 && sportEnd.value.length != 0 && (parseInt(sportStart.value) > parseInt(sportEnd.value)))
		{
			sportEnd.focus();
			alert("源起始端口不能大于结束端口，请重新输入结束端口！");
			return;
		}
		///////////////

		if(document.forms[0].IpProtocolType.value == 1){
			if(dipStart.value.length == 0 || sji_checkvip(dipStart.value) == false)
		{
			dipStart.focus();
			alert("目的IP地址(起始)\"" + sipStart.value + "\"为无效地址，请重新输入！");
			return;
		}
		if(dipEnd.value.length != 0 && sji_checkvip(dipEnd.value) == false)
		{
			dipEnd.focus();
			alert("目的IP地址(结束)\"" + dipEnd.value + "\"为无效地址，请重新输入！");
			return;
		}
		if(dipStart.value.length != 0 && dipEnd.value.length != 0 && sji_ipcmp(dipStart.value, dipEnd.value) > 0)
		{
			dipEnd.focus();
			alert("目的IP起始地址不能大于结束地址，请重新输入结束地址！");
			return;
		}
			
		if(dipStart.value.length != 0 &&  dipEnd.value.length==0 && sji_checkmask(dmask.value) == false)
		{
			dmask.focus();
			alert("目的子网掩码\"" + dmask.value + "\"为无效掩码，请重新输入！");
			return;
		}
		if(dipStart.value.length != 0 && dipEnd.value.length != 0 && dmask.value.length !=0)
		{
			dmask.focus();
			alert("设定目的IP范围时不能填入目的子网掩码！");
			return;
		}
			
		}
		if(dportStart.value.length != 0 && sji_checkdigitrange(dportStart.value, 1, 65535) == false)
		{
			dportStart.focus();
			alert("目的端口(起始)\"" + dportStart.value + "\"为无效端口，请重新输入！");
			return;
		}
		if(dportEnd.value.length != 0 && sji_checkdigitrange(dportEnd.value, 1, 65535) == false)
		{
			dportEnd.focus();
			alert("目的端口(结束)\"" + dportStart.value + "\"为无效端口，请重新输入！");
			return;
		}
		if(dportStart.value.length != 0 && dportEnd.value.length != 0 && (parseInt(dportStart.value) > parseInt(dportEnd.value)))
		{
			dportEnd.focus();
			alert("目的起始端口不能大于结束端口，请重新输入结束端口！");
			return;
		}
		/*ql:20080717 START: must assign at least one term.*/
		if ((protoType.selectedIndex==0 && sipStart.value.length==0 && dipStart.value.length==0 &&
			sportStart.value.length==0 && dportEnd.value.length==0) &&
			(protoTypeV6.selectedIndex==0 && sip6Start.value.length==0 && dip6Start.value.length==0 &&
			sportStart.value.length==0 && dportEnd.value.length==0))
		{
			alert("请设定过滤规则!");
			return;
		}
		/*ql:20080717 END*/

		var sif = "";
		for(var i in links)
		{
			if(!links[i].select)continue;
			if(sif.length != 0) sif += ";" + links[i].displayname();
			else sif += links[i].displayname();
		}

		ifname.value = sif;

		if ( <%checkWrite("IPv6Show");%> ) {
			if(document.forms[0].IpProtocolType.value == 0) {
				alert("请指定IP协议版本！");
				return;
			}

			//If this is IPv6 rule.
			if(document.forms[0].IpProtocolType.value == 2){
				if(sip6Start.value != ""){
					if (! isGlobalIpv6Address(sip6Start.value) ){
						alert("无效的源IPv6起始地址!"); //Invalid Source IPv6 Start address!
						return;
					}
					if ( sip6PrefixLen.value != "" ) {
						var prefixlen= getDigit(sip6PrefixLen.value, 1);
						if (prefixlen > 128 || prefixlen <= 0) {
							alert("无效的源IPv6前缀长度!"); //Invalid Source IPv6 prefix length!
							return;
						}
					}
				}

				if(sip6End.value != ""){
					if (! isGlobalIpv6Address(sip6End.value) ){
						alert("无效的源IPv6结束地址!"); //Invalid Source IPv6 End address!
						return;
					}
				}

				if(dip6Start.value != ""){
					if (! isGlobalIpv6Address(dip6Start.value) ){
						alert("无效的目的IPv6起始地址!"); //Invalid Destination IPv6 Start address!
						return;
					}
					if ( dip6PrefixLen.value != "" ) {
						var prefixlen= getDigit(dip6PrefixLen.value, 1);
						if (prefixlen > 128 || prefixlen <= 0) {
							alert("无效的目的IPv6前缀长度!"); //Invalid destination IPv6 prefix length!
							return;
						}
					}
				}

				if(dip6End.value != ""){
					if (! isGlobalIpv6Address(dip6End.value) ){
						alert("无效的目的IPv6结束地址!"); //Invalid Destination IPv6 End address!
						return;
					}
				}
			}
		}
		submit();
	}
}
</SCRIPT>
</HEAD>

<!-------------------------------------------------------------------------------------->
<!--主页代码-->
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init();">
<blockquote>
	<DIV align="left" style="padding-left:20px; padding-top:0px">
		<form id="form" action="/boaform/admin/formPortFilterWhiteIn" method="post">
			<div align="left">
				<b>IP层过滤</b><br>

				<br>
				<table cellSpacing="1" cellPadding="0" border="0">
				   <tr>
					  <td width="130px">过滤名称:</td>
					  <td><input type="text" size="22" name="filterName" style="width:150px"></td>
				   </tr>

				   <tr>
					  <td width="130px">协议:</td>
					  <td><select name="protoType" size="1" style="width:150px">
							<option value="5" selected>&nbsp;</option>
							<option value="1">TCP/UDP</option>
							<option value="2">TCP</option>
							<option value="3">UDP</option>
							<option value="4">ICMP</option>
						 </select></td>
				   </tr>

				   <tr>
					  <td width="130px">源IP地址:</td>
					  <td><input type="text" size="16" name="sipStart" style="width:150px"></td>
				   </tr>
				   <tr>
					  <td width="130px">结束源IP地址:</td>
					  <td><input type="text" size="16" name="sipEnd" style="width:150px"></td>
				   </tr>
				   <tr>
					  <td width="130px">源端口:</td>
					  <td><input type="text" size="6" name="sportStart" style="width:150px"></td>
				   </tr>
				   <tr>
					  <td width="130px">结束源端口:</td>
					  <td><input type="text" size="6" name="sportEnd" style="width:150px"></td>
				   </tr>
				   <tr>
					  <td width="130px">目的IP地址:</td>
					  <td><input type="text" size="16" name="dipStart" style="width:150px"></td>
				   </tr>
				   <tr>
					  <td width="130px">结束目的IP地址:</td>
					  <td><input type="text" size="16" name="dipEnd" style="width:150px"></td>
				   </tr>
				   <tr>
					  <td width="130px">目的端口:</td>
					  <td><input type="text" size="6" name="dportStart" style="width:150px"></td>
				   </tr>
				   <tr>
					  <td width="130px">结束目的端口:</td>
					  <td><input type="text" size="6" name="dportEnd" style="width:150px"></td>
				   </tr>
				</table>
				</div>
				
                <div>
                  <table  border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="130px">接口:</td>
                      <td><select id="WanPath" name="WanPath" size="1" onChange="ChangeInface()">
                        <script language="JavaScript" type="text/javascript">
						for (i = 0; i < nEntryNum; i++)
						{
							document.write('<option value=' + vEntryValue[i] + '>' + vEntryName[i] + '</option>');
						}
						  
						</script>
                        </select></td>
                    </tr>
                    <tr>
                      <td height="23">NAT状态:</td>
                      <td><div id="NatState">&nbsp;</div></td>
                        <script language="JavaScript" type="text/javascript">
						if (WANEnNAT[0] == "Disabled")
						{
							document.getElementById('NatState').innerHTML = '禁用';
						}
						else
						{
							document.getElementById('NatState').innerHTML = '启用';
						}
						</script>
                    </tr>
                  </table>
                </div>

			<hr align="left" class="sep" size="1" width="90%">
			<INPUT type="button" class="btnsaveup" value="确定" onClick="on_submit();">
	<input type="reset" onclick="refresh()" class="BtnCnl" value="取消">
			<input type="hidden" name="action" value="ad">
			<input type="hidden" name="portnum" value="0">
			<input type="hidden" name="ifname" value="">
			<input type="hidden" name="IpProtocolType" value="">
			<input type="hidden" name="protoTypeV6" value="">
			<input type="hidden" name="sip6Start" value="">
			<input type="hidden" name="sip6End" value="">
			<input type="hidden" name="sip6PrefixLen" value="">
			<input type="hidden" name="dip6Start" value="">
			<input type="hidden" name="dip6End" value="">
			<input type="hidden" name="dip6PrefixLen" value="">
			<input type="hidden" name="smask" value="">
			<input type="hidden" name="dmask" value="">
			<input type="hidden" name="sip6PrefixLen" value="">
			<input type="hidden" name="dip6PrefixLen" value="">
			<input type="hidden" name="submit-url" value="/secu_portfilter_cfg.asp">
		</form>
	</DIV>
	</blockquote>
</body>
<%addHttpNoCache();%>
</html>
