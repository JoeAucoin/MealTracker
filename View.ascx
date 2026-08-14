<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="GIBS.Modules.MealTracker.View" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<asp:Label ID="lblDebug" runat="server" Visible="false" CssClass="alert alert-warning" />
 	
<asp:HiddenField ID="hfSelecteValue" Value="" runat="server" />

<div style="width:95%;text-align:right;"><asp:LinkButton ID="lbReport" runat="server" resourcekey="lbReport" OnClick="lbReportClick" CausesValidation="false" CssClass="dnnSecondaryAction" />
    <asp:LinkButton ID="lbLocations" runat="server" resourcekey="lbLocations"  CausesValidation="false" CssClass="dnnSecondaryAction" OnClick="lbLocations_Click" />
</div>



    <asp:HiddenField ID="HiddenMealID" runat="server" Value="0" />





<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12">
            
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist" id="dnnTabPanel">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="tab1-tab" href="#tab1" aria-controls="tab1" role="tab" aria-selected="true" data-toggle="tab" data-bs-toggle="tab">Weekly Form</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab2-tab" href="#tab2" aria-controls="tab2" role="tab" aria-selected="false" data-toggle="tab" data-bs-toggle="tab">Daily Form</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="tab3-tab" href="#tab3" aria-controls="tab3" role="tab" aria-selected="false" data-toggle="tab" data-bs-toggle="tab">Report</a>
                </li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content" style="padding-top: 15px;">
                <div role="tabpanel" class="tab-pane fade in show active" id="tab1" aria-labelledby="tab1-tab">
                    <div class="container">
    	<div class="row form">
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
            
            <dnn:label id="lblSchoolLocation" runat="server" controlname="ddlLocationID" suffix=":" CssClass="control-label" />
	
	    <asp:DropDownList ID="ddlLocationID" runat="server" CssClass="form-control input-lg" OnSelectedIndexChanged="ddlLocationID_SelectedIndexChanged" AutoPostBack="true">
    </asp:DropDownList>	
	<asp:RequiredFieldValidator runat="server" id="reqLocationID" controltovalidate="ddlLocationID" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqSchoolLocation" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>	
            
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4"><dnn:label id="lblSeating" runat="server" controlname="ddlSeating" suffix=":" CssClass="control-label" />
			
    <asp:DropDownList ID="ddlSeating" runat="server" OnSelectedIndexChanged="ddlSeating_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control input-lg">
    </asp:DropDownList>	
		<asp:RequiredFieldValidator runat="server" id="reqSeating" resourcekey="reqSeating" controltovalidate="ddlSeating" Display="Dynamic" errormessage="Required!" ValidationGroup="weekly" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-6 col-sm-1 col-md-1 col-lg-1 checkbox-lg">
            <dnn:label id="lblDeseCbx" runat="server" controlname="CheckBoxDESE" suffix=":" CssClass="control-label" />
            <asp:CheckBox ID="CheckBoxDESE" runat="server" Enabled="false" CssClass="form-control form-check-input"  />
            </div>
            </div>

    <div class="row form">


        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2"><dnn:label id="lblMealDate" runat="server" controlname="txtMealDate" suffix=":" for="txtMealDate" CssClass="control-label" />
			<asp:TextBox ID="txtMealDate" runat="server" MaxLength="10" AutoCompleteType="Disabled" ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="reqMealDate" resourcekey="reqMealDate" ValidationGroup="weekly" controltovalidate="txtMealDate" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>

                <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            
            <dnn:label id="lblDeliveryTime" runat="server" controlname="ddlDeliveryTime" suffix=":" CssClass="control-label" />
			 <asp:DropDownList ID="ddlDeliveryTime" runat="server" CssClass="form-control input-lg">
                 
			 </asp:DropDownList>
	<asp:RequiredFieldValidator runat="server" id="reqDeliveryTime" controltovalidate="ddlDeliveryTime" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveryTime" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>


 <div class="form-group col-xs-4 col-sm-3 col-md-3 col-lg-1">
     <dnn:label id="lblDeliveryPriorDay" runat="server" controlname="cbxDeliveryPriorDay" suffix=":" CssClass="control-label" />
     <asp:CheckBox ID="cbxDeliveryPriorDay" runat="server" CssClass="form-control checkbox-lg" />
     </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1">
            
            <dnn:label id="lblDelivered" runat="server" controlname="txtDelivered" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDelivered" runat="server" onchange="javascript:myCopyFunction();" ClientIDMode="Static" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDelivered" controltovalidate="txtDelivered" Display="Dynamic" errormessage="Required!" resourcekey="reqDelivered" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>
			        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblDamagedIncomplete" runat="server" controlname="txtDamagedIncomplete" suffix=":" />
	<asp:TextBox ID="txtDamagedIncomplete" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDamagedIncomplete" controltovalidate="txtDamagedIncomplete" Display="Dynamic" errormessage="Required!" resourcekey="reqDamagedIncomplete" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblFirstsCount" runat="server" controlname="txtFirstsCount" suffix=":" />
	<asp:TextBox ID="txtFirstsCount" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCount" controltovalidate="txtFirstsCount" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCount" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblSecondsCount" runat="server" controlname="txtSecondsCount" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCount" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCount" controltovalidate="txtSecondsCount" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCount" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
         <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblAdults" runat="server" controlname="txtAdults" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdults" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdults" controltovalidate="txtAdults" errormessage="Required!" Display="Dynamic" resourcekey="reqAdults" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>

         <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblShort" runat="server" controlname="txtShort" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtShort" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" />
	
            </div>

    </div>

        <div class="row form">


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblMealDateTues" runat="server" controlname="txtMealDateTues" suffix=":" for="txtMealDateTues" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateTues" runat="server" MaxLength="10" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
		<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator1" resourcekey="reqMealDate" controltovalidate="txtMealDateTues" errormessage="Required!" Display="Dynamic" ValidationGroup="weekly" CssClass="NormalRed" />
        </div>

                <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            
            <dnn:label id="lblDeliveryTimeTues" runat="server" controlname="ddlDeliveryTimeTues" suffix=":" CssClass="control-label" />
			 <asp:DropDownList ID="ddlDeliveryTimeTues" runat="server" CssClass="form-control input-lg">
                 
			 </asp:DropDownList>
	<asp:RequiredFieldValidator runat="server" id="reqDeliveryTimeTues" controltovalidate="ddlDeliveryTimeTues" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveryTimeTues" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>

 <div class="form-group col-xs-4 col-sm-3 col-md-3 col-lg-1">
     <dnn:label id="lblDeliveryPriorDayTues" runat="server" controlname="cbxDeliveryPriorDayTues" suffix=":" CssClass="control-label" />
     <asp:CheckBox ID="cbxDeliveryPriorDayTues" runat="server" CssClass="form-control checkbox-lg" />
     </div>


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1">
            
            <dnn:label id="lblDeliveredTues" runat="server" controlname="txtDeliveredTues" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredTues" controltovalidate="txtDeliveredTues" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredTues" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>

		<div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblDamagedIncompleteTues" runat="server" controlname="txtDamagedIncompleteTues" suffix=":" />
		<asp:TextBox ID="txtDamagedIncompleteTues" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDamagedIncompleteTues" controltovalidate="txtDamagedIncompleteTues" Display="Dynamic" errormessage="Required!" resourcekey="reqDamagedIncompleteTues" ValidationGroup="weekly" CssClass="NormalRed" />
		</div>

        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblFirstsCountTues" runat="server" controlname="txtFirstsCountTues" suffix=":" />
	<asp:TextBox ID="txtFirstsCountTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountTues" controltovalidate="txtFirstsCountTues" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountTues" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblSecondsCountTues" runat="server" controlname="txtSecondsCountTues" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountTues" controltovalidate="txtSecondsCountTues" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountTues" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
 
                    <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblAdultsTues" runat="server" controlname="txtAdultsTues" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsTues" controltovalidate="txtAdultsTues" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsTues" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>

         <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblShortTues" runat="server" controlname="txtShortTues" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtShortTues" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" />
	
            </div>	

    </div>


        <div class="row form">


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblMealDateWeds" runat="server" controlname="txtMealDateWeds" suffix=":" for="txtMealDateWeds" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateWeds" runat="server" MaxLength="10" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
		<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator2" resourcekey="reqMealDate" controltovalidate="txtMealDateWeds" errormessage="Required!" Display="Dynamic" ValidationGroup="weekly" CssClass="NormalRed" />
        </div>

                <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            
            <dnn:label id="lblDeliveryTimeWeds" runat="server" controlname="ddlDeliveryTimeWeds" suffix=":" CssClass="control-label" />
			 <asp:DropDownList ID="ddlDeliveryTimeWeds" runat="server" CssClass="form-control input-lg">     
			 </asp:DropDownList>
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator9" controltovalidate="ddlDeliveryTimeWeds" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveryTimeTues" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>

 <div class="form-group col-xs-4 col-sm-3 col-md-3 col-lg-1">
     <dnn:label id="lblDeliveryPriorDayWeds" runat="server" controlname="cbxDeliveryPriorDayWeds" suffix=":" CssClass="control-label" />
     <asp:CheckBox ID="cbxDeliveryPriorDayWeds" runat="server" CssClass="form-control checkbox-lg" />
     </div>


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1">
            
            <dnn:label id="lblDeliveredWeds" runat="server" controlname="txtDeliveredWeds" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredWeds" controltovalidate="txtDeliveredWeds" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredWeds" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>

		<div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblDamagedIncompleteWeds" runat="server" controlname="txtDamagedIncompleteWeds" suffix=":" />
		<asp:TextBox ID="txtDamagedIncompleteWeds" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDamagedIncompleteWeds" controltovalidate="txtDamagedIncompleteWeds" Display="Dynamic" errormessage="Required!" resourcekey="reqDamagedIncompleteWeds" ValidationGroup="weekly" CssClass="NormalRed" />
		</div>

        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblFirstsCountWeds" runat="server" controlname="txtFirstsCountWeds" suffix=":" />
	<asp:TextBox ID="txtFirstsCountWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountWeds" controltovalidate="txtFirstsCountWeds" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountWeds" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblSecondsCountWeds" runat="server" controlname="txtSecondsCountWeds" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountWeds" controltovalidate="txtSecondsCountWeds" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountWeds" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
 
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblAdultsWeds" runat="server" controlname="txtAdultsWeds" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsWeds" controltovalidate="txtAdultsWeds" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsWeds" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>

         <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblShortWeds" runat="server" controlname="txtShortWeds" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtShortWeds" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" />
	
            </div>	

    </div>


        <div class="row form">


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblMealDateThurs" runat="server" controlname="txtMealDateThurs" suffix=":" for="txtMealDateThurs" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateThurs" runat="server" MaxLength="10" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
		<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator3" resourcekey="reqMealDate" controltovalidate="txtMealDateThurs" errormessage="Required!" Display="Dynamic" ValidationGroup="weekly" CssClass="NormalRed" />
        </div>

                <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            
            <dnn:label id="lblDeliveryTimeThurs" runat="server" controlname="ddlDeliveryTimeThurs" suffix=":" CssClass="control-label" />
			 <asp:DropDownList ID="ddlDeliveryTimeThurs" runat="server" CssClass="form-control input-lg">
                 
			 </asp:DropDownList>
	<asp:RequiredFieldValidator runat="server" id="reqDeliveryTimeThurs" controltovalidate="ddlDeliveryTimeThurs" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveryTimeThurs" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>


 <div class="form-group col-xs-4 col-sm-3 col-md-3 col-lg-1">
     <dnn:label id="lblDeliveryPriorDayThurs" runat="server" controlname="cbxDeliveryPriorDayThurs" suffix=":" CssClass="control-label" />
     <asp:CheckBox ID="cbxDeliveryPriorDayThurs" runat="server" CssClass="form-control checkbox-lg" />
     </div>


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1">
            
            <dnn:label id="lblDeliveredThurs" runat="server" controlname="txtDeliveredThurs" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredThurs" controltovalidate="txtDeliveredThurs" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredThurs" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>

		<div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblDamagedIncompleteThurs" runat="server" controlname="txtDamagedIncompleteThurs" suffix=":" />
		<asp:TextBox ID="txtDamagedIncompleteThurs" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDamagedIncompleteThurs" controltovalidate="txtDamagedIncompleteThurs" Display="Dynamic" errormessage="Required!" resourcekey="reqDamagedIncompleteThurs" ValidationGroup="weekly" CssClass="NormalRed" />
		</div>

        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblFirstsCountThurs" runat="server" controlname="txtFirstsCountThurs" suffix=":" />
	<asp:TextBox ID="txtFirstsCountThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountThurs" controltovalidate="txtFirstsCountThurs" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountThurs" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblSecondsCountThurs" runat="server" controlname="txtSecondsCountThurs" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountThurs" controltovalidate="txtSecondsCountThurs" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountThurs" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
 
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblAdultsThurs" runat="server" controlname="txtAdultsThurs" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsThurs" controltovalidate="txtAdultsThurs" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsThurs" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>

         <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblShortThurs" runat="server" controlname="txtShortThurs" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtShortThurs" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" />
	
            </div>

    </div>



        <div class="row form">


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblMealDateFri" runat="server" controlname="txtMealDateFri" suffix=":" for="txtMealDateFri" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateFri" runat="server" MaxLength="10"  ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
		<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator4" resourcekey="reqMealDate" controltovalidate="txtMealDateFri" errormessage="Required!" Display="Dynamic" ValidationGroup="weekly" CssClass="NormalRed" />
        </div>

                <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            
            <dnn:label id="lblDeliveryTimeFri" runat="server" controlname="ddlDeliveryTimeFri" suffix=":" CssClass="control-label" />
			 <asp:DropDownList ID="ddlDeliveryTimeFri" runat="server" CssClass="form-control input-lg">
                 
			 </asp:DropDownList>
	<asp:RequiredFieldValidator runat="server" id="reqDeliveryTimeFri" controltovalidate="ddlDeliveryTimeFri" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveryTimeFri" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>

 <div class="form-group col-xs-4 col-sm-3 col-md-3 col-lg-1">
     <dnn:label id="lblDeliveryPriorDayFri" runat="server" controlname="cbxDeliveryPriorDayFri" suffix=":" CssClass="control-label" />
     <asp:CheckBox ID="cbxDeliveryPriorDayFri" runat="server" CssClass="form-control checkbox-lg" />
     </div>

        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1">
            
            <dnn:label id="lblDeliveredFri" runat="server" controlname="txtDeliveredFri" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredFri" controltovalidate="txtDeliveredFri" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredFri" ValidationGroup="weekly" CssClass="NormalRed" />
            
            </div>

		<div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblDamagedIncompleteFri" runat="server" controlname="txtDamagedIncompleteFri" suffix=":" />
		<asp:TextBox ID="txtDamagedIncompleteFri" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDamagedIncompleteFri" controltovalidate="txtDamagedIncompleteFri" Display="Dynamic" errormessage="Required!" resourcekey="reqDamagedIncompleteFri" ValidationGroup="weekly" CssClass="NormalRed" />
		</div>

        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblFirstsCountFri" runat="server" controlname="txtFirstsCountFri" suffix=":" />
	<asp:TextBox ID="txtFirstsCountFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountFri" controltovalidate="txtFirstsCountFri" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountFri" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblSecondsCountFri" runat="server" controlname="txtSecondsCountFri" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountFri" controltovalidate="txtSecondsCountFri" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountFri" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
 
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblAdultsFri" runat="server" controlname="txtAdultsFri" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsFri" controltovalidate="txtAdultsFri" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsFri" ValidationGroup="weekly" CssClass="NormalRed" />
            </div>
            
         <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-1"><dnn:label id="lblShortFri" runat="server" controlname="txtShortFri" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtShortFri" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" />
	
            </div>	
    </div>




	<div class="row form">
	       <div class="form-group col-xs-7 col-sm-7 col-md-7 col-lg-7 col-md-offset-1"><dnn:label id="lblMealNotes" runat="server" controlname="txtMealNotes" suffix=":" CssClass="control-label" />
			<asp:TextBox ID="txtMealNotes" runat="server" TextMode="MultiLine" CssClass="form-control input-lg"></asp:TextBox>      
            </div> 
        <div class="form-group col-xs-3 col-sm-3 col-md-3 col-lg-3">
            <dnn:label id="lblNoteDays" runat="server" controlname="DDLNoteDays" suffix=":" CssClass="control-label" />
            <asp:DropDownList ID="DDLNoteDays" runat="server" CssClass="form-control input-lg">
                <asp:ListItem Text="All Days" Value="All"></asp:ListItem>
                <asp:ListItem Text="Monday" Value="Mon"></asp:ListItem>
                <asp:ListItem Text="Tuesday" Value="Tues"></asp:ListItem>
                <asp:ListItem Text="Wednesday" Value="Weds"></asp:ListItem>
                <asp:ListItem Text="Thursday" Value="Thurs"></asp:ListItem>
                <asp:ListItem Text="Friday" Value="Fri"></asp:ListItem>
            </asp:DropDownList>


            </div>

