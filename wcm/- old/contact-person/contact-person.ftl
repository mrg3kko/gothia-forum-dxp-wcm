<div class="info-box">
	<#if heading.data?has_content>
		<h3>
			${heading.data}
		</h3>
	</#if>
	
	<div class="info-block">
		<#if contactPerson.data?has_content>
			<div class="info-item info-name">
				${contactPerson.data}
			</div>
		</#if>
		<#if contactPerson.title.data?has_content>
			<div class="info-item info-title">
				${contactPerson.title.data}
			</div>
		</#if>
	</div>
	
	<#if contactPerson.phone.data?has_content>
		<div class="info-block">
			<div class="info-item info-label">
				${languageUtil.get(locale, "phone")}
			</div>
			<div class="info-item">
				${contactPerson.phone.data}
			</div>
		</div>
	</#if>

	<#if contactPerson.email.data?has_content>
		<div class="info-block">
			<div class="info-item info-label">
				${languageUtil.get(locale, "email")}
			</div>
			<div class="info-item">
				<a href="mailto:${contactPerson.email.data}">
					${contactPerson.email.data}
				</a>
			</div>
		</div>
	</#if>

	<#if contactPerson.image.data?has_content>
		<div class="info-block">
			<div class="info-image-wrap">
				<img src="${contactPerson.image.data}" alt="${contactPerson.data}" />
			</div>
		</div>
	</#if>
	
</div>