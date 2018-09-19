<#if faqEntries.siblings?has_content>
	<dl class="faq">
		<#list faqEntries.siblings as faqEntry>
			<dt>${faqEntry.data}</dt>
			<dd>${faqEntry.answer.data}</dd>
		</#list>
	</dl>
</#if>
