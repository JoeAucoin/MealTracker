<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Report.ascx.cs" Inherits="GIBS.Modules.MealTracker.Report" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>


<style type="text/css">

@media print {
  a[href]:after {
    content: none !important;
  }
}

</style>

<script type="text/javascript">

    $(document).ready(function () {
        //Binding Code
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        function EndRequestHandler(sender, args) {
            //Binding Code Again
        }
    });


    $(function () {
        $("#txtStartDate").datepicker({
           
            numberOfMonths: 1,
            showButtonPanel: false,
            showCurrentAtPos: 0
            

        });
        $("#txtEndDate").datepicker({
            
            numberOfMonths: 1,
            showButtonPanel: false,
            showCurrentAtPos: 0
        });
    });

 </script>


<div style=" float:right">
<asp:Button ID="btnFilter" runat="server" Text="Update" 
                resourcekey="btnFilter" onclick="btnFilter_Click" CssClass="dnnPrimaryAction" />
</div>





<div class="container">
    	<div class="row form">

            
        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
            <dnn:Label ID="lblStartDate" runat="server" CssClass="control-label" suffix=":" AssociatedControlID="txtStartDate" Text="Start Date" />
            <asp:TextBox ID="txtStartDate" runat="server" ClientIDMode="Static" CssClass="form-control input-lg" />
    
        </div>
		
		        <div class="form-group col-xs-10 col-sm-4 col-md-4 col-lg-4">
                    
			 <dnn:Label ID="lblEndDate" runat="server" CssClass="control-label" suffix=":" AssociatedControlID="txtEndDate" Text="End Date" />
            <asp:TextBox ID="txtEndDate" runat="server" ClientIDMode="Static" CssClass="form-control input-lg" />
  
        </div>
		</div>
    <div class="row form">

         <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-3">
            
            <dnn:label id="lblLocationCode" runat="server" controlname="ddlLocationCode" suffix=":" CssClass="control-label" />
	
	    <asp:DropDownList ID="ddlLocationCode" runat="server" CssClass="form-control input-lg">
    </asp:DropDownList>	
	
            </div>	

                <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-3">
            
            <dnn:label id="lblLocation" runat="server" controlname="ddlLocationID" suffix=":" CssClass="control-label" />
	
	    <asp:DropDownList ID="ddlLocationID" runat="server" CssClass="form-control input-lg">
    </asp:DropDownList>	
	
            </div>	

         <div class="form-group col-xs-5 col-sm-3 col-md-3 col-lg-3">
             <dnn:label id="lblTowns" runat="server" controlname="ddlTowns" suffix=":" CssClass="control-label" />
	
	    <asp:DropDownList ID="ddlTowns" runat="server" CssClass="form-control input-lg" />
            </div>

        </div>


	
	
</div>





<br clear="all" />

<asp:GridView ID="GridViewSummaryReport" runat="server" EnableModelValidation="True" EmptyDataText="No Records Found" PageSize="10" 
    DataKeyNames="MealID" OnRowEditing="GridView_RowEditing" OnRowDataBound="GridView_RowDataBound"   
    AutoGenerateColumns="False" 
    GridLines="None"  CssClass="table table-striped table-bordered table-list"
    resourcekey="GridViewSummaryReport" ShowFooter="true">
    <HeaderStyle HorizontalAlign="Center" />
    <Columns>
        
        <asp:BoundField HeaderText="Month" DataField="MonthYear"  ItemStyle-Width="90px"></asp:BoundField>
    <asp:BoundField HeaderText="Program" DataField="Location"></asp:BoundField>
<asp:BoundField HeaderText="Meal" DataField="Seating"></asp:BoundField>
      <asp:TemplateField HeaderText="Delivered" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblDeliveredCount" runat="server" Text='<%# Eval("DeliveredCount") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblDeliveredTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>


        <asp:TemplateField HeaderText="Firsts" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblFirstsCount" runat="server" Text='<%# Eval("FirstsCount") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblFirstsTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>


          <asp:TemplateField HeaderText="Seconds" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblSecondsCount" runat="server" Text='<%# Eval("SecondsCount") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblSecondsTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>
        

      <asp:TemplateField HeaderText="Total Served" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblTotalServedCount" runat="server" Text='<%# Eval("TotalMealsCount") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblTotalServedTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>
       
                  <asp:TemplateField HeaderText="Adults" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblAdults" runat="server" Text='<%# Eval("Adults") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblAdults" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>

      <asp:TemplateField HeaderText="Service Days" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblServiceDays" runat="server" Text='<%# Eval("ServiceDays") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblTotalServiceDays" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>

    </Columns>
</asp:GridView>


<!-----
    
    ----->
<asp:GridView ID="gv_Report" runat="server" HorizontalAlign="Center"  OnRowDataBound="gv_Report_DataBound"
    OnSorting="gv_Report_Sorting" 
    AutoGenerateColumns="False" CssClass="dnnGrid"    
    resourcekey="gv_ReportDetails" EnableViewState="False" DataKeyNames="MealID" >
    <HeaderStyle CssClass="dnnGridHeader" />
    <RowStyle CssClass="dnnGridItem" />
<AlternatingRowStyle CssClass="dnnGridAltItem" />     
<PagerStyle CssClass="pgr" />  
<PagerSettings Mode="NumericFirstLast" /> 
    <Columns>
<asp:BoundField HeaderText="Program" DataField="Location" SortExpression="Location"  ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
    <asp:BoundField HeaderText="MealID" Visible="false" DataField="MealID" SortExpression="MealID" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
        <asp:BoundField HeaderText="LocationID" Visible="false" DataField="LocationID" SortExpression="LocationID" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
       <asp:BoundField HeaderText="MealDate" DataField="MealDate" DataFormatString="{0:MM-dd-yyyy}"  Visible="true" SortExpression="MealDate" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
         <asp:BoundField HeaderText="MonthYear" DataField="MonthYear" Visible="false" SortExpression="MealDate" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

        
         <asp:BoundField HeaderText="Town" DataField="City" SortExpression="City" Visible="false" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
        
        <asp:BoundField HeaderText="Meal" DataField="Seating" SortExpression="Seating" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
        
		<asp:BoundField HeaderText="Delivered" DataField="DeliveredCount" SortExpression="DeliveredCount"  ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
        <asp:BoundField HeaderText="Firsts" DataField="FirstsCount" SortExpression="FirstsCount" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
		<asp:BoundField HeaderText="Seconds" DataField="SecondsCount" SortExpression="SecondsCount" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
        <asp:BoundField HeaderText="Total Served" DataField="TotalMealsCount" Visible="true" SortExpression="TotalMealsCount" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
        <asp:BoundField HeaderText="Adults" DataField="Adults" SortExpression="Adults" ItemStyle-VerticalAlign="Middle" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

    </Columns>
</asp:GridView>	



<div style="text-align:right"><asp:Button ID="btnReturn" resourcekey="btnReturn" runat="server" CssClass="dnnSecondaryAction" 
                Text="Return" onclick="btnReturn_Click" /></div>