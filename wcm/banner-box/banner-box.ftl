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

    <#if image.videoId.data == "">
      <#-- Documents and Media -->
      <a href="${image.link.data}" class="${link_class} banner-box-item" target="${image_target}">
        <img src="${image.getData()}" alt="${image.alt.data}" />
      </a>


    <#else>
      <#--Youtube movie -->
      <div class="banner-box-item movie-box">
    			<div class="movie-ctn" data-videoId="${image.videoId.data}">
                    <a href="#">
						<img src="${image.data}" alt="${image.alt.data}" />
					</a>
    			</div>
			</div>
    </#if>

  </#list>
</div>
