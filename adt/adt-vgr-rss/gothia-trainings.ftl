<#if entries?has_content>

  <div class="cal-wrap">
    <ul class="cal-list">

      <#list entries as entry>

        <li class="clearfix">
          <span class="cal-entry-date">
            <span class="cal-entry-date-month">
              ${entry.startDate?string["MMM"]}
            </span>
            <span class="cal-entry-date-day">
              ${entry.startDate?string["dd"]}
            </span>
          </span>
          <span class="cal-entry-content">
            <span class="cal-entry-heading">
              <a class="cal-link" href="${entry.link}" target="_BLANK">${entry.title}</a>
            </span>
          </span>
        </li>

      </#list>

    </ul>
  </div>

  <@liferay_util["body-bottom"]>
    <style type="text/css">
      /* Align with articles which has no padding on portlet-body */
      #p_p_id${renderResponse.getNamespace()} .portlet-body {
        padding-left: 0;
        padding-right: 0;
      }
    </style>
  </@>

</#if>
