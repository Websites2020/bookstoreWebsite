<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Management</title>
    <link href="../../includes/bootstrap/css/bootstrap.css" rel="stylesheet" />

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    <script src="../includes/ckeditor/ckeditor.js" type="text/javascript"></script>

    <link href="../includes/css/mycss.css" rel="stylesheet"/>

</head>


<!-- default value of introPage is selected if value of p is missing -->
<cfparam name="tool" default="addedit">

<body>
<div class="container">
<div id="topHeader" class="row">
    <cfinclude template="../header.cfm">
</div>

<cfinclude template="managementnavbar.cfm">
<cfinclude template="#tool#.cfm">

<div id="footer" class="row">
    <cfinclude template="../footer.cfm">
</div>

</div>

</body>
</html>
