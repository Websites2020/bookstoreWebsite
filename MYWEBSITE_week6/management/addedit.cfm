<cfparam name="book" default="">

<cftry>
<cfset processForms()>
<div class="col-lg-9 col-lg-push-3">
    <cfoutput>#mainform()#</cfoutput>
</div>
<div class="col-lg-3 col-lg-pull-9">
    <cfoutput>#sidenav()#</cfoutput>
</div>
    <cfcatch type="any">
        <cfoutput> #cfcatch.Message#
        </cfoutput> </cfcatch>
</cftry>

<cffunction name="mainform">
<cfif book neq ''>
<cfif isdefined('url.book')>
    <cfif isdefined('form.uploadimage') and trim(form.uploadimage) neq '' >
        <cffile action="upload" filefield="uploadimage" destination="#expandpath('/')#sdemo1/MYWEBSITE/images/" nameconflict="makeunique"> <cfset form.image='#cffile.serverfile#'>
        <cfdump var="#cffile#" label="CFFILE">
    </cfif>
    <cfquery name="thisbook" datasource="#application.dsource#">
        select * from books where isbn13='#book#'
    </cfquery>
    <cfquery name="allpubs" datasource="#application.dsource#">
        select * from publishers order by name
    </cfquery>
    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#&book=#url.book#" method="post" class="form-horizontal" enctype="multipart/form-data">
        <div class="form-group">
            <label for="isbn13" class="col-lg-3 control-label">ISBN13:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="isbn13" name="isbn13" value="#thisbook.isbn13[1]#" placeholder="ISBN13" />
            </div>
        </div>
        <div class="form-group">
            <label for="booktitle" class="col-lg-3 control-label">Book Title:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="booktitle" name="booktitle" value="#thisbook.title[1]#" placeholder="Book Title" />
            </div>
        </div>
        <div class="form-group">
            <label for="year" class="col-lg-3 control-label">Year:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="year" name="year" value="#thisbook.year[1]#" placeholder="Year" />
            </div>
        </div>
        <div class="form-group">
            <label for="weight" class="col-lg-3 control-label">Weight:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="weight" name="weight" value="#thisbook.weight[1]#" placeholder="Weight" />
            </div>
        </div>
        <div class="form-group">
            <label for="isbn" class="col-lg-3 control-label">ISBN:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="isbn" name="isbn" value="#thisbook.isbn[1]#" placeholder="ISBN" />
            </div>
        </div>
        <div class="form-group">
            <label for="pages" class="col-lg-3 control-label">Pages:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="pages" name="pages" value="#thisbook.pages[1]#" placeholder="Pages" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-lg-3"></div>
            <div class="col-lg-9">
                <cfif thisbook.image[1] neq ''>
                <img src="/sdemo1/MYWEBSITE/images/#trim(thisbook.image[1])#" />
                </cfif>
                <input type="file" name="uploadimage">
                <input type="hidden" name="image" value="#trim(thisbook.image[1])#">
            </div>
        </div>

        <div class="form-group">
            <label for="publisher" class="col-lg-3 control-label">Publisher</label>
        <div class="col-lg-9">
            <select id="publisher" name="publisher">
                <option value=""></option>
            <cfloop query="allpubs">
                <cfset sel=''>
                <cfif trim(allpubs.id) eq trim(thisbook.publisher[1])>
                    <cfset sel='selected="selected"'>
                </cfif>
                    <option value="#trim(ID)#" #sel#> #trim(name)# </option>
            </cfloop>
            </select>
        </div>
        </div>
        <div class="col-lg-3"></div>
        <div class="col-lg-9">
            <button type="submit" class="btn btn-primary">&nbsp;</button>
        </div>
    </form>
    </cfoutput>