</div>
<div class="row form">


      

        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4" style="text-align:center;">
        <asp:LinkButton ID="lbSave" runat="server" resourcekey="lbSave" OnClick="LbSaveClick" ValidationGroup="weekly" CssClass="dnnPrimaryAction" />
        <asp:LinkButton ID="lbCancel" runat="server" resourcekey="lbCancel" OnClick="LbCancelClick" CausesValidation="false" CssClass="dnnSecondaryAction" Visible="false"/>
        </div>
   
    <div class="clearfix"></div>

	</div>
</div>


                </div>
                <div role="tabpanel" class="tab-pane fade" id="tab2" aria-labelledby="tab2-tab">

<div class="container">
    <div class="row form">
        <div class="form-group col-xs-11 col-sm-5 col-md-4 col-lg-4">
            <dnn:label id="lblSchoolLocationSingle" runat="server" controlname="ddlLocationIDSingle" suffix=":" CssClass="control-label" />
            <asp:DropDownList ID="ddlLocationIDSingle" runat="server" CssClass="form-control input-lg" OnSelectedIndexChanged="ddlLocationIDSingle_SelectedIndexChanged" AutoPostBack="true">
            </asp:DropDownList>    
            <asp:RequiredFieldValidator runat="server" id="reqLocationIDSingle" controltovalidate="ddlLocationIDSingle" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqSchoolLocation" CssClass="NormalRed" ValidationGroup="single" />
        </div>    
        
        <div class="form-group col-xs-11 col-sm-5 col-md-4 col-lg-4">
            <dnn:label id="lblSeatingSingle" runat="server" controlname="ddlSeatingSingle" suffix=":" CssClass="control-label" />
            <asp:DropDownList ID="ddlSeatingSingle" runat="server" OnSelectedIndexChanged="ddlSeatingSingle_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control input-lg">
            </asp:DropDownList>    
            <asp:RequiredFieldValidator runat="server" id="reqSeatingSingle" resourcekey="reqSeating" controltovalidate="ddlSeatingSingle" Display="Dynamic" errormessage="Required!" CssClass="NormalRed" ValidationGroup="single" />
        </div>

        <div class="form-group col-xs-6 col-sm-2 col-md-1 col-lg-1 checkbox-lg">
            <dnn:label id="Label2" runat="server" controlname="CheckBoxDESESingle" suffix=":" CssClass="control-label" />
            <asp:CheckBox ID="CheckBoxDESESingle" runat="server" Enabled="true" CssClass="form-control form-check-input" />
        </div>
    </div>

    <div class="row form">
        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            <dnn:label id="Label3" runat="server" controlname="txtMealDate" suffix=":" for="txtMealDate" CssClass="control-label" />
            <asp:TextBox ID="txtMealDateSingle" OnTextChanged="txtMealDate_TextChanged" Enabled="true" runat="server" MaxLength="10" AutoPostBack="true" AutoCompleteType="Disabled" ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator10" resourcekey="reqMealDate" controltovalidate="txtMealDateSingle" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" ValidationGroup="single" />
        </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            <dnn:label id="Label4" runat="server" controlname="ddlDeliveryTime" suffix=":" CssClass="control-label" />
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control input-lg">
            </asp:DropDownList>
            <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator11" controltovalidate="DropDownList1" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveryTime" CssClass="NormalRed" ValidationGroup="single" />
        </div>

        <div class="form-group col-xs-4 col-sm-3 col-md-3 col-lg-1">
            <dnn:label id="Label5" runat="server" controlname="cbxDeliveryPriorDay" suffix=":" CssClass="control-label" />
            <asp:CheckBox ID="CheckBox1" runat="server" CssClass="form-control checkbox-lg" />
        </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1">
            <dnn:label id="Label6" runat="server" controlname="txtDeliveredSingle" suffix=":" CssClass="control-label" />
            <asp:TextBox ID="txtDeliveredSingle" runat="server" ClientIDMode="Static" type="number" pattern="\d*" CssClass="form-control input-lg" />
            <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator12" controltovalidate="txtDeliveredSingle" Display="Dynamic" errormessage="Required!" resourcekey="reqDelivered" CssClass="NormalRed" ValidationGroup="single" />
            <asp:RangeValidator ID="rvDelivered" runat="server" ControlToValidate="txtDeliveredSingle" MinimumValue="0" MaximumValue="200" Type="Integer" ErrorMessage="Please enter a number between 1 and 200." Display="Dynamic" CssClass="NormalRed" resourcekey="rvDeliveredPositive" ValidationGroup="single" />
        </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1">
            <dnn:label id="Label7" runat="server" controlname="txtDamagedIncompleteSingle" suffix=":" CssClass="control-label" />
            <asp:TextBox ID="txtDamagedIncompleteSingle" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" />
            <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator13" controltovalidate="txtDamagedIncompleteSingle" Display="Dynamic" errormessage="Required!" resourcekey="reqDamagedIncomplete" CssClass="NormalRed" ValidationGroup="single" />
            <asp:RangeValidator ID="rvDamaged" runat="server" ControlToValidate="txtDamagedIncompleteSingle" MinimumValue="0" MaximumValue="200" Type="Integer" ErrorMessage="Please enter a number zero or greater." Display="Dynamic" CssClass="NormalRed" resourcekey="rvDamagedPositive" ValidationGroup="single" />
            <asp:CustomValidator ID="cvDamagedVsDelivered" runat="server" ControlToValidate="txtDamagedIncompleteSingle" ClientValidationFunction="validateDamaged" ErrorMessage="Damaged cannot be greater than Delivered." Display="Dynamic" CssClass="NormalRed" resourcekey="cvDamagedVsDelivered" ValidationGroup="single" />
        </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1">
            <dnn:label id="Label8" runat="server" controlname="txtFirstsCountSingle" suffix=":" CssClass="control-label" />
            <asp:TextBox ID="txtFirstsCountSingle" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
            <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator14" controltovalidate="txtFirstsCountSingle" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCount" CssClass="NormalRed" ValidationGroup="single" />
            <asp:CustomValidator ID="cvFirstsVsTotal" runat="server" ControlToValidate="txtFirstsCountSingle" ClientValidationFunction="validateFirsts" ErrorMessage="Firsts Count cannot be greater than Delivered - Damaged." Display="Dynamic" CssClass="NormalRed" resourcekey="cvFirstsVsTotal" ValidationGroup="single" />
            <asp:RangeValidator ID="rvFirsts" runat="server" ControlToValidate="txtFirstsCountSingle" MinimumValue="0" MaximumValue="200" Type="Integer" ErrorMessage="Please enter a number greater than zero and less then 200." Display="Dynamic" CssClass="NormalRed" resourcekey="rvFirstsPositive" ValidationGroup="single" />
        </div>
        
        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1">
            <dnn:label id="Label9" runat="server" controlname="txtSecondsCountSingle" suffix=":" CssClass="control-label" />
            <asp:TextBox ID="txtSecondsCountSingle" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
            <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator15" controltovalidate="txtSecondsCountSingle" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCount" CssClass="NormalRed" ValidationGroup="single" />
            <asp:CustomValidator ID="cvSecondsVsRemaining" runat="server" ControlToValidate="txtSecondsCountSingle" ClientValidationFunction="validateSeconds" ErrorMessage="Seconds Count cannot be greater than Delivered - Damaged - Firsts." Display="Dynamic" CssClass="NormalRed" resourcekey="cvSecondsVsRemaining" ValidationGroup="single" />
            <asp:RangeValidator ID="rvSeconds" runat="server" ControlToValidate="txtSecondsCountSingle" MinimumValue="0" MaximumValue="99" Type="Integer" ErrorMessage="Please enter 0 or a positive number." Display="Dynamic" CssClass="NormalRed" resourcekey="rvSecondsPositive" ValidationGroup="single" />
        </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1">
            <dnn:label id="Label10" runat="server" controlname="txtAdultsSingle" suffix=":" CssClass="control-label" />
            <asp:TextBox ID="txtAdultsSingle" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
            <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator16" controltovalidate="txtAdultsSingle" errormessage="Required!" Display="Dynamic" resourcekey="reqAdults" CssClass="NormalRed" ValidationGroup="single" />
            <asp:CustomValidator ID="cvAdultsVsRemaining" runat="server" ControlToValidate="txtAdultsSingle" ClientValidationFunction="validateAdults" ErrorMessage="Adults Count cannot be greater than Delivered - Damaged - Firsts - Seconds." Display="Dynamic" CssClass="NormalRed" resourcekey="cvAdultsVsRemaining" ValidationGroup="single" />
            <asp:RangeValidator ID="rvAdults" runat="server" ControlToValidate="txtAdultsSingle" MinimumValue="0" MaximumValue="99" Type="Integer" ErrorMessage="Please enter 0 or a positive number." Display="Dynamic" CssClass="NormalRed" resourcekey="rvAdultsPositive" ValidationGroup="single" />
        </div>

        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1">
            <dnn:label id="Label11" runat="server" controlname="txtShortSingle" suffix=":" CssClass="control-label" />
            <asp:TextBox ID="txtShortSingle" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control input-lg" />
            <asp:RangeValidator ID="rvShort" runat="server" ControlToValidate="txtShortSingle" MinimumValue="0" MaximumValue="99" Type="Integer" ErrorMessage="Please enter 0 or a positive number." Display="Dynamic" CssClass="NormalRed" resourcekey="rvShortPositive" ValidationGroup="single" />
        </div>
    </div>

    <div class="row form">
        <div class="form-group col-xs-11 col-sm-10 col-md-7 col-lg-7 col-md-offset-1">
            <dnn:label id="Label12" runat="server" controlname="txtMealNotesSingle" suffix=":" CssClass="control-label" />
            <asp:TextBox ID="txtMealNotesSingle" runat="server" TextMode="MultiLine" CssClass="form-control input-lg"></asp:TextBox>        
        </div>    
    </div>

    <div class="row form">
        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4" style="text-align:center;">
            <asp:LinkButton ID="lbSaveSingle" runat="server" resourcekey="lbSave" OnClick="LbSaveSingleClick" CssClass="dnnPrimaryAction" ValidationGroup="single" />
            <asp:LinkButton ID="lbCancelSingle" runat="server" resourcekey="lbCancel" OnClick="LbCancelSingleClick" CausesValidation="false" CssClass="dnnSecondaryAction" Visible="false" />
            
        </div>
        <div class="clearfix"></div>
    </div>
