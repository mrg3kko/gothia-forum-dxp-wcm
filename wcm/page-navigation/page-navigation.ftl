<#-- Define services -->
<#assign groupLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.GroupLocalService") >
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService") >

<#assign themeDisplay = requestMap["theme-display"] >

<#-- Get scope data -->
<#assign scopePlid =  getterUtil.getLong(requestMap["theme-display"]["plid"]) >
<#assign scopeLayout =  layoutLocalService.getLayout(scopePlid) >
<#assign scopeLayoutPrivate = scopeLayout.isPrivateLayout() />
<#assign scopeGroupId = scopeLayout.getGroupId() />
<#assign scopeGroup =  groupLocalService.getGroup(scopeGroupId) >

<#-- Find root layout --->
<#assign branchLayouts = [scopeLayout] + scopeLayout.getAncestors() />
<#assign branchLayouts = branchLayouts?reverse />
<#assign startIndex = getterUtil.getInteger(startLevel.data) />
<#assign rootIndex = startIndex -1 />
<#if rootIndex lt 0>
  <#assign rootIndex = 0 />
</#if>
<#assign rootLayout = branchLayouts[rootIndex] />

<#-- Get URL prefix -->
<#-- TODO: fix this when there is a virtual host -->
<#assign urlPrefix = "/web" + scopeGroup.getFriendlyURL() />
<#if scopeLayoutPrivate>
  <#assign urlPrefix = "/group" + scopeGroup.getFriendlyURL() />
</#if>

<div class="nav-menu">
  <h2>
    <a href="${urlPrefix + rootLayout.getFriendlyURL()}">${rootLayout.getName(locale)}</a>
  </h2>
  <@renderNavChildren baseLayout=rootLayout scopeLayout=scopeLayout listLevel=1 urlPrefix=urlPrefix />
</div>

<#macro renderNavChildren baseLayout scopeLayout listLevel urlPrefix>

  <#local childLayouts = layoutLocalService.getLayouts(baseLayout.getGroupId(), baseLayout.isPrivateLayout(), baseLayout.getLayoutId()) />
  <#local listCss = "layouts level" + listLevel />

  <ul class="${listCss}">
    <#list childLayouts as childLayout>
      <#local listItemCss = "" />
      <#local isScopeLayout = (childLayout.getPlid() == scopeLayout.getPlid()) />
      <#local isScopeLayoutAncestor = false />

      <#local scopeLayoutAncestors = scopeLayout.getAncestors() />
      <#list scopeLayoutAncestors as scopeLayoutAncestor>
        <#if scopeLayoutAncestor.getPlid() == childLayout.getPlid()>
          <#local isScopeLayoutAncestor = true />
          <#break>
        </#if>
      </#list>

      <#if isScopeLayout>
        <#local listItemCss = "selected" />
      <#elseif isScopeLayoutAncestor>
        <#local listItemCss = "open" />
      </#if>

      <li class="${listItemCss}">
        <a href="${urlPrefix + childLayout.getFriendlyURL()}">${childLayout.getName(locale)}</a>

        <#if isScopeLayout || isScopeLayoutAncestor>
          <@renderNavChildren baseLayout=childLayout scopeLayout=scopeLayout listLevel=(listLevel+1) urlPrefix=urlPrefix />
        </#if>
      </li>
    </#list>
  </ul>


</#macro>
