<html>
<! Copyright (c) Realtek Semiconductor Corp., 2003. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>UPnP <% multilang(LANG_CONFIGURATION); %></title>
<link rel="stylesheet" type="text/css" href="common_style.css" />
<SCRIPT language="javascript" src="/common.js"></SCRIPT>
<SCRIPT>
function proxySelection()
{
	if (document.upnp.daemon[0].checked) {
		document.upnp.ext_if.disabled = true;

		if(typeof(document.upnp.tr_064_sw) != "undefined")
		{
			document.upnp.tr_064_sw[0].disabled = true;
			document.upnp.tr_064_sw[1].disabled = true;
		}
	}
	else {
		document.upnp.ext_if.disabled = false;

		if(typeof(document.upnp.tr_064_sw) != "undefined")
		{
			document.upnp.tr_064_sw[0].disabled = false;
			document.upnp.tr_064_sw[1].disabled = false;
		}
	}
}

function on_submit()
{
	postTableEncrypt(document.forms[0].postSecurityFlag, document.forms[0]);
	return true;
}
</SCRIPT>
</head>

<body>
<blockquote>
<h2 class="page_title">UPnP <% multilang(LANG_CONFIGURATION); %></h2>

<form action=/boaform/formUpnp method=POST name="upnp">
<table style="font-size: 13">
  <tr>
  	<td>
  		<% multilang(LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_UPNP_THE_SYSTEM_ACTS_AS_A_DAEMON_WHEN_YOU_ENABLE_IT_AND_SELECT_WAN_INTERFACE_UPSTREAM_THAT_WILL_USE_UPNP); %>
	  </td>
  </tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table style="font-size: 13">
	<tr>
		<th><% multilang(LANG_UPNP); %>:</th>
		<td>
			<input type="radio" value="0" name="daemon" <% checkWrite("upnp0"); %> onClick="proxySelection()"><% multilang(LANG_DISABLE); %>&nbsp;&nbsp;
			<input type="radio" value="1" name="daemon" <% checkWrite("upnp1"); %> onClick="proxySelection()"><% multilang(LANG_ENABLE); %>
		</td>
	</tr>
	<% checkWrite("tr064_switch"); %>
	<tr>
		<th><% multilang(LANG_WAN_INTERFACE); %>:</th>
		<td>
			<select name="ext_if" <% checkWrite("upnp0d"); %>>
				<% if_wan_list("rt"); %>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			<input type="submit" value="<% multilang(LANG_APPLY_CHANGES); %>" onClick="return on_submit()">
		</td>
	</tr>
</table>
<input type="hidden" value="/upnp.asp" name="submit-url">
<input type="hidden" name="postSecurityFlag" value="">
<script>
	initUpnpDisable = document.upnp.daemon[0].checked;
	ifIdx = <% getInfo("upnp-ext-itf"); %>;
	document.upnp.ext_if.selectedIndex = -1;

	for( i = 0; i < document.upnp.ext_if.options.length; i++ )
	{
		if( ifIdx == document.upnp.ext_if.options[i].value )
			document.upnp.ext_if.selectedIndex = i;
	}

	proxySelection();
</script>
</form>
</blockquote>
</body>

</html>
