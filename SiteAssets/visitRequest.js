/*
SOCEUR VISIT REQUEST SYSTEM
CREATED: JUNE 2019
AUTHOR: WESTON SEAL
DESCRIPTION: THIS APPLICATION HANDLES NOTIFICATIONS OF NEW AND INCOMING VISITS TO THE COMMAND

*/
const ROW = "<tr>";
const COL = "<td>";
const COL_END = "</td>";
const REQSTR = "ows_visitRequestor";
const VSTR = "ows_visitVisitors";

function myList() {
  return "SOCEUR_VISITS";
}
function emailDirList() {
  return "securityEmails";
}
function myVersion() {
  return "VERSION 1.1.4 DEC 2021";
}
function myCreator() {
  return "SOCEUR J63 APPLICATION DEVELOPMENT  EMAIL: SOCEURLISTJ63@SOCOM.MIL ";
}
function myURI() {
  return "https://soceur.sof.socom.mil/security/";
} //change to https on server side//SET THE URI OF THE APPLICATION
function myUser() {
  return $().SPServices.SPGetCurrentUser({ fieldName: "Name", debug: false });
} //RETURNS MY USER
function home() {
  return "visit_landing.aspx";
} //LANDING PAGE
function form() {
  return "visit_request.aspx";
} //FORM PAGE

function dStamp() {
  var d = new Date();
  return d.toString();
} //TIMESTAMP FUNCTION
//FUNCTION TO CREATE A LIST OF DIRECTORATES
function loadMyDirectorates(sID) {
  var myID = "#" + sID;
  $(myID).append("<option value='select'  selected>PLEASE SELECT</option>");
  var myDirectorates = {
    CG: "Command Group",
    J1: "J1",
    J2: "J2",
    J3: "J3",
    J4: "J4",
    J5: "J5",
    J6: "J6",
    J8: "J8",
    JOGE: "JOG-E",
    LEGAL: "Legal",
    MED: "Medical",
    PAO: "PAO",
    REL: "Religious Affairs",
    SOHC: "SOHC",
    SSD: "SSD",
    SSO: "SSO",
  };
  $.each(myDirectorates, function (key, value) {
    $(myID).append($("<option></option>").attr("value", key).text(value));
  });
}

//HELPER FUNCTION TO GET THE QUERY STRING
function getQueryString() {
  var myQuery = location.search;
  var mySplit = myQuery.split("=");
  try {
    myQuery = mySplit[1];
  } catch (error) {
    myQuery = "0";
  }
  return myQuery;
}
//PULLS IN THE SHAREPOINT QUICK LINKS MENU
function buildAMenu(sID) {
  var myItem = "#" + sID;
  $.ajax({
    url: myURI() + "/_api/web/navigation/QuickLaunch",
    type: "GET",
    headers: { Accept: "application/json;odata=verbose" },
    success: function (data, textStatus, xhr) {
      $.each(data.d.results, function (i, item) {
        var t =
          "<li class='nav-item'><a class='nav-link pl-0 text-nowrap' href='" +
          item.Url +
          "'><span class='font-weight-bolder h5'>" +
          item.Title +
          "</span></a></li>";
        $(myItem).append(t);
      });
    },
  });
}

function systemWarnMessage(myValue) {
  var t = "";
  switch (myValue) {
    case "PERMCERT":
      t =
        "PERMCERT: Caution a PERMCERT will last as long as your current DEROS date.";
      break;
    case "EMBASSY":
      t =
        "EMBASSY: Caution a Embassy visit will take at least 5 days to process, as the hosting embassy must process the request.";
      break;
    default:
      t = "";
      break;
  }
  return t;
}
function whatLevel(smoCode) {
  var t = smoCode.slice(-1);
  switch (t) {
    case "2":
      t = "SSO";
      break;
    case "3":
      t = "SSO";
      break;
    case "A":
      t = "SSO";
      break;
    case "a":
      t = "SSO";
      break;
    default:
      t = "DIRECTORATE";
      break;
  }
  return t;
}
function determineEmail(stat) {
  //THIS FUNCTION WILL DETERMINE WHO TO EMAIL
  var dir = "",
    em = "weston.seal@socom.smil.mil";
  if (stat == "SSO") {
    dir = "SSO";
  } else {
    dir = $("#visitDirectorate option:selected").val();
  }
  em = lookupEmails(dir);
  return em;
}
function lookupEmails(em) {
  var eDir = "";
  var query =
    "<Query><Where><Eq><FieldRef Name='Title' /><Value Type='Text'>" +
    em +
    "</Value></Eq></Where></Query>";
  var viewFields =
    "<ViewFields><FieldRef Name='Title' /><FieldRef Name='emails' /><FieldRef Name='ID' /></ViewFields>";
  $().SPServices({
    operation: "GetListItems",
    async: false,
    listName: emailDirList(),
    CAMLQuery: query,
    CAMLViewFields: viewFields,
    completefunc: function (xData, Status) {
      $(xData.responseXML)
        .SPFilterNode("z:row")
        .each(function () {
          eDir = $(this).attr("ows_emails");
          $("#groupEmail").text($(this).attr("ows_ID"));
        });
    },
  });
  return eDir;
}

