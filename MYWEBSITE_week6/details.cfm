<cfoutput>
<cfquery name="bookinfo" datasource="#application.dsource#">
    select * from books
    inner join publishers on books.publisher=publishers.id
    where title like '%#trim(form.searchme)#%' or isbn13 like '%#trim(searchme)#%'
</cfquery>
<cfif bookinfo.recordcount eq 0>
        #noResults()#
    <cfelseif bookinfo.recordcount eq 1>
        #oneResult()#
    <cfelse>
        #manyResults()#
</cfif>
</cfoutput>

    <cffunction name = "noResults">
        <cfset var noResults = "There were no results to be found." />

        <cfreturn noResults />
    </cffunction>

    <cffunction name = "oneResult">
        <cfoutput>
            <img src="images/#bookinfo.IMAGE[1]#" style="float:left; width:250px; height:250px"/>
        <span>Title: #bookinfo.title[1]#</span>
        <span>Publisher: #bookinfo.name[1]#</span> </cfoutput>
    </cffunction>

    <cffunction name = "manyResults">

        there were many results, show a list

        <ol class="nav nav-stacked"> <cfoutput query="bookinfo">
            <li><a href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a></li>
        </cfoutput>
        </ol>

    </cffunction>

