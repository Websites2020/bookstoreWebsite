<script>
    function toggleNewISBNForm(){
        var newISBNArea=document.getElementById('newisbn13area');
        if(newISBNArea.style.display==='none'){
            newISBNArea.style.display='inline';
        } else{
            newISBNArea.style.display='none';
        }
    }
</script>

<cfparam name="qterm" default=''>
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
    <cfquery name="thisbook" datasource="#application.dsource#">
        select * from books where isbn13='#book#'
    </cfquery>

    <cfquery name="allpubs" datasource="#application.dsource#">
        select * from publishers order by name
    </cfquery>

    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#&book=#book#" method="post" class="form-horizontal" enctype="multipart/form-data">
        <div class="form-group">
            <label for="isbn13" class="col-lg-3 control-label">ISBN13:</label>
            <div class="col-lg-9">
                <!--- isbnfield - this is the input --->
                <!--- isbndisplay is the isbn13 span that displays only --->

                    <cfset isbnfield="none">
                    <cfset isbndisplay="inline">
                    <cfset req=''>
                    <cfif trim(thisbook.isbn13[1]) eq ''>
                        <cfset isbnfield="inline">
                        <cfset isbndisplay="none">
                        <cfset req="required">
                    </cfif>
                <span id="newisbn13area" id="newisbn13area" style="display:#isbnfield#">
                    <input id="newisbn13" class="form-control" type="text" name="newisbn13" value="#thisbook.isbn13[1]#" placeholder="Put the ISBN13 code here" pattern=".{13}" title="Please Enter 13 characters only please. No dashes necessary" #req# >
                </span>
                <span style="display:#isbndisplay#" >
                    #thisbook.isbn13[1]#
                    <input type="hidden" class="form-control" id="isbn13" name="isbn13" placeholder="ISBN13" value="#thisbook.isbn13[1]#" />
                    <button type="button" onclick="toggleNewISBNForm()" class="btn btn-warning btn-xs">Edit ISBN</button>
                </span>
            </div>
        </div>
        <div class="form-group">
            <label for="booktitle" class="col-lg-3 control-label">Book Title:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="booktitle" name="booktitle" value="#thisbook.title[1]#" placeholder="Book Title" required maxlength="45"/>
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
            <label for="image" class="col-lg-3 control-label">Image:</label>
            <div class="col-lg-9">
                <cfif thisbook.image[1] neq ''>
                <img src="/dbutt26414/myWebsite10-21-18/images/#trim(thisbook.image[1])#" width="150px"/>
                </cfif>
                <input type="file" name="uploadimage">
                <input type="hidden" name="image" value="#trim(thisbook.image[1])#">
            </div>
        </div>

        <div class="form-group">
            <label for="publisher" class="col-lg-3 control-label">Publisher</label>
        <div class="col-lg-9">
            <select id="publisher" name="publisher" class="form-control">
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

        <div class="form-group">
            <label for="bookdesc" class="col-lg-3 control-label">Description</label>
            <div class="col-lg-9">
                <textarea id="bookdesc" name="description">#trim(thisbook.description[1])#</textarea>
                <script>
                    CKEDITOR.replace('bookdesc');
                </script>
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-3"></div>
            <div class="col-lg-9">
                <button type="submit" class="btn btn-primary">&nbsp;</button>
            </div>
        </div>
    </form>
    </cfoutput>
    <!---
