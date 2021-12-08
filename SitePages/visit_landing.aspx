<!DOCTYPE html >
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<html>

<head runat="server">
<title>Visit Request System</title>
	<meta http-equiv="X-UA-Compatible" content="IE=10" />
	<link rel="stylesheet" href="../SiteAssets/bootstrap.min.css"  type="text/css">
    <link rel="stylesheet" href="../SiteAssets/tabs_boostrap.css"   type="text/css">
    <link rel="stylesheet" href="../SiteAssets/jquery-ui.css">
    <script src="../SiteAssets/jquery-3.3.1.slim.min.js"  type="text/javascript"></script>
    <script src="../SiteAssets/popper.min.js" type="text/javascript" ></script>    
    <script src="../SiteAssets/jquery.min.js" type="text/javascript"></script>
    <script src="../SiteAssets/bootstrap.min.js" type="text/javascript"></script>
    <script src="../SiteAssets/jquery-ui.js" type="text/javascript"></script>
    <script src="../SiteAssets/jquery.SPServices-2014.02.js" type="text/javascript"></script>    
    <script src="../SiteAssets/visitRequest.js" type="text/javascript"></script> 
</head>
<body>
 <form id="form1" runat="server">        
    <SharePoint:FormDigest runat="server"/>
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h1 class="h1 text-center">SOCEUR Visit Request Tracking</h1>
            </div>
            <div class="card-body">
                <div class="row">
                        <div class="col-2">
                            <h3 class="h3">Security</h3>
                            <nav class="navbar navbar-expand navbar-light flex-md-column flex-row align-items-start py-2">
                                <ul id="myQuickLinks" class="flex-md-column flex-row navbar-nav justify-content-between">                                    
                                </ul>
                            </nav>
                            <input id="newVisitRequest" type="button" class="btn btn-primary btn-md btn-block" value="New Request" >
                            <input id="myEmailList" type="button" class="btn btn-info btn-sm btn-block" value="Modify Email Lists" data-toggle="modal" data-target="#myList">
                        </div>
                        <div class="col-10">
                            <div class="row">
                                <div class="col-7">
                                        <ul class="nav nav-tabs">
                                            <li class="active"><a onclick="changeTab('DIRECTORATE')"  class="h6" data-toggle="tab" href="#DIRECTORATE">Directorate/Collateral Requests</a></li>
                                            <li><a onclick="changeTab('SSO')"  class="h6"  data-toggle="tab" href="#SSO">SSO/SCI  Requests</a></li>
                                            <li><a onclick="changeTab('APPROVED')"  class="h6" data-toggle="tab" href="#APPROVED">Approved Requests</a></li>
                                            <!--<li><a onclick="changeTab('ARCHIVED')" class="h6" data-toggle="tab" href="#ARCHIVED">Archived Requests</a></li>-->
                                        </ul> 
                                </div>
                                <div class="col-3">
                                    <input class="form-control shadow-sm" type="text" id="filterUser" onblur="filterVisitRequests()" placeholder="Filter by Requestor or Visitor">
                                </div>
                                <div class="col-2">
                                    <input class="form-control shadow-sm" type="text" id="filterDirectorate" onblur="filterVisitRequests()" placeholder="Filter by Directorate">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                        <div class="tab-content">
                                            <div id="DIRECTORATE" class="tab-pane fade in active"></div>
                                            <div id="SSO" class="tab-pane fade in active"></div>
                                            <div id="APPROVED" class="tab-pane fade in active"></div>
                                        </div>
                                </div>                               
                            </div>            
                            <div class="row">
                                <div class="col-12">
                                        <h3 class="h3" id="currentTab">DIRECTORATE</h3></div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                        <table class="table table-striped w-100" id="myRequests" >
                                                <thead>
                                                    <tr>
                                                        <th>Directorate</th>
                                                        <th>Visit Type</th>
                                                        <th>SMO Code</th>
                                                        <th>Visit Start Date</th>            
                                                        <th>Visit End Date</th>      
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                            </table>
                                </div>
                            </div>                             
                            </div>            
                        </div>
                </div>                
            </div>
            <div class="card-footer">
                <div class="row">
                    <div class="col-1"><span class="font-weight-bold">Support:</span></div>
                    <div class="col-7"><span id="Owner"></span></div>
                    <div class="col-1"></div>
                    <div class="col-3">

                    </div>
                </div>
            </div>
        </div>
  
    <div class="modal" id="myList">
            <div class="modal-dialog">
                <div class="modal-content">
                        <div class="modal-header">
                                <h3>Manage Email Distribution Lists:</h3>                                
                            </div> 
                            <div class="modal-body">
                                <span class="h3 font-weight-bold">Please note do not modify this list unless you are authorized:</span>
                                <h5>Please seperate each email with a <span style='background-color:yellow'>semicolon,</span> so that exchange can process the email</h5>
                                <select id="chooseGroup" class="form-control" onchange="changeListContent()">                                       
                                </select>                                
                                <table id="emailListTable" class="table table-striped w-100">
                                    <thead>
                                        <tr>
                                            <th>Code</th>
                                            <th style="width: 70%">Emails</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <span id="mySelGroup"></span>
                                            </td>
                                            <td>
                                                <textarea id="mySelEmails" rows="3" cols="10" class="form-control"></textarea>
                                            </td>
                                            <td>
                                                <input id="updateSelEmails" type="button" class="btn btn-xs btn-info" onclick="updateSelectedEmailList()" value="Update">
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="3">
                                                    <span id="groupEmail"></span>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>                
                            <!-- Modal footer -->
                            <div class="modal-footer">
                                    <div class="col-12">
                                            <input  type="button" class="btn btn-danger btn-block m-0 font-weight-bold" data-dismiss="modal" value="&#10008; Close Window">            
                                    </div>                                                                                        
                            </div>   
                </div>
            </div>
        </div>
    <script type="text/javascript">
        function changeTab(stat){
            const tab = document.getElementById("currentTab").innerText;
            if (tab !== stat) {
                // reset filters
                document.getElementById("filterUser").value = "";
                document.getElementById("filterDirectorate").value = "";
                
                $("#currentTab").text(stat);
                loadRequestsByStatus(stat);
            }
        }
        function changeListContent(){   $("#mySelEmails").val(lookupEmails( $("#chooseGroup option:selected").val()));      }
        function updateSelectedEmailList(){    
            updateEmails($("#mySelEmails").val());
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#currentTab").text("DIRECTORATE");
            //load current tab table myRequests 
            loadRequestsByStatus("DIRECTORATE");
            buildAMenu("myQuickLinks");
            $("#Owner").text( myCreator() +" " +myVersion());
            loadMyDirectorates("chooseGroup");
            $("#newVisitRequest").click(function(){document.location.href=form();   });
        });
    </script>
    <script type="text/javascript">
        function filterVisitRequests() {
            let directorate = document.getElementById("filterDirectorate").value;
            let name = document.getElementById("filterUser").value;
            const visitRequests = document.getElementById("myRequests");
            if (visitRequests) {
                const visitRequest =visitRequests.getElementsByTagName("tr");
                if (visitRequest && visitRequest.length) {
                    for (i = 0; i < visitRequest.length; i++) {
                        const requestInfo = visitRequest[i]
                            .getElementsByTagName("td");
                        if (requestInfo && requestInfo.length) {
                            let match = true;
                            // filter by directorate
                            if (directorate) {
                                match = false;
                                const requestDir = requestInfo[0]
                                    .innerHTML
                                    .toUpperCase();
                                if (requestDir &&
                                    requestDir.indexOf(
                                        directorate.toUpperCase()) > -1) {
                                    match = true;
                                }
                            }
                            // filter by requestor or visitors
                            if (match && name) {
                                match = false;
                                const lastCol = requestInfo.length - 1;
                                if (lastCol > 0) {
                                    const requestPocOrVisitors =
                                        requestInfo[lastCol]
                                        .innerHTML;
                                    if (requestPocOrVisitors &&
                                        requestPocOrVisitors.indexOf(
                                            name.toUpperCase()) > -1) {
                                        match = true;
                                    }
                                }
                            }
                            match ? visitRequest[i].style.display = "" :
                                visitRequest[i].style.display = "none";
                        }
                    }
                }
            }
        }
    </script>

</form>
</body>
</html>