function updateEmails(emailsToUpdate) {
  $().SPServices({
    operation: "UpdateListItems",
    async: false,
    batchCmd: "Update",
    listName: emailDirList(),
    ID: $("#groupEmail").text(),
    valuepairs: [["emails", emailsToUpdate]],
    completefunc: function (xData, Status) {
      alert("Updated");
    },
  });
}
function buildourEmail() {
  var l1, l2, l3, l4, l5;
  l1 =
    "%3Chtml%3E%3Chead%3E%3Ctitle%3EVisitRequest%3C/title%3E%3C/head%3E%3Cbody%3E%3Ch1%3ESOCEUR VISIT REQUEST SYSTEM%3C/h1%3E";
  l2 =
    "%3Cp%3EEither a new visit request has been submitted or your request has been updated on the SOCEUR portal%3C/p%3E";
  l3 =
    "%3Cul%3E%3Cli%3EType of Visit: " +
    $("#visitType option:selected").val() +
    "%3C/li%3E%3Cli%3EVisit Level: " +
    $("#visitLevel option:selected").val() +
    "%3C/li%3E%3Cli%3EDirectorate: " +
    $("#visitDirectorate option:selected").val() +
    "%3C/li%3E%3Cli%3ESMO Code: " +
    $("#SMOCode").val() +
    "%3C/li%3E%3Cul%3E";
  l4 = "%3C/body%3E%3C/html%3E";
  return l1 + l2 + l3 + l4;
}

function saveMyData(myJSON, field, title, dir, val3, val4) {
  var ct = $("#myVisitors tbody").length;
  var mess = buildourEmail();
  var myTable = encodeURI($("#myVisitors tbody").html()); //GRAB THE WHOLE TABLE YOU CREATED VICE DISECTING IT
  $().SPServices({
    operation: "UpdateListItems",
    async: false,
    batchCmd: "New",
    listName: myList(),
    valuepairs: [
      ["Title", title],
      [field, myJSON],
      ["DIRECTORATE", dir],
      ["visitVisitors", myTable],
      ["status", val3],
      ["message", mess],
      ["emails", val4],
    ],
    completefunc: function (xData, Status) {
      console.log(
        (document.location.href = home() + "?=Successfully submitted")
      );
    },
  });
}
function determineLoad() {
  try {
    if (getQueryString == "0" || getQueryString == "") {
    } else {
      loadMyExistingRequest();
    } //NEED TO LOAD SOMETHING
  } catch (error) {
    console.log(error);
  }
}
function loadMyExistingRequest() {
  var query =
    "<Query><Where><Eq><FieldRef Name='ID' /><Value Type='Text'>" +
    getQueryString() +
    "</Value></Eq></Where></Query>";
  var viewFields =
    "<ViewFields><FieldRef Name='visitRequestor' /><FieldRef Name='visitVisitors' /><FieldRef Name='status' /><FieldRef Name='visitApprovals' /></ViewFields>";
  $().SPServices({
    operation: "GetListItems",
    async: false,
    listName: myList(),
    CAMLQuery: query,
    CAMLViewFields: viewFields,
    completefunc: function (xData, Status) {
      $(xData.responseXML)
        .SPFilterNode("z:row")
        .each(function () {
          var visitors = $(this).attr(VSTR);
          var visits = $(this).attr("ows_visitApprovals");

          var myJ = JSON.parse($(this).attr(REQSTR));
          $("#pocName").val(decodeURI(myJ.pocName));
          $("#pocDSN").val(decodeURI(myJ.pocDSN));
          $("#pocEmail").val(decodeURI(myJ.pocEmail));
          $("#pocComPhone").val(decodeURI(myJ.pocComPhone));
          $("#SMOCode").val(decodeURI(myJ.SMOCode));
          $("#visitType option[value='" + myJ.visitType + "']").prop(
            "selected",
            true
          );
          $("#visitLevel option[value='" + myJ.visitLevel + "']").prop(
            "selected",
            true
          );
          $("#visitStartDate").val(myJ.visitStartDate);
          $("#visitEndDate").val(myJ.visitEndDate);
          $(
            "#visitDirectorate option[value='" + myJ.visitDirectorate + "']"
          ).prop("selected", true);
          $("#creator").removeAttr("style");
          $("#visitCreator").text(decodeURI(myJ.visitCreator));
          $("#visitCreateDate").text(decodeURI(myJ.visitCreateDate));
          if (typeof visitors !== "undefined") {
            //look at removing the checkboxes
            $("#myVisitors tbody").html(decodeURI($(this).attr(VSTR)));
          }
          $("#addVisitorsForm").css("display", "none");
          $("#mySubmit").css("display", "none");
          $("#myCancel").css("display", "none");
          $("#approvalModule").removeAttr("style");
          //now try and load the Office use
          $(
            "#internalStatus option[value='" + $(this).attr("ows_status") + "']"
          ).prop("selected", true);
          if (typeof visit !== "undefined") {
            loadOfficeUse($(this).attr("ows_visitApprovals"));
          }
        });
    },
    error: function r(xhr, textStatus, errorThrown) {
      alert("error");
    },
  });
}
function loadOfficeUse(myField) {
  var myJ = ""; //now we try and parse the fields...if exists
  try {
    myJ = JSON.parse(myField);
    $("#myOfficeUser").text(decodeURI(myJ.myOfficeUser));
    $("#internalProcessDate").val(myJ.internalProcessDate);
    $("#internalNotes").val(decodeURI(myJ.internalNotes));
  } catch (error) {
    console.log(error);
  }
}
function saveOffice(myJ, stats) {
  $().SPServices({
    operation: "UpdateListItems",
    async: false,
    batchCmd: "Update",
    listName: myList(),
    ID: getQueryString(),
    valuepairs: [
      ["visitApprovals", myJ],
      ["status", stats],
    ],
    completefunc: function (xData, Status) {
      document.location.href = home() + "?=Successfully submitted";
    },
  });
}