<cfelse>
    <cfif isdefined('form.uploadimage') and trim(form.uploadimage) neq '' >
        <cffile action="upload" filefield="uploadimage" destination="#expandpath('/')#sdemo1/MYWEBSITE/images/" nameconflict="makeunique"> <cfset form.image='#cffile.serverfile#'>
        <cfdump var="#cffile#" label="CFFILE">
    </cfif>
    <cfquery name="thisbook" datasource="#application.dsource#">
        select * from books where isbn13='#book#'
    </cfquery>
    <cfquery name="allpubs" datasource="#application.dsource#">
        select * from publishers order by name
    </cfquery>
    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#&book=#url.book#" method="post" class="form-horizontal" enctype="multipart/form-data">
        <div class="form-group">
            <label for="isbn13" class="col-lg-3 control-label">ISBN13:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="isbn13" name="isbn13" value="#thisbook.isbn13[1]#" placeholder="ISBN13" />
            </div>
        </div>
        <div class="form-group">
            <label for="booktitle" class="col-lg-3 control-label">Book Title:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="booktitle" name="booktitle" value="#thisbook.title[1]#" placeholder="Book Title" />
            </div>
        </div>
        <div class="form-group">
            <label for="year" class="col-lg-3 control-label">Year:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="year" name="year" value="#thisbook.year[1]#" placeholder="Year" />
            </div>
        </div>
        <div class="form-group">
            <label for="weight" class="col-lg-3 control-label">Weight:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="weight" name="weight" value="#thisbook.weight[1]#" placeholder="Weight" />
            </div>
        </div>
        <div class="form-group">
            <label for="isbn" class="col-lg-3 control-label">ISBN:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="isbn" name="isbn" value="#thisbook.isbn[1]#" placeholder="ISBN" />
            </div>
        </div>
        <div class="form-group">
            <label for="pages" class="col-lg-3 control-label">Pages:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="pages" name="pages" value="#thisbook.pages[1]#" placeholder="Pages" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-lg-3"></div>
            <div class="col-lg-9">
                <cfif thisbook.image[1] neq ''>
                    <img src="/sdemo1/MYWEBSITE/images/#trim(thisbook.image[1])#" />
                </cfif>
                <input type="file" name="uploadimage">
                <input type="hidden" name="image" value="#trim(thisbook.image[1])#">
            </div>
        </div>

        <div class="form-group">
            <label for="publisher" class="col-lg-3 control-label">Publisher</label>
        <div class="col-lg-9">
            <select id="publisher" name="publisher">
                <option value=""></option>
        <cfloop query="allpubs">
        <cfset sel=''>
        <cfif trim(allpubs.id) eq trim(thisbook.publisher[1])>
            <cfset sel='selected="selected"'>
        </cfif>
                <option value="#trim(ID)#" #sel#> #trim(name)# </option>
        </cfloop>
            </select>
        </div>
        </div>
        <div class="col-lg-3"></div>
        <div class="col-lg-9">
            <button type="submit" class="btn btn-primary">&nbsp;</button>
        </div>
    </form>
    </cfoutput>
</cfif>
</cfif>
</cffunction>

<cffunction name="sidenav">
    <cfquery name="allbooks" datasource="#application.dsource#">
        select * from books order by title
    </cfquery>
    <div>
        Book List
    </div>
    <cfoutput>
    <ul class="nav flex-column">
        <li><a href="#cgi.script_name#?tool=addedit&book=new">Add a Book</a></li>
        <cfloop query="allbooks">
            <li><a href="#cgi.script_name#?tool=addedit&book=#isbn13#">#trim(title)#</a></li>
        </cfloop>
    </ul>
    </cfoutput>
</cffunction>

<cffunction name="processForms">
    <cfif isdefined("form.isbn13")>
        <cfdump var="#form#" />
        <cfquery name="adddata" datasource="#application.dsource#">
            If not exists(select * from books where isbn13='#form.isbn13#')
            INSERT into books (isbn13,title) VALUES ('#form.isbn13#','#form.booktitle#')
            update books set
            title='#form.booktitle#',
            weight='#form.weight#',
            year='#form.year#',
            isbn='#form.isbn#',
            pages='#form.pages#',
            image='#form.image#',
            publisher='#form.publisher#'
            where isbn13='#form.isbn13#'
        </cfquery>
    </cfif>
</cffunction>