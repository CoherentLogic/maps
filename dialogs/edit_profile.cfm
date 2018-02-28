<div class="modal inmodal" id="dlgEditProfile" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <i class="fa fa-edit modal-icon"></i>
                <h4 class="modal-title">Edit Profile</h4>
                <small class="font-bold">Edits the properties of your user profile.</small>
            </div>
            <div class="modal-body">              
                <div class="tabs-container">
                    <ul class="nav nav-tabs">                        
                        <li class="active"><a data-toggle="tab" href="#ep-basic">Personal Info</a></li>                            
                        <li><a data-toggle="tab" href="#ep-layers">Personal Layer Display</a></li>                            
                    </ul>
                    <div class="tab-content">                            

                        <div id="ep-basic" class="tab-pane active">
                            <div class="panel-body">
                                <div class="form-group">
                                    <label>First name</label>
                                    <input type="text" id="ep-firstname" name="ep-firstname" class="form-control profile-edit-control" placeholder="Enter your first name">
                                    <label>Last name</label>
                                    <input type="text" id="ep-lastname" name="ep-lastname" class="form-control profile-edit-control" placeholder="Enter your last name">
                                    <label>ZIP code</label>
                                    <input type="text" id="ep-zip" name="ep-zip" class="form-control profile-edit-control" placeholder="Enter your ZIP code">
                                </div>
                                <form target="formTarget" action="dialogs/edit_profile_submit.cfm" method="post" id="frmEditProfile" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label>Profile picture</label><br>
                                        <img id="ep-picture" width="50" height="50" style="margin: 20px;">
                                        <input class="form-control" type="file" name="profilePicture">

                                    </div>
                                </form>                          
                            </div>
                        </div>
                        <div id="ep-layers" class="tab-pane">
                            <div class="panel-body">
c
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>                
            </div>
        </div>
    </div>
</div>