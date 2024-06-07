<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Locations.ascx.cs" Inherits="GIBS.Modules.MealTracker.Locations" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

  <script type="text/javascript">

      $(function () {
          $("#hide-it").hide(10000);
      });        


  </script>

<div id="hide-it" CssClass="dnnFormSuccess" style="width: 100%; text-align: center;">
<asp:Label ID="LabelDebug" runat="server" Text="" CssClass="lead"></asp:Label>
    </div>

<asp:Panel ID="Panel1" runat="server" Visible="false" BorderColor="#999966" BorderWidth="1px" CssClass="panelPadding">

    <h5><asp:Label ID="LabelEditPanelMode" runat="server" Text="Label"></asp:Label> </h5>  
    <asp:HiddenField ID="HiddenFieldLocationID" runat="server" Value="0" />

    <div class="container">
    	<div class="row form">
            <div class="form-group col-xs-10 col-sm-6 col-md-6 col-lg-6 col-lg-offset-1">
                <dnn:label id="lblLocationName" runat="server" controlname="txtLocationName" suffix=":" CssClass="control-label" />
                <asp:TextBox ID="txtLocationName" runat="server" MaxLength="60" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
            </div>
            <div class="form-group col-xs-10 col-sm-3 col-md-3 col-lg-3">
                <dnn:label id="lblLocationCode" runat="server" controlname="txtLocationCode" suffix=":" CssClass="control-label" />
                <asp:TextBox ID="txtLocationCode" runat="server" MaxLength="60" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
            </div>
         </div>
    	<div class="row form">
            <div class="form-group col-xs-10 col-sm-3 col-md-3 col-lg-3 col-lg-offset-1">
                <dnn:label id="lblAddress" runat="server" controlname="txtAddress" suffix=":" CssClass="control-label" />
<asp:TextBox ID="txtAddress" runat="server" MaxLength="50" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
            </div>
            <div class="form-group col-xs-10 col-sm-3 col-md-3 col-lg-3">
                <dnn:label id="lblCity" runat="server" controlname="txtCity" suffix=":" CssClass="control-label" />
<asp:TextBox ID="txtCity" runat="server" MaxLength="50" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
            </div>

<div class="form-group col-xs-10 col-sm-1 col-md-1 col-lg-1">
                <dnn:label id="lblRegion" runat="server" controlname="txtRegion" suffix=":" CssClass="control-label" />
<asp:TextBox ID="txtRegion" runat="server" MaxLength="50" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
            </div>
            <div class="form-group col-xs-10 col-sm-2 col-md-2 col-lg-2">
                <dnn:label id="lblZipCode" runat="server" controlname="txtZipCode" suffix=":" CssClass="control-label" />
<asp:TextBox ID="txtZipCode" runat="server" MaxLength="50" AutoCompleteType="Disabled" CssClass="form-control input-lg"></asp:TextBox>
            </div>
         </div>

    	<div class="row form">
            <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2 col-lg-offset-1">
                
                <asp:CheckBox ID="CheckBoxDESEBreakfast" runat="server" CssClass="checkbox-inline" Text="DESE Breakfast" />
            </div>
            <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2">
               
                <asp:CheckBox ID="CheckBoxDESELunch" runat="server" CssClass="checkbox-inline" Text="DESE Lunch" />
            </div>
           <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2">
                
                <asp:CheckBox ID="CheckBoxDESESnack" runat="server" CssClass="checkbox-inline" Text="DESE AM Snack" />
            </div>
           <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2">
                
                <asp:CheckBox ID="CheckBoxDESESnackPM" runat="server" CssClass="checkbox-inline" Text="DESE PM Snack" />
            </div>		
             <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2">
                
                <asp:CheckBox ID="CheckBoxIsActive" runat="server" Checked="true" CssClass="checkbox-inline" Text="Is Active" />
            </div>

         </div>

        <div class="row form">
             <div class="form-group col-xs-5 col-sm-2 col-md-2 col-lg-2 col-md-offset-2">
            <asp:LinkButton ID="lbUpdate" runat="server" resourcekey="lbUpdateMeal" OnClick="lbUpdate_Click" ValidationGroup="LocationUpdate" CssClass="btn btn-primary" />
            <asp:LinkButton ID="lbCancelUpdate" runat="server" CausesValidation="false" resourcekey="lbCancelUpdate" OnClick="lbCancelUpdate_Click" CssClass="btn btn-light" />
            </div>
        </div>


    </div>

</asp:Panel>

<!---
    OnRowDataBound="GridView1_DataBound"
    OnSorting="GridView1_Sorting" OnRowCommand="GridView1_RowCommand" EnableViewState="False" 
    -->

<asp:GridView ID="GridView1" runat="server" HorizontalAlign="Center"  
    AutoGenerateColumns="False" CssClass="dnnGrid" OnRowCommand="GridView1_RowCommand"    
    resourcekey="GridView1Details" DataKeyNames="LocationID" >
    <HeaderStyle CssClass="dnnGridHeader" />
    <RowStyle CssClass="dnnGridItem" />
<AlternatingRowStyle CssClass="dnnGridAltItem" />     
<PagerStyle CssClass="pgr" />  
<PagerSettings Mode="NumericFirstLast" /> 
    <Columns>

      <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center" >
         <ItemTemplate>
             <asp:LinkButton ID="LinkButtonUpdate" runat="server" CommandName="DataCommand" CommandArgument='<%# Eval("LocationID" )%>'>Update</asp:LinkButton>
           
         </ItemTemplate>
            <ItemStyle Width="40px"></ItemStyle>
      </asp:TemplateField>
    
        <asp:BoundField HeaderText="Code" Visible="true" DataField="LocationCode" SortExpression="LocationCode" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
       <asp:BoundField HeaderText="Program" DataField="Location" Visible="true" SortExpression="Location" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
         <asp:BoundField HeaderText="Address" DataField="Address" Visible="false" SortExpression="Address" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
     <asp:BoundField HeaderText="Town" DataField="City" SortExpression="City"  ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
        
        <asp:BoundField HeaderText="Address" DataField="Address" SortExpression="Address" Visible="false" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
        
		<asp:BoundField HeaderText="Region" DataField="Region" SortExpression="Region" Visible="false" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
        <asp:BoundField HeaderText="Zip" DataField="ZipCode" Visible="false" SortExpression="ZipCode" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
		
        
        <asp:CheckBoxField DataField="DESE_Breakfast" HeaderText="DESE Breakfast" ItemStyle-HorizontalAlign="Center" />
        <asp:CheckBoxField DataField="DESE_Lunch" HeaderText="DESE Lunch" ItemStyle-HorizontalAlign="Center" />
        <asp:CheckBoxField DataField="DESE_Snack" HeaderText="DESE AM Snack" ItemStyle-HorizontalAlign="Center" />
        <asp:CheckBoxField DataField="DESE_Snack_PM" HeaderText="DESE PM Snack" ItemStyle-HorizontalAlign="Center" />
        <asp:CheckBoxField DataField="IsActive" HeaderText="IsActive" ItemStyle-HorizontalAlign="Center" />

    </Columns>
</asp:GridView>	

<div style="text-align: right; width: 100%;">
    <asp:LinkButton ID="LinkButtonAddNewLocation" runat="server" OnClick="LinkButtonAddNewLocation_Click" CssClass="btn btn-primary">Add New Program</asp:LinkButton>

</div>