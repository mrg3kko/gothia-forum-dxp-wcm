<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>
<#assign dlFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService")>

<div class="banner-box-wrap">
  <div class="banner-box">

    <#list images.siblings as image>
      <#assign link_class = "banner-box-link" />

      <#if image?index != 0>
        <#assign link_class = "banner-box-link hide" />
      </#if>

      <#assign image_target = "" />
      <#if image.targetBlank.data == "true">
        <#assign image_target = "_BLANK" />
      </#if>

      <#assign imageUrl = getArticleDLEntryUrl(image.data) />

      <#if image.videoId.data == "">
        <#-- Documents and Media -->
        <a href="${image.link.data}" class="${link_class} banner-box-item" target="${image_target}">
          <img src="${imageUrl}" alt="" />
        </a>


      <#else>
        <#--Youtube movie -->
        <div class="banner-box-item movie-box">
      			<div class="movie-ctn" data-videoId="${image.videoId.data}">
              <a href="#">
				        <img src="${imageUrl}" alt="" />
		           </a>
      			</div>
  			</div>
      </#if>

    </#list>
  </div>
  <div class="banner-box-extra">
    ${content.data}
  </div>
</div>

<#--
Function that returns the download url for a DLFileEntry in an article
Params: xmlValue = the xml-value of the DLFileEntry node in the article XML.
If structure field for the DLFileEntry is called image, the xmlValue can be retrieved by
<#assign xmlValue = docXml.valueOf("//dynamic-element[@name='image']/dynamic-content/text()") />
Returns: the download-url of the DLFileEntry

Requires the following services located in ADT:
<#assign assetEntryLocalService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetEntryLocalService")>
<#assign dlFileEntryLocalService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLFileEntryLocalService")>
-->
<#function getArticleDLEntryUrl xmlValue>
  <#local docUrl = "" />

  <#if xmlValue?has_content>
    <#local jsonObject = xmlValue?eval />

    <#local entryUuid = jsonObject.uuid />
    <#local entryGroupId = getterUtil.getLong(jsonObject.groupId) />

    <#local dlFileEntry = dlFileEntryLocalService.getDLFileEntryByUuidAndGroupId(entryUuid, entryGroupId) />

    <#local assetEntry = assetEntryLocalService.getEntry("com.liferay.document.library.kernel.model.DLFileEntry", dlFileEntry.fileEntryId) />
    <#local assetRenderer = assetEntry.assetRenderer />

    <#local docUrl = assetRenderer.getURLDownload(themeDisplay) />
  </#if>
  <#return docUrl />
</#function>