</div>

                </div>
                <div role="tabpanel" class="tab-pane fade" id="tab3" aria-labelledby="tab3-tab">

<asp:Panel ID="Panel1" runat="server" Visible="false" BorderColor="#999966" BorderWidth="1px" CssClass="panelPadding">

    <h5>EDIT RECORD</h5>  
    <div class="row form">
<div class="form-group col-xs-5 col-sm-5 col-md-4 col-lg-4">
    <dnn:Label ID="LabelLocation" runat="server" Text="Location" suffix=":" CssClass="control-label"></dnn:Label>
    <asp:DropDownList ID="ddlLocationEdit" runat="server" CssClass="form-control input-lg" OnSelectedIndexChanged="ddlLocationEdit_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
</div>
<div class="form-group col-xs-5 col-sm-5 col-md-3 col-lg-3">
    <dnn:Label ID="LabelMeal" runat="server" Text="Meal" suffix=":" CssClass="control-label"></dnn:Label>
    <asp:DropDownList ID="ddlMealEdit" runat="server" CssClass="form-control input-lg" OnSelectedIndexChanged="ddlMealEdit_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
</div>
        <div class="form-group col-xs-6 col-sm-1 col-md-1 col-lg-1 checkbox-lg">
            <dnn:label id="lblDeseCbxEdit" runat="server" controlname="CheckBoxDESEedit" suffix=":" CssClass="control-label" />
            <asp:CheckBox ID="CheckBoxDESEedit" runat="server" Enabled="false" CssClass="form-control form-check-input"  />
            </div>
