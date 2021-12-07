<!DOCTYPE html >
<%@ Page Language="C#" %>
<%@ Register tagprefix="SharePoint" namespace="Microsoft.SharePoint.WebControls" assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<html>

<head runat="server">
<title>Visit Request System</title>
	<meta http-equiv="X-UA-Compatible" content="IE=10" />
	<link rel="stylesheet" href="../SiteAssets/bootstrap.min.css"  type="text/css">
    <link rel="stylesheet" href="../SiteAssets/tabs_boostrap.css"   type="text/css">
    <link rel="stylesheet" href="../SiteAssets/jquery-ui.css" type="text/css">
    <script src="../SiteAssets/jquery-3.3.1.slim.min.js"  type="text/javascript"></script>
    <script src="../SiteAssets/popper.min.js" type="text/javascript" ></script>    
    <script src="../SiteAssets/jquery.min.js" type="text/javascript"></script>
    <script src="../SiteAssets/bootstrap.min.js" type="text/javascript"></script>
    <script src="../SiteAssets/jquery-ui.js" type="text/javascript"></script>
    <script src="../SiteAssets/jquery.SPServices-2014.02.js" type="text/javascript"></script>    
    <script src="../SiteAssets/visitRequest.js" type="text/javascript"></script>
    <script type="text/javascript">
            $( function() {
                $( "#visitStartDate" ).datepicker({dateFormat:'yy mm dd'});
                $("#visitEndDate").datepicker({dateFormat:'yy mm dd'});
                $("#visitorDob").datepicker({dateFormat:'yy mm dd'});
                $("#internalProcessDate").datepicker({dateFormat:'yy mm dd'});
            } );
    </script>
