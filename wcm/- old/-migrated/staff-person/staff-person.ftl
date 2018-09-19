<div class="staff-person">
	<h2>${firstName.data} ${lastName.data}</h2>

	<#if image.data?has_content>
		<img src="${image.data}" alt="Bild" />
	</#if>

	<#if jobTitle.data?has_content>
		<div>
			${jobTitle.data}
		</div>
	</#if>

	<#if email.data?has_content>
		<div>
			${email.data}
		</div>
	</#if>

	<#if phone.data?has_content>
		<div>
			${phone.data}
		</div>
	</#if>

	<#if link.data?has_content>
		<#if link.linkLabel.data?has_content>
			<div>
				<a href="${link.data}">${link.linkLabel.data}</a>
			</div>
		</#if>
	</#if>


</div>
