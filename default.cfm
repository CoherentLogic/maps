<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Geodigraph Model</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- Toastr style -->
    <link href="css/plugins/toastr/toastr.min.css" rel="stylesheet">

    <!-- Gritter -->
    <link href="js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/geolayers.css" rel="stylesheet">
    <link href="css/leaflet.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/plugins/nouslider/jquery.nouislider.css" rel="stylesheet">
    <link href="css/leaflet-measure.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/leaflet-easybutton@2/src/easy-button.css" rel="stylesheet">
    
    <link href="css/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet">


    <link rel="shortcut icon" href="img/geodigraph_icon.png">

</head>

<body ng-app="">

    <cfinclude template="dialogs/add_geotiff_layer.cfm">
    <cfinclude template="dialogs/add_base_layer.cfm">
    <cfinclude template="dialogs/add_user.cfm">    
    <cfinclude template="dialogs/debug.cfm">
    <cfinclude template="dialogs/layer_controls.cfm">
    <cfinclude template="dialogs/edit_layer.cfm">
    <cfinclude template="dialogs/edit_profile.cfm">
    <cfinclude template="dialogs/confirm_delete_layer.cfm">
    <cfinclude template="dialogs/view_layer_properties.cfm">

    <cfif not session.loggedIn>
        <cfif isDefined("url.showLayer")>
            <cflocation url="login.cfm?showLayer=#url.showLayer#">
        <cfelse>
            <cflocation url="login.cfm">
        </cfif>        
    </cfif>
    <div id="wrapper">
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav metismenu" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element"> <span>
                            <cfoutput>
                                <img id="sb-user-picture" alt="image" class="img-circle" width="48" src="#session.account.picture#" />
                            </cfoutput>
                        </span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold" id="sb-user-name"><span id="sb-user-name"><cfoutput>#session.firstName# #session.lastName# <cfif session.account.admin>(Administrator)</cfif></cfoutput></strong>
                            </span> <span class="text-muted text-xs block"><cfoutput>#session.account.email#</cfoutput> <b class="caret"></b></span> </span> </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a href="#" onclick="editProfile();">Edit Profile</a></li>
                                <!--- <li><a href="#">Manage Account</a></li> --->
                                <li class="divider"></li>
                                <li><a href="logout.cfm">Logout</a></li>
                            </ul>
                        </div>                    
                        <div class="logo-element">
                            <img src="img/geodigraph_icon.png">
                        </div>
                    </li>

                    <li>
                        <a href="#"><i class="fa fa-globe"></i> <span class="nav-label">Map</span><span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">                                
                            <li><a href="#" onclick="addBaseLayer();">Add Base Layer</a></li>
                            <li><a href="#" onclick="addGeoTiffLayer();">Add GeoTIFF Layer</a></li>
                            <!--- <li><a href="#" onclick="">Add Parcel Layer</a></li> 
                            <li><a href="#" onclick="">Manage Layers</a></li>    --->                                               
                        </ul>
                    </li>  
                    <cfif session.account.admin>                 
                        <li>
                            <a href="#"><i class="fa fa-users"></i> <span class="nav-label">Users</span><span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level collapse">
                                <li><a href="#" onclick="geodigraph.updateSelects();" data-toggle="modal" data-target="#dlgAddUser">Add User</a></li>
                                <!---<li><a href="#" onclick="geodigraph.updateSelects();" data-toggle="modal" data-target="#dlgAddCompany">Add Company</a></li>--->
                                <li><a href="#" onclick="geodigraph.updateSelects();">Manage Users &amp; Companies</a></li>
                            </ul>
                        </li>
                    </cfif>
                    <cfif session.account.admin>
                    <li>
                        <a href="#" onclick="geodigraph.updateSelects();" data-toggle="modal" data-target="#dlgDebug"><i class="fa fa-bug"></i> <span class="nav-label">Debug</span></a>
                    </li>               
                    </cfif>     

                </ul>

            </div>
        </nav>

        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0" id="navbar">
                    <div class="navbar-header">
                        <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i onclick="geodigraph.map.leafletMap.invalidateSize(false);" class="fa fa-bars"></i> </a>

                    </div>
                    <ul class="nav navbar-top-links navbar-right">
                        <li>
                            <span class="m-r-sm text-muted welcome-message">Welcome to Geodigraph Model</span>
                        </li>
                        
                        <!---
                        <li class="dropdown">

                            <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                                <i class="fa fa-bell"></i>  <span class="label label-primary" id="notificationCount"></span>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts" id="notifications">
                                
                            </ul>
                        </li>
                        --->


                        <li>
                            <a href="logout.cfm">
                                <i class="fa fa-sign-out"></i> Log out
                            </a>
                        </li>

                    </ul>

                </nav>
            </div>

            <div class="row">
                <div class="col-lg-12" style="padding: 0;">
                    <div class="map-container" id="map">

                    </div>
                </div>


                <div class="footer" id="footer">
                    <div class="pull-right">
                        Tokens (Used/Total): <strong><span id="tokens-used"></span>/<span id="tokens-total"></span></strong>
                    </div>
                    <div>
                        <strong>Copyright</strong> &copy; 2018 Coherent Logic Development LLC
                    </div>
                </div>
            </div>
        </div>

    </div>

</span>

<!-- Mainly scripts -->
<script src="js/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

<!-- Flot -->
<script src="js/plugins/flot/jquery.flot.js"></script>
<script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script src="js/plugins/flot/jquery.flot.spline.js"></script>
<script src="js/plugins/flot/jquery.flot.resize.js"></script>
<script src="js/plugins/flot/jquery.flot.pie.js"></script>

<!-- Peity -->
<script src="js/plugins/peity/jquery.peity.min.js"></script>
<script src="js/demo/peity-demo.js"></script>

<!-- Custom and plugin javascript -->
<script src="js/inspinia.js"></script>
<script src="js/plugins/pace/pace.min.js"></script>

<!-- jQuery UI -->
<script src="js/plugins/jquery-ui/jquery-ui.min.js"></script>

<!-- GITTER -->
<script src="js/plugins/gritter/jquery.gritter.min.js"></script>

<!-- Sparkline -->
<script src="js/plugins/sparkline/jquery.sparkline.min.js"></script>

<!-- Sparkline demo data  -->
<script src="js/demo/sparkline-demo.js"></script>

<!-- ChartJS-->
<script src="js/plugins/chartJs/Chart.min.js"></script>

<!-- Toastr -->
<script src="js/plugins/toastr/toastr.min.js"></script>
 <script src="js/plugins/iCheck/icheck.min.js"></script>

<!-- NouSlider -->
<script src="js/plugins/nouslider/jquery.nouislider.min.js"></script>

<!-- Tags Input -->
<script src="js/plugins/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>


<!-- uuid -->
<script src="https://cdn.rawgit.com/jackens/uuidv1/master/uuidv1.js"></script>

<!-- Leaflet stuff -->
<script src="js/leaflet.js"></script>
<!--- <script src="https://cdn.jsdelivr.net/npm/leaflet-easybutton@2/src/easy-button.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/0.4.2/leaflet.draw.js"></script> --->
<script src="js/leaflet-measure.js"></script>

<!-- ChartJS-->
<script src="js/plugins/chartJs/Chart.min.js"></script>

<!-- Angular -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>

<!-- Geodigraph stuff -->
<script src="js/layer.js"></script>
<script src="js/account.js"></script>
<script src="js/filehandler.js"></script>
<script src="js/gis.js"></script>
<script src="js/geolayers.js"></script>



<script>
    $(document).ready(function() {
        geodigraph.init();            
    });
</script>
</body>
</html>