</head>
<body>
    <form id="form1" runat="server">        
    <SharePoint:FormDigest runat="server"/>
        <div class="container-fluid w-100">
            <div class="card w-100 m-0" >
                <div class="card-header shadow-sm">
                        <div class="row">
                            <div class="col-12">
                                <h1 class="h1 font-weight-bolder font-italic text-center text-dark">SOCEUR VISIT REQUEST SYSTEM</h1>
                            </div>
                        </div>
                </div>
                <div class="card-body">                    
                    <div class="row">
                        <div class="col-12"><p class="text-primary"></p></div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <h3 class="h3 font-weight-bold">Visit: Type </h3>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-10 input-group mb-1">
                            <label for="visitType" class="col-sm-4 col-form-label" >Type of Requested Visit:</label>
                            <select class="shadow-sm  w-50 form-control" id="visitType">
                                <option value="select">PLEASE SELECT</option>
                                <option value="COMMAND-VISIT">COMMAND VISIT</option>
                                <option value="PERMCERT">PERMANENT VISIT CERTIFICATION</option>
                                <option value="NATO">NATO VISIT CERTIFICATE</option>
                                <option value="EMBASSY">EMBASSY VISIT CERTIFICATION</option>
                            </select>
                        </div>
                        <div class="col-2"></div>                       
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div id="myAlert" role="alert">                            
                            </div>
                        </div>
                    </div>
                    <div class="row" id="creator" style="display: none;">
                        <div class="col-2">Created by:</div>
                        <div class="col-3"><span id="visitCreator"></span></div>
                        <div class="col-2">Created on:</div>
                        <div class="col-5"><span id="visitCreateDate"></span></div>
                    </div>
                    <div class="row">
                            <div class="col-12">
                                    <h3 class="h3 font-weight-bold ">Visit: Visit POC </h3>
                            </div>                            
                    </div>
                    <div class="form-row">
                        <div class="col-2">
                            <label for="pocName" class="col-form-label">&#128100; POC Name:</label>                            
                        </div>
                        <div class="col-4">
                                <input type="text" class="form-control shadow-sm " id="pocName">                             
                        </div>
                        <div class="col-2">
                                <label for="pocDSN" class="col-form-label">&#9743; POC DSN:</label>
                        </div>
                        <div class="col-4">
                                <input type="text"  class="form-control shadow-sm " id="pocDSN" >
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-2">
                            <label for="pocEmail" class="col-form-label">&#128231; POC Email:</label>                            
                        </div>
                        <div class="col-4">
                                <input type="text" class="form-control shadow-sm " id="pocEmail">                             
                        </div>
                        <div class="col-2">
                                <label for="pocComPhone" class="col-form-label"> &#9742; Commercial Phone:</label>
                        </div>
                        <div class="col-4">
                                <input type="text" class="form-control shadow-sm " id="pocComPhone">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-2">
                            <label for="SMOCode" class="col-form-label">&#128196; SMO Code:</label>                            
                        </div>
                        <div class="col-2">
                                <input type="text" class="form-control shadow-sm " id="SMOCode">                             
                        </div>
                        <div class="col-2">                            
                        </div>
                        <div class="col-2">
                                <label for="visitLevel" class="my-1 mr-2">&#128195; Visit Level:</label>
                        </div>
                        <div class="col-4">
                                <select class="shadow-sm  w-50 form-control" id="visitLevel">
                                        <option value="select">PLEASE SELECT</option>
                                        <option value="NATO-S">NATO-S</option>
                                        <option value="SECRET">SECRET</option>
                                        <option value="TOP SECRET">TOP SECRET</option>
                                        <option value="SCI">SCI</option>
                                        <option value="SAP">SAP</option>
                                </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-2">
                                <label for="visitStartDate" class="col-form-label">&#128198;  Visit Start Date:</label>                            
                            </div>
                            <div class="col-4">                                  
                                        <input type="text" class="form-control shadow-sm w-50 " id="visitStartDate">                                                                                    
                            </div>
                            <div class="col-2">
                                    <label for="visitEndDate" class="col-form-label">&#128198; Visit End Date :</label>
                            </div>
                            <div class="col-4">
                                    <input type="text" class="form-control shadow-sm w-50" id="visitEndDate">
                            </div>
                    </div>
                    <div class="form-row">
                        <div class="col-2">
                                <label for="visitDirectorate" class="col-form-label">Requesting Directorate:</label>     
                        </div>
                        <div class="col-6">
                                <select class="shadow-sm  w-50 form-control" id="visitDirectorate">
                                  
                                </select>
                        </div>
                        <div class="col-4">
                        </div>
                    </div>
                    <div class="row">
                            <div class="col-12">
                                    <h3 class="h3 font-weight-bold shadow-sm">Visit:  Visitors</h3>
                            </div>                            
                    </div>
                    <div id="addVisitorsForm" class="form-row">
                       <div class="col-2">
                            <label for="visitorLastName" class="col-form-label">Last Name:</label>
                            <input type="text" class="form-control shadow-sm " id="visitorLastName">     
                       </div>
                       <div class="col-2">
                            <label for="visitorFirstName" class="col-form-label">First Name:</label>
                            <input type="text" class="form-control shadow-sm " id="visitorFirstName">    
                       </div>
                       <div class="col-2">
                            <label for="visitorEDIPI" class="col-form-label">EDIPI:</label>
                            <input type="text" class="form-control shadow-sm " maxlength="10" id="visitorEDIPI">    
                       </div>
                       <div class="col-2">
                            <label for="visitorDob" class="col-form-label">DoB (yyyy mm dd):</label>
                            <input type="text" class="form-control shadow-sm " id="visitorDob">  
                       </div>
                       <div class="col-2">
                           <div style="height: 30px; width:100%"></div>
                           <input type="button" id="add-row" class=" btn btn-info btn-block m-0" value="&#10133;  Add">    
                       </div>   
                       <div class="col-2">
                            <div style="height: 30px; width:100%"></div>
                            <input type="button" id="delete-row" class="btn btn-danger btn-block m-0" value="&#10008;  Delete ">
                       </div>                    
                    </div>
                    <div class="row">                        
                        <div class="col-12">
                            <table id="myVisitors" class="table table-striped table-hover w-100">
                                <thead  class="thead-light">
                                    <tr>
                                        <th></th>
                                        <th>Last Name</th>
                                        <th>First Name</th>
                                        <th style="width:15%">EDIPI</th>
                                        <th style="width:15%">Date of Birth</th>
                                    </tr>
                                </thead>
                                <tbody ></tbody>
                            </table>
                        </div>
                    </div>                                      
                </div>
                <div id="approvalModule" class="row" style="display: none;">
                    <div class="col-12">
                       <div class="row">
                           <div class="col-12">
                               <h4 class="h4 border-bottom font-weight-bold">Internal Office Use Only</h4>
                           </div>
                       </div>  
                       <div class="row">
                           <div class="col-3">Processed by:</div>
                           <div class="col-3"><span id="myOfficeUser"></span></div>
                           <div class="col-3">Date:</div>
                           <div class="col-3"><input type="text" class="form-control shadow-sm " id="internalProcessDate">  </div>
                       </div>
                       <div class="row">
                           <div class="col-2">Notes:</div>
                           <div class="col-10">
                               <textarea id="internalNotes" class="form-control" rows="5"></textarea>
                           </div>
                       </div>
                       <div class="row">
                           <div class="col-4"></div>
                           <div class="col-4">
                                <select class="shadow-sm  w-50 form-control" id="internalStatus">
                                        <option value="select">PLEASE SELECT</option>
                                        <option value="INITIAL">INITIAL</option>
                                        <option value="APPROVED">APPROVED</option>
                                        <option value="DIRECTORATE">DIRECTORATE/COLLATERAL</option>
                                        <option value="SSO">SSO LEVEL</option>
                                </select>
                           </div>
                           <div class="col-2">
                               <input id="internalSubmit" type="button" class="btn btn-info btn-block" value="Submit Request">
                           </div>
                           <div class="col-2">
                                <input id="internalCancel" type="button" class="btn btn-danger btn-block" value="Cancel">
                           </div>
                       </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row ">
                        <div class="col-8">
                            <h5 class="h5"><span class='font-weight-bold'>USER:</span>  <span id="myUser"></span> </h5>                            
                        </div>
                        <div class="col-2">
                                <input id="mySubmit" type="button" class="btn btn-info btn-block" value="&#10133; Submit Request">                                
                        </div>
                        <div class="col-2">
                                <input id="myCancel" type="button" class="btn btn-danger btn-block" value="&#10008; Cancel Request">
                        </div>
                    </div>
                    <div class="clearfix"></div> 
                    <div class="row">
                        <div class="col-1 font-weight-bold">SUPPORT:</div>
                        <div class="col-6"><span id="productOwner"></span></div>
                        <div class="col-5"><span id="loadDate"></span> </div>                        
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <span id="groupEmail"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#myOfficeUser").text(myUser());
                loadMyDirectorates("visitDirectorate");
                determineLoad();
            });
        </script>
        <script type="text/javascript">
        //FUNCTION HANDLES THE TABLE...
            $(document).ready(function(){
                $("#add-row").click(function(){
                    //now add something to un-hide this
                    var lname = $("#visitorLastName").val();
                    var fname= $("#visitorFirstName").val();
                    var edipi=$("#visitorEDIPI").val();
                    var dob=$("#visitorDob").val();
                    var markup = "<tr><td><input type='checkbox' name='record'></td><td>" + lname + "</td><td>" + fname+ "</td><td>"+edipi+"</td><td>"+dob+"</td></tr>";
                    $("#myVisitors tbody").append(markup);
                });                
                // Find and remove selected table rows
                $("#delete-row").click(function(){
                    $("table tbody").find('input[name="record"]').each(function(){
                        if($(this).is(":checked")){
                            $(this).parents("tr").remove();
                        }
                    });
                });
            });    
        </script>      
        <script type="text/javascript">
            $(document).ready(function(){
                $("#productOwner").text(myCreator());//LOAD PROCESS IMPROVEMENT NAME
                $("#loadDate").html("<span class='font-weight-bold'>DATE: </span>"+dStamp());       //LOAD DATE TIME STAMP
                $("#myUser").html(myUser()+ "  <span class='font-weight-bold'>VERSION: </span>"+myVersion());         //LOAD MY USER                     
                //HANDLE VISIT MESSAGE CHANGE
                $("#visitType").on('change', function(){
                    if(this.value =="EMBASSY" || this.value=="PERMCERT"){  $("#myAlert").addClass("alert alert-warning");       $("#myAlert").text(systemWarnMessage(this.value));      }
                    else{  $("#myAlert").removeClass("alert alert-warning");   $("#myAlert").text(systemWarnMessage(this.value));   }
                });
                //HANDLE SUBMIT BUTTON 
                $("#mySubmit").click(function(){
                    //need to figure out if this shoudl be different Status
                    var val3= whatLevel($("#SMOCode").val());
                   var myJSON='{"pocName":"'+encodeURI($('#pocName').val())+'", "pocDSN":"'+encodeURI($('#pocDSN').val())+'", "pocEmail":"'+encodeURI($('#pocEmail').val())+'", "pocComPhone":"'+encodeURI($('#pocComPhone').val())+ '", "SMOCode":"'+encodeURI($('#SMOCode').val())+
                    '", "visitType":"'+$('#visitType option:selected').val()+'", "visitLevel":"'+$('#visitLevel option:selected').val()+'", "visitStartDate":"'+$('#visitStartDate').val()+'", "visitEndDate":"'+$('#visitEndDate').val()+
                    '", "visitCreator":"'+encodeURI(myUser())+'", "visitDirectorate":"'+$("#visitDirectorate option:selected").val()+'",  "visitCreateDate":"'+encodeURI(dStamp())+'"}';
                    var title= $("#visitDirectorate option:selected").val()+"_"+ $('#SMOCode').val()+"-"+$('#visitStartDate').val();
                    saveMyData(myJSON, "visitRequestor", title, $("#visitDirectorate option:selected").val(), val3, determineEmail(val3));//Now save our JSON back to the SharePoint List
                });
                //HANDLE CANCEL BUTTON REMEMBER EVERTHING IS IN THE CLASS URLS INCLUDED
                $("#myCancel").click(function(){document.location.href= myURI()+"SitePages/"+home();  });
                $("#internalCancel").click(function(){document.location.href= myURI()+"SitePages/"+home();  });
                $("#internalSubmit").click(function(){
                    var myJ="";
                    var t=  $('#internalStatus  option:selected').val();                    
                    if(t !== "APPROVED"){
                        myJ='{"myOfficeUser":"'+encodeURI($('#myOfficeUser').text())+'", "internalProcessDate":"'+$('#internalProcessDate').val()+'", "internalNotes":"'
                        +encodeURI($('#internalNotes').val())+'", "internalStatus":"'+t+'"}';                        
                    }
                    else{
                        myJ='{"myOfficeUser":"'+encodeURI($('#myOfficeUser').text())+'", "internalProcessDate":"'+$('#internalProcessDate').val()+'", "internalNotes":"'
                        +encodeURI($('#internalNotes').val())+'", "internalStatus":"'+t+'"}';                        
                    }
                    saveOffice(myJ,t);//SAVE MY DATA                    
                });

            });
        </script>
    </form>
</body>
</html>