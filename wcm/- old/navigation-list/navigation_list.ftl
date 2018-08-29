<#-- Define some services -->
<#assign groupLocalService = serviceLocator.findService("com.liferay.portal.service.GroupLocalService") >
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutLocalService") >
<#assign layoutSetLocalService = serviceLocator.findService("com.liferay.portal.service.LayoutSetLocalService") >

<#-- Define some variables -->

<#assign themeDisplay = request["theme-display"] >
<#assign scopePlid =  getterUtil.getLong(request["theme-display"]["plid"]) >
<#assign scopeLayout =  layoutLocalService.getLayout(scopePlid) >
<#assign groupIdLong =  getterUtil.getLong(groupId) >
<#assign scopeGroup =  groupLocalService.getGroup(groupIdLong) >

<#assign isBaseGroup = scopeGroup.isRoot() />
<#assign baseGroupid = groupIdLong />
<#assign baseGroup = scopeGroup />

<#if !isBaseGroup>
	<#assign baseGroup = scopeGroup.getParentGroup() />
	<#assign baseGroupid = baseGroup.getGroupId() />
</#if>

<ul class="navigation-list">
	<#list links.getSiblings() as link>

		<#assign linkUrl = link.externalUrl.data />
		<#assign linkText = link.linkText.data />
		<#assign linkTarget = link.linkTarget.data />

		<#assign showWhen = link.showWhen.data />

		<#assign cssClass = link.cssClass.data />

		<#if linkUrl = "">

			<#assign linkData = link.data?split("@") />
			<#assign linkPlid = linkData[2] />

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

		<#--
		${permissionChecker.isSignedIn()
		-->

		<#assign showItem = true />
		<#if showWhen = "signed-out" && permissionChecker.isSignedIn()>
			<#assign showItem = false />
		<#elseif showWhen = "signed-in" && !permissionChecker.isSignedIn()>
			<#assign showItem = false />
		</#if>

		<#if showItem>
			<li class="${cssClass}">
				<a href="${linkUrl}" target="${linkTarget}">
					${linkText}
				</a>
			</li>
		</#if>

	</#list>
</ul>