</div>

    <div class="row form">


        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-2 "><dnn:label id="lblMealDateEdit" runat="server" controlname="txtMealDateEdit" suffix=":" for="txtMealDateEdit" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateEdit" runat="server" MaxLength="10" ValidationGroup="MealUpdate" AutoCompleteType="Disabled" ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator5" resourcekey="reqMealDate" controltovalidate="txtMealDateEdit" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>

           <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">     
            <dnn:label id="lblDeliveryTimeEdit" runat="server" controlname="ddlDeliveryTimeEdit" suffix=":" CssClass="control-label" />
			 <asp:DropDownList ID="ddlDeliveryTimeEdit" runat="server" CssClass="form-control input-lg" ValidationGroup="MealUpdate">
			 </asp:DropDownList>
	<asp:RequiredFieldValidator runat="server" id="reqDeliveryTimeEdit" controltovalidate="ddlDeliveryTimeEdit" ValidationGroup="MealUpdate" InitialValue="0" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveryTimeEdit" CssClass="NormalRed" />         
            </div>

 <div class="form-group col-xs-4 col-sm-3 col-md-3 col-lg-1">
     <dnn:label id="lblDeliveryPriorDayEdit" runat="server" controlname="cbxDeliveryPriorDayEdit" suffix=":" CssClass="control-label" />
     <asp:CheckBox ID="cbxDeliveryPriorDayEdit" runat="server" CssClass="form-control checkbox-lg" />
     </div>

        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-1">
            <dnn:label id="lblDeliveredEdit" runat="server" controlname="txtDeliveredEdit" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredEdit" runat="server" ValidationGroup="MealUpdate" type="number" pattern="\d*" CssClass="form-control" /><asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator6" controltovalidate="txtDeliveredEdit" Display="Dynamic" errormessage="Required!" resourcekey="reqDelivered" CssClass="NormalRed" />   
            </div>

			        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblDamagedIncompleteEdit" runat="server" controlname="txtDamagedIncompleteEdit" suffix=":" />
	<asp:TextBox ID="txtDamagedIncompleteEdit" runat="server" type="number" pattern="\d*" ValidationGroup="MealUpdate" CssClass="form-control" /><asp:RequiredFieldValidator runat="server" id="reqDamagedIncompleteEdit" controltovalidate="txtDamagedIncompleteEdit" Display="Dynamic" errormessage="Required!" resourcekey="reqDamagedIncompleteEdit" CssClass="NormalRed" />
            </div>

        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-1"><dnn:label id="lblFirstsCountEdit" runat="server" controlname="txtFirstsCountEdit" suffix=":" />
	<asp:TextBox ID="txtFirstsCountEdit" runat="server" type="number" ValidationGroup="MealUpdate" pattern="\d*" CssClass="form-control" /><asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator7" controltovalidate="txtFirstsCountEdit" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCount" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-1"><dnn:label id="lblSecondsCountEdit" runat="server" controlname="txtSecondsCountEdit" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountEdit" ValidationGroup="MealUpdate" runat="server" type="number" pattern="\d*" CssClass="form-control" />
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator8" controltovalidate="txtSecondsCountEdit" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCount" CssClass="NormalRed" />
            </div>
        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-1"><dnn:label id="lblAdultsCountEdit" runat="server" controlname="txtAdultsCountEdit" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsCountEdit" ValidationGroup="MealUpdate" runat="server" type="number" pattern="\d*" CssClass="form-control" />
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidatorAdultsEdit" controltovalidate="txtAdultsCountEdit" errormessage="Required!" Display="Dynamic" resourcekey="RequiredFieldValidatorAdultsEdit" CssClass="NormalRed" />
            </div>	

     <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-1"><dnn:label id="lblShortEdit" runat="server" controlname="txtShortEdit" suffix=":" CssClass="control-label" />