function loadRequestsByStatus(stats) {
  $("#myRequests tbody").empty();
  var query =
    "<Query><Where><Eq><FieldRef Name='status' /><Value Type='Text'>" +
    stats +
    "</Value></Eq></Where><OrderBy><FieldRef Name='DIRECTORATE' Ascending='True' /><FieldRef Name='Created' /></OrderBy></Query>";
  var viewFields =
    "<ViewFields><FieldRef Name='DIRECTORATE' /><FieldRef Name='visitRequestor' /><FieldRef  Name='ID' /><FieldRef Name='visitVisitors' /></ViewFields>";
  $().SPServices({
    operation: "GetListItems",
    async: false,
    listName: myList(),
    CAMLQuery: query,
    CAMLViewFields: viewFields,
    completefunc: function (xData, Status) {
      $(xData.responseXML)
        .SPFilterNode("z:row")
        .each(function () {
          try {
            let requestorVisitorNamesStr = "";
            var myJSON = JSON.parse($(this).attr(REQSTR));
            if (myJSON && myJSON.pocName) {
              requestorVisitorNamesStr = decodeURI(myJSON.pocName);
            }

            // get all visitor names
            const visitors = $(this).attr(VSTR);
            if (visitors) {
              let rows = decodeURI(visitors).split(ROW);
              if (rows.length > 1) {
                rows.shift();
                if (rows.length) {
                  let cols = rows[0].split(COL);
                  if (cols.length > 3) {
                    requestorVisitorNamesStr += cols[3].replace(COL_END, "");
                  }
                  if (cols.length > 2) {
                    requestorVisitorNamesStr += cols[2].replace(COL_END, "");
                  }
                }
              }
            }
            requestorVisitorNamesStr = requestorVisitorNamesStr.toUpperCase();

            var t =
              "<a href='" +
              form() +
              "?=" +
              $(this).attr("ows_ID") +
              "'>&#x270E;";
            var row =
              "<tr><td>" +
              t +
              " " +
              $(this).attr("ows_DIRECTORATE") +
              "</a></td><td>" +
              myJSON.visitType +
              "</td><td>" +
              decodeURI(myJSON.SMOCode) +
              "</td><td>" +
              myJSON.visitStartDate +
              "</td><td>" +
              myJSON.visitEndDate +
              '</td><td class="hide">' +
              requestorVisitorNamesStr +
              "</td></tr>";
            $("#myRequests").append(row);
          } catch (error) {
            console.error("Error", $(this).attr("ows_ID"));
            console.error("Error", $(this).attr(REQSTR));
          }
        });
    },
  });
}
