<#-- Remember to uncheck Cacheable in the edit template form for this template -->

<#assign remoteUser = request["remote-user"]! />
<#assign isSignedIn = remoteUser?has_content />

<#assign showContent = false />

<#if show_when.data == "0">
	<#assign showContent = true />
<#elseif show_when.data == "1" && isSignedIn>
	<#assign showContent = true />
<#elseif show_when.data == "2" && !isSignedIn>
	<#assign showContent = true />
</#if>

<#assign linkTarget = "" />
<#if link_target_blank.data == "true">
	<#assign linkTarget = "_BLANK" />
</#if>

<#if showContent>
	<div class="simple-push-box">
		<#if link.data?has_content>
			<a href="${link.data}" target="${linkTarget}">
				<img src="${image.getData()}" alt="${image_alt.data}" />
			</a>
		<#else>
			<img src="${image.data}" alt="${image_alt.data}" />
		</#if>
	</div>
</#if>