<asp:TextBox ID="txtShortEdit" runat="server" Text="0" type="number" pattern="\d*" CssClass="form-control" />

        </div>



    </div>

    <div class="row form">
       <div class="form-group col-xs-7 col-sm-7 col-md-7 col-lg-7 col-md-offset-1"><dnn:label id="lblNotedEdit" runat="server" controlname="txtNotesEdit" suffix=":" CssClass="control-label" />
		<asp:TextBox ID="txtNotesEdit" runat="server" TextMode="MultiLine" CssClass="form-control input-lg"></asp:TextBox>      
        </div> 

	<div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-1">
        <dnn:label id="lblUpdateButtons" runat="server" controlname="lbUpdateMeal" CssClass="control-label" />
	 <asp:LinkButton ID="lbUpdateMeal" runat="server" resourcekey="lbUpdateMeal" OnClick="lbUpdateMeal_Click" ValidationGroup="MealUpdate" CssClass="btn btn-primary" />
        <asp:LinkButton ID="LinkButtonCancelUpdate" runat="server" CausesValidation="false" resourcekey="LinkButtonCancelUpdate" OnClick="LinkButtonCancelUpdate_Click" CssClass="btn btn-light" />
	</div>

        </div>


</asp:Panel>


<div class="table-responsive">
<asp:GridView ID="GridView1" runat="server" EnableModelValidation="True" 
    DataKeyNames="MealID" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCommand="GridView1_RowCommand"    
    resourcekey="GridView1Resource1" OnPageIndexChanging="GridView1_PageIndexChanging" 
     AllowPaging="True" PageSize="20" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-list" PagerStyle-CssClass="gpagination"   
    GridLines="None">
   
    <Columns>

        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center" >
         <ItemTemplate>
             <asp:LinkButton ID="LinkButtonUpdate" CausesValidation="false" runat="server" CommandName="DataCommand" CommandArgument='<%# Eval("MealID" )%>'><img src="/Icons/Sigma/Edit_32X32_Standard.png" alt="Edit" /></asp:LinkButton>
           
         </ItemTemplate>
            <ItemStyle Width="20px"></ItemStyle>
       </asp:TemplateField>

        <asp:TemplateField HeaderText="" meta:resourcekey="TemplateFieldResource1" ItemStyle-Width="20px">
         <ItemTemplate>
           <asp:LinkButton ID="LinkButtonDelete" CausesValidation="false"     
             CommandArgument='<%# Eval("MealID") %>' 
             CommandName="Delete" runat="server" meta:resourcekey="LinkButtonEditResource1">
             <img src="/Icons/Sigma/Delete_32x32_Standard.png" alt="Delete" /></asp:LinkButton>
         </ItemTemplate>

