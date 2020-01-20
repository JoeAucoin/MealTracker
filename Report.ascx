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


<div class="dnnForm" id="form-demo">
    <fieldset>
        <div class="dnnFormItem">
            <dnn:Label ID="lblStartDate" runat="server" CssClass="dnnFormLabel" AssociatedControlID="txtStartDate" Text="Start Date" />
            <asp:TextBox ID="txtStartDate" runat="server" ClientIDMode="Static" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label ID="lblEndDate" runat="server" CssClass="dnnFormLabel" AssociatedControlID="txtEndDate" Text="End Date" />
            <asp:TextBox ID="txtEndDate" runat="server" ClientIDMode="Static" />
        </div>		
    </fieldset>
</div>	



<br clear="all" />

<asp:GridView ID="GridViewSummaryReport" runat="server" EnableModelValidation="True" EmptyDataText="No Records Found" 
    DataKeyNames="MealDate" OnRowEditing="GridView_RowEditing" OnRowDataBound="GridView_RowDataBound"   
    AutoGenerateColumns="False" 
    GridLines="None"  CssClass="table table-striped table-bordered table-list"
    resourcekey="GridViewSummaryReport" ShowFooter="true">
    <HeaderStyle HorizontalAlign="Center" />
    <Columns>
        
        <asp:BoundField HeaderText="Date" DataField="MealDate" DataFormatString="{0:d}"  ItemStyle-Width="90px"></asp:BoundField>
    
        <asp:TemplateField HeaderText="Children" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblChildren" runat="server" Text='<%# Eval("ChildCount") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblChildrenTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>


          <asp:TemplateField HeaderText="Adults" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblAdultCount" runat="server" Text='<%# Eval("AdultCount") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblAdultTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>
        
        

      <asp:TemplateField HeaderText="Head Count" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblHeadCount" runat="server" Text='<%# Eval("HeadCount") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblHeadTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>

      <asp:TemplateField HeaderText="Plates Served" Visible="true" ItemStyle-HorizontalAlign="Center" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
         <ItemTemplate>
         <asp:Label ID="lblPlatesServedCount" runat="server" Text='<%# Eval("PlatesServed") %>'/>
         </ItemTemplate>
         <FooterTemplate>
         <asp:Label ID="lblPlatesServedTotal" runat="server"></asp:Label>
         </FooterTemplate>
     </asp:TemplateField>
       

    </Columns>
</asp:GridView>


<div style="text-align:right"><asp:Button ID="btnReturn" resourcekey="btnReturn" runat="server" CssClass="dnnSecondaryAction" 
                Text="Return" onclick="btnReturn_Click" /></div>