<#setting locale=locale>

<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService")>
<#assign assetVocabularyLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetVocabularyLocalService")>

<#assign staffVocabularyName = "Enhet" />
<#assign categoryCssPrefix = "category" />

<#assign page = themeDisplay.getLayout() />
<#assign group_id = page.getGroupId() />
<#assign company_id = themeDisplay.getCompanyId() />

<#assign uniqueStaffCategoryIds = [] />
<#assign uniqueStaffCategories = [] />

<#attempt>
  <#assign staffVocabulary = assetVocabularyLocalService.getGroupVocabulary(group_id, staffVocabularyName)! />
<#recover>
</#attempt>

<#if staffVocabulary?has_content>
  <#list entries as entry>
    <#list entry.getCategories() as category >
      <#if category.getVocabularyId() == staffVocabulary.getVocabularyId()>
        <#assign categoryId = category.getCategoryId() />
        <#if (uniqueStaffCategoryIds?seq_contains(categoryId)) == false >
          <#assign uniqueStaffCategoryIds = uniqueStaffCategoryIds + [ categoryId ] />
          <#assign uniqueStaffCategories = uniqueStaffCategories + [ category ] />
        </#if>
      </#if>
    </#list>
  </#list>
</#if>

<#if uniqueStaffCategories?has_content>
  <#if uniqueStaffCategories?size gt 1>
    <div class="select-filter js-select-filter" data-filterctn="${renderResponse.getNamespace()}staffContainer" data-filteritemselector="person">
      <label for="${renderResponse.getNamespace()}selecteCategory">
        ${languageUtil.get(locale, "show")}:
      </label>
      <select id="${renderResponse.getNamespace()}selecteCategory" name="${renderResponse.getNamespace()}selecteCategory">
        <option value="0">${languageUtil.get(locale, "all")}</option>
        <#list uniqueStaffCategories as category>
          <#assign categoryName = category.getTitle(locale) />
          <#assign categoryClassName = cssClassNameFromString(categoryName, categoryCssPrefix) />
          <option value="${categoryClassName}">${categoryName}</option>
          </li>
        </#list>
      <select>
    </div>
  </#if>
</#if>

<#-- For testing -->
<#--
<#assign entries = entries + entries + entries + entries />
-->

<div class="staff" id="${renderResponse.getNamespace()}staffContainer">

  <#if entries?has_content>
      <#list entries as entry>

        <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContentByLocale(locale)) />

        <#assign firstName = docXml.valueOf("//dynamic-element[@name='firstName']/dynamic-content/text()") />
        <#assign lastName = docXml.valueOf("//dynamic-element[@name='lastName']/dynamic-content/text()") />
        <#assign jobTitle = docXml.valueOf("//dynamic-element[@name='jobTitle']/dynamic-content/text()") />
        <#assign email = docXml.valueOf("//dynamic-element[@name='email']/dynamic-content/text()") />
        <#assign phone = docXml.valueOf("//dynamic-element[@name='phone']/dynamic-content/text()") />
        <#assign linkUrl = docXml.valueOf("//dynamic-element[@name='link']/dynamic-content/text()") />
        <#assign linkLabel = docXml.valueOf("//dynamic-element[@name='link']/dynamic-element[@name='linkLabel']/dynamic-content/text()") />

        <#assign imageUrl = docXml.valueOf("//dynamic-element[@name='image']/dynamic-content/text()") />


        <#if !(imageUrl?has_content)>
          <#assign imageUrl = themeDisplay.getPathThemeImages() + "/theme/staff/no-img.png" />
        </#if>

        <#assign categoryClassNames = "" />
        <#list entry.getCategories() as category >
          <#assign categoryClassName = cssClassNameFromString(category.getTitle(locale), categoryCssPrefix) />
          <#assign categoryClassNames = categoryClassNames + " " + categoryClassName />
        </#list>


        <div class="person ${categoryClassNames}">
          <div class="person-inner">

            <img src="${imageUrl}" alt="${firstName} ${lastName}" />

            <div class="person-info">

              <h2>${firstName} ${lastName}</h2>

              <#if jobTitle?has_content>
                <div>${jobTitle}</div>
              </#if>
              <#if email?has_content>
              <div>
                <a href="mailto:${email}">
                  ${email}
                </a>
              </div>
              </#if>
              <#if phone?has_content>
                <div>${phone}</div>
              </#if>

              <#if linkUrl?has_content && linkLabel?has_content>
                <a href="${linkUrl}">${linkLabel}</a>
              </#if>

            </div>

          </div>
        </div>


      </#list>
  </#if>

</div>

<#function cssClassNameFromString myString prefix>
  <#local myStringReplaced = prefix + "-" + myString?lower_case?replace(" ", "-")?replace("[^a-z-]", "", "r") />
  <#return myStringReplaced />
</#function>