<ItemStyle Width="20px"></ItemStyle>
       </asp:TemplateField>


      <asp:BoundField HeaderText="Date" DataField="MealDate" DataFormatString="{0:dddd, MM/dd/yyyy}"  ItemStyle-Width="90px">
<ItemStyle Width="90px"></ItemStyle>
        </asp:BoundField>

        <asp:BoundField HeaderText="Delivery Time" DataField="DeliveryTime" NullDisplayText="" HtmlEncode="false" ItemStyle-Width="80px">
<ItemStyle Width="80px"></ItemStyle>
        </asp:BoundField>

      <asp:BoundField HeaderText="Location" DataField="Location" ItemStyle-Width="170px" />

        <asp:BoundField HeaderText="Seating" DataField="Seating" ItemStyle-Width="140px" />

        <asp:BoundField HeaderText="Delivered" DataField="DeliveredCount" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
        </asp:BoundField>

                <asp:BoundField HeaderText="Damaged" DataField="DamagedIncomplete" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
        </asp:BoundField>

		<asp:BoundField HeaderText="Firsts" DataField="FirstsCount" ItemStyle-Width="65px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="65px"></ItemStyle>
        </asp:BoundField>
		<asp:BoundField HeaderText="Seconds" DataField="SecondsCount" ItemStyle-Width="65px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="65px"></ItemStyle>
        </asp:BoundField>
