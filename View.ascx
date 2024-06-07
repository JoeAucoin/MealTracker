<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="GIBS.Modules.MealTracker.View" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>


<script type="text/javascript">



    $(function () {
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


    function fillDates(date) {
       
        const dateCopy = new Date(date);
        dateCopy.setDate(dateCopy.getDate() + 1);
        var newDateOptions = {
            year: "numeric",
            month: "2-digit",
            day: "2-digit"
        }
       
        $('#txtMealDateTues').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
        dateCopy.setDate(dateCopy.getDate() + 1);
        $('#txtMealDateWeds').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
        dateCopy.setDate(dateCopy.getDate() + 1);
        $('#txtMealDateThurs').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
        dateCopy.setDate(dateCopy.getDate() + 1);
        $('#txtMealDateFri').val(dateCopy.toLocaleDateString('en-US', newDateOptions));
    
    }


    function myCopyFunction() {
        var myNumber = document.getElementById('txtDelivered').value;
        $('#<% = txtDeliveredTues.ClientID %>').val(myNumber);
        $('#<% = txtDeliveredWeds.ClientID %>').val(myNumber);
        $('#<% = txtDeliveredThurs.ClientID %>').val(myNumber);
        $('#<% = txtDeliveredFri.ClientID %>').val(myNumber);
        //txtDeliveredTues  
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

<asp:Label ID="lblDebug" runat="server" Visible="false" CssClass="alert alert-warning" />
 	
<asp:HiddenField ID="hfSelecteValue" Value="" runat="server" />

<div style="width:95%;text-align:right;"><asp:LinkButton ID="lbReport" runat="server" resourcekey="lbReport" OnClick="lbReportClick" CausesValidation="false" CssClass="dnnSecondaryAction" />
    <asp:LinkButton ID="lbLocations" runat="server" resourcekey="lbLocations"  CausesValidation="false" CssClass="dnnSecondaryAction" OnClick="lbLocations_Click" />
</div>

<div class="container">
    	<div class="row form">
                <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4 col-md-offset-1">
            
            <dnn:label id="lblSchoolLocation" runat="server" controlname="ddlLocationID" suffix=":" CssClass="control-label" />
	
	    <asp:DropDownList ID="ddlLocationID" runat="server" CssClass="form-control input-lg" OnSelectedIndexChanged="ddlLocationID_SelectedIndexChanged" AutoPostBack="true">
    </asp:DropDownList>	
	<asp:RequiredFieldValidator runat="server" id="reqLocationID" controltovalidate="ddlLocationID" Display="Dynamic" errormessage="Required!" resourcekey="reqSchoolLocation" CssClass="NormalRed" />
            
            </div>	
            
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4"><dnn:label id="lblSeating" runat="server" controlname="ddlSeating" suffix=":" CssClass="control-label" />
			
    <asp:DropDownList ID="ddlSeating" runat="server" OnSelectedIndexChanged="ddlSeating_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control input-lg">
    </asp:DropDownList>	
	    <asp:RequiredFieldValidator runat="server" id="reqSeating" resourcekey="reqSeating" controltovalidate="ddlSeating" Display="Dynamic" errormessage="Required!" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-6 col-sm-1 col-md-1 col-lg-1 checkbox-lg">
            <dnn:label id="lblDeseCbx" runat="server" controlname="CheckBoxDESE" suffix=":" CssClass="control-label" />
            <asp:CheckBox ID="CheckBoxDESE" runat="server" Enabled="false" CssClass="form-control form-check-input"  />
            </div>
            </div>

    <div class="row form">


        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2 col-md-offset-1"><dnn:label id="lblMealDate" runat="server" controlname="txtMealDate" suffix=":" for="txtMealDate" CssClass="control-label" />
			<asp:TextBox ID="txtMealDate" runat="server" MaxLength="10" AutoCompleteType="Disabled" ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="reqMealDate" resourcekey="reqMealDate" controltovalidate="txtMealDate" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2">
            
            <dnn:label id="lblDelivered" runat="server" controlname="txtDelivered" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDelivered" runat="server" onchange="javascript:myCopyFunction();" ClientIDMode="Static" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDelivered" controltovalidate="txtDelivered" Display="Dynamic" errormessage="Required!" resourcekey="reqDelivered" CssClass="NormalRed" />
            
            </div>
        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2"><dnn:label id="lblFirstsCount" runat="server" controlname="txtFirstsCount" suffix=":" />
	<asp:TextBox ID="txtFirstsCount" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCount" controltovalidate="txtFirstsCount" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCount" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-2"><dnn:label id="lblSecondsCount" runat="server" controlname="txtSecondsCount" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCount" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCount" controltovalidate="txtSecondsCount" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCount" CssClass="NormalRed" />
            </div>
         <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblAdults" runat="server" controlname="txtAdults" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdults" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdults" controltovalidate="txtAdults" errormessage="Required!" Display="Dynamic" resourcekey="reqAdults" CssClass="NormalRed" />
            </div>

    </div>

        <div class="row form">


        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2 col-md-offset-1"><dnn:label id="lblMealDateTues" runat="server" controlname="txtMealDateTues" suffix=":" for="txtMealDateTues" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateTues" runat="server" MaxLength="10" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator1" resourcekey="reqMealDate" controltovalidate="txtMealDateTues" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2">
            
            <dnn:label id="lblDeliveredTues" runat="server" controlname="txtDeliveredTues" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredTues" controltovalidate="txtDeliveredTues" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredTues" CssClass="NormalRed" />
            
            </div>
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblFirstsCountTues" runat="server" controlname="txtFirstsCountTues" suffix=":" />
	<asp:TextBox ID="txtFirstsCountTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountTues" controltovalidate="txtFirstsCountTues" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountTues" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblSecondsCountTues" runat="server" controlname="txtSecondsCountTues" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountTues" controltovalidate="txtSecondsCountTues" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountTues" CssClass="NormalRed" />
            </div>
 
                    <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblAdultsTues" runat="server" controlname="txtAdultsTues" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsTues" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsTues" controltovalidate="txtAdultsTues" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsTues" CssClass="NormalRed" />
            </div>

    </div>


        <div class="row form">


        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2 col-md-offset-1"><dnn:label id="lblMealDateWeds" runat="server" controlname="txtMealDateWeds" suffix=":" for="txtMealDateWeds" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateWeds" runat="server" MaxLength="10" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator2" resourcekey="reqMealDate" controltovalidate="txtMealDateWeds" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2">
            
            <dnn:label id="lblDeliveredWeds" runat="server" controlname="txtDeliveredWeds" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredWeds" controltovalidate="txtDeliveredWeds" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredWeds" CssClass="NormalRed" />
            
            </div>
        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblFirstsCountWeds" runat="server" controlname="txtFirstsCountWeds" suffix=":" />
	<asp:TextBox ID="txtFirstsCountWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountWeds" controltovalidate="txtFirstsCountWeds" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountWeds" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblSecondsCountWeds" runat="server" controlname="txtSecondsCountWeds" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountWeds" controltovalidate="txtSecondsCountWeds" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountWeds" CssClass="NormalRed" />
            </div>
 
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblAdultsWeds" runat="server" controlname="txtAdultsWeds" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsWeds" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsWeds" controltovalidate="txtAdultsWeds" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsWeds" CssClass="NormalRed" />
            </div>

    </div>


        <div class="row form">


        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2 col-md-offset-1"><dnn:label id="lblMealDateThurs" runat="server" controlname="txtMealDateThurs" suffix=":" for="txtMealDateThurs" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateThurs" runat="server" MaxLength="10" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator3" resourcekey="reqMealDate" controltovalidate="txtMealDateThurs" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2">
            
            <dnn:label id="lblDeliveredThurs" runat="server" controlname="txtDeliveredThurs" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredThurs" controltovalidate="txtDeliveredThurs" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredThurs" CssClass="NormalRed" />
            
            </div>
        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblFirstsCountThurs" runat="server" controlname="txtFirstsCountThurs" suffix=":" />
	<asp:TextBox ID="txtFirstsCountThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountThurs" controltovalidate="txtFirstsCountThurs" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountThurs" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblSecondsCountThurs" runat="server" controlname="txtSecondsCountThurs" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountThurs" controltovalidate="txtSecondsCountThurs" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountThurs" CssClass="NormalRed" />
            </div>
 
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblAdultsThurs" runat="server" controlname="txtAdultsThurs" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsThurs" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsThurs" controltovalidate="txtAdultsThurs" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsThurs" CssClass="NormalRed" />
            </div>

    </div>



        <div class="row form">


        <div class="form-group col-xs-3 col-sm-2 col-md-2 col-lg-2 col-md-offset-1"><dnn:label id="lblMealDateFri" runat="server" controlname="txtMealDateFri" suffix=":" for="txtMealDateFri" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateFri" runat="server" MaxLength="10"  ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator4" resourcekey="reqMealDate" controltovalidate="txtMealDateFri" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-2 col-sm-2 col-md-2 col-lg-2">
            
            <dnn:label id="lblDeliveredFri" runat="server" controlname="txtDeliveredFri" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqDeliveredFri" controltovalidate="txtDeliveredFri" Display="Dynamic" errormessage="Required!" resourcekey="reqDeliveredFri" CssClass="NormalRed" />
            
            </div>
        <div class="form-group col-xs-2 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblFirstsCountFri" runat="server" controlname="txtFirstsCountFri" suffix=":" />
	<asp:TextBox ID="txtFirstsCountFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqFirstsCountFri" controltovalidate="txtFirstsCountFri" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCountFri" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-2 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblSecondsCountFri" runat="server" controlname="txtSecondsCountFri" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqSecondsCountFri" controltovalidate="txtSecondsCountFri" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCountFri" CssClass="NormalRed" />
            </div>
 
        <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2"><dnn:label id="lblAdultsFri" runat="server" controlname="txtAdultsFri" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsFri" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqAdultsFri" controltovalidate="txtAdultsFri" errormessage="Required!" Display="Dynamic" resourcekey="reqAdultsFri" CssClass="NormalRed" />
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
        <asp:LinkButton ID="lbSave" runat="server" resourcekey="lbSave" OnClick="LbSaveClick" CssClass="dnnPrimaryAction" />
        <asp:LinkButton ID="lbCancel" runat="server" resourcekey="lbCancel" OnClick="LbCancelClick" CausesValidation="false" CssClass="dnnSecondaryAction" Visible="false"/>
        </div>
   
    <div class="clearfix"></div>

	</div>
</div>


    <asp:HiddenField ID="HiddenMealID" runat="server" Value="0" />




<asp:Panel ID="Panel1" runat="server" Visible="false" BorderColor="#999966" BorderWidth="1px" CssClass="panelPadding">

    <h5>EDIT RECORD</h5>  
    <div class="row form">
<div class="form-group col-xs-5 col-sm-5 col-md-4 col-lg-4">
    <asp:Label ID="LabelLocation" runat="server" Text="LabelLocation" CssClass="NormalBold lead"></asp:Label>
</div>
<div class="form-group col-xs-5 col-sm-5 col-md-3 col-lg-3">
    <asp:Label ID="LabelMeal" runat="server" Text="LabelMeal" CssClass="NormalBold lead"></asp:Label>
</div>
</div>

    <div class="row form">


        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-2 "><dnn:label id="lblMealDateEdit" runat="server" controlname="txtMealDateEdit" suffix=":" for="txtMealDateEdit" CssClass="control-label" />
			<asp:TextBox ID="txtMealDateEdit" runat="server" MaxLength="10" ReadOnly="true" ValidationGroup="MealUpdate" AutoCompleteType="Disabled" ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator5" resourcekey="reqMealDate" controltovalidate="txtMealDateEdit" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-2">
            
            <dnn:label id="lblDeliveredEdit" runat="server" controlname="txtDeliveredEdit" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtDeliveredEdit" runat="server" ValidationGroup="MealUpdate" onchange="javascript:myCopyFunction();" ClientIDMode="Static" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator6" controltovalidate="txtDeliveredEdit" Display="Dynamic" errormessage="Required!" resourcekey="reqDelivered" CssClass="NormalRed" />
            
            </div>
        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-2"><dnn:label id="lblFirstsCountEdit" runat="server" controlname="txtFirstsCountEdit" suffix=":" />
	<asp:TextBox ID="txtFirstsCountEdit" runat="server" type="number" ValidationGroup="MealUpdate" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator7" controltovalidate="txtFirstsCountEdit" Display="Dynamic" errormessage="Required!" resourcekey="reqFirstsCount" CssClass="NormalRed" />
            </div>
		
        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-2"><dnn:label id="lblSecondsCountEdit" runat="server" controlname="txtSecondsCountEdit" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtSecondsCountEdit" ValidationGroup="MealUpdate" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator8" controltovalidate="txtSecondsCountEdit" errormessage="Required!" Display="Dynamic" resourcekey="reqSecondsCount" CssClass="NormalRed" />
            </div>
        <div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-2"><dnn:label id="lblAdultsCountEdit" runat="server" controlname="txtAdultsCountEdit" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtAdultsCountEdit" ValidationGroup="MealUpdate" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="RequiredFieldValidatorAdultsEdit" controltovalidate="txtAdultsCountEdit" errormessage="Required!" Display="Dynamic" resourcekey="RequiredFieldValidatorAdultsEdit" CssClass="NormalRed" />
            </div>	
	<div class="form-group col-xs-5 col-sm-5 col-md-2 col-lg-2">
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
             <asp:LinkButton ID="LinkButtonUpdate" CausesValidation="false" runat="server" CommandName="DataCommand" CommandArgument='<%# Eval("MealID" )%>'><img src="/Icons/Sigma/Edit_16X16_Standard_2.png" alt="Edit" /></asp:LinkButton>
           
         </ItemTemplate>
            <ItemStyle Width="20px"></ItemStyle>
       </asp:TemplateField>

        <asp:TemplateField HeaderText="" meta:resourcekey="TemplateFieldResource1" ItemStyle-Width="20px">
         <ItemTemplate>
           <asp:LinkButton ID="LinkButtonDelete" CausesValidation="false"     
             CommandArgument='<%# Eval("MealID") %>' 
             CommandName="Delete" runat="server" meta:resourcekey="LinkButtonEditResource1">
             <img src="/Icons/Sigma/Delete_16X16_Standard_2.png" alt="Delete" /></asp:LinkButton>
         </ItemTemplate>

<ItemStyle Width="20px"></ItemStyle>
       </asp:TemplateField>

        
        


      <asp:BoundField HeaderText="Date" DataField="MealDate" DataFormatString="{0:d}"  ItemStyle-Width="90px">
<ItemStyle Width="90px"></ItemStyle>
        </asp:BoundField>
      <asp:BoundField HeaderText="Location" DataField="Location" ItemStyle-Width="170px" />

        <asp:BoundField HeaderText="Seating" DataField="Seating" ItemStyle-Width="140px" />

        <asp:BoundField HeaderText="Delivered" DataField="DeliveredCount" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
        </asp:BoundField>
		<asp:BoundField HeaderText="Firsts" DataField="FirstsCount" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
        </asp:BoundField>
		<asp:BoundField HeaderText="Seconds" DataField="SecondsCount" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="80px"></ItemStyle>
        </asp:BoundField>
<asp:BoundField HeaderText="Adults" DataField="Adults" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="80px"></ItemStyle>
        </asp:BoundField>
<asp:CheckBoxField DataField="DESE" HeaderText="DESE" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="60px" />
        <asp:TemplateField HeaderText="Notes">
            <ItemTemplate>
            <asp:Label ID="lblNotes" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Notes").ToString().TrimEnd() %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>


    </Columns>
    
</asp:GridView>
    </div>