<cfelse>
    <cfif isdefined('form.uploadimage') and trim(form.uploadimage) neq '' >
        <cffile action="upload" filefield="uploadimage" destination="#expandpath('/')#sdemo1/myWebsite10-21-18/images/" nameconflict="makeunique">
        <cfset form.image='#cffile.serverfile#' />
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
            <div class="col-lg-9">
            <input type="hidden" name="qterm" value="#qterm#" />
            </div>
        </div>
        <div class="form-group">
            <label for="isbn13" class="col-lg-3 control-label">ISBN13:</label>
            <div class="col-lg-9">
                    <cfset isbnfield="none">
                    <cfset isbndisplay="inline">
                    <cfset req=''>
                    <cfif trim(thisbook.isbn13[1]) eq ''>
                        <cfset isbnfield="inline">
                        <cfset isbndisplay="none">
                        <cfset req="required">
                    </cfif>
                <span id="newisbn13area" style="display:#isbnfield#">
                    <input id="newisbn13" class="form-control" type="text" name="newisbn13" value="#thisbook.isbn13[1]#" placeholder="Put the ISBN13 code here" pattern=".{13}" title="Please Enter 13 characters only please. No dashes necessary" #req#>
                </span>
                <span style="display:#isbndisplay#">
                    #thisbook.isbn13[1]#
                    <input type="hidden" class="form-control" id="isbn13" name="isbn13" placeholder="ISBN13" value="#thisbook.isbn13[1]#" />
                <button type="button" onclick="togglenewisbnform()" class="btn btn-warning btn- xs">Edit ISBN</button>
                </span>
            </div>
        </div>
        <div class="form-group">
            <label for="booktitle" class="col-lg-3 control-label">Book Title:</label>
            <div class="col-lg-9">
                <input type="text" class="form-control" id="booktitle" name="booktitle" value="#thisbook.title[1]#" placeholder="Book Title" required maxlength="45" />
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
            <label for="image" class="col-lg-3 control-label">Image:</label>
            <div class="col-lg-9">
                <cfif thisbook.image[1] neq ''>
                    <img src="/sdemo1/myWebsite10-21-18/images/#trim(thisbook.image[1])#" width="150px" />
                </cfif>
                <input type="file" name="uploadimage">
                <input type="hidden" name="image" value="#trim(thisbook.image[1])#">
            </div>
        </div>

        <div class="form-group">
            <label for="publisher" class="col-lg-3 control-label">Publisher</label>
        <div class="col-lg-9">
            <select id="publisher" name="publisher" class="form-control">
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

            <div>
                <label for=" bookdesc">Description</label>

            <textarea id="bookdesc" name="description">#trim(bookinfo.description[1])#</textarea>
        <script> CKEDITOR.replace('bookdesc');
        </script> </div>

        <div class="col-lg-3"></div>
        <div class="col-lg-9">
            <button type="submit" class="btn btn-primary">&nbsp;</button>
        </div>
    </form>
    </cfoutput>
</cfif>--->
</cfif>
</cffunction>

<cffunction name="sidenav">
    <cfoutput>
        <form action="#cgi.SCRIPT_NAME#?tool=addedit" method="post" class="form-inline">
    <div class="form-group">
            <input type="text" class="form-control" id="qterm" name="qterm" value="#qterm#">
        <button type="submit" class="btn btn-xs btn-primary">Search</button> </div>
    </form>
    </cfoutput>
    <cfif qterm neq ''>
    <cfquery name="allbooks" datasource="#application.dsource#">
        select * from books where title like '%#qterm#%' order by title
    </cfquery>
    </cfif>
    <div>
        Book List
    </div>
    <cfoutput>
    <ul class="nav flex-column">
        <li><a href="#cgi.script_name#?tool=addedit&book=new">Add a Book</a></li>
        <cfif isdefined('allbooks')>
        <cfloop query="allbooks">
            <li><a href="#cgi.SCRIPT_NAME#?tool=addedit&book=#isbn13#&qterm=#qterm#">#trim(title)#</a></li>
        </cfloop>
        <cfelse>
                No Search Term Entered (Try "test")
        </cfif>
    </ul>
    </cfoutput>
</cffunction>

<cffunction name="processForms">
    <cfdump var="#form#"/>
    <cfif isdefined('form.newisbn13')>
        <cfquery datasource='#application.dsource#'>
            update books set isbn13='#form.newisbn13#' where isbn13='#form.isbn13#' </cfquery>
        <cfset form.isbn13=form.newisbn13>
    </cfif>




    <cfif isdefined("form.isbn13")>
        <cfif isdefined('form.uploadimage') and trim(form.uploadimage) neq '' >
            <cffile action="upload" filefield="uploadimage" destination="#expandpath('/')#dbutt26414/myWebsite10-21-18/images/" nameconflict="makeunique">
            <cfset form.image='#cffile.clientfile#'>
            <cfdump var="#cffile#" label="CFFILE">
        </cfif>
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
            publisher='#form.publisher#',
            description='#form.description#'
            where isbn13='#form.isbn13#'
        </cfquery>
    </cfif>
</cffunction>