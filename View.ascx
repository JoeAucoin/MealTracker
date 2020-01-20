<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="GIBS.Modules.MealTracker.View" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>


<script type="text/javascript">



    $(function () {
        $("#txtMealDate").datepicker({
            numberOfMonths: 1,
            showButtonPanel: false,
            showCurrentAtPos: 0
        });

    });


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

<asp:Label ID="lblDebug" runat="server" Visible="true" CssClass="alert alert-warning" />
 	



<div class="container">
	<div class="row form">
	  
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4"><dnn:label id="lblMealDate" runat="server" controlname="txtMealDate" suffix=":" for="txtMealDate" CssClass="control-label" />
			<asp:TextBox ID="txtMealDate" runat="server" MaxLength="10"  ClientIDMode="Static" CssClass="form-control input-lg"></asp:TextBox>
	    <asp:RequiredFieldValidator runat="server" id="reqMealDate" resourcekey="reqMealDate" controltovalidate="txtMealDate" errormessage="Required!" Display="Dynamic" CssClass="NormalRed" />
        </div>
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4"><dnn:label id="lblSeating" runat="server" controlname="ddlSeating" suffix=":" CssClass="control-label" />
			
    <asp:DropDownList ID="ddlSeating" runat="server" CssClass="form-control input-lg">
        <asp:ListItem Text="-- Please Select --" Value="" ></asp:ListItem>
        <asp:ListItem Text="Early Seating" Value="Early Seating" ></asp:ListItem>
        <asp:ListItem Text="Late Seating" Value="Late Seating" ></asp:ListItem>
    </asp:DropDownList>	
	    <asp:RequiredFieldValidator runat="server" id="reqSeating" resourcekey="reqSeating" controltovalidate="ddlSeating" Display="Dynamic" errormessage="Required!" CssClass="NormalRed" />
        </div>
        <div class="clearfix"></div>
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
            
            <dnn:label id="lblChildCount" runat="server" controlname="txtChildCount" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtChildCount" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqChildCount" controltovalidate="txtChildCount" Display="Dynamic" errormessage="Required!" resourcekey="reqChildCount" CssClass="NormalRed" />
            
            </div>
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4"><dnn:label id="lblAdultCount" runat="server" controlname="txtAdultCount" suffix=":" />
	<asp:TextBox ID="txtAdultCount" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" /><asp:RequiredFieldValidator runat="server" id="reqAdultCount" controltovalidate="txtAdultCount" Display="Dynamic" errormessage="Required!" resourcekey="reqAdultCount" CssClass="NormalRed" />
            </div>
		<div class="clearfix"></div>
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4"><dnn:label id="lblPlatesServed" runat="server" controlname="txtPlatesServed" suffix=":" CssClass="control-label" />
	<asp:TextBox ID="txtPlatesServed" runat="server" type="number" pattern="\d*" CssClass="form-control input-lg" />
	<asp:RequiredFieldValidator runat="server" id="reqPlatesServed" controltovalidate="txtPlatesServed" errormessage="Required!" Display="Dynamic" resourcekey="reqPlatesServed" CssClass="NormalRed" />
            </div>
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4"><dnn:label id="lblMealNotes" runat="server" controlname="txtMealNotes" suffix=":" CssClass="control-label" />
			<asp:TextBox ID="txtMealNotes" runat="server" TextMode="MultiLine" CssClass="form-control input-lg"></asp:TextBox>      
            </div>
		<div class="clearfix"></div>

        <div class="col-xs-10 col-sm-4 col-md-4 col-lg-4" style="text-align:center;">
        <asp:LinkButton ID="lbSave" runat="server" resourcekey="lbSave" OnClick="LbSaveClick" CssClass="dnnPrimaryAction" />
        <asp:LinkButton ID="lbCancel" runat="server" resourcekey="lbCancel" OnClick="LbCancelClick" CausesValidation="false" CssClass="dnnSecondaryAction" Visible="false"/>
        </div>
   
    <div class="clearfix"></div>

	</div>
</div>


    <asp:HiddenField ID="HiddenMealID" runat="server" Value="0" />


<hr />
<div style="width:95%;text-align:right;"><asp:LinkButton ID="lbReport" runat="server" resourcekey="lbReport" OnClick="lbReportClick" CausesValidation="false" CssClass="dnnSecondaryAction" /></div>

<div class="table-responsive">
<asp:GridView ID="GridView1" runat="server" EnableModelValidation="True" 
    DataKeyNames="MealID" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"   
    resourcekey="GridView1Resource1" OnPageIndexChanging="GridView1_PageIndexChanging" 
     AllowPaging="True" PageSize="20" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-list" PagerStyle-CssClass="gpagination"   
    GridLines="None">
   
    <Columns>

        <asp:TemplateField HeaderText="" meta:resourcekey="TemplateFieldResource1" ItemStyle-Width="40px">
         <ItemTemplate>
           <asp:LinkButton ID="LinkButtonEdit" CausesValidation="false"     
             CommandArgument='<%# Eval("MealID") %>' 
             CommandName="Edit" runat="server" meta:resourcekey="LinkButtonEditResource1">
             Delete</asp:LinkButton>
         </ItemTemplate>

<ItemStyle Width="40px"></ItemStyle>
       </asp:TemplateField>
      <asp:BoundField HeaderText="Date" DataField="MealDate" DataFormatString="{0:d}"  ItemStyle-Width="90px">
<ItemStyle Width="90px"></ItemStyle>
        </asp:BoundField>
        <asp:BoundField HeaderText="Seating" DataField="Seating"  ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="110px"></ItemStyle>
        </asp:BoundField>
        <asp:BoundField HeaderText="Children" DataField="ChildCount" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
        </asp:BoundField>
		<asp:BoundField HeaderText="Adults" DataField="AdultCount" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="70px"></ItemStyle>
        </asp:BoundField>
		<asp:BoundField HeaderText="Meals Served" DataField="PlatesServed" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
<ItemStyle HorizontalAlign="Center" Width="80px"></ItemStyle>
        </asp:BoundField>
        <asp:TemplateField HeaderText="Notes">
            <ItemTemplate>
            <asp:Label ID="lblNotes" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Notes").ToString().TrimEnd() %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>


    </Columns>
    
</asp:GridView>
    </div>