<asp:BoundField HeaderText="Others" DataField="Adults" ItemStyle-Width="65px" ItemStyle-HorizontalAlign="Center">

<ItemStyle HorizontalAlign="Center" Width="65px"></ItemStyle>
        </asp:BoundField>
    <asp:BoundField HeaderText="LeftOvers" DataField="LeftOvers" ItemStyle-Width="65px" ItemStyle-HorizontalAlign="Center">
        <ItemStyle HorizontalAlign="Center" Width="65px"></ItemStyle>
    </asp:BoundField>
<asp:BoundField HeaderText="Short" DataField="Short" ItemStyle-Width="65px" ItemStyle-HorizontalAlign="Center"> 
    <ItemStyle HorizontalAlign="Center" Width="65px"></ItemStyle>
</asp:BoundField>

<asp:CheckBoxField DataField="DESE" HeaderText="DESE" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="55px" />
        <asp:TemplateField HeaderText="Notes">
            <ItemTemplate>
            <asp:Label ID="lblNotes" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Notes").ToString().TrimEnd() %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>


    </Columns>
    
</asp:GridView>
    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    // Ensures tab behavior is consistent across Bootstrap versions/themes
    (function ($) {
        function setActiveTab(tabSelector) {
            if (!tabSelector || tabSelector.charAt(0) !== '#') {
                return;
            }

            var $tabs = $('#dnnTabPanel a[href^="#"]');
            var $panes = $('.tab-content > .tab-pane');

            $tabs.removeClass('active').attr('aria-selected', 'false');
            $tabs.parent('li').removeClass('active');
            $panes.removeClass('active in show');

            var $tab = $tabs.filter('[href="' + tabSelector + '"]');
            var $pane = $(tabSelector);

            if ($tab.length && $pane.length) {
                $tab.addClass('active').attr('aria-selected', 'true');
                $tab.parent('li').addClass('active');
                $pane.addClass('active in show');
            }
        }

        $(document).ready(function () {
            $('#dnnTabPanel a[href^="#"]').on('click', function (e) {
                e.preventDefault();
                var tabSelector = $(this).attr('href');
                setActiveTab(tabSelector);

                if (typeof (Storage) !== 'undefined') {
                    localStorage.setItem('dnnActiveTab', tabSelector);
                }
            });

            var activeTab = null;
            if (typeof (Storage) !== 'undefined') {
                activeTab = localStorage.getItem('dnnActiveTab');
            }

            if (activeTab && $(activeTab).length) {
                setActiveTab(activeTab);
            }
            else {
                setActiveTab('#tab1');
            }
        });
    })(jQuery);
