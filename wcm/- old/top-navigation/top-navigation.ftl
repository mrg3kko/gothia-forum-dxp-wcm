<#-- Define some services -->
<#assign groupLocalService = serviceLocator.findService("com.liferay.portal.service.GroupLocalService") >
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService") >
<#assign layoutSetLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutSetLocalService") >

<#assign themeDisplay = request["theme-display"] >
<#assign scopePlid =  getterUtil.getLong(request["theme-display"]["plid"]) >
<#assign scopeLayout =  layoutLocalService.getLayout(scopePlid) >
<#assign groupIdLong =  getterUtil.getLong(groupId) >
<#assign scopeGroup =  groupLocalService.getGroup(groupIdLong) >


<#assign isSignedIn = (request["remote-user"] != "") />

<ul class="navigation-list">
	<#list links.getSiblings() as link>

		<#assign linkUrl = link.externalLink.data />
		<#assign linkText = link.data />
		<#assign linkTarget = link.linkTarget.data />

		<#if linkUrl = "">
			<#assign linkData = link.internalLink.data?split("@") />
			<#assign linkLayoutId =  getterUtil.getLong(linkData[0]) />
			<#assign linkGroupId = getterUtil.getLong(linkData[2]) />
			<#assign linkIsPrivate = true />
			<#if linkData[1] == "public">
				<#assign linkIsPrivate = false />
			</#if>

			<#assign linkLayout = layoutLocalService.getLayout(linkGroupId, linkIsPrivate, linkLayoutId) >
			<#assign linkUrl =  linkLayout.getFriendlyURL() >

			<#if linkText = "">
				<#assign linkText =  linkLayout.getName(locale) >
			</#if>
		</#if>

		<li>
			<a href="${linkUrl}" target="${linkTarget}">
				${linkText}
			</a>
		</li>

	</#list>

	<#if isSignedIn>

		<#-- Signout -->
		<#if linkSignout.data != "" >
			<li>
				<a href="/c/portal/logout">${linkSignout.data}</a>
			</li>
		</#if>

		<#-- Profile Link -->
		<#assign profileLinkText = linkProfile.data />
		<#assign profileLinkHelpText = linkProfile.linkProfileHelp.data />

		<#assign profileLinkData = linkProfile.linkProfileLayout.data?split("@") />

		<#assign profileLinkLayoutId =  getterUtil.getLong(profileLinkData[0]) />
		<#assign profileLinkGroupId = getterUtil.getLong(profileLinkData[2]) />
		<#assign profileLinkIsPrivate = true />
		<#if profileLinkData[1] == "public">
			<#assign profileLinkIsPrivate = false />
		</#if>

		<#assign profileLinkLayout = layoutLocalService.getLayout(profileLinkGroupId, profileLinkIsPrivate, profileLinkLayoutId) >
		<#assign profileLinkUrl =  profileLinkLayout.getFriendlyURL() >

		<#if profileLinkText = "">
			<#assign profileLinkText =  profileLinkLayout.getName(locale) >
		</#if>

		<li class="profile-link">
			<a href="${profileLinkUrl}">
				<span>${profileLinkText}</span>
			</a>

			<#if profileLinkHelpText != "">
				<span class="profile-help">${profileLinkHelpText}</span>
			</#if>
		</li>

	<#else>
		<#-- Signin -->

	<#if linkSignin.data != "" >
		<li>
			<a href="/c/portal/logout">${linkSignin.data}</a>
		</li>
	</#if>


	</#if>

</ul>