</script>




<script type="text/javascript">

    $(function () {
        $('#<%= ddlDeliveryTime.ClientID %>').on('change', function () {
            copyDeliveryTime();
        });

        $("#txtMealDate").datepicker({
            onSelect: function (date) {
                fillDates(date);
            },
            numberOfMonths: 1,
            showButtonPanel: false,
            beforeShowDay: function (date) { return [(date.getDay() == 1), ""]; },
            showCurrentAtPos: 0
        });





       
    });

        $(function () {
         
            $('#txtMealDateEdit').datepicker({
             beforeShowDay: $.datepicker.noWeekends
            
            });

            $('#txtMealDateSingle').datepicker({
                beforeShowDay: $.datepicker.noWeekends

            });
     });

/**
 * @param {string} date
 */
function fillDates(date) {
    const dateCopy = new Date(date);
    dateCopy.setDate(dateCopy.getDate() + 1);
    const newDateOptions = {
        year: "numeric",
        month: "2-digit",
        day: "2-digit"
    };
   
    $('#txtMealDateTues').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
    dateCopy.setDate(dateCopy.getDate() + 1);
    $('#txtMealDateWeds').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
    dateCopy.setDate(dateCopy.getDate() + 1);
    $('#txtMealDateThurs').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
    dateCopy.setDate(dateCopy.getDate() + 1);
    $('#txtMealDateFri').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
}


    function copyDeliveryTime() {
        var selectedVal = $('#<%= ddlDeliveryTime.ClientID %>').val();
        $('#<%= ddlDeliveryTimeTues.ClientID %>').val(selectedVal);
        $('#<%= ddlDeliveryTimeWeds.ClientID %>').val(selectedVal);
        $('#<%= ddlDeliveryTimeThurs.ClientID %>').val(selectedVal);
        $('#<%= ddlDeliveryTimeFri.ClientID %>').val(selectedVal);
    }

    function myCopyFunction() {
        var myNumber = document.getElementById('txtDelivered').value;
        $('#<%= txtDeliveredTues.ClientID %>').val(myNumber);
        $('#<%= txtDeliveredWeds.ClientID %>').val(myNumber);
        $('#<%= txtDeliveredThurs.ClientID %>').val(myNumber);
        $('#<%= txtDeliveredFri.ClientID %>').val(myNumber);
        //txtDeliveredTues  
    }

    function getIntValue(id) {
        var value = parseInt($('#' + id).val(), 10);
        return isNaN(value) ? 0 : value;
    }

    function validateDamaged(source, args) {
        var delivered = getIntValue('txtDeliveredSingle');
        var damaged = getIntValue('txtDamagedIncompleteSingle');
        args.IsValid = damaged <= delivered;
    }

    function validateFirsts(source, args) {
        var delivered = getIntValue('txtDeliveredSingle');
        var damaged = getIntValue('txtDamagedIncompleteSingle');
        var firsts = getIntValue('txtFirstsCountSingle');
        args.IsValid = firsts <= (delivered - damaged);
    }

    function validateSeconds(source, args) {
        var delivered = getIntValue('txtDeliveredSingle');
        var damaged = getIntValue('txtDamagedIncompleteSingle');
        var firsts = getIntValue('txtFirstsCountSingle');
        var seconds = getIntValue('txtSecondsCountSingle');
        args.IsValid = seconds <= (delivered - damaged - firsts);
    }

    function validateAdults(source, args) {
        var delivered = getIntValue('txtDeliveredSingle');
        var damaged = getIntValue('txtDamagedIncompleteSingle');
        var firsts = getIntValue('txtFirstsCountSingle');
        var seconds = getIntValue('txtSecondsCountSingle');
        var adults = getIntValue('txtAdultsSingle');
        args.IsValid = adults <= (delivered - damaged - firsts - seconds);
    }

</script>
<style type="text/css">

    .gpagination
{
  line-height: 26px;
}

.gpagination span
{
  padding: 10px;
  border: solid 1px #477B0E;
  text-decoration: none;
  white-space: nowrap;

}

.gpagination a, 
.gpagination a:visited
{
  text-decoration: none;
  padding: 11px;
  white-space: nowrap;
}
.gpagination a:hover, 
.gpagination a:active
{
  padding: 10px;
  border: solid 1px #9ECDE7;
  text-decoration: none;
  white-space: nowrap;
  background: #9ECDE7;
}
